package MT::BasicAuthor;

# fake out the require for this package since we're
# declaring it inline...

use MT::Object;
@MT::BasicAuthor::ISA = qw( MT::Object );
__PACKAGE__->install_properties({
    column_defs => {
        'id' => 'integer not null auto_increment',
        'name' => 'string(50) not null',
        'password' => 'string(60) not null',
        'email' => 'string(75)',
        'hint' => 'string(75)',
    },
    indexes => {
        name => 1,
        email => 1,
    },
    datasource => 'author',
    primary_key => 'id',
});

sub is_valid_password {
    my $auth = shift;
    my($pass, $crypted) = @_;
    $pass ||= '';
    my $real_pass = $auth->column('password');
    return $crypted ? $real_pass eq $pass :
                      crypt($pass, $real_pass) eq $real_pass;
}

sub set_password {
    my $auth = shift;
    my($pass) = @_;
    my @alpha = ('a'..'z', 'A'..'Z', 0..9);
    my $salt = join '', map $alpha[rand @alpha], 1..2;
    $auth->column('password', crypt $pass, $salt);
}

sub magic_token {
    my $auth = shift;
    require MT::Util;
    my $pw = $auth->column('password');
    if ($pw eq '(none)') {
        $pw = $auth->id . ';' . $auth->name . ';' . ($auth->email || '') . ';' . ($auth->hint || '');
    }
    require MT::Util;
    MT::Util::perl_sha1_digest_hex($pw);
}

1;
__END__

=head1 NAME

MT::BasicAuthor

=head1 METHODS

=head2 $author->is_valid_password($pass, $crypted, $error_ref)

Return the value of L<MT::Auth/is_valid_password>

=head2 $author->set_password

Set the I<$author> password with the perl C<crypt> function.

=head2 $author->magic_token()

Return the value of L<MT::Util/perl_sha1_digest_hex> for the I<password> column.

=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
