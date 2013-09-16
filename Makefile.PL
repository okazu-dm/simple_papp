use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'simple',
    VERSION_FROM  => 'lib/simple.pm',
    PREREQ_PM     => {
        'Kossy' =>  '0.19',
    },
    MIN_PERL_VERSION => '5.008001'
);

