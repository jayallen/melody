package mixiComment::L10N::es;

use strict;
use base 'mixiComment::L10N::en_us';
use vars qw( %Lexicon );

%Lexicon = (

## plugins/mixiComment/mixiComment.pl
	'Allows commenters to sign in to Movable Type 4 using their own mixi username and password via OpenID.' => 'Permite a los comentaristas identificarse en Movable Type 4 usando su propio usuario y contraseña de mixi vía OpenID.',
	'Sign in using your mixi ID' => 'Identifíquese usando su ID de mixi ID',
	'Click the button to sign in using your mixi ID' => 'Click the button to sign in using your mixi ID',
	'mixi' => 'mixi',

## plugins/mixiComment/lib/mixiComment/App.pm
	'mixi reported that you failed to login.  Try again.' => 'mixi informó que falló la identificación. Inténtelo de nuevo.',

## plugins/mixiComment/tmpl/config.tmpl
	'A mixi ID has already been registered in this blog.  If you want to change the mixi ID for the blog, <a href="[_1]">click here</a> to sign in using your mixi account.  If you want all of the mixi users to comment to your blog (not only your my mixi users), click the reset button to remove the setting.' => 'Ya se ha registrado un ID de mixi en este blog. Si desea modificar el ID de mixi del blog, <a href="[_1]">haga clic aquí</a> para identificarse en su cuenta de mixi. Si desea que todos los usuarios de mixi puedan comentar en el blog (no solo sus usuarios de my mixi), haga clic en el botón de reiniciar para eliminar la configuración.',
	'If you want to restrict comments only from your my mixi users, <a href="[_1]">click here</a> to sign in using your mixi account.' => 'Si desea restringir los comentarios a sus usuarios de my mixi, <a href="[_1]">haga clic aquí</a> para identificarse en su cuenta de mixi.',

);

1;
