package Data::Timeline::IScrobbler;

use strict;
use warnings;
use DateTime::Format::DateParse;



our $VERSION = '0.02';


use base qw(Data::Timeline::Builder);


__PACKAGE__->mk_scalar_accessors(qw(log_filename));


use constant DEFAULTS => (
    log_filename => "$ENV{HOME}/Library/Logs/iScrobbler.log",
);


sub create {
    my $self = shift;

    my $timeline = $self->make_timeline;

    my $filename = $self->log_filename;
    open my $fh, '<', $filename or die "can't open $filename: $!\n";

    while (<$fh>) {
        next unless /^\[(.*?)\]-\[VERB\] Added '(.*)'/;
        $timeline->entries_push($self->make_entry(
            timestamp   => DateTime::Format::DateParse->parse_datetime($1),
            description => $2,
            type        => 'iscrobbler',
        ));
    }

    close $fh or die "can't close $filename: $!\n";

    $timeline;
}


1;


__END__



=head1 NAME

Data::Timeline::IScrobbler - Build a timeline from tracks recorded by iScrobbler

=head1 SYNOPSIS

    my $timeline = Data::Timeline::IScrobbler->new->create;

=head1 DESCRIPTION

This class parses the logs created by the Mac OS X application iScrobbler and
creates a timeline of the recently played tracks. iScrobbler is an
application for Mac OS X that creates a simple menu extra that submits your
"currently playing" info from iTunes to AudioScrobbler. The advantage over
using the AudioScrobbler web service is that iScrobbler keeps a lot more
recently played tracks history than the web service. See its page at
http://iscrobbler.sourceforge.net/.

The timeline entries generated by this builder have the type C<iscrobbler>.

See the C<eg/hackmusic-text.pl> and C<eg/hackmusic-html.pl> programs in this
distribution for examples. The idea for those programs was inspired by Greg
McCarroll's blog post "Optimal Hacking Music" at
http://drinkbroken.typepad.com/drink_broken/2007/11/set-the-hack--1.html. The
programs show timelines of your recently played iTunes tracks history
alongside your svk commit history and thus give an impression of which music
you like to hack to.

Data::Timeline::IScrobbler inherits from L<Data::Timeline::Builder>.

The superclass L<Data::Timeline::Builder> defines these methods and
functions:

    new(), make_entry(), make_timeline()

The superclass L<Class::Accessor::Complex> defines these methods and
functions:

    carp(), cluck(), croak(), flatten(), mk_abstract_accessors(),
    mk_array_accessors(), mk_boolean_accessors(),
    mk_class_array_accessors(), mk_class_hash_accessors(),
    mk_class_scalar_accessors(), mk_concat_accessors(),
    mk_forward_accessors(), mk_hash_accessors(), mk_integer_accessors(),
    mk_new(), mk_object_accessors(), mk_scalar_accessors(),
    mk_set_accessors(), mk_singleton()

The superclass L<Class::Accessor> defines these methods and functions:

    _carp(), _croak(), _mk_accessors(), accessor_name_for(),
    best_practice_accessor_name_for(), best_practice_mutator_name_for(),
    follow_best_practice(), get(), make_accessor(), make_ro_accessor(),
    make_wo_accessor(), mk_accessors(), mk_ro_accessors(),
    mk_wo_accessors(), mutator_name_for(), set()

The superclass L<Class::Accessor::Installer> defines these methods and
functions:

    install_accessor(), subname()

The superclass L<Class::Accessor::Constructor> defines these methods and
functions:

    NO_DIRTY(), WITH_DIRTY(), _make_constructor(), mk_constructor(),
    mk_constructor_with_dirty(), mk_singleton_constructor()

The superclass L<Data::Inherited> defines these methods and functions:

    every_hash(), every_list(), flush_every_cache_by_key()

The superclass L<Class::Accessor::Constructor::Base> defines these methods
and functions:

    HYGIENIC(), STORE(), clear_dirty(), clear_hygienic(),
    clear_unhygienic(), contains_hygienic(), contains_unhygienic(),
    delete_hygienic(), delete_unhygienic(), dirty(), dirty_clear(),
    dirty_set(), elements_hygienic(), elements_unhygienic(), hygienic(),
    hygienic_clear(), hygienic_contains(), hygienic_delete(),
    hygienic_elements(), hygienic_insert(), hygienic_is_empty(),
    hygienic_size(), insert_hygienic(), insert_unhygienic(),
    is_empty_hygienic(), is_empty_unhygienic(), set_dirty(),
    size_hygienic(), size_unhygienic(), unhygienic(), unhygienic_clear(),
    unhygienic_contains(), unhygienic_delete(), unhygienic_elements(),
    unhygienic_insert(), unhygienic_is_empty(), unhygienic_size()

The superclass L<Tie::StdHash> defines these methods and functions:

    CLEAR(), DELETE(), EXISTS(), FETCH(), FIRSTKEY(), NEXTKEY(), SCALAR(),
    TIEHASH()

=head1 METHODS

=over 4

=item clear_log_filename

    $obj->clear_log_filename;

Clears the value.

=item log_filename

    my $value = $obj->log_filename;
    $obj->log_filename($value);

A basic getter/setter method. If called without an argument, it returns the
value. If called with a single argument, it sets the value.

=item log_filename_clear

    $obj->log_filename_clear;

Clears the value.

=item log_filename

The log filename from which the builder tries to parse the recently played
track information. Defaults to C<~/Library/Logs/iScrobbler.log>.

=item create

Start parsing information from the logfile indicated by the C<log_filename()>.
Returns a L<Data::Timeline> object with the gleaned information.

=back

=head1 TAGS

If you talk about this module in blogs, on del.icio.us or anywhere else,
please use the C<datatimelineiscrobbler> tag.

=head1 VERSION 
                   
This document describes version 0.02 of L<Data::Timeline::IScrobbler>.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<<bug-data-timeline-iscrobbler@rt.cpan.org>>, or through the web interface at
L<http://rt.cpan.org>.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit <http://www.perl.com/CPAN/> to find a CPAN
site near you. Or see <http://www.perl.com/CPAN/authors/id/M/MA/MARCEL/>.

=head1 AUTHOR

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Marcel GrE<uuml>nauer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

