package MooseX::Storage::Format::XML;
use Moose::Role;

use warnings;
use strict;

use XML::Simple;

requires 'pack';
requires 'unpack';

=head1 NAME

MooseX::Storage::Format::XML - An XML serialization role

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';
our $AUTHORITY = 'cpan:STEVAN';

=head1 SYNOPSIS

    package Point;
    use Moose;
    use MooseX::Storage;

    with Storage('format' => 'XML');

    has 'x' => (is => 'rw', isa => 'Int');
    has 'y' => (is => 'rw', isa => 'Int');

    1;

    my $p = Point->new(x => 10, y => 10);

    ## methods to freeze/thaw into 
    ## a specified serialization format
    ## (in this case XML)

    # pack the class into a XML string
    $p->freeze(); 

    # <opt>
    #   <__CLASS__>Point</__CLASS__> 
    #   <x>10</x>
    #   <y>10</y>
    # </opt>  

    # unpack the XML string into a class
    my $p2 = Point->thaw(<<XML);  
    <opt>
      <__CLASS__>Point</__CLASS__>
      <x>10</x>
      <y>10</y>
    </opt>
    XML

This module is obsoleted by C<MooseX::Storage::Format::XML::Simple>.

=head1 METHODS

=over 4 

=item B<freeze>

=cut

sub freeze {
    my ( $self, @args ) = @_;
    XMLout( $self->pack(@args), NoAttr => 1 );
}

=item B<thaw($xml)>

=cut

sub thaw {
    my ( $class, $xml, @args ) = @_;
    $class->unpack( XMLin( $xml, SuppressEmpty => undef ), @args );
}

=back

=head2 Introspection

=over 4

=item B<meta>

=back

=head1 BUGS

All complex software has bugs lurking in it, and this module is no 
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 AUTHOR

Chris Prather E<lt>chris.prather@iinteractive.comE<gt>

Stevan Little E<lt>stevan.little@iinteractive.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2007-2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
