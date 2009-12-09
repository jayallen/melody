package mixiComment::L10N::nl;

use strict;
use base 'mixiComment::L10N::en_us';
use vars qw( %Lexicon );

%Lexicon = (

## plugins/mixiComment/mixiComment.pl
	'Allows commenters to sign in to Movable Type 4 using their own mixi username and password via OpenID.' => 'Laat reageerders zich aanmelden op Movable Type met hun eigen mixi gebruikersnaam en wachtwoord via OpenID.',
	'Sign in using your mixi ID' => 'Aanmelden met uw mixi ID',
	'Click the button to sign in using your mixi ID' => 'Klik op de knop om aan te melden met uw mixi ID',
	'mixi' => 'mixi',

## plugins/mixiComment/lib/mixiComment/App.pm
	'mixi reported that you failed to login.  Try again.' => 'mixi meldde dat het aanmelden mislukte.  Probeer opnieuw.',

## plugins/mixiComment/tmpl/config.tmpl
	'A mixi ID has already been registered in this blog.  If you want to change the mixi ID for the blog, <a href="[_1]">click here</a> to sign in using your mixi account.  If you want all of the mixi users to comment to your blog (not only your my mixi users), click the reset button to remove the setting.' => 'Er werd reeds een mixi ID geregistreerd voor deze blog.  Als u de mixi ID voor de blog wenst aan te passen, <a href="[_1]">klik dan hier</a> om u aan te melden met uw mixi account.  Als u alle mixi gebruikers toestemming wenst te geven op uw blog te reageren (en niet enkel uw eigen mixi gebruikers), klik dan op de resetknop om deze instelling te verwijderen.',
	'If you want to restrict comments only from your my mixi users, <a href="[_1]">click here</a> to sign in using your mixi account.' => 'Als u reacties wenst te beperken tot uw eigen mixi gebruikers, <a href="[_1]">klik dan hier</a> om u aan te melden met uw mixi account.',

);

1;
