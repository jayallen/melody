# Copyright 2002-2006 Appnel Internet Solutions, LLC
# This code is distributed with permission by Six Apart

package FeedsLite::L10N::de;

use strict;
use base 'FeedsLite::L10N::en_us';
use vars qw( %Lexicon );

## The following is the translation table.

%Lexicon = (

## plugins/feeds-app-lite/lib/MT/Feeds/Lite.pm
	'An error occurred processing [_1]. The previous version of the feed was used. A HTTP status of [_2] was returned.' => 'Beim Einlesen von [_1] ist ein Fehler aufgetreten (zurückgegebener HTTP-Status: [_2]). Es wird die zuletzt erfolgreich eingelesene Version des Feeds verwendet.',
	'An error occurred processing [_1]. A previous version of the feed was not available.A HTTP status of [_2] was returned.' => 'Beim Einlesen von [_1] ist ein Fehler aufgetreten (zurückgegebener HTTP-Status: [_2]). Es liegt keine vorherige Version des Feeds vor.',

## plugins/feeds-app-lite/lib/MT/Feeds/Tags.pm
	'\'[_1]\' is a required argument of [_2]' => '\'[_1]\' ist ein erforderliches Argument von [_2]',
	'MT[_1] was not used in the proper context.' => 'MT[_1] außerhalb seines Kontexts verwendet.',

## plugins/feeds-app-lite/tmpl/config.tmpl
	'Feeds.App Lite Widget Creator' => 'Feeds.App Lite Widget Creator',
	'Configure feed widget settings' => 'Feed-Widget konfigurieren',
	'Enter a title for your widget.  This will also be displayed as the title of the feed when used on your published blog.' => 'Vergeben Sie einen Namen für das Widget. Dieser Name wird auch als Name des Feeds in Ihrem Blog angezeigt werden.',
	'[_1] Feed Widget' => '[_1]-Feed-Widget',
	'Select the maximum number of entries to display.' => 'Anzahl der höchstens anzuzeigenden Einträge',
	'3' => '3',
	'5' => '5',
	'10' => '10',
	'All' => 'Alle',

## plugins/feeds-app-lite/tmpl/msg.tmpl
	'No feeds could be discovered using [_1]' => 'Keine Feeds per [_1] entdeckt.',
	'An error occurred processing [_1]. Check <a href="javascript:void(0)" onclick="closeDialog(\'http://www.feedvalidator.org/check.cgi?url=[_2]\')">here</a> for more detail and please try again.' => 'Fehler beim Einlesen von [_1]. Beachten Sie die  <a href="javascript:void(0)" onclick="closeDialog(\'http://www.feedvalidator.org/check.cgi?url=[_2]\')">Hinweise des Feed Validators</a> und versuchen Sie es ggf. erneut.',
	'A widget named <strong>[_1]</strong> has been created.' => 'Widget <strong>[_1]</strong> angelegt.',
	'You may now <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">edit &ldquo;[_1]&rdquo;</a> or include the widget in your blog using <a href="javascript:void(0)" onclick="closeDialog(\'[_3]\')">WidgetManager</a> or the following MTInclude tag:' => 'Sie können &ldquo;[_1]&rdquo; jetzt <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">bearbeiten</a> oder in Ihr Blog <a href="javascript:void(0)" onclick="closeDialog(\'[_3]\')">einbinden</a>. Alternativ können Sie dazu auch diesen MTInclude-Befehl verwenden:',
	'You may now <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">edit &ldquo;[_1]&rdquo;</a> or include the widget in your blog using the following MTInclude tag:' => 'Sie können &ldquo;[_1]&rdquo; jetzt <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">bearbeiten</a> oder mit diesem MTInclude-Befehl in Ihr Blog einbinden:',
	'Create Another' => 'Weiteres Widget anlegen',

## plugins/feeds-app-lite/tmpl/start.tmpl
	'You must enter a feed or site URL to proceed' => 'Geben Sie die Adresse eines Feeds oder einer Website an.',
	'Create a widget from a feed' => 'Feed als Widget anzeigen',
	'Feed or Site URL' => 'Feed- oder Website-URL',
	'Enter the URL of a feed, or the URL of a site that has a feed.' => 'Geben Sie die URL eines Feeds oder einer Website, die Feeds anbietet, ein:',

## plugins/feeds-app-lite/tmpl/select.tmpl
	'Multiple feeds were found' => 'Mehrere Feeds gefunden',
	'Select the feed you wish to use. <em>Feeds.App Lite supports text-only RSS 1.0, 2.0 and Atom feeds.</em>' => 'Wählen Sie den zu verwendenden Feed. <em>Feeds.App Lite unterstützt RSS 1.0-, RSS 2.0- und ATOM-Feeds.</em>',
	'URI' => 'URI',

## plugins/feeds-app-lite/mt-feeds.pl
	'Feeds.App Lite helps you republish feeds on your blogs. Want to do more with feeds in Movable Type? <a href="http://code.appnel.com/feeds-app" target="_blank">Upgrade to Feeds.App</a>.' => 'Mit Feeds.App Lite binden Sie externe Newsfeeds in Ihre Blogs ein. Noch mehr Möglichkeiten erhalten Sie durch ein <a href="http://code.appnel.com/feeds-app" target="_blank">Upgrade auf Feeds.App</a>.',
	'Create a Feed Widget' => 'Feed-Widget anlegen',
);

1;

