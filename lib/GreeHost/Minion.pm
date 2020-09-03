# ABSTRACT: Job Queue For Make Great GreeHost
package GreeHost::Minion;
use Moo;
use Minion;
use GreeHost::Config;

has Pg => (
    is      => 'ro',
    default => sub { $GreeHost::Config::MINION_CONNECT_URL },
);

has minion => (
    is   => 'ro',
    isa  => sub { $_[0]->isa( 'Minion' ) },
    lazy => 1,
    builder => sub {
        my ( $self ) = @_;
        return Minion->new( Pg => $self->Pg );
    },
    handles => [qw( enqueue )],
);

1;
