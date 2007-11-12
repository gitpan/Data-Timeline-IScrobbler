use inc::Module::Install;
include 'Module::AutoInstall';

name 'Data-Timeline-IScrobbler';
all_from 'lib/Data/Timeline/IScrobbler.pm';
perl_version '5.006';

requires 'Data::Timeline';

build_requires 'Test::More' => '0.70';

# feature 'Generated documentation',
#     - default => 1,
#     'Pod::Generated' => '0.02';

auto_install;

process_templates(
    first_year => 2007,
    rest_from  => "$ENV{HOME}/.mitlib/standard_pod",
    start_tag  => '{%',
    end_tag    => '%}',
);

use_standard_tests(without => 'pod_coverage');
auto_include;
WriteAll;
