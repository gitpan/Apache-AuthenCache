use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
			  'NAME'	=> 'Apache::AuthenCache',
			  'VERSION_FROM' => 'AuthenCache.pm', # finds $VERSION
			  'dist'    => {
							COMPRESS=> 'gzip -9f', SUFFIX=>'gz',
							PREOP => 'pod2text AuthenCache.pm > README',
						   }
);
