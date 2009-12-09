# Copyright 2002-2006 Appnel Internet Solutions, LLC
# This code is distributed with permission by Six Apart

package FeedsLite::L10N::fr;

use strict;
use base 'FeedsLite::L10N::en_us';
use vars qw( %Lexicon );

## The following is the translation table.

%Lexicon = (

## plugins/feeds-app-lite/lib/MT/Feeds/Lite.pm
	'An error occurred processing [_1]. The previous version of the feed was used. A HTTP status of [_2] was returned.' => 'Une erreur s\'est produite en traitant [_1]. La version précédente du flux a été utilisée. Un statut HTTP de [_2] a été retourné.',
	'An error occurred processing [_1]. A previous version of the feed was not available.A HTTP status of [_2] was returned.' => 'Une erreur s\'est produite en traitant [_1]. Une version précédente du flux n\'est pas disponible. Un statut HTTP de [_2] a été renvoyé.',

## plugins/feeds-app-lite/lib/MT/Feeds/Tags.pm
	'\'[_1]\' is a required argument of [_2]' => '\'[_1]\' est un argument nécessaire de [_2]',
	'MT[_1] was not used in the proper context.' => 'Le [_1] MT n\'a pas été utilisé dans le bon contexte.',

## plugins/feeds-app-lite/tmpl/config.tmpl
	'Feeds.App Lite Widget Creator' => 'Créateur de widget de flux',
	'Configure feed widget settings' => 'Configurer les paramètres du widget de flux',
	'Enter a title for your widget.  This will also be displayed as the title of the feed when used on your published blog.' => 'Saisissez un titre pour votre widget. Il sera aussi utilisé comme titre pour le flux qui sera utilisé sur votre blog.',
	'[_1] Feed Widget' => 'Widget de flux [_1]',
	'Select the maximum number of entries to display.' => 'Sélectionnez le nombre maximum de notes que vous voulez afficher.',
	'3' => '3',
	'5' => '5',
	'10' => '10',
	'All' => 'Toutes',

## plugins/feeds-app-lite/tmpl/msg.tmpl
	'No feeds could be discovered using [_1]' => 'Aucun flux n\'a pu être trouvé en utilisant [_1]',
	'An error occurred processing [_1]. Check <a href="javascript:void(0)" onclick="closeDialog(\'http://www.feedvalidator.org/check.cgi?url=[_2]\')">here</a> for more detail and please try again.' => 'Une erreur s\'est produite en traitant [_1]. Vérifiez <a href="javascript:void(0)" onclick="closeDialog(\'http://www.feedvalidator.org/check.cgi?url=[_2]\')">ici</a> pour plus de détails et essayez à nouveau.',
	'A widget named <strong>[_1]</strong> has been created.' => 'Un widget nommé <strong>[_1]</strong> a été créé.',
	'You may now <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">edit &ldquo;[_1]&rdquo;</a> or include the widget in your blog using <a href="javascript:void(0)" onclick="closeDialog(\'[_3]\')">WidgetManager</a> or the following MTInclude tag:' => 'Vous pouvez maintenant <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">modifier &ldquo;[_1]&rdquo;</a> ou inclure le widget dans votre blog en utilisant <a href="javascript:void(0)" onclick="closeDialog(\'[_3]\')">WidgetManager</a> ou la balise MTInclude suivante :',
	'You may now <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">edit &ldquo;[_1]&rdquo;</a> or include the widget in your blog using the following MTInclude tag:' => 'Vous pouvez maintenant <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">modifier &ldquo;[_1]&rdquo;</a> ou inclure le widget dans votre blog en utilisant la balise  MTInclude suivante :',
	'Create Another' => 'En créer un autre',

## plugins/feeds-app-lite/tmpl/start.tmpl
	'You must enter a feed or site URL to proceed' => 'Vous devez saisir l\'URL d\'un flux ou d\'un site pour poursuivre',
	'Create a widget from a feed' => 'Créer un widget à partir d\'un flux',
	'Feed or Site URL' => 'URL du site ou du flux',
	'Enter the URL of a feed, or the URL of a site that has a feed.' => 'Saisissez l\'adresse d\'un flux ou l\'adresse d\'un site possédant un flux.',

## plugins/feeds-app-lite/tmpl/select.tmpl
	'Multiple feeds were found' => 'Plusieurs flux ont été trouvés',
	'Select the feed you wish to use. <em>Feeds.App Lite supports text-only RSS 1.0, 2.0 and Atom feeds.</em>' => 'Sélectionnez le flux que vous voulez utiliser. <em>Feeds.App Lite supporte les flux texte uniquement en RSS 1.0, 2.0 et Atom.</em>',
	'URI' => 'URI',

## plugins/feeds-app-lite/mt-feeds.pl
	'Feeds.App Lite helps you republish feeds on your blogs. Want to do more with feeds in Movable Type? <a href="http://code.appnel.com/feeds-app" target="_blank">Upgrade to Feeds.App</a>.' => 'Feeds.App Lite vous aide à republier les flux sur votre blog. Vous souhaitez en faire plus avec les flux dans Movable Type ? <a href="http://code.appnel.com/feeds-app" target="_blank">Évoluez vers Feeds.App</a>.', # Translate - New
	'Create a Feed Widget' => 'Créer un widget à partir d\'un flux',
);

1;

