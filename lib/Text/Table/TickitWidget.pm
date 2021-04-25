package Text::Table::TickitWidget;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

sub table {

    my %params = @_;
    my $rows = $params{rows} or die "Must provide rows!";

    return "" unless @$rows;

    require Tickit;
    require Tickit::Widget::Table;

    my $tbl = Tickit::Widget::Table->new;
    for my $i (0..$#{$rows->[0]}) {
        $tbl->add_column(
            label => $params{header_row} ? $rows->[0][$i] : "column$i",
            align => 'left',
        );
    }
    $tbl->adapter->push([ @{$rows}[1 .. $#{$rows}] ]);
    Tickit->new(root => $tbl)->run;
    "";
}

1;
#ABSTRACT: View table data on the terminal using Tickit::Widget::Table

=for Pod::Coverage ^(max)$

=head1 SYNOPSIS

 use Text::Table::TickitWidget;

 my $rows = [
     # header row
     ['Name', 'Rank', 'Serial'],
     # rows
     ['alice', 'pvt', '123<456>'],
     ['bob',   'cpl', '98765321'],
     ['carol', 'brig gen', '8745'],
 ];
 Text::Table::TickitWidget::table(rows => $rows, header_row => 1);


=head1 DESCRIPTION

This module uses the L<Text::Table::Tiny> (0.03) interface to let you view table
data on the terminal using L<Tickit::Widget::Table>.


=head1 FUNCTIONS

=head2 table


=head1 SEE ALSO

L<Text::Table::Any>

L<Text::Table::Tiny>

=cut
