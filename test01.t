use Test::More;
use common::sense;

# sorter class

#### use moxie class  ####
# my $sorter = Sorter->new;
# $sorter->set_values(5,4,3,2,1);
# $sorter->sort;
# $sorter->get_values # (1,2,3,4,5) が返ってくる


package SorterClassMx {

    use Test::More;
    use Moxie;
    extends 'Moxie::Object';

    has setter => ( default => sub { [0,1] } );
    has getter => ( default => sub { [0,1] } );

    sub setter : rw;
    sub getter : rw;

    sub clear ($self) {
        $self->@{ 'setter', 'getter' } = ( [0], [0] );
    }

    sub issmall {
        ## 前後の比較のみif method
        my ( $is1, $is2 ) = @_;
        my $s3 = 0;
        if ( $is1 > $is2 ) {
            $s3  = $is2;
            $is2 = $is1;
            $is1 = $s3;
        }
        return $is1, $is2;
    }

    sub sortm  {
        my $self = shift ;
        my $item  = $self->setter ;
        my @s1;
        @s1 = @$item;
#        note "incluse sortm method :", explain $self->setter ;;
        for ( my $it = 0 ; $it < $#s1 ; $it++ ) {

            for my $i ( 0 ... scalar @s1 - 1 ) {
                last
                  if $i == $#s1;

                #添字を超えないためループを抜ける
                ( $s1[$i], $s1[ $i + 1 ] ) = issmall( $s1[$i], $s1[ $i + 1 ] );
            }
        }
        return $self->getter (\@s1) ;
     }
}



note "ClassMx sorted values : ";

my $v = SorterClassMx->new();

 $v->setter([4,3,24]) ;
$v->sortm ();

note "setter :", explain $v->setter ();
 note "getter :" ,  explain $v->getter();


$v->clear ();

done_testing;
1;
