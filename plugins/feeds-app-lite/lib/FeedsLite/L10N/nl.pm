# Copyright 2002-2006 Appnel Internet Solutions, LLC
# This code is distributed with permission by Six Apart

package FeedsLite::L10N::nl;

use strict;
use base 'FeedsLite::L10N::en_us';
use vars qw( %Lexicon );

## The following is the translation table.

%Lexicon = (

# plugins/feeds-app-lite/lib/MT/Feeds/Lite.pm
	'An error occurred processing [_1]. The previous version of the feed was used. A HTTP status of [_2] was returned.' => 'Er deed zich een fout voor bij het verwerken van [_1].  De vorige versie van de feed werd gebruikt.  Een HTTP status van [_2] werd teruggezonden.',
	'An error occurred processing [_1]. A previous version of the feed was not available.A HTTP status of [_2] was returned.' => 'Er deed zich een fout voor bij het verwerken van [_1].  De vorige versie van de feed was niet beschikbaar.  Een HTTP status van [_2] werd teruggezonden.',

## plugins/feeds-app-lite/lib/MT/Feeds/Tags.pm
	'\'[_1]\' is a required argument of [_2]' => '\'[_1]\' is een verplicht argument van [_2]',
	'MT[_1] was not used in the proper context.' => 'MT[_1] werd niet gebruikt in de juiste context.',

## plugins/feeds-app-lite/tmpl/config.tmpl
	'Feeds.App Lite Widget Creator' => 'Feeds.App Lite Widgetmaker',
	'Configure feed widget settings' => 'Feedwidget instellingen configureren',
	'Enter a title for your widget.  This will also be displayed as the title of the feed when used on your published blog.' => 'Vul een titel in voor uw widget.  Deze titel zal ook getoond worden als de titel van de feed wanneer die op uw gepubliceerde weblog verschijnt.',
	'[_1] Feed Widget' => '[_1] feedwidget',
	'Select the maximum number of entries to display.' => 'Selecteer het maximum aantal berichten om te tonen.',
	'3' => '3',
	'5' => '5',
	'10' => '10',
	'All' => 'Alle',

## plugins/feeds-app-lite/tmpl/msg.tmpl
	'No feeds could be discovered using [_1]' => 'Er werden geen feeds gevonden worden met [_1]',
	'An error occurred processing [_1]. Check <a href="javascript:void(0)" onclick="closeDialog(\'http://www.feedvalidator.org/check.cgi?url=[_2]\')">here</a> for more detail and please try again.' => 'Er deed zich een fout voor bij het verwerken van [_1]. Kijk dit <a href="javascript:void(0)" onclick="closeDialog(\'http://www.feedvalidator.org/check.cgi?url=[_2]\')">hier</a> na voor meer details en probeer opnieuw.',
	'A widget named <strong>[_1]</strong> has been created.' => 'Een widget met de naam <strong>[_1]</strong> is aangemaakt',
	'You may now <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">edit &ldquo;[_1]&rdquo;</a> or include the widget in your blog using <a href="javascript:void(0)" onclick="closeDialog(\'[_3]\')">WidgetManager</a> or the following MTInclude tag:' => 'U kunt nu dit widget <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">&ldquo;[_1]&rdquo; bewerken</a> of includeren in uw blog met behulp van <a href="javascript:void(0)" onclick="closeDialog(\'[_3]\')">WidgetManager</a> of volgende MTInclude tag:',
	'You may now <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">edit &ldquo;[_1]&rdquo;</a> or include the widget in your blog using the following MTInclude tag:' => 'U kunt nu dit widget <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">&ldquo;[_1]&rdquo; bewerken</a> of includeren in uw weblog met behulp van volgende MTInclude tag:',
	'Create Another' => 'Maak er nog één aan',

## plugins/feeds-app-lite/tmpl/start.tmpl
	'You must enter a feed or site URL to proceed' => 'U moet een feed of site-URL ingeven om verder te gaan',
	'Create a widget from a feed' => 'Maak een widget van een feed',
	'Feed or Site URL' => 'URL van feed of site',
	'Enter the URL of a feed, or the URL of a site that has a feed.' => 'Vul de URL in van een feed, of de URL van een site met een feed..',

## plugins/feeds-app-lite/tmpl/select.tmpl
	'Multiple feeds were found' => 'Meerdere feeds gevonden',
	'Select the feed you wish to use. <em>Feeds.App Lite supports text-only RSS 1.0, 2.0 and Atom feeds.</em>' => 'Selecteer de feed die u wenst te gebruiken. <em>Feeds.App Lite ondersteunt RSS 1.0, 2.0 en Atom feeds met uitsluitend tekst.</em>',
	'URI' => 'URI',

## plugins/feeds-app-lite/mt-feeds.pl
	'Feeds.App Lite helps you republish feeds on your blogs. Want to do more with feeds in Movable Type? <a href="http://code.appnel.com/feeds-app" target="_blank">Upgrade to Feeds.App</a>.' => 'Feeds.App Lite maakt het mogelijk feeds te herpubliceren op uw blog.  Meer doen met feeds in Movable Type? <a href="http://code.appnel.com/feeds-app" target="_blank">Upgraden naar Feeds.App</a>.',
	'Create a Feed Widget' => 'Feedwidget aanmaken',

);

1;

