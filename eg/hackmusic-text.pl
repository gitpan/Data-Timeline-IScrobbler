#!/usr/bin/env perl

use warnings;
use strict;
use Data::Timeline::IScrobbler;
use Data::Timeline::SVK;
use Data::Timeline::Formatter::SimpleTable;

my $svk_base_dir = "$ENV{HOME}/svk/hanekomu-cpan";

my $timeline     = Data::Timeline::IScrobbler->new->create;
my $svk_timeline = Data::Timeline::SVK->new(base_dir => $svk_base_dir)->create;

$timeline->merge_timeline($svk_timeline);

Data::Timeline::Formatter::SimpleTable->new(
    columns => [ [ 40, 'iscrobbler' ], [ 40, 'svk' ] ],
)->format($timeline);
