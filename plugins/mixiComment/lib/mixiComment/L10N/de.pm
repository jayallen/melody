package mixiComment::L10N::de;

use strict;
use base 'mixiComment::L10N::en_us';
use vars qw( %Lexicon );

%Lexicon = (

## plugins/mixiComment/mixiComment.pl
	'Allows commenters to sign in to Movable Type 4 using their own mixi username and password via OpenID.' => 'Ermöglicht es Kommentarautoren, sich per OpenID mit ihrem mixi-Benutzernamen und -Passwort bei Movable Type 4 anzumelden',
	'Sign in using your mixi ID' => 'Mit Ihrer mixi-ID anmelden',
	'Click the button to sign in using your mixi ID' => 'Klicken Sie den Knopf an, um sich mit Ihrer mixi-ID anzumelden',
	'mixi' => 'mixi',

## plugins/mixiComment/lib/mixiComment/App.pm
	'mixi reported that you failed to login.  Try again.' => 'Ihre Anmeldung über mixi ist fehlgeschlagen. Bitte versuchen Sie es erneut.',

## plugins/mixiComment/tmpl/config.tmpl
	'A mixi ID has already been registered in this blog.  If you want to change the mixi ID for the blog, <a href="[_1]">click here</a> to sign in using your mixi account.  If you want all of the mixi users to comment to your blog (not only your my mixi users), click the reset button to remove the setting.' => 'Es ist bereits eine mixi-ID für Ihr Blog registriert. <a href="[_1]">Klicken Sie hier</a>, um die mixi-ID dieses Blogs zu ändern. Klicken Sie auf Zurücksetzen, um alle mixi-Benutzer kommentieren zu lassen. Derzeit können nur Ihre my mixi-Benutzer kommentieren.',
	'If you want to restrict comments only from your my mixi users, <a href="[_1]">click here</a> to sign in using your mixi account.' => 'Wenn Sie nur Ihre my mixi-Benutzer kommentieren lassen wollen, <a href="[_1]">klicken Sie hier</a>, um sich mit Ihrer mixi-ID anzumelden.',

);

1;
