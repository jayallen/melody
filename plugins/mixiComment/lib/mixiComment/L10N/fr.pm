package mixiComment::L10N::fr;

use strict;
use base 'mixiComment::L10N::en_us';
use vars qw( %Lexicon );

%Lexicon = (

## plugins/mixiComment/mixiComment.pl
	'Allows commenters to sign in to Movable Type 4 using their own mixi username and password via OpenID.' => 'Permet aux auteurs de commentaires de s\'identifier sur Movable Type en utilisant leur nom d\'utilisateur mixi via OpenID.', # Translate - New
	'Sign in using your mixi ID' => 'S\'identifier en utilisant votre identifiant mixi', # Translate - New
	'Click the button to sign in using your mixi ID' => 'Cliquez sur le bouton pour vous identifier en utilisant votre identifiant mixi.', # Translate - New
	'mixi' => 'mixi', # Translate - New

## plugins/mixiComment/lib/mixiComment/App.pm
	'mixi reported that you failed to login.  Try again.' => 'mixi n\'a pas réussi à vous identifier. Veuillez réessayer.', # Translate - New

## plugins/mixiComment/tmpl/config.tmpl
	'A mixi ID has already been registered in this blog.  If you want to change the mixi ID for the blog, <a href="[_1]">click here</a> to sign in using your mixi account.  If you want all of the mixi users to comment to your blog (not only your my mixi users), click the reset button to remove the setting.' => 'Un ID mixi est déjà enregistré sur ce blog. Si vous souhaitez modifier l\'ID mixi, <a href="[_1]">cliquez ici</a> pour vous identifier en utilisant votre compte mixi. Si vous souhaitez permettre à tous les utilisateurs mixi de commenter sur votre blog (et pas uniquement vos utilisateurs mixi), cliquez sur le bouton de réinitialisation pour retirer les paramètres.', # Translate - New
	'If you want to restrict comments only from your my mixi users, <a href="[_1]">click here</a> to sign in using your mixi account.' => 'Si vous souhaitez restreindre les commentaires à uniquement vos utilisateurs mixi, <a href="[_1]">cliquez ici</a> pour vous identifier en utilisant votre compte mixi.', # Translate - New

);

1;
