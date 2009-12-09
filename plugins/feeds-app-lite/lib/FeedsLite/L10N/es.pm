# Copyright 2002-2006 Appnel Internet Solutions, LLC
# This code is distributed with permission by Six Apart

package FeedsLite::L10N::es;

use strict;
use base 'FeedsLite::L10N::en_us';
use vars qw( %Lexicon );

## The following is the translation table.

%Lexicon = (

## plugins/feeds-app-lite/lib/MT/Feeds/Lite.pm
	'An error occurred processing [_1]. The previous version of the feed was used. A HTTP status of [_2] was returned.' => 'Ocurrió un error procesando [_1]. Se utilizó la versión previa de la fuente. Se devolvió el estado HTTP [_2].',
	'An error occurred processing [_1]. A previous version of the feed was not available.A HTTP status of [_2] was returned.' => 'Ocurrió un error procesando [_1]. La versión anterior de la fuente no estaba disponible. Se devolvió el estado HTTP [_2].',

## plugins/feeds-app-lite/lib/MT/Feeds/Tags.pm
	'\'[_1]\' is a required argument of [_2]' => '\'[_1]\' es un argumento necesario de [_2]',
	'MT[_1] was not used in the proper context.' => 'MT[_1] no se está utilizando en el contexto adecuado.',

## plugins/feeds-app-lite/tmpl/config.tmpl
	'Feeds.App Lite Widget Creator' => 'Creador de widgets de Feeds.App Lite',
	'Configure feed widget settings' => 'Configurar widgets de sindicación',
	'Enter a title for your widget.  This will also be displayed as the title of the feed when used on your published blog.' => 'Teclee un título para su widget. Esto también se mostrará como título de la fuente en el blog.',
	'[_1] Feed Widget' => 'Widget de sindicación [_1]',
	'Select the maximum number of entries to display.' => 'Seleccione el máximo número de entradas a mostrar.',
	'3' => '3',
	'5' => '5',
	'10' => '10',
	'All' => 'Todos',

## plugins/feeds-app-lite/tmpl/msg.tmpl
	'No feeds could be discovered using [_1]' => 'No se descubrieron fuentes usando [_1]',
	'An error occurred processing [_1]. Check <a href="javascript:void(0)" onclick="closeDialog(\'http://www.feedvalidator.org/check.cgi?url=[_2]\')">here</a> for more detail and please try again.' => 'Ocurrió un error procesando [_1]. Compruebe <a href="javascript:void(0)" onclick="closeDialog(\'http://www.feedvalidator.org/check.cgi?url=[_2]\')">aquí</a> los detalles e inténtelo de nuevo.',
	'A widget named <strong>[_1]</strong> has been created.' => 'Se creó un widget titulado <strong>[_1]</strong>.',
	'You may now <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">edit &ldquo;[_1]&rdquo;</a> or include the widget in your blog using <a href="javascript:void(0)" onclick="closeDialog(\'[_3]\')">WidgetManager</a> or the following MTInclude tag:' => 'Ahora puede <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">editar &ldquo;[_1]&rdquo;</a> o incluir el widget su blog utilizando <a href="javascript:void(0)" onclick="closeDialog(\'[_3]\')">WidgetManager</a> o la siguiente etiqueta MTInclude:',
	'You may now <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">edit &ldquo;[_1]&rdquo;</a> or include the widget in your blog using the following MTInclude tag:' => 'Ahora puede <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">editar &ldquo;[_1]&rdquo;</a> o incluir el widget en su blog utilizando la siguiente etiqueta MTInclude:',
	'Create Another' => 'Crear otro',

## plugins/feeds-app-lite/tmpl/start.tmpl
	'You must enter a feed or site URL to proceed' => 'Debe introducir una fuente o una URL de un sitio para proceder.',
	'Create a widget from a feed' => 'Crear un widget de una fuente',
	'Feed or Site URL' => 'URL del sitio o fuente',
	'Enter the URL of a feed, or the URL of a site that has a feed.' => 'Introduzca la URL de una fuente de sindicación, o la URL de un sitio que tenga una fuente.',

## plugins/feeds-app-lite/tmpl/select.tmpl
	'Multiple feeds were found' => 'Se encontraron múltiples fuentes',
	'Select the feed you wish to use. <em>Feeds.App Lite supports text-only RSS 1.0, 2.0 and Atom feeds.</em>' => 'Seleccione la fuente que desea usar. <em>Feeds.App Lite soporta las fuentes con solo texto RSS 1.0, 2.0 y Atom.',
	'URI' => 'URI',

## plugins/feeds-app-lite/mt-feeds.pl
	'Feeds.App Lite helps you republish feeds on your blogs. Want to do more with feeds in Movable Type? <a href="http://code.appnel.com/feeds-app" target="_blank">Upgrade to Feeds.App</a>.' => 'Feeds.App Lite le ayuda a republicar fuentes de sindicación en los blogs. ¿Quiere hacer más cosas con la sindicación en Movable Type? <a href="http://code.appnel.com/feeds-app" target="_blank">Actualícese a Feeds.App</a>.',
	'Create a Feed Widget' => 'Crear un widget de fuente',
);

1;

