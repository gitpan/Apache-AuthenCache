# $Id: AuthenCache.pm,v 1.11 2003/06/23 18:44:44 cgilmore Exp $
#
# Author          : Jason Bodnar, Christian Gilmore
# Created On      : Long ago
# Status          : Functional
#
# PURPOSE
#    User Authentication Cache
#
###############################################################################
#
# IBM Public License Version 1.0
#
# THE ACCOMPANYING PROGRAM IS PROVIDED UNDER THE TERMS OF THIS IBM
# PUBLIC LICENSE ("AGREEMENT"). ANY USE, REPRODUCTION OR
# DISTRIBUTION OF THE PROGRAM CONSTITUTES RECIPIENT'S ACCEPTANCE OF
# THIS AGREEMENT.
#
# 1. DEFINITIONS
#
# "Contribution" means:
#
#   a) in the case of International Business Machines Corporation
#   ("IBM"), the Original Program, and
#
#   b) in the case of each Contributor,
#
#   i) changes to the Program, and
#
#   ii) additions to the Program;
#
#   where such changes and/or additions to the Program originate from
#   and are distributed by that particular Contributor. A Contribution
#   'originates' from a Contributor if it was added to the Program by
#   such Contributor itself or anyone acting on such Contributor's
#   behalf. Contributions do not include additions to the Program
#   which: (i) are separate modules of software distributed in
#   conjunction with the Program under their own license agreement,
#   and (ii) are not derivative works of the Program.
#
# "Contributor" means IBM and any other entity that distributes the
# Program.
#
# "Licensed Patents " mean patent claims licensable by a Contributor
# which are necessarily infringed by the use or sale of its
# Contribution alone or when combined with the Program.
#
# "Original Program" means the original version of the software
# accompanying this Agreement as released by IBM, including source
# code, object code and documentation, if any.
#
# "Program" means the Original Program and Contributions.
#
# "Recipient" means anyone who receives the Program under this
# Agreement, including all Contributors.
#
# 2. GRANT OF RIGHTS
#
#   a) Subject to the terms of this Agreement, each Contributor hereby
#   grants Recipient a non-exclusive, worldwide, royalty-free
#   copyright license to reproduce, prepare derivative works of,
#   publicly display, publicly perform, distribute and sublicense the
#   Contribution of such Contributor, if any, and such derivative
#   works, in source code and object code form.
#
#   b) Subject to the terms of this Agreement, each Contributor hereby
#   grants Recipient a non-exclusive, worldwide, royalty-free patent
#   license under Licensed Patents to make, use, sell, offer to sell,
#   import and otherwise transfer the Contribution of such
#   Contributor, if any, in source code and object code form. This
#   patent license shall apply to the combination of the Contribution
#   and the Program if, at the time the Contribution is added by the
#   Contributor, such addition of the Contribution causes such
#   combination to be covered by the Licensed Patents. The patent
#   license shall not apply to any other combinations which include
#   the Contribution. No hardware per se is licensed hereunder.
#
#   c) Recipient understands that although each Contributor grants the
#   licenses to its Contributions set forth herein, no assurances are
#   provided by any Contributor that the Program does not infringe the
#   patent or other intellectual property rights of any other entity.
#   Each Contributor disclaims any liability to Recipient for claims
#   brought by any other entity based on infringement of intellectual
#   property rights or otherwise. As a condition to exercising the
#   rights and licenses granted hereunder, each Recipient hereby
#   assumes sole responsibility to secure any other intellectual
#   property rights needed, if any. For example, if a third party
#   patent license is required to allow Recipient to distribute the
#   Program, it is Recipient's responsibility to acquire that license
#   before distributing the Program.
#
#   d) Each Contributor represents that to its knowledge it has
#   sufficient copyright rights in its Contribution, if any, to grant
#   the copyright license set forth in this Agreement.
#
# 3. REQUIREMENTS
#
# A Contributor may choose to distribute the Program in object code
# form under its own license agreement, provided that:
#
#   a) it complies with the terms and conditions of this Agreement;
#
# and
#
#   b) its license agreement:
#
#   i) effectively disclaims on behalf of all Contributors all
#   warranties and conditions, express and implied, including
#   warranties or conditions of title and non-infringement, and
#   implied warranties or conditions of merchantability and fitness
#   for a particular purpose;
#
#   ii) effectively excludes on behalf of all Contributors all
#   liability for damages, including direct, indirect, special,
#   incidental and consequential damages, such as lost profits;
#   iii) states that any provisions which differ from this Agreement
#   are offered by that Contributor alone and not by any other party;
#   and
#
#   iv) states that source code for the Program is available from such
#   Contributor, and informs licensees how to obtain it in a
#   reasonable manner on or through a medium customarily used for
#   software exchange.
#
# When the Program is made available in source code form:
#
#   a) it must be made available under this Agreement; and
#
#   b) a copy of this Agreement must be included with each copy of the
#   Program.
#
# Each Contributor must include the following in a conspicuous
# location in the Program:
#
#   Copyright © {date here}, International Business Machines
#   Corporation and others. All Rights Reserved.
#
# In addition, each Contributor must identify itself as the originator
# of its Contribution, if any, in a manner that reasonably allows
# subsequent Recipients to identify the originator of the
# Contribution.
#
# 4. COMMERCIAL DISTRIBUTION
#
# Commercial distributors of software may accept certain
# responsibilities with respect to end users, business partners and
# the like. While this license is intended to facilitate the
# commercial use of the Program, the Contributor who includes the
# Program in a commercial product offering should do so in a manner
# which does not create potential liability for other Contributors.
# Therefore, if a Contributor includes the Program in a commercial
# product offering, such Contributor ("Commercial Contributor") hereby
# agrees to defend and indemnify every other Contributor ("Indemnified
# Contributor") against any losses, damages and costs (collectively
# "Losses") arising from claims, lawsuits and other legal actions
# brought by a third party against the Indemnified Contributor to the
# extent caused by the acts or omissions of such Commercial
# Contributor in connection with its distribution of the Program in a
# commercial product offering. The obligations in this section do not
# apply to any claims or Losses relating to any actual or alleged
# intellectual property infringement. In order to qualify, an
# Indemnified Contributor must: a) promptly notify the Commercial
# Contributor in writing of such claim, and b) allow the Commercial
# Contributor to control, and cooperate with the Commercial
# Contributor in, the defense and any related settlement negotiations.
# The Indemnified Contributor may participate in any such claim at its
# own expense.
#
# For example, a Contributor might include the Program in a commercial
# product offering, Product X. That Contributor is then a Commercial
# Contributor. If that Commercial Contributor then makes performance
# claims, or offers warranties related to Product X, those performance
# claims and warranties are such Commercial Contributor's
# responsibility alone. Under this section, the Commercial Contributor
# would have to defend claims against the other Contributors related
# to those performance claims and warranties, and if a court requires
# any other Contributor to pay any damages as a result, the Commercial
# Contributor must pay those damages.
#
# 5. NO WARRANTY
#
# EXCEPT AS EXPRESSLY SET FORTH IN THIS AGREEMENT, THE PROGRAM IS
# PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, EITHER EXPRESS OR IMPLIED INCLUDING, WITHOUT LIMITATION,
# ANY WARRANTIES OR CONDITIONS OF TITLE, NON-INFRINGEMENT,
# MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Each Recipient
# is solely responsible for determining the appropriateness of using
# and distributing the Program and assumes all risks associated with
# its exercise of rights under this Agreement, including but not
# limited to the risks and costs of program errors, compliance with
# applicable laws, damage to or loss of data, programs or equipment,
# and unavailability or interruption of operations.
#
# 6. DISCLAIMER OF LIABILITY
#
# EXCEPT AS EXPRESSLY SET FORTH IN THIS AGREEMENT, NEITHER RECIPIENT
# NOR ANY CONTRIBUTORS SHALL HAVE ANY LIABILITY FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING WITHOUT LIMITATION LOST PROFITS), HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
# TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
# THE USE OR DISTRIBUTION OF THE PROGRAM OR THE EXERCISE OF ANY RIGHTS
# GRANTED HEREUNDER, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
# DAMAGES.
#
# 7. GENERAL
#
# If any provision of this Agreement is invalid or unenforceable under
# applicable law, it shall not affect the validity or enforceability
# of the remainder of the terms of this Agreement, and without further
# action by the parties hereto, such provision shall be reformed to
# the minimum extent necessary to make such provision valid and
# enforceable.
#
# If Recipient institutes patent litigation against a Contributor with
# respect to a patent applicable to software (including a cross-claim
# or counterclaim in a lawsuit), then any patent licenses granted by
# that Contributor to such Recipient under this Agreement shall
# terminate as of the date such litigation is filed. In addition, If
# Recipient institutes patent litigation against any entity (including
# a cross-claim or counterclaim in a lawsuit) alleging that the
# Program itself (excluding combinations of the Program with other
# software or hardware) infringes such Recipient's patent(s), then
# such Recipient's rights granted under Section 2(b) shall terminate
# as of the date such litigation is filed.
#
# All Recipient's rights under this Agreement shall terminate if it
# fails to comply with any of the material terms or conditions of this
# Agreement and does not cure such failure in a reasonable period of
# time after becoming aware of such noncompliance. If all Recipient's
# rights under this Agreement terminate, Recipient agrees to cease use
# and distribution of the Program as soon as reasonably practicable.
# However, Recipient's obligations under this Agreement and any
# licenses granted by Recipient relating to the Program shall continue
# and survive.
#
# IBM may publish new versions (including revisions) of this Agreement
# from time to time. Each new version of the Agreement will be given a
# distinguishing version number. The Program (including Contributions)
# may always be distributed subject to the version of the Agreement
# under which it was received. In addition, after a new version of the
# Agreement is published, Contributor may elect to distribute the
# Program (including its Contributions) under the new version. No one
# other than IBM has the right to modify this Agreement. Except as
# expressly stated in Sections 2(a) and 2(b) above, Recipient receives
# no rights or licenses to the intellectual property of any
# Contributor under this Agreement, whether expressly, by implication,
# estoppel or otherwise. All rights in the Program not expressly
# granted under this Agreement are reserved.
#
# This Agreement is governed by the laws of the State of New York and
# the intellectual property laws of the United States of America. No
# party to this Agreement will bring a legal action under this
# Agreement more than one year after the cause of action arose. Each
# party waives its rights to a jury trial in any resulting litigation.
#
###############################################################################


# Package name
package Apache::AuthenCache;


# Required libraries
use strict;
use mod_perl ();
use Apache::Constants qw(OK AUTH_REQUIRED DECLINED DONE);
use Apache::Log ();
use Cache::FileCache;
use Time::Object;


# Global variables
$Apache::AuthenCache::VERSION = '1.00';


###############################################################################
###############################################################################
# handler: hook into Apache/mod_perl API
###############################################################################
###############################################################################
sub handler {
  my $r = shift;
  return OK unless $r->is_initial_req; # only the first internal request

  # Get configuration
  my $nopasswd = $r->dir_config('AuthenCache_NoPasswd') || 'off';
  my $encrypted = $r->dir_config('AuthenCache_Encrypted') || 'on';
  my $casesensitive = $r->dir_config('AuthenCache_CaseSensitive') || 'on';
  my $cache_time_limit = $r->dir_config('AuthenCache_CacheTime') ||
    $Cache::Cache::EXPIRES_NEVER;
  my $cache_dir = $r->dir_config('AuthenCache_Directory') || '/tmp';
  my $cache_umask = $r->dir_config('AuthenCache_Umask') || '007';
  my $auth_name = $r->auth_name;

  # Clear for paranoid security precautions
  $r->notes('AuthenCache' => 'miss');

  # Get response and password
  my($res, $passwd_sent) = $r->get_basic_auth_pw;
  return $res if $res; # e.g. HTTP_UNAUTHORIZED

  # Get username
  my $user_sent = $r->connection->user;
  # If the user left the username field blank, we must catch it and DECLINE
  # for the downstream handler
  unless ($user_sent) {
    return DECLINED;
  }
  $r->log->debug("handler: username=$user_sent");

  # Do we want Windows-like case-insensitivity?
  if ($casesensitive eq 'off') {
    $user_sent = lc($user_sent);
  }

  # Create or retreive the cache
  # Use the Realm name to allow for a cache per realm
  my $cache = Cache::FileCache->new({ namespace          => $auth_name,
				      default_expires_in => $cache_time_limit,
				      cache_root         => $cache_dir,
				      directory_umask    => $cache_umask });
  my $passwd = $cache->get($user_sent);
  # Is the user in the cache
  if ($passwd) {
    $r->log->debug("handler: using cached passwd for $user_sent");

    # Allow no password
    if ($nopasswd eq 'on' and not length($passwd)) {
      $r->log->debug("handler: no password required; returning DONE");
      # Must return DECLINED so that user has a chance to put in
      # no password
      return DONE;
    }

    # If nopasswd is off, reject user
    unless (length($passwd_sent) and length($passwd)) {
      $r->log->debug("handler: user $user_sent: empty password(s) rejected" .
		     $r->uri);
      # Must return DECLINED so that user has a chance to put in a
      # new password
      return DECLINED;
    }

    # If crypt is needed
    if ($encrypted eq 'on') {
      my $salt = substr($passwd, 0, 2);
      $passwd_sent = crypt($passwd_sent, $salt);
    }

    unless ($passwd_sent eq $passwd) {
      $r->log->debug("AuthenCache::handler: user $user_sent: " .
		     "password mismatch" .  $r->uri);
      # Must return DECLINED so that user has a chance to put in a
      # new password
      return DECLINED;
    }

    # Password matches so end stage
    # The required patch was not introduced in 1.26. It is no longer
    # promised to be included in any timeframe. Commenting out.
    # if ($mod_perl::VERSION > 1.25) {
      # I should be able to use the below lines and be done with it.
      # Since set_handlers() doesn't work properly until 1.26
      # (according to Doug MacEachern) I have to work around it by
      # cobbling together cheat sheets for the subsequent handlers
      # in this phase. I get the willies about the security implications
      # in a general environment where you might be using someone else's
      # handlers upstream or downstream...
      # $r->log->debug("handler: user in cache and password matches; ",
      #                "returning OK and clearing authen handler stack");
      # $r->set_handlers(PerlAuthenHandler => undef);
    # } else {
    $r->log->debug("handler: user in cache and password matches; ",
		   "returning OK and setting notes");
    $r->notes('AuthenCache' => 'hit');
    #}
    return OK;
  } # End if()

  # User not in cache
  $r->log->debug("handler: user not in cache; returning DECLINED");
  return DECLINED;
}

###############################################################################
###############################################################################
# manage_cache: insert new entries into the cache
###############################################################################
###############################################################################
sub manage_cache {
  my $r = shift;
  return OK unless $r->is_initial_req; # only the first internal request

  # Get response and password
  my ($res, $passwd_sent) = $r->get_basic_auth_pw;
  return $res if $res; # e.g. HTTP_UNAUTHORIZED

  # Get username
  my $user_sent = $r->connection->user;
  $r->log->debug("manage_cache: username=$user_sent");

  # The required patch was not introduced in 1.26. It is no longer
  # promised to be included in any timeframe. Commenting out.
  # unless ($mod_perl::VERSION > 1.25) {
    # The below test is dubious. I'm putting it in as a hack around the
    # problems with set_handlers not working quite right until 1.26 is
    # released (according to Doug MacEachern).
  my $cache_result = $r->notes('AuthenCache');
  if ($cache_result eq 'hit') {
    $r->log->debug("manage_cache: upstream cache hit for username=",
		   "$user_sent");
    return OK;
  #  }
  }

  # Get configuration
  my $no_passwd = $r->dir_config('AuthenCache_NoPasswd') || 'off';
  my $encrypted = $r->dir_config('AuthenCache_Encrypted') || 'on';
  my $casesensitive = $r->dir_config('AuthenCache_CaseSensitive') || 'on';
  my $cache_time_limit = $r->dir_config('AuthenCache_CacheTime') ||
    $Cache::Cache::EXPIRES_NEVER;
  my $cache_dir = $r->dir_config('AuthenCache_Directory') || '/tmp';
  my $cache_umask = $r->dir_config('AuthenCache_Umask') || '007';
  my $auth_name = $r->auth_name;
  $r->log->debug("manage_cache: cache_time_limit=$cache_time_limit, ",
		 "cache_dir=$cache_dir, cache_umask=$cache_umask, ",
		 "auth_name=$auth_name");

  # Do we want Windows-like case-insensitivity?
  if ($casesensitive eq 'off') {
    $user_sent = lc($user_sent);
    $passwd_sent = lc($passwd_sent);
  }

  # Do we need to crypt the password?
  if ($encrypted eq 'on') {
    my @alphabet = ('a' .. 'z', 'A' .. 'Z', '0' .. '9', '.', '/');
    my $salt = join ('', @alphabet[rand (64), rand (64)]);
    $passwd_sent = crypt($passwd_sent, $salt);
  }

  # Add the user to the cache
  # Use the Realm name to allow for a cache per realm
  my $cache = Cache::FileCache->new({ namespace          => $auth_name,
				      default_expires_in => $cache_time_limit,
				      cache_root         => $cache_dir,
				      directory_umask    => $cache_umask });
  $cache->set($user_sent, $passwd_sent);
  $r->log->debug("manage_cache: added $user_sent to the cache");

  return OK;
}

if (Apache->module("Apache::Status")) {
#  $r->log->debug("status: launching menu");
  Apache::Status->menu_item('AuthenCache' => 'AuthenCache Menu Item',
			    \&status_menu);
}

###############################################################################
###############################################################################
# status_menu: provide status via Apache::Status on cache
###############################################################################
###############################################################################
sub status_menu {
  my ($r, $q) = @_;
  my @s;

  my $cache_dir = $r->dir_config('AuthenCache_Directory') || '/tmp';
  my $cache = Cache::FileCache->new({ cache_root => $cache_dir });
  my @nss = $cache->get_namespaces();

  push(@s, "<TABLE BORDER=\"1\">\n<TR>\n<TD><STRONG>Namespace</STRONG></TD>\n",
       "<TD><STRONG>UserID</STRONG></TD>\n",
       "<TD><STRONG>Creation Date</STRONG></TD>\n",
       "<TD><STRONG>Expiration Date</STRONG></TD>\n</TR>\n");

  foreach my $ns (sort(@nss)) {
    $cache = Cache::FileCache->new({ cache_root => $cache_dir,
				     namespace  => $ns });
    my @keys = $cache->get_keys();
    foreach my $key (sort(@keys)) {
      my $obj = $cache->get_object($key);
      my $created = Time::Object->new($obj->get_created_at);
      my $expires = Time::Object->new($obj->get_expires_at);
      push(@s, "<TR><TD>$ns</TD>\n<TD>$key</TD>\n",
	   "<TD>$created</TD>\n",
	   "<TD>$expires</TD>\n</TR>\n");
    }
  }

  push(@s, '</TABLE>');

  return \@s;
}


1;

__END__

# Documentation - try 'pod2text AuthenCache.pm'

=head1 NAME

Apache::AuthenCache - Authentication caching used in conjuction
with a primary authentication module (Apache::AuthenDBI,
Apache::AuthenLDAP, etc.)


=head1 SYNOPSIS

 # In your httpd.conf
 PerlModule Apache::AuthenCache

 # In httpd.conf or .htaccess:
 AuthName Name
 AuthType Basic

 PerlAuthenHandler Apache::AuthenCache <Primary Authentication Module> Apache::AuthenCache::manage_cache

 require valid-user # Limited to valid-user

 # Optional parameters
 # Defaults are listed to the right.
 PerlSetVar AuthenCache_CacheTime     900 # Default: indefinite
 PerlSetVar AuthenCache_CaseSensitive Off # Default: On
 PerlSetVar AuthenCache_Encrypted     Off # Default: On
 PerlSetVar AuthenCache_NoPasswd      On  # Default: Off

=head1 DESCRIPTION

B<Apache::AuthenCache> implements a caching mechanism in order to
speed up authentication and to reduce the usage of system
resources. It must be used in conjunction with a regular mod_perl
authentication module (it was designed with AuthenDBI and
AuthenLDAP in mind).  For a list of mod_perl authentication
modules see:

http://www.cpan.org/modules/by-module/Apache/apache-modlist.html

When a request that requires authorization is received,
AuthenCache::handler looks up the REMOTE_USER in a per-realm file
cache (using Cache::FileCache) and compares the cached password to the
sent password. A new cache is created for the first request in a realm
or if the realm's cache has expired. If the passwords match, the
handler returns OK and clears the downstream Authen handlers from the
stack. Otherwise, it returns DECLINED and allows the next
PerlAuthenHandler in the chain to be called.

After the primary authentication handler completes with an OK,
AuthenCache::manage_cache adds the new user to the cache.

=head1 CONFIGURATION OPTIONS

The following variables can be defined within the configuration
of Directory, Location, or Files blocks or within .htaccess
files.

=over 4

=item B<AuthenCache_CacheTime>

This directive contains the number of seconds before the cache is
expired. Default is an indefinite time limit.

=back

=over 4

=item B<AuthenCache_CaseSensitive>

If this directive is set to 'Off', userid matches will be case
insensitive. Default is 'On'.

=back

=over 4

=item B<AuthenCache_Directory>

The base directory for the cache. Defaults to /tmp.

=back

=over 4

=over 4

=item B<AuthenCache_Encrypted>

If this directive is set to 'Off', passwords are not encrypted.
Default is 'On', ie passwords use standard Unix crypt.

=back

=over 4

=item B<AuthenCache_NoPasswd>

If this directive is set to 'On', passwords must be blank.
Default is 'Off'.

=back

=over 4

=item B<AuthenCache_Umask>

Umask for the cache. Defaults to 007.

=back

=head1 PREREQUISITES

mod_perl 1.26 or greater is required. Cache::Cache is also required.

=head1 SEE ALSO

crypt(3c), httpd(8), mod_perl(1)

=head1 AUTHORS

Jason Bodnar <jason@shakabuku.org>
Christian Gilmore <cag@us.ibm.com>

=head1 COPYRIGHT

Copyright (C) 1998-2002, Jason Bodnar.
Copyright (C) 2003 International Business Machines Corporation and
others. All Rights Reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

###############################################################################
###############################################################################
# $Log: AuthenCache.pm,v $
# Revision 1.11  2003/06/23 18:44:44  cgilmore
# see ChangeLog
#
# Revision 1.10  2002/04/04 16:53:40  cgilmore
# updated to use FileCache and added Status
#
# Revision 1.9  2002/03/28 22:17:56  cgilmore
# removed additional internal debugging statements
#
# Revision 1.8  2002/03/28 20:12:18  cgilmore
# updated to 0.10 by switching from IPC::Cache to Cache::FileCache
#
# Revision 1.7  2002/01/25 22:27:35  cgilmore
# updated to latest from Bodnar with re-commenting from me to
# correct dependency on mod_perl versions.
#
# Revision 1.6  2001/01/03 19:17:56  cgilmore
# rewrote documentation and inserted code to handle pre-1.26 mod_perl
#
# Revision 1.5  2000/11/06 19:33:04  cgilmore
# added catching of empty username field
#
# Revision 1.4  2000/10/18 16:31:12  cgilmore
# removed note_basic_auth_failure lines
#
# Revision 1.3  2000/08/03 21:12:07  cgilmore
# changed from AUTH_REQUIRED to DECLINED to allow for new passwords
# to enter the cache
#
# Revision 1.2  2000/07/18 18:58:05  cgilmore
# corrected mis-use of log (commas instead of periods)
#
# Revision 1.1  2000/07/12 18:32:07  cgilmore
# Initial revision
#
###############################################################################
###############################################################################

