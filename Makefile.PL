# $Id: Makefile.PL,v 1.1 2003/06/23 18:44:44 cgilmore Exp $

use strict;
use Config qw(%Config);
use ExtUtils::MakeMaker;

WriteMakefile 
  (
   'NAME'         => 'Apache::AuthenCache',
   'VERSION_FROM' => 'AuthenCache.pm',
   'PREREQ_PM'    => { 'Apache' => '1.26', 'Cache::Cache' => '1.01' },
   'dist'         => { 'COMPRESS' => 'gzip -9f', 'SUFFIX' => 'gz', },
  );
