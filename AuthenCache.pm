package Apache::AuthenCache;

use mod_perl 1.11_01;
#use Apache ();
use Apache::Constants qw(OK AUTH_REQUIRED DECLINED DONE);
use Tie::IxHash;

use strict;

$Apache::AuthenCache::VERSION = '0.03';

# Globals

my %Cache_hash; # For per-realm caches

sub handler {

  my $r = shift;
  return OK unless $r->is_initial_req; # only the first internal request

  # Get configuration
  my $nopasswd = $r->dir_config('AuthenCache_nopasswd') || 'off';
  my $encrypted = $r->dir_config('AuthenCache_encrypted') || 'on';
  my $casesensitive = $r->dir_config('AuthenCache_casesensitive') || 'on';
  my $cache_size = $r->dir_config('AuthenCache_cache_size');
  my $cache_time_limit = $r->dir_config('AuthenCache_cache_time');
  my $auth_name = $r->auth_name;

  # Get response and password
  my($res, $passwd_sent) = $r->get_basic_auth_pw;
  $r->warn("AuthenCache::handler: res=$res, password=$passwd_sent");
  return $res if $res; # e.g. HTTP_UNAUTHORIZED

  # Get username
  my $user_sent = $r->connection->user;
  $r->warn("AuthenCache::handler: username=$user_sent");

  # Do we want Windows-like case-insensitivity?
  if ($casesensitive eq 'off') {
    $user_sent = lc($user_sent);
    $passwd_sent = lc($passwd_sent);
  } # End if

  # Delete the cache if it has expired
  if ($cache_time_limit and time - $Cache_hash{$auth_name}->{'cache_time'} >= $cache_time_limit) {
    $r->warn("Authencache::handler: cache has expired; deleting cache");
    undef $Cache_hash{$auth_name};
  } # End if

  # Create the cache if needed
  unless (defined $Cache_hash{$auth_name}) {
    my $time = time;
    $Cache_hash{$auth_name}->{'cache'} = new Tie::IxHash;
    $Cache_hash{$auth_name}->{'cache_time'} = $time;
    $r->warn("AuthenCache::handler: creating cache at $time");
  } # End if

  # Is the user in the cache
  if ($Cache_hash{$auth_name}->{'cache'}->EXISTS($user_sent)) {
    
    $r->warn("AuthenCache::handler: using cache for $user_sent");
    my $passwd = $Cache_hash{$auth_name}->{'cache'}->FETCH($user_sent); # Save the password
    $r->warn("AuthenCache::handler: password=$passwd  (cached)");

    # Allow no password
    if ($nopasswd eq 'on' and not length($passwd)) {
      $r->warn("AuthenCache::handler: no password required; returning DONE");
      return DONE;
    } # End if

    # If nopasswd is off, reject user
    unless (length($passwd_sent) and length($passwd)) {
      $r->log_reason("AuthenCache::handler: user $user_sent: empty password(s) rejected", $r->uri);
      $r->note_basic_auth_failure;
      return AUTH_REQUIRED;
    } # End unless

    # Is crypt is needed
    if ($encrypted eq 'on') {
      my $salt = substr($passwd, 0, 2);
      $passwd_sent = crypt($passwd_sent, $salt);
    } # End if

    unless ($passwd_sent eq $passwd) {
      $r->log_reason("AuthenCache::handler: user $user_sent: password mismatch", $r->uri);
      $r->note_basic_auth_failure;
      return AUTH_REQUIRED;
    } # ENd unless

    # Password matches so end stage
    $r->warn("AuthenCache::handler: user in cache and password matches; returning OK");
    $r->set_handlers(PerlAuthenHandler => undef);
    return OK;

  } # End if

  # User not in cache
  $r->warn("AuthenCache::handler: user not in cache; returning DECLINED");
  return DECLINED;

} # End handler()

sub manage_cache {

  my $r = shift;
  return OK unless $r->is_initial_req; # only the first internal request

  # Get response and password
  my ($res, $passwd_sent) = $r->get_basic_auth_pw;
  $r->warn("AuthenCache::manage_cache: res=$res, password=$passwd_sent");
  return $res if $res; # e.g. HTTP_UNAUTHORIZED

  # Get username
  my $user_sent = $r->connection->user;
  $r->warn("AuthenCache::manage_cache: username=$user_sent");

  # Get configuration
  my $no_passwd = $r->dir_config('AuthenCache_nopasswd') || 'off';
  my $encrypted = $r->dir_config('AuthenCache_encrypted') || 'on';
  my $casesensitive = $r->dir_config('AuthenCache_casesensitive') || 'on';
  my $cache_size = $r->dir_config('AuthenCache_cache_size');
  my $cache_time_limit = $r->dir_config('AuthenCache_cache_time');
  my $auth_name = $r->auth_name;

  # Do we want Windows-like case-insensitivity?
  if ($casesensitive eq 'off') {
    $user_sent = lc($user_sent);
    $passwd_sent = lc($passwd_sent);
  } # End if

  # Do we need to crypt the password?
  if ($encrypted eq 'on') {
    my @alphabet = ('a' .. 'z', 'A' .. 'Z', '0' .. '9', '.', '/');
    my $salt = join ('', @alphabet[rand (64), rand (64)]);
    $passwd_sent = crypt($passwd_sent, $salt);
  } # End if

  # Add the user to the cache
  $Cache_hash{$auth_name}->{'cache'}->Push($user_sent => $passwd_sent); 
  $r->warn("AuthenCache::manage_cache: added $user_sent:$passwd_sent to the cache");
  if (defined $cache_size and $Cache_hash{$auth_name}->{'cache'}->Length > $cache_size) { # Remove oldest cache entry if over max cache size
    my ($k, $v) = $Cache_hash{$auth_name}->{'cache'}->Shift;
    $r->warn("AuthenCache::manage_cache: cache size reached. Dropped $k:$v");
  } # End if

  return OK;

} # End manage_cache()

Apache::Status->menu_item
  (
   'AuthenCache' => 'AuthenCache Realms-Users',
   sub {
	 my($r, $q) = @_;
	 my @s;
	 push @s, qq(<TABLE BORDER=1 CELLPADDING=5>), 
	          qq(<TR><TH>Realm</TH><TH>Seconds Cached</TH><TH>Users</TH></TR>);
	 foreach my $realm (keys %Cache_hash) {
	   push @s, qq(<TR VALIGN=TOP><TD>$realm</TD><TD ALIGN=CENTER>), 
                (time - $Cache_hash{$realm}->{'cache_time'}),
	            qq(</TD><TD>);
	   foreach my $user ($Cache_hash{$realm}->{'cache'}->Keys) {push @s, qq($user<BR>)}
	   push @s, qq(</TD></TR>);
	 } # End foreach
	 push @s, qq(</TABLE>);
	 return \@s;
   } # End sub
  ) if ($INC{'Apache.pm'} && Apache->module('Apache::Status'));

1;

__END__


=head1 NAME

Apache::AuthenCache - Authentication caching used in conjuction with a primary authentication module (Apache::AuthenDBI, etc.)


=head1 SYNOPSIS

 # In your httpd.conf
 PerlModule Apache::AuthenCache

 # In httpd.conf or .htaccess:
 AuthName Name
 AuthType Basic
 PerlAuthenHandler Apache::AuthenCache <Primary Authentication Module> Apache::AuthenCache::manage_cache
 <Limit GET>
 require valid-user # Limited to valid-user or user
 </Limit>

 # Optional parameters
 PerlSetVar AuthenCache_cache_size     100 # Maximum number of entries in cache (no default)
 PerlSetVar AuthenCache_cache_time      900 # Number of seconds cache is good for (no default)
 PerlSetVar AuthenCache_nopasswd       on  # Allows authentication with out a password (defaults to off)
 PerlSetVar AuthenCache_encrypted      off # Uses plaintext passwords (defaults to on)
 PerlSetVar AuthenCache_casesensitive  off # Allows for Windows-like case-insensitivity (defaults to on)

=head1 DESCRIPTION

This module implements a caching mechanism in order to speed up authentication 
and to reduce the usage of system resources. It must be used in conjunction with a 
regular mod_perl authentication module. (It was designed with AuthenDBI in mind.) 
For mod_perl authentication modules see:

 http://www.perl.com/CPAN-local/modules/by-module/Apache/apache-modlist.html

When an access controlled request is received AuthenCache::handler looks up the 
username in the cache and compares the cached password to the sent password. A 
new cache is created for the first request or if the cache has expired. If the 
passwords match the remaing Authen handlers are removed from the stack and OK is 
returned. If the passwords don't match DECLINED is returned and the next Authen 
handler is called. 

After the primary authentication handler authenticates the user, AuthenCache::manage_cache 
adds the new user to the cache and removes the oldest user if AuthenCache_cache_size 
is set and the size of the cache is greater than AuthenCache_cache_size.

=head1 PREREQUISITES

mod_perl 1.11_01 is required. The following call-back hooks need to be enabled when making mod_perl:

  perl Makefile.PL PERL_AUTHEN=1 PERL_STACKED_HANDLERS=1 PERL_GET_SET_HANDLERS

Tie::IxHash is also required.

=head1 TODO

=over 4

=item * Make cache LRU

=back


=head1 SEE ALSO

L<Apache>, L<mod_perl>

=head1 AUTHOR

Jason Bodnar <jcbodnar@mail.utexas.edu>

=head1 COPYRIGHT

Copyright (C) 1998, Jason Bodnar

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
