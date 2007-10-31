# Copyright 2003-2007 Six Apart. This code cannot be redistributed without
# permission from www.sixapart.com.
#
# $Id$

package MT::L10N::de;
use strict;
use MT::L10N;
use MT::L10N::en_us;
use vars qw( @ISA %Lexicon );
@ISA = qw( MT::L10N::en_us );

## The following is the translation table.

%Lexicon = (

## php/plugins/init.Date-basedCategoryArchives.php
	'Category Yearly' => 'Kategorie jährlich',
	'Category Monthly' => 'Kategorie monatlich',
	'Category Daily' => 'Kategorie ätglich',
	'Category Weekly' => 'Kategorie wöchentlich',

## php/plugins/init.AuthorArchives.php
	'Author' => 'Autor',
	'Author (#' => 'Autor (#', # Translate - New # OK
	'Author Yearly' => 'Autor jährlich',
	'Author Monthly' => 'Autor monatlich',
	'Author Daily' => 'Autor täglich',
	'Author Weekly' => 'Autor wöchentlich',

## php/lib/function.mtauthordisplayname.php

## php/lib/function.mtproductname.php
	'$short_name [_1]' => '$short_name [_1]',

## php/lib/function.mtcommentfields.php
	'Thanks for signing in,' => 'Danke für Ihre Anmeldung',
	'Now you can comment.' => 'Sie können jetzt Ihren Kommentar verfassen.',
	'sign out' => 'abmelden',
	'(If you haven\'t left a comment here before, you may need to be approved by the site owner before your comment will appear. Until then, it won\'t appear on the entry. Thanks for waiting.)' => '(Wenn Sie auf dieser Site bisher noch nicht kommentiert haben, wird Ihr Kommentar eventuell erst zeitverzögert freigeschaltet werden. Vielen Dank für Ihre Geduld.)',
	'Remember me?' => 'Benutzername speichern?',
	'Yes' => 'Ja',
	'No' => 'Nein',
	'Comments' => 'Kommentare',
	'Preview' => 'Vorschau',
	'Post' => 'Absenden',
	'You are not signed in. You need to be registered to comment on this site.' => 'Sie sind nicht angemeldet. Sie müssen sich registrieren, um hier zu kommentieren.',
	'Sign in' => 'Anmelden',
	'. Now you can comment.' => '. Sie können jetzt Ihren Kommentar verfassen.',
	'If you have a TypeKey identity, you can ' => 'Wenn Sie eine TypeKey-Identität besitzen, können Sie ',
	'sign in' => 'anmelden',
	'to use it here.' => ', um es hier zu verwenden.',
	'Name' => 'Name',
	'Email Address' => 'E-Mail-Adresse',
	'URL' => 'URL',
	'(You may use HTML tags for style)' => '(HTML-Tags erlaubt)',

## php/lib/block.mtentries.php
	'sort_by="score" must be used in combination with namespace.' => 'sort_by="score" erfordert einen Namespace.',

## php/lib/function.mtremotesigninlink.php
	'TypeKey authentication is not enabled in this blog.  MTRemoteSignInLink can\'t be used.' => 'TypeKey-Authentifizierung in diesem Weblog nicht aktiviert -  MTRemoteSignInLink kann nicht verwendet werden.',

## php/lib/block.mtassets.php

## php/lib/captcha_lib.php
	'Captcha' => 'Captcha',
	'Type the characters you see in the picture above.' => 'Geben Sie die Buchstaben ein, die Sie in obigem Bild sehen.',

## php/lib/archive_lib.php
	'Individual' => 'Individuell',
	'Yearly' => 'Jährlich',
	'Monthly' => 'Monatlich',
	'Daily' => 'Täglich',
	'Weekly' => 'Wöchentlich',

## default_templates/entry_metadata.mtml
	'Posted by [_1] on [_2]' => 'Geschrieben von [_1] am [_2]',
	'Posted on [_1]' => 'Geschrieben am [_1]',
	'Permalink' => 'Permalink',
	'Comments ([_1])' => 'Kommentare ([_1])',
	'TrackBacks ([_1])' => 'TrackBacks ([_1])',

## default_templates/comment_preview.mtml
	'Comment on [_1]' => 'Kommentar zu [_1]',
	'Header' => 'Kopf',
	'Previewing your Comment' => 'Vorschau Ihres Kommentars',
	'Comment Detail' => 'Kommentardetail',

## default_templates/header.mtml
	'[_1]: Search Results' => '[_1]: Suchergebnisse',
	'[_1] - [_2]' => '[_1] - [_2]',
	'[_1]: [_2]' => '[_1]: [_2]',

## default_templates/dynamic_error.mtml
	'Page Not Found' => 'Seite nicht gefunden',

## default_templates/entry.mtml
	'Entry Detail' => 'Eintragsdetails',
	'TrackBacks' => 'TrackBacks',

## default_templates/search_results.mtml
	'Search Results' => 'Suchergebnisse',
	'Search this site' => 'Diese Site durchsuchen',
	'Search' => 'Suchen',
	'Match case' => 'Groß-/Kleinschreibung',
	'Regex search' => 'Regex-Suche',
	'Matching entries matching &ldquo;[_1]&rdquo; from [_2]' => 'Einträge mit &ldquo;[_1]&rdquo; von [_2]',
	'Entries tagged with &ldquo;[_1]&rdquo; from [_2]' => 'Mit &ldquo;[_1]&rdquo; getaggte Einträge von [_2]',
	'Entry Summary' => 'Eintrags-Zusammenfassung',
	'Entries matching &ldquo;[_1]&rdquo;' => 'Einträge mit &ldquo;[_1]&rdquo',
	'Entries tagged with &ldquo;[_1]&rdquo;' => 'Mit &ldquo;[_1]&rdquo getaggte Einträge',
	'No pages were found containing &ldquo;[_1]&rdquo;.' => 'Keine Seiten mit &ldquo;[_1]&rdquo gefunden',
	'Instructions' => 'Anleitung',
	'By default, this search engine looks for all words in any order. To search for an exact phrase, enclose the phrase in quotes:' => 'Die Suchfunktion sucht standardmäßig nach allen angebenen Begriffen in beliebiger Reihenfolge. Um nach einem exakten Ausdruck zu suchen, setzen Sie diesen bitte in Anführungszeichen:',
	'movable type' => 'Movable Type',
	'The search engine also supports AND, OR, and NOT keywords to specify boolean expressions:' => 'Die boolschen Operatoren AND, OR und NOT werden unterstützt:',
	'personal OR publishing' => 'Schrank OR Schublade',
	'publishing NOT personal' => 'Regal NOT Schrank',

## default_templates/archive_index.mtml
	'Archives' => 'Archive',
	'Monthly Archives' => 'Monatsarchive',
	'Categories' => 'Kategorien',
	'Author Archives' => 'Autorenarchive',
	'Category Monthly Archives' => 'Monatliche Kategoriearchive',
	'Author Monthly Archives' => 'Monatliche Autorenarchive',

## default_templates/comment_form.mtml
	'Post a comment' => 'Kommentar schreiben',
	'Remember personal info?' => 'Persönliche Angaben speichern?',
	'Cancel' => 'Abbrechen',

## default_templates/tags.mtml
	'Tags' => 'Tags',

## default_templates/main_index.mtml

## default_templates/entry_listing.mtml
	'[_1] Archives' => '[_1]-Archive',
	'Recently in <em>[_1]</em> Category' => 'Neues in der Kategorie <em>[_1]</em>',
	'Recently by <em>[_1]</em>' => 'Neues von <em>[_1]</em>',
	'Main Index' => 'Hauptindex',

## default_templates/comment_response.mtml
	'Comment Posted' => 'Kommentar veröffentlicht', # Translate - New # OK
	'Confirmation...' => 'Bestätigung...', # Translate - New # OK
	'Your comment has been posted!' => 'Ihr Kommentar wurde veröffentlicht!', # Translate - New # OK
	'Comment Pending' => 'Kommentar noch nicht freigegeben',
	'Thank you for commenting.' => 'Vielen Dank für Ihren Kommentar',
	'Your comment has been received and held for approval by the blog owner.' => 'Ihr Kommentar wurde gespeichert und muß nun vom Weblog-Betreiber freigegeben werden.',
	'Comment Submission Error' => 'Kommentar-Fehler',
	'Your comment submission failed for the following reasons:' => 'Folgender Fehler ist beim Kommentieren aufgetreten:',
	'Return to the <a href="[_1]">original entry</a>.' => '<a href="[_1]">Zurück zum Eintrag</a>.',

## default_templates/sidebar_3col.mtml
	'If you use an RSS reader, you can subscribe to a feed of all future entries tagged &ldquo;<$MTSearchString$>&ldquo;.' => 'Wenn Sie einen Feedreader verwenden, können Sie einen Feed aller neuen mit &ldquo;<$MTSearchString$>&ldquo; getaggten Einträge abonnieren.',
	'If you use an RSS reader, you can subscribe to a feed of all future entries matching &ldquo;<$MTSearchString$>&ldquo;.' => 'Wenn Sie einen Feedreader verwenden, können Sie einen Feed aller neuen Einträge mit &ldquo;<$MTSearchString$>&ldquo;  abonnieren.',
	'Feed Subscription' => 'Feed abonnieren',
	'(<a href="[_1]">What is this?</a>)' => '(<a href="[_1]">Was ist das?</a>)',
	'Subscribe to feed' => 'Feed abonnieren',
	'[_1] ([_2])' => '[_1] ([_2])',
	'About This Post' => 'Über diesen Eintrag',
	'About This Archive' => 'Über dieses Archiv',
	'About Archives' => 'Über die Archive',
	'This page contains links to all the archived content.' => 'Diese Seite enthält Links zu allen archivierten Einträgen.',
	'This page contains a single entry by [_1] posted on <em>[_2]</em>.' => 'Diese Seite enthält einen einzelnen Weblogeintrag vom [_1] über <em>[_2]</em>.',
	'<a href="[_1]">[_2]</a> was the previous post in this blog.' => '<a href="[_1]">[_2]</a> ist der vorherige Eintrag in diesem Blog.',
	'<a href="[_1]">[_2]</a> is the next post in this blog.' => '<a href="[_1]">[_2]</a> ist der nächste Eintrag in diesem Blog.',
	'This page is a archive of entries in the <strong>[_1]</strong> category from <strong>[_2]</strong>.' => 'Diese Seite enthält alle Einträge der Kategorie <strong>[_1]</strong> aus <strong>[_2]</strong>.',
	'<a href="[_1]">[_2]</a> is the previous archive.' => '<a href="[_1]">[_2]</a> ist das vorherige Archiv.',
	'<a href="[_1]">[_2]</a> is the next archive.' => '<a href="[_1]">[_2]</a> ist das nächste Archiv.',
	'This page is a archive of recent entries in the <strong>[_1]</strong> category.' => 'Diese Seite enthält aktuelle Einträge der Kategorie <strong>[_1]</strong>.',
	'<a href="[_1]">[_2]</a> is the previous category.' => '<a href="[_1]">[_2]</a> ist die vorherige Kategorie.',
	'<a href="[_1]">[_2]</a> is the next category.' => '<a href="[_1]">[_2]</a> ist die nächste Kategorie.',
	'This page is a archive of recent entries written by <strong>[_1]</strong> in <strong>[_2]</strong>.' => 'Diese Seite enthält aktuelle Einträge von <strong>[_1]</srong> über <strong>[_2]</strong>.',
	'This page is a archive of recent entries written by <strong>[_1]</strong>.' => 'Diese Seite enthält aktuelle Einträge von <strong>[_1]</strong> ',
	'This page is an archive of entries from <strong>[_2]</strong> listed from newest to oldest.' => 'Diese Seite enthält alle Einträge von <strong>[_1]</strong> von neu nach alt.',
	'Find recent content on the <a href="[_1]">main index</a>.' => 'Aktuelle Einträge finden Sie auf der <a href="[_1]">Startseite</a>.',
	'Find recent content on the <a href="[_1]">main index</a> or look in the <a href="[_2]">archives</a> to find all content.' => 'Aktuelle Einträge finden Sie auf der <a href="[_1]">Startseite</a>, alle Einträge in den <a href="[_2]">Archiven</a>.',
	'Recent Posts' => 'Aktuelle Einträge',
	'[_1] <a href="[_2]">Archives</a>' => '[_1]-<a href="[_2]">Archive</a>',
	'Search this blog:' => 'Dieses Weblog durchsuchen:',
	'[_1]: Monthly Archives' => '[_1]: Monatsarchive',
	'Subscribe to this blog\'s feed' => 'Feed dieses Weblogs abonnieren',
	'This blog is licensed under a <a href="[_1]">Creative Commons License</a>.' => 'Dieses Blog steht unter einer <a href="[_1]">Creative Commons-Lizenz</a>.',
	'Powered by Movable Type [_1]' => 'Powered by Movable Type [_1]',

## default_templates/rss.mtml
	'Copyright [_1]' => 'Copyright [_1]',

## default_templates/javascript.mtml
	'You do not have permission to comment on this blog.' => 'Sie dürfen nicht kommentieren.',
	'Sign in</a> to comment on this post.' => 'Anmelden</a> um diesen Eintrag zu kommentieren.',
	'Sign in</a> to comment on this post,' => 'Anmelden</a> um diesen Eintrag zu kommentieren,',
	'or ' => 'oder',
	'comment anonymously.' => 'anonym kommentieren.',

## default_templates/entry_detail.mtml
	'Entry Metadata' => 'Eintrags-Metadaten',

## default_templates/categories.mtml

## default_templates/trackbacks.mtml
	'[_1] TrackBacks' => '[_1]-TrackBacks',
	'Listed below are links to blogs that reference this post: <a href="[_1]">[_2]</a>.' => 'Folgende Einträge anderer Blogs beziehen sich auf diesen Eintrag: <a href="[_1]">[_2]</a>.',
	'TrackBack URL for this entry: <span id="trackbacks-link">[_1]</span>' => 'TrackBack-URL dieses Eintrags: <span id="trackbacks-link">[_1]</span>',
	'&raquo; <a rel="nofollow" href="[_1]">[_2]</a> from [_3]' => '&raquo; <a rel="nofollow" href="[_1]">[_2]</a> von [_3]',
	'[_1] <a rel="nofollow" href="[_2]">Read More</a>' => '[_1] <a rel="nofollow" href="[_2]">Mehr</a>',
	'Tracked on <a href="[_1]">[_2]</a>' => 'Gesehen auf <a href="[_1]">[_2]</a>',

## default_templates/footer.mtml
	'Sidebar - 3 Column Layout' => 'Seitenleiste - dreispaltiges Layout', # Translate - New # OK

## default_templates/comment_detail.mtml
	'[_1] [_2] said:' => '[_1] [_2] schrieb:',
	'<a href="[_1]" title="Permalink to this comment">[_2]</a>' => '<a href="[_1]" title="Peramlink dieses Eintrags">[_2]</a>',

## default_templates/entry_summary.mtml
	'Continue reading <a href="[_1]">[_2]</a>.' => 'Weiterlesen aus  <a href="[_1]">[_2]</a>.',

## default_templates/page.mtml
	'Page Detail' => 'Seiteninformationen',

## default_templates/sidebar_2col.mtml

## default_templates/comments.mtml
	'Comment Form' => 'Kommentarformular',
	'[_1] Comments' => '[_1] Kommentare',

## lib/MT/Component.pm
	'Loading template \'[_1]\' failed: [_2]' => 'Laden der Vorlage \'[_1]\' fehlgeschlagen: [_2]',
	'Publish' => 'Veröffentlichen',
	'Uppercase text' => 'In Großschreibung',
	'Lowercase text' => 'In Kleinschreibung',
	'My Text Format' => 'Mein Textformat',

## lib/MT/XMLRPCServer.pm
	'Invalid timestamp format' => 'Ungültiges Zeitstempel-Format',
	'No web services password assigned.  Please see your user profile to set it.' => 'Kein Web Services-Passwort vorhanden. Bitte legen Sie auf Ihrer Profilseite eines fest.',
	'Failed login attempt by disabled user \'[_1]\'' => 'Fehlgeschlagener Anmeldeversuch von deaktiviertem Benutzer \'[_1]\'',
	'No blog_id' => 'blog_id fehlt',
	'Invalid blog ID \'[_1]\'' => 'Ungültige blog_id \'[_1]\'',
	'Invalid login' => 'Login ungültig',
	'No publishing privileges' => 'Keine Veröffentlichungsrechte',
	'Value for \'mt_[_1]\' must be either 0 or 1 (was \'[_2]\')' => '\'mt_[_1]\' kann nur 0 oder 1 sein (war \'[_2]\')',
	'PreSave failed [_1]' => 'PreSave fehlgeschlagen [_1]',
	'User \'[_1]\' (user #[_2]) added entry #[_3]' => 'Benutzer \'[_1]\' (#[_2]) hat Eintrag #[_3] hinzugefügt',
	'No entry_id' => 'entry_id fehlt',
	'Invalid entry ID \'[_1]\'' => 'Ungültige Eintrags-ID \'[_1]\'',
	'Not privileged to edit entry' => 'Keine Bearbeitungsrechte',
	'User \'[_1]\' (user #[_2]) edited entry #[_3]' => 'Benutzer \'[_1]\' (#[_2]) hat Eintrag #[_3] bearbeitet',
	'Not privileged to delete entry' => 'Keine Löschrechte',
	'Entry \'[_1]\' (entry #[_2]) deleted by \'[_3]\' (user #[_4]) from xml-rpc' => 'Eintrag \'[_1]\' (Eintrag #[_2]) von \'[_3]\' (Benutzer #[_4]) via XML-RPC gelöscht',
	'Not privileged to get entry' => 'Keine Leserechte',
	'User does not have privileges' => 'Benutzer hat keine Rechte',
	'Not privileged to set entry categories' => 'Keine Rechte, Kategorien zu vergeben',
	'Saving placement failed: [_1]' => 'Speichern von Platzierung fehlgeschlagen: [_1]',
	'Publish failed: [_1]' => 'Veröffentlichung fehlgeschlagen: [_1]',
	'Not privileged to upload files' => 'Keine Upload-Rechte',
	'No filename provided' => 'Kein Dateiname angegeben',
	'Invalid filename \'[_1]\'' => 'Ungültiger Dateiname \'[_1]\'',
	'Error making path \'[_1]\': [_2]' => 'Fehler beim Anlegen des Ordners \'[_1]\': [_2]',
	'Error writing uploaded file: [_1]' => 'Fehler beim Schreiben der hochgeladenen Datei: [_1]',
	'Perl module Image::Size is required to determine width and height of uploaded images.' => 'Das Perl-Modul Image::Size ist zur Bestimmung von Höhe und Breite hochgeladener Bilddateien erforderlich.',
	'Template methods are not implemented, due to differences between the Blogger API and the Movable Type API.' => 'Funktionen zum Zugriff auf Vorlagen sind auf Grund von Unterschieden zwischen der Blogger-API und der MovableType-API nicht implementiert.',

## lib/MT/ObjectDriver/Driver/DBD/SQLite.pm
	'Can\'t open \'[_1]\': [_2]' => 'Kann \'[_1]\' nicht öffnen: [_2]',

## lib/MT/ImportExport.pm
	'No Blog' => 'Kein Blog',
	'You need to provide a password if you are going to create new users for each user listed in your blog.' => 'Sollen für die Benutzer Ihres Blogs neue Benutzerkonten angelegt werden, müssen Sie ein Passwort angeben.',
	'Need either ImportAs or ParentAuthor' => 'Entweder ImportAs oder ParentAuthor erforderlich',
	'Importing entries from file \'[_1]\'' => 'Importieren der Einträge aus Datei \'[_1]\'',
	'Creating new user (\'[_1]\')...' => 'Lege neuen Benutzer an (\'[_1]\')...',
	'ok' => 'OK',
	'failed' => 'Fehlgeschlagen',
	'Saving user failed: [_1]' => 'Speichern von Benutzer fehlgeschlagen: [_1]',
	'Assigning permissions for new user...' => 'Weise neuem Benutzer Rechte zu...',
	'Saving permission failed: [_1]' => 'Speichern von Rechten fehlgeschlagen: [_1]',
	'Creating new category (\'[_1]\')...' => 'Lege neue Kategorie an (\'[_1]\')...',
	'Saving category failed: [_1]' => 'Speichern von Kategorie fehlgeschlagen: [_1]',
	'Invalid status value \'[_1]\'' => 'Ungültiger Status-Wert \'[_1]\'',
	'Invalid allow pings value \'[_1]\'' => 'Ungültiger Ping-Status \'[_1]\'',
	'Can\'t find existing entry with timestamp \'[_1]\'... skipping comments, and moving on to next entry.' => 'Kann vorhandenen Eintrag mit Zeitstempel \'[_1]\' nicht finden, überspringe Kommentare und fahre mit nächstem Eintrag fort...',
	'Importing into existing entry [_1] (\'[_2]\')' => 'Importiere in vorhandenen Eintrag [_1] (\'[_2]\')',
	'Saving entry (\'[_1]\')...' => 'Speichere Eintrag (\'[_1]\')...',
	'ok (ID [_1])' => 'OK',
	'Saving entry failed: [_1]' => 'Speichern von Eintrag fehlgeschlagen: [_1]',
	'Creating new comment (from \'[_1]\')...' => 'Lege neuen Kommentar an (von \'[_1]\')...',
	'Saving comment failed: [_1]' => 'Speichern von Kommentar fehlgeschlagen: [_1]',
	'Entry has no MT::Trackback object!' => 'Eintrag hat kein MT::Trackback-Objekt!',
	'Creating new ping (\'[_1]\')...' => 'Lege neuen Ping an (\'[_1]\')...',
	'Saving ping failed: [_1]' => 'Speichern von Ping fehlgeschlagen: [_1]',
	'Export failed on entry \'[_1]\': [_2]' => 'Export von \'[_1]\' fehlgeschlagen bei: [_2]',
	'Invalid date format \'[_1]\'; must be \'MM/DD/YYYY HH:MM:SS AM|PM\' (AM|PM is optional)' => 'Ungültiges Datumsformat \'[_1]\';  muss \'MM/TT/JJJJ HH:MM:SS AM|PM\' sein (AM|PM optional)',

## lib/MT/Util/Captcha.pm
	'Movable Type default CAPTCHA provider requires Image::Magick.' => 'Zur Nutzung der in Movable Type integrierten CAPTCHA-Quelle ist Image::Magick erforderlich.',
	'You need to configure CaptchaSourceImageBase.' => 'Bitte konfigurieren Sie CaptchaSourceImageBase',
	'Image creation failed.' => 'Bilderzeugung fehlgeschlagen.',
	'Image error: [_1]' => 'Bildfehler: [_1]',

## lib/MT/Import.pm
	'Can\'t rewind' => 'Kann nicht zurückspulen',
	'Can\'t open directory \'[_1]\': [_2]' => 'Kann Verzeichnis \'[_1]\' nicht öffnen: [_2]',
	'No readable files could be found in your import directory [_1].' => 'Im Import-Verzeichnis [_1] konnten keine lesbaren Dateien gefunden werden.',
	'Couldn\'t resolve import format [_1]' => 'Kann Importformat [_1] nicht auflösen',
	'Movable Type' => 'Movable Type',
	'Another system (Movable Type format)' => 'Anderes System (Movable Type-Format)',

## lib/MT/TemplateMap.pm
	'Archive Mapping' => 'Archiv-Verknüpfung',
	'Archive Mappings' => 'Archiv-Verknüpfungen',

## lib/MT/Comment.pm
	'Comment' => 'Kommentar',
	'Load of entry \'[_1]\' failed: [_2]' => 'Laden des Eintrags \'[_1]\' fehlgeschlagen: [_2]',
	'Load of blog \'[_1]\' failed: [_2]' => 'Weblog \'[_1]\' konnte nicht geladen werden: [_2]',

## lib/MT/App.pm
	'First Weblog' => 'Erstes Weblog',
	'Error loading weblog #[_1] for user provisioning. Check your NewUserTemplateBlogId setting.' => 'Fehler beim Laden von Weblog #[_1] zur Bereitstellung von Benutzerkonten. Bitte überprüfen Sie die NewUserTemplateBlogId-Einstellung.',
	'Error provisioning weblog for new user \'[_1]\' using template blog #[_2].' => 'Fehler beim Bereitstellen des Weblogs für neuen Benutzer \'[_1]\'. Verwendete Vorlage: Weblog #[_2].',
	'Error creating directory [_1] for blog #[_2].' => 'Fehler beim Anlegen des Ordners [_1] für Blog #[_2])',
	'Error provisioning weblog for new user \'[_1] (ID: [_2])\'.' => 'Fehler bei der Bereitstellung des persönlichen Blogs für Benutzer \'[_1] (ID: [_2])\'.',
	'Blog \'[_1] (ID: [_2])\' for user \'[_3] (ID: [_4])\' has been created.' => 'Blog \'[_1] (ID: [_2])\' für Benutzer \'[_3] (ID: [_4])\' erfolgreich angelegt.',
	'Error assigning weblog administration rights to user \'[_1] (ID: [_2])\' for weblog \'[_3] (ID: [_4])\'. No suitable weblog administrator role was found.' => 'Fehler bei der Vergabe von Administrationsrechten an Benutzer \'[_1] (ID: [_2])\' for weblog \'[_3] (ID: [_4])\': keine geeignete Administratorenrolle gefunden',
	'The login could not be confirmed because of a database error ([_1])' => 'Anmeldung konnte aufgrund eines Datenbankfehlers nicht durchgeführt werden ([_1])',
	'Invalid login.' => 'Login ungültig',
	'Failed login attempt by unknown user \'[_1]\'' => 'Fehlgeschlagener Anmeldeversuch von unbekanntem Benutzer \'[_1]\'',
	'This account has been disabled. Please see your system administrator for access.' => 'Dieses Benutzerkonto wurde gesperrt. Bitte wenden Sie sich an den Administrator.',
	'This account has been deleted. Please see your system administrator for access.' => 'Dieses Benutzerkonto wurde gelöscht. Bitte wenden Sie sich an den Administrator.',
	'User cannot be created: [_1].' => 'Kann Benutzer nicht anlegen: [_1].',
	'User \'[_1]\' has been created.' => 'Benutzerkonto \'[_1]\' angelegt.',
	'User \'[_1]\' (ID:[_2]) logged in successfully' => 'Benutzer \'[_1]\' (ID:[_2]) erfolgreich angemeldet',
	'Invalid login attempt from user \'[_1]\'' => 'Ungültiger Anmeldeversuch von Benutzer \'[_1]\'',
	'User \'[_1]\' (ID:[_2]) logged out' => 'Benutzer \'[_1]\' (ID:[_2]) abgemeldet',
	'Close' => 'Schließen',
	'Go Back' => 'Zurück',
	'The file you uploaded is too large.' => 'Die hochgeladene Datei ist zu gross',
	'Unknown action [_1]' => 'Unbekannte Aktion [_1]',
	'Permission denied.' => 'Keine Berechtigung.',
	'Warnings and Log Messages' => 'Warnungen und Logmeldungen',
	'Removed [_1].' => '[_1] entfernt.',
	'http://www.movabletype.com/' => 'http://www.movabletype.com/',

## lib/MT/Page.pm
	'Page' => 'Seite',
	'Pages' => 'Seiten',
	'Folder' => 'Ordner',
	'Load of blog failed: [_1]' => 'Laden des Weblogs fehlgeschlagen: [_1]',

## lib/MT/XMLRPC.pm
	'No WeblogsPingURL defined in the configuration file' => 'Keine WeblogsPingURL in der Konfigurationsdatei definiert',
	'No MTPingURL defined in the configuration file' => 'Keine MTPingURL in der Konfigurationsdatei definiert',
	'HTTP error: [_1]' => 'HTTP-Fehler: [_1]',
	'Ping error: [_1]' => 'Ping-Fehler: [_1]',

## lib/MT/Core.pm
	'System Administrator' => 'Systemadministrator',
	'Create Blogs' => 'Blogs anlegen',
	'Manage Plugins' => 'Plugins verwalten',
	'View System Activity Log' => 'Systemaktivitätsprotokoll einsehen',
	'Blog Administrator' => 'Blog-Administrator',
	'Configure Blog' => 'Blog konfigurieren',
	'Set Publishing Paths' => 'Veröffentlichungspfade setzen',
	'Manage Categories' => 'Kategorien verwalten',
	'Manage Tags' => 'Tags verwalten',
	'Manage Notification List' => 'Benachrichtigungen verwalten',
	'View Activity Log' => 'Aktivitätsprotokoll anzeigen',
	'Create Entries' => 'Neuer Eintrag',
	'Publish Post' => 'Eintrag veröffentlichen',
	'Send Notifications' => 'Benachrichtigungen versenden',
	'Edit All Entries' => 'Alle Einträge bearbeiten',
	'Manage Pages' => 'Seiten verwalten',
	'Publish Files' => 'Dateien veröffentlichen', # Translate - New # OK
	'Manage Templates' => 'Vorlagen verwalten',
	'Upload File' => 'Dateiupload',
	'Save Image Defaults' => 'Bild-Voreinstellungen speichern',
	'Manage Files' => 'Dateien verwalten',
	'Post Comments' => 'Kommentare schreiben',
	'Manage Feedback' => 'Feedback verwalten',
	'MySQL Database' => 'MySQL-Datenbank',
	'PostgreSQL Database' => 'PostgreSQL-Datenbank',
	'SQLite Database' => 'SQLite-Datenbank',
	'SQLite Database (v2)' => 'SQLite-Datenbank (v2)',
	'Convert Line Breaks' => 'Zeilenumbrüche konvertieren',
	'Rich Text' => 'Rich Text',
	'weblogs.com' => 'weblogs.com',
	'technorati.com' => 'technorati.com',
	'google.com' => 'google.com',
	'Publishes content.' => 'Veröffentlicht Inhalte.', # Translate - New # OK
	'Synchronizes content to other server(s).' => 'Synchronisiert Inhalte mit anderen Servern', # Translate - New # OK
	'Entries List' => 'Eintragsverzeichnis',
	'Blog URL' => 'Blog-URL',
	'Blog ID' => 'Blog-ID',
	'Blog Name' => 'Weblog-Name',
	'Entry Body' => 'Eintragstext',
	'Entry Excerpt' => 'Eintragsauszug',
	'Entry Link' => 'Eintragslink',
	'Entry Extended Text' => 'Erweiterter Eintragstext',
	'Entry Title' => 'Eintragstitel',
	'If Block' => 'If-Block',
	'If/Else Block' => 'If-Else-Block',
	'Include Template Module' => 'Include-Vorlagenmodul',
	'Include Template File' => 'Include-Vorlagendatei',
	'Get Variable' => 'Variable lesen',
	'Set Variable' => 'Variable setzen',
	'Set Variable Block' => 'Variablenblock setzen',
	'Publish Future Posts' => 'Zukünftige Einträge veröffentlichen',
	'Junk Folder Expiration' => 'Junk-Ordner-Einstellungen',
	'Remove Temporary Files' => 'Temporäre Dateien löschen',

## lib/MT/Asset/Image.pm
	'Image' => 'Bild',
	'Images' => 'Bilder',
	'Actual Dimensions' => 'Tatsächliche Größe',
	'[_1] wide, [_2] high' => '[_1] breit, [_2] hoch',
	'Error scaling image: [_1]' => 'Fehler bei der Skalierung: [_1]',
	'Error creating thumbnail file: [_1]' => 'Fehler beim Erzeugen des Vorschaubilds: [_1]',
	'Can\'t load image #[_1]' => 'Kann Bild #[_1] nicht laden',
	'View image' => 'Bild ansehen',
	'Permission denied setting image defaults for blog #[_1]' => 'Keine Benutzerrechte zur Einstellung der Bild-Voreinstellungen für Weblog #[_1]',
	'Thumbnail failed: [_1]' => 'Thumbnail fehlgeschlagen: [_1]',
	'Invalid basename \'[_1]\'' => 'Ungültiger Basename \'[_1]\'',
	'Error writing to \'[_1]\': [_2]' => 'Fehler beim Schreiben auf \'[_1]\': [_2]',

## lib/MT/BackupRestore.pm
	'Backing up [_1] records:' => 'Sichere [_1]-Einträge:',
	'[_1] records backed up...' => '[_1]-Einträge gesichert...',
	'[_1] records backed up.' => '[_1]-Einträge gesichert.',
	'There were no [_1] records to be backed up.' => 'Keine [_1]-Einträge zu speichern.',
	'No manifest file could be found in your import directory [_1].' => 'Keine Manifest-Datei im Importverzeichnis [_1] gefunden.',
	'Can\'t open [_1].' => 'Kann [_1] nicht öffnen.',
	'Manifest file [_1] was not a valid Movable Type backup manifest file.' => 'Manifest-Datei [_1] ist keine gültige Movable Type Backup-Manifest-Datei.',
	'Manifest file: [_1]' => 'Manifest-Datei: [_1]',
	'Path was not found for the file ([_1]).' => 'Pfad zu Datei ([_1]) nicht gefunden.',
	'[_1] is not writable.' => 'Kein Schreibzugriff auf [_1]',
	'Copying [_1] to [_2]...' => 'Kopiere [_1] nach [_2]...',
	'Failed: ' => 'Fehler: ',
	'Done.' => 'Fertig.',
	'ID for the file was not set.' => 'ID für Datei nicht gesetzt.',
	'The file ([_1]) was not restored.' => 'Datei ([_1]) nicht wiederhergestellt.',
	'Changing path for the file \'[_1]\' (ID:[_2])...' => 'Ändere Pfad für Datei \'[_1]\' (ID:[_2])....',

## lib/MT/BackupRestore/ManifestFileHandler.pm
	'Uploaded file was not a valid Movable Type backup manifest file.' => 'Die hochgeladene Datei ist keine gültige Movable Type Backup-Manifest-Datei.',

## lib/MT/BackupRestore/BackupFileHandler.pm
	'Uploaded file was backed up from Movable Type with the newer schema version ([_1]) than the one in this system ([_2]).  It is not safe to restore the file to this version of Movable Type.' => 'Die hochgeladene Datei wurde aus einer Movable Type-Installation mit einer neueren Schema-Version ([_1]) als der hier vorhandenen ([_2]) gesichert. Es wird daher nicht empfohlen, die Datei mit dieser Movable Type-Version zu verwenden.',
	'[_1] is not a subject to be restored by Movable Type.' => '[_1] ist keine Eigenschaft, die von Movable Type wiederhergestellt wird.',
	'[_1] records restored.' => '[_1]-Einträge wiederhergestellt.',
	'Restoring [_1] records:' => 'Stelle [_1]-Einträge wieder her:',
	'User with the same name \'[_1]\' found (ID:[_2]).  Restore replaced this user with the data backed up.' => 'Benutzer mit gleichem Namen \'[_1]\' gefunden (ID:[_2]).  Die Benutzerdaten wurden entsprechend ersetzt.',
	'Tag \'[_1]\' exists in the system.' => 'Tag \'[_1]\' bereits im System vorhanden.',
	'Trackback for entry (ID: [_1]) already exists in the system.' => 'TrackBack für Eintrag (ID: [_1]) bereits im System vorhanden.',
	'Trackback for category (ID: [_1]) already exists in the system.' => 'TrackBack für Kategorie (ID: [_1]) bereits im System vorhanden.',
	'[_1] records restored...' => '[_1] Einträge wiederhergstellt...',

## lib/MT/Folder.pm
	'Folders' => 'Ordner',

## lib/MT/DefaultTemplates.pm
	'Archive Index' => 'Archivindex',
	'Stylesheet - Main' => 'Stylesheet - Hauptdatei',
	'Stylesheet - Base Theme' => 'Stylesheet - Basisthema',
	'JavaScript' => 'JavaScript',
	'RSD' => 'RSD',
	'Atom' => 'ATOM',
	'RSS' => 'RSS',
	'Entry' => 'Eintrag',
	'Entry Listing' => 'Eintragsverzeichnis',
	'Comment Response' => 'Kommentarantworten', # Translate - New # OK
	'Shown for a comment error, pending or confirmation message.' => 'Wird bei Fehler-, Moderations- und Bestätigungsmeldungen für Kommentarautoren angezeigt.', # Translate - New # OK
	'Comment Preview' => 'Kommentarvorschau',
	'Shown when a commenter previews their comment.' => 'Wird angezeigt, wenn ein Kommentarautor eine Vorschau auf seinen Kommentar anzeigen lässt.',
	'Dynamic Error' => 'Dynamischer Fehler',
	'Shown when an error is encountered on a dynamic blog page.' => 'Wird angezeigt, wenn ein Fehler auf einer dynamischen Seite angezeigt wird.',
	'Popup Image' => 'Popup-Bild',
	'Shown when a visitor clicks a popup-linked image.' => 'Wird angezeigt, wenn ein Leser auf ein mit einem Popup-Fenster verlinktes Bild klickt.',
	'Shown when a visitor searches the weblog.' => 'Wird bei Suchvorgängen angezeigt.',
	'Footer' => 'Fußzeile',
	'Sidebar - 2 Column Layout' => 'Seitenleiste - zweispaltiges Layout', # Translate - New # OK

## lib/MT/Plugin/JunkFilter.pm
	'[_1]: [_2][_3] from rule [_4][_5]' => '[_1]: [_2][_3] aus Regel [_4][_5]',
	'[_1]: [_2][_3] from test [_4]' => '[_1]: [_2][_3] aus Test [_4]',

## lib/MT/TaskMgr.pm
	'Unable to secure lock for executing system tasks. Make sure your TempDir location ([_1]) is writable.' => 'Konnte Lock für Systemtask nicht setzen. Stellen Sie sicher, daß Schreibrechte für das TempDir ([_1]) vorhanden sind.',
	'Error during task \'[_1]\': [_2]' => 'Fehler während Task \'[_1]\': [_2]',
	'Scheduled Tasks Update' => 'Aktualisierung geplanter Aufgaben',
	'The following tasks were run:' => 'Folgende Tasks wurden ausgeführt:',

## lib/MT/AtomServer.pm

## lib/MT/Scorable.pm
	'Already scored for this object.' => 'Bewertung für dieses Objekt bereits abgegeben.',
	'Can not set score to the object \'[_1]\'(ID: [_2])' => 'Kann \'[_1]\'(ID: [_2]) keine Bewertung zuweisen',

## lib/MT/Notification.pm
	'Contact' => 'Kontakt', # Translate - New # OK
	'Contacts' => 'Kontakte', # Translate - New # OK

## lib/MT/Compat/v3.pm
	'uses: [_1], should use: [_2]' => 'verwendet [_1], sollte [_2] verwenden',
	'uses [_1]' => 'verwendet [_1]',
	'No executable code' => 'Kein ausführbarer Code',
	'Publish-option name must not contain special characters' => 'Der Optionsname darf keine Sonderzeichen enthalten.', # Translate - New # OK

## lib/MT/Author.pm
	'The approval could not be committed: [_1]' => 'Konnte nicht übernommen werden: [_1]',

## lib/MT/Template/Context.pm
	'The attribute exclude_blogs cannot take \'all\' for a value.' => '\'all\' ist kein gültiges exclude_blogs-Parameter.',

## lib/MT/Template/ContextHandlers.pm
	'Remove this widget' => 'Dieses Widget entfernen',
	'[_1]Publish[_2] your site to see these changes take effect.' => '[_1]Veröffentlichen[_2] Sie Ihre Site, um die Änderungen wirksam werden zu lassen.', # Translate - New # OK
	'Plugin Actions' => 'Plugin-Aktionen',
	'Warning' => 'Warnung',
	'No [_1] could be found.' => 'Kein [_1] gefunden.',
	'Recursion attempt on [_1]: [_2]' => 'Rekursionsversuch bei [_1]: [_2]',
	'Can\'t find included template [_1] \'[_2]\'' => 'Kann verwendete Vorlage [_1] \'[_2]\' nicht finden',
	'Can\'t find blog for id \'[_1]' => 'Kann Blog für ID \'[_1]\' nicht finden',
	'Can\'t find included file \'[_1]\'' => 'Kann verwendete Datei \'[_1]\' nicht finden',
	'Error opening included file \'[_1]\': [_2]' => 'Fehler beim Öffnen der verwendeten Datei \'[_1]\': [_2]',
	'Recursion attempt on file: [_1]' => 'Rekursionsversuch bei Datei [_1]',
	'Unspecified archive template' => 'Nicht spezifizierte Archiv-Vorlage',
	'Error in file template: [_1]' => 'Fehler in Datei-Vorlage: [_1]',
	'Can\'t load template' => 'Kann Vorlage nicht laden',
	'Can\'t find template \'[_1]\'' => 'Kann Vorlage \'[_1]\' nicht finden',
	'Can\'t find entry \'[_1]\'' => 'Kann Eintrag \'[_1]\' nicht finden',
	'[_1] [_2]' => '[_1] [_2]',
	'You used a [_1] tag without any arguments.' => 'Sie haben einen [_1]-Tag ohne Argument verwendet.',
	'You used an \'[_1]\' tag outside of the context of a author; perhaps you mistakenly placed it outside of an \'MTAuthors\' container?' => 'Sie haben ein \'[_1]\'-Tag außerhalb eines Autoren-Kontexts verwendet - \'MTAuthors\'-Container erforderlich',
	'Author (#[_1])' => 'Autor (#[_1])', # Translate - New # OK
	'You have an error in your \'[_2]\' attribute: [_1]' => 'Fehler im \'[_2]\'-Attribut: [_1]',
	'You have an error in your \'tag\' attribute: [_1]' => 'Fehler im \'tag\'-Attribut: [_1]',
	'No such user \'[_1]\'' => 'Kein Benutzer \'[_1]\'',
	'You used an \'[_1]\' tag outside of the context of an entry; perhaps you mistakenly placed it outside of an \'MTEntries\' container?' => '\'[_1]\'-Tag außerhalb eines Eintrags-Kontexts verwendet - \'MTEntries\'-Container erforderlich.',
	'You used <$MTEntryFlag$> without a flag.' => 'Sie haben <$MTEntryFlag$> ohne Flag verwendet.',
	'You used an [_1] tag for linking into \'[_2]\' archives, but that archive type is not published.' => 'Sie haben mit einem [_1]-Tag \'[_2]\'-Archive verlinkt, ohne diese vorher zu veröffentlichen.',
	'Could not create atom id for entry [_1]' => 'Konnte keine ATOM-ID für Eintrag [_1] erzeugen',
	'To enable comment registration, you need to add a TypeKey token in your weblog config or user profile.' => 'Um Registierung von Kommentarautoren zu ermöglichen geben Sie ein TypeKey-Token in den Weblogeinstellungen oder dem Benutzerenprofil an.',
	'You used an [_1] tag without a date context set up.' => 'Sie haben einen [_1]-Tag ohne Datumskontext verwendet.',
	'You used an \'[_1]\' tag outside of the context of a comment; perhaps you mistakenly placed it outside of an \'MTComments\' container?' => '\'[_1]\'-Tag außerhalb eines Kommentar-Kontexts verwendet - \'MTComments\'-Container erforderlich.',
	'[_1] can be used only with Daily, Weekly, or Monthly archives.' => '[_1] kann nur mit Tages-, Wochen- oder Monatsarchiven verwendet werden.',
	'Group iterator failed.' => 'Gruppeniterator fehlgeschlagen.',
	'You used an [_1] tag outside of the proper context.' => 'Sie haben ein [_1]-Tag außerhalb seines Kontexts verwendet.',
	'Could not determine entry' => 'Konnte Eintrag nicht bestimmen',
	'Invalid month format: must be YYYYMM' => 'Ungültiges Datumsformat: richtig ist JJJJMM',
	'No such category \'[_1]\'' => 'Keine Kategorie \'[_1]\'',
	'<\$MTCategoryTrackbackLink\$> must be used in the context of a category, or with the \'category\' attribute to the tag.' => '<\$MTCategoryTrackbackLink\$> muss im Kategoriekontext stehen oder mit dem \'category\'-Attribut des Tags.',
	'You failed to specify the label attribute for the [_1] tag.' => 'Kein Label-Attribut des [_1]-Tags angegeben.',
	'You used an \'[_1]\' tag outside of the context of a ping; perhaps you mistakenly placed it outside of an \'MTPings\' container?' => '\'[_1]\'-Tag außerhalb eines Ping-Kontextes verwendet - \'MTPings\'-Container erforderlich.',
	'[_1] used outside of [_2]' => '[_1] außerhalb [_2] verwendet',
	'MT[_1] must be used in a [_2] context' => 'MT[_1] muss in einem [_2]-Kontext stehen',
	'Cannot find package [_1]: [_2]' => 'Kann Paket [_1] nicht finden: [_2]',
	'Error sorting [_2]: [_1]' => 'Fehler beim Sortieren von [_2]: [_1]',
	'Edit' => 'Bearbeiten',
	'You used an \'[_1]\' tag outside of the context of an asset; perhaps you mistakenly placed it outside of an \'MTAssets\' container?' => '\'[_1]\'-Tag außerhalb eines Asset-Kontexts verwendet - möglicherweise außerhalb eines \'MTAssets\'-Containers?',
	'You used an \'[_1]\' tag outside of the context of an page; perhaps you mistakenly placed it outside of an \'MTPages\' container?' => '\'[_1]\'-Tag außerhalb eines Seiten-Kontexts verwendet - möglicherweise außerhalb eines \'MTPages\'-Containers?',
	'You used an [_1] without a author context set up.' => '[_1] ohne vorhandenen Autorenkontext verwendet.',
	'Can\'t load blog.' => 'Kann Weblog nicht lande # OK.',
	'Can\'t load user.' => 'Kann Benutzer nicht landen.',

## lib/MT/Image.pm
	'Can\'t load Image::Magick: [_1]' => 'Image::Magick kann nicht geladen werden: [_1]',
	'Reading file \'[_1]\' failed: [_2]' => 'Datei \'[_1]\' kann nicht gelesen werden: [_2]',
	'Reading image failed: [_1]' => 'Bild kann nicht geladen werden: [_1]',
	'Scaling to [_1]x[_2] failed: [_3]' => 'Skalieren auf [_1]x[_2] fehlgeschlagen: [_3]',
	'Can\'t load IPC::Run: [_1]' => 'IPC::Run kann nicht geladen werden: [_1]',
	'You do not have a valid path to the NetPBM tools on your machine.' => 'Kein gültiger Pfad auf NetPBM-Tools eingestellt.',

## lib/MT/ConfigMgr.pm
	'Alias for [_1] is looping in the configuration.' => 'Alias für [_1] bildet eine Schleife.',
	'Error opening file \'[_1]\': [_2]' => 'Fehler beim Öffnen der Datei \'[_1]\': [_2]',
	'Config directive [_1] without value at [_2] line [_3]' => 'Konfigurationsanweisung [_1] ohne Wert [_2] in Zeile [_3]',
	'No such config variable \'[_1]\'' => 'Konfigurationsvariable \'[_1]\' nicht vorhanden oder nicht existent',

## lib/MT/Log.pm
	'System' => 'System',
	'Page # [_1] not found.' => 'Seite # [_1] nicht gefunden.',
	'Entries' => 'Einträge',
	'Entry # [_1] not found.' => 'Eintrag #[_1] nicht gefunden.',
	'Comment # [_1] not found.' => 'Kommentar #[_1] nicht gefunden.',
	'TrackBack # [_1] not found.' => 'TrackBack #[_1] nicht gefunden.',

## lib/MT/Auth/OpenID.pm
	'Could not discover claimed identity: [_1]' => 'Konnte angegebene Identität nicht finden: [_1]',
	'Couldn\'t save the session' => 'Session konnte nicht gespeichert werden',

## lib/MT/Auth/MT.pm
	'Passwords do not match.' => 'Passwörter stimmen nicht überein.',
	'Failed to verify current password.' => 'Kann Passwort nicht überprüfen.',
	'Password hint is required.' => 'Passwort-Erinnerungssatz erforderlich.',

## lib/MT/Auth/TypeKey.pm
	'Sign in requires a secure signature.' => 'Die Anmeldung erfordert eine sichere Signatur.',
	'The sign-in validation failed.' => 'Anmeldung fehlgeschlagen.',
	'This weblog requires commenters to pass an email address. If you\'d like to do so you may log in again, and give the authentication service permission to pass your email address.' => 'Kommentarautoren müssen eine Email-Adresse angeben. Wenn Sie das tun möchten, melden Sie sich an und erlauben Sie dem Authentifizierungsdienst, Ihre Email-Adresse weiterzuleiten.',
	'This weblog requires commenters to pass an email address' => 'Kommentarautoren müssen eine Email-Adresse angeben',
	'Couldn\'t get public key from url provided' => 'Public Key konnte von der angegebenen Adresse nicht gelesen werden',
	'No public key could be found to validate registration.' => 'Kein Public Key zur Validierung gefunden.',
	'TypeKey signature verif\'n returned [_1] in [_2] seconds verifying [_3] with [_4]' => 'TypeKey-Signaturbestätigung gab [_1] zurück (nach [_2] Sekunden) und bestätigte [_3] mit [_4]',
	'The TypeKey signature is out of date ([_1] seconds old). Ensure that your server\'s clock is correct' => 'Die TypeKey-Signatur ist veraltet ([_1] seconds old). Stellen Sie sicher, daß die Uhr Ihres Servers richtig geht.',

## lib/MT/Mail.pm
	'Unknown MailTransfer method \'[_1]\'' => 'Unbekannte MailTransfer-Methode \'[_1]\'',
	'Sending mail via SMTP requires that your server have Mail::Sendmail installed: [_1]' => 'Für das Versenden von Email mittels SMTP ist Mail::Sendmail erforderlich: [_1]',
	'Error sending mail: [_1]' => 'Fehler beim Versenden von Mail: [_1]',
	'You do not have a valid path to sendmail on your machine. Perhaps you should try using SMTP?' => 'Kein gültiger sendmail-Pfad gefunden. Versuchen Sie stattdessen SMTP zu verwenden.',
	'Exec of sendmail failed: [_1]' => 'Ausführung von sendmail fehlgeschlagen: [_1]',

## lib/MT/JunkFilter.pm
	'Action: Junked (score below threshold)' => 'Aktion: Junked (Score unterschreitet Grenzwert)',
	'Action: Published (default action)' => 'Aktion: Veröffentlicht (Standardaktion)',
	'Junk Filter [_1] died with: [_2]' => 'Junk-Filter [_1] abgebrochen: [_2]',
	'Unnamed Junk Filter' => 'Namenloser Junk Filter',
	'Composite score: [_1]' => 'Gesamt-Score: [_1]',

## lib/MT/TBPing.pm
	'TrackBack' => 'TrackBack',

## lib/MT/Util.pm
	'moments from now' => 'In einem Augenblick',
	'moments ago' => 'Vor einem Augenblick',
	'[quant,_1,hour,hours] from now' => 'In [quant,_1,Stunde,Stunden]',
	'[quant,_1,hour,hours] ago' => 'Vor [quant,_1,Stunde,Stunden]',
	'[quant,_1,minute,minutes] from now' => 'In [quant,_1,Minute,Minuten]',
	'[quant,_1,minute,minutes] ago' => 'Vor [quant,_1,Minute,Minuten]',
	'[quant,_1,day,days] from now' => 'In [quant,_1,Tag,Tagen]',
	'[quant,_1,day,days] ago' => 'Vor [quant,_1,Tag,Tagen]',
	'less than 1 minute from now' => 'In weniger als 1 Minute',
	'less than 1 minute ago' => 'Vor weniger als 1 Minute',
	'[quant,_1,hour,hours], [quant,_2,minute,minutes] from now' => 'In [quant,_1,Stunde,Stunden] [quant,_1,Minute,Minuten]',
	'[quant,_1,hour,hours], [quant,_2,minute,minutes] ago' => 'Vor [quant,_1,Stunde,Stunden] [quant,_1,Minute,Minuten]',
	'[quant,_1,day,days], [quant,_2,hour,hours] from now' => 'In [quant,_1,Tag,Tagen] [quant,_1,Stunde,Stunden]',
	'[quant,_1,day,days], [quant,_2,hour,hours] ago' => 'Vor [quant,_1,Tag,Tagen] [quant,_1,Stunde,Stunden]',

## lib/MT/WeblogPublisher.pm
	'yyyy/index.html' => 'jjjj/index.html',
	'yyyy/mm/index.html' => 'jjjj/mm/index.html',
	'yyyy/mm/day-week/index.html' => 'jjjj/mm/Tag-Woche/index.html',
	'yyyy/mm/entry-basename.html' => 'jjjj/mm/Eintrags-Name.html',
	'yyyy/mm/entry_basename.html' => 'jjjj/mm/Eintrags_Name.html',
	'yyyy/mm/entry-basename/index.html' => 'jjjj/mm/Eintrags-Name/index.html',
	'yyyy/mm/entry_basename/index.html' => 'jjjj/mm/Eintrags_Name/index.html',
	'yyyy/mm/dd/entry-basename.html' => 'jjjj/mm/tt/Eintrags-Name.html',
	'yyyy/mm/dd/entry_basename.html' => 'jjjj/mm/tt/Eintrags_Name.html',
	'yyyy/mm/dd/entry-basename/index.html' => 'jjjj/mm/tt/Eintrags-Name/index.html',
	'yyyy/mm/dd/entry_basename/index.html' => 'jjjj/mm/tt/Eintrags_Name/index.html',
	'category/sub-category/entry-basename.html' => 'Kategorie/Unter-Kategorie/Eintrags-Name.html',
	'category/sub-category/entry-basename/index.html' => 'Kategorie/Unter-Kategorie/Eintrags-Name/index.html',
	'category/sub_category/entry_basename.html' => 'Kategorie/Unter_Kategorie/Eintrags_Name.html',
	'category/sub_category/entry_basename/index.html' => 'Kategorie/Unter_Kategorie/Eintrags_Name/index.html',
	'folder-path/page-basename.html' => 'Ordner-Pfad/Seiten-Name.html',
	'folder-path/page-basename/index.html' => 'Ordner-Pfad/Seiten-Name/index.html',
	'folder_path/page_basename.html' => 'Ordner_Pfad/Seiten_Name.html',
	'folder_path/page_basename/index.html' => 'Ordner_Pfad/Seiten_Name/index.html',
	'folder/sub_folder/index.html' => 'Ordner/Unter_Ordner/index.html',
	'folder/sub-folder/index.html' => 'Ordner/Unter_Ordner/index.html',
	'yyyy/mm/dd/index.html' => 'jjjj/mm/tt/index.html',
	'category/sub-category/index.html' => 'Kategorie/Unter-Kategorie/index.html',
	'category/sub_category/index.html' => 'Kategorie/Unter_Kategorie/index.html',
	'Archive type \'[_1]\' is not a chosen archive type' => 'Archivtyp \'[_1]\' wurde vorher nicht ausgewählt',
	'Parameter \'[_1]\' is required' => 'Parameter \'[_1]\' erforderlich',
	'You did not set your blog publishing path' => 'Veröffentlichungspfade nicht gesetzt', # Translate - New # OK
	'The same archive file exists. You should change the basename or the archive path. ([_1])' => 'Diese Archivdatei existiert bereits. Ändern Sie entweder den Basename oder den Archivpfad. ([_1])',
	'An error occurred publishing category \'[_1]\': [_2]' => 'Fehler bei Veröffentlichung der Kategorie \'[_1]\': [_2]',
	'An error occurred publishing entry \'[_1]\': [_2]' => 'Fehler bei Veröffentlichung des Eintrags \'[_1]\': [_2]',
	'An error occurred publishing date-based archive \'[_1]\': [_2]' => 'Fehler bei Veröffentlichtung des Archivs \'[_1]\': [_2]',
	'Writing to \'[_1]\' failed: [_2]' => 'Schreien auf \'[_1]\' fehlgeschlagen: [_2]',
	'Renaming tempfile \'[_1]\' failed: [_2]' => 'Umbenennung der temporären Datei \'[_1]\' fehlgeschlagen: [_2]',
	'Template \'[_1]\' does not have an Output File.' => 'Vorlage \'[_1]\' hat keine Ausgabedatei.',
	'An error occurred while publishing scheduled entries: [_1]' => 'Fehler bei der Veröffentlichung zeitgeplanter Einträge: [_1]',
	'YEARLY_ADV' => 'YEARLY_ADV',
	'MONTHLY_ADV' => 'Monatlich',
	'CATEGORY_ADV' => 'Kategorie',
	'PAGE_ADV' => 'PAGE_ADV',
	'INDIVIDUAL_ADV' => 'Einzeln',
	'DAILY_ADV' => 'Täglich',
	'WEEKLY_ADV' => 'Wöchentlich',

## lib/MT/Asset.pm
	'File' => 'Datei',
	'Files' => 'Dateien',
	'Description' => 'Beschreibung',
	'Location' => 'Ort',

## lib/MT/BasicAuthor.pm
	'authors' => 'Autoren',

## lib/MT/App/Comments.pm
	'Error assigning commenting rights to user \'[_1] (ID: [_2])\' for weblog \'[_3] (ID: [_4])\'. No suitable commenting role was found.' => 'Fehler bei der Zuweisung von Kommentierungsrechten an Benutzer \'[_1] (ID: [_2])\' für Weblog \'[_3] (ID: [_4])\'. Keine geeignete Kommentierungsrolle gefunden.',
	'Invalid commenter login attempt from [_1] to blog [_2](ID: [_3]) which does not allow Movable Type native authentication.' => 'Ungültiger Anmeldeversuch von Kommetarautor [_1] an Weblog [_2](ID: [_3]) - native Movable Type-Authentifizierung nicht in diesem Weblog nicht zulässig.',
	'Login failed: permission denied for user \'[_1]\'' => 'Login fehlgeschlagen: Zugriff verweigert für Benutzer \'[_1]\'',
	'Login failed: password was wrong for user \'[_1]\'' => 'Login fehlgeschlagen: falsches Passwort für Benutzer \'[_1]\'',
	'Signing up is not allowed.' => 'Anmelden nicht erlaubt.',
	'User requires username.' => 'Benutzername für Benutzer erforderlich.',
	'User requires display name.' => 'Anzeigename für Benutzer erforderlich.',
	'A user with the same name already exists.' => 'Ein Benutzer mit diesem Namen existiert bereits.',
	'User requires password.' => 'Passwort für Benutzer erforderlich.',
	'User requires password recovery word/phrase.' => 'Passwort-Erinnerungsfrage für Benutzer erforderlich.',
	'Email Address is invalid.' => 'E-Mail-Adresse ungültig.',
	'Email Address is required for password recovery.' => 'E-Mail-Addresse zur Erzeugung eines neuen Passworts erforderlich .',
	'URL is invalid.' => 'URL ist ungültig.',
	'Text entered was wrong.  Try again.' => 'Der eingegebene Text ist falsch. Bitte versuchen Sie es erneut.',
	'Something wrong happened when trying to process signup: [_1]' => 'Bei der Bearbeitung der Registrierung ist ein Fehler aufgetreten: [_1]',
	'Movable Type Account Confirmation' => 'Movable Type-Anmeldungsbestätigung',
	'System Email Address is not configured.' => 'System-E-Mail-Adresse nicht konfiguriert.',
	'Commenter \'[_1]\' (ID:[_2]) has been successfully registered.' => 'Kommentarautor \'[_1]\' (ID:[_2]) erfolgreich registriert.',
	'Thanks for the confirmation.  Please sign in to comment.' => 'Vielen Dank für Ihre Bestätigung. Sie können sich jetzt anmelden und kommentieren.',
	'[_1] registered to the blog \'[_2]\'' => '[_1] registiert für Weblog \'[_2]\'',
	'No id' => 'Keine ID',
	'No such comment' => 'Kein entsprechender Kommentar',
	'IP [_1] banned because comment rate exceeded 8 comments in [_2] seconds.' => 'IP [_1] gesperrt, da mehr als 8 Kommentare in [_2] Sekunden abgegeben wurden.',
	'IP Banned Due to Excessive Comments' => 'IP gesperrt - zu viele Kommentare',
	'_THROTTLED_COMMENT_EMAIL' => 'Die IP-Adresse [_3] wurde automatisch gesperrt, da ein Besucher in den letzten [_2] Sekunden mehr Kommentaren als zulässig in Ihrem [_1] zu veröffentlichen versucht hat. Diese Sperre schützt Ihr Blog vor Spam-Angriffen. Sollte diese Sperrung ein Irrtum sein, können Sie die IP-Adresse wieder entsperren. Löschen Sie dazu die Adresse [_4] auf der IP-Sperrliste.',
	'Invalid request' => 'Ungültige Anfrage',
	'No such entry \'[_1]\'.' => 'Kein Eintrag \'[_1]\'.',
	'You are not allowed to add comments.' => 'Sie sind nicht berechtigt, Kommentare hinzuzufügen.',
	'_THROTTLED_COMMENT' => 'Sie haben zu viele Kommentare in kurzer Folge abgegeben. Zum Schutz vor Spam steht Ihnen die Kommentarfunktion daher erst wieder in einigen Augenblicken zur Verfügung. Vielen Dank für Ihr Verständnis.',
	'Comments are not allowed on this entry.' => 'Bei diesem Eintrag sind Kommentare nicht erlaubt.',
	'Comment text is required.' => 'Kommentartext ist Pflichtfeld.',
	'An error occurred: [_1]' => 'Es ist ein Fehler aufgetreten: [_1]',
	'Registration is required.' => 'Registrierung ist erforderlich.',
	'Name and email address are required.' => 'Name und Email sind Pflichtfelder.',
	'Invalid email address \'[_1]\'' => 'Ungültige Email-Adresse \'[_1]\'',
	'Invalid URL \'[_1]\'' => 'Ungültige URL \'[_1]\'',
	'Comment save failed with [_1]' => 'Speichern des Kommentars fehlgeschlagen: [_1]',
	'Comment on "[_1]" by [_2].' => 'Kommentar zu "[_1]" von [_2].',
	'Commenter save failed with [_1]' => 'Speichern des Kommentarautorens fehlgeschlagen: [_1]',
	'Failed comment attempt by pending registrant \'[_1]\'' => 'Fehlgeschlagener Kommentierungsversuch durch schwebenden Kommentarautoren \'[_1]\'',
	'Registered User' => 'Registrierter Benutzer',
	'New Comment Added to \'[_1]\'' => 'Neuer Kommentar zu \'[_1]\' hinzugefügt',
	'The sign-in attempt was not successful; please try again.' => 'Sign-in war nicht erfolgreich; bitte erneut versuchen.',
	'The sign-in validation was not successful. Please make sure your weblog is properly configured and try again.' => 'Validierung des Sign-ins war nicht erfolgreich. Bitte Konfiguration überprüfen und erneut versuchen.',
	'No such entry ID \'[_1]\'' => 'Keine Eintrags-ID \'[_1]\'',
	'No entry was specified; perhaps there is a template problem?' => 'Es wurde kein Eintrag angegeben. Vielleicht gibt es ein Problem mit der Vorlage?',
	'Somehow, the entry you tried to comment on does not exist' => 'Der Eintrag, den Sie kommentieren möchten, existiert nicht.',
	'Invalid commenter ID' => 'Ungültige Kommentarautoren-ID',
	'No entry ID provided' => 'Keine Eintrags-ID angegeben',
	'Permission denied' => 'Zugriff verweigert',
	'All required fields must have valid values.' => 'Alle erforderlichen Felder müssen gültige Werte aufweisen.',
	'Commenter profile has successfully been updated.' => 'Kommentarautoren-Profil erfolgreich aktualisiert.',
	'Commenter profile could not be updated: [_1]' => 'Kommentarautoren-Profil konnte nicht aktualisiert werden: [_1]',
	'You can\'t reply to unpublished comment.' => 'Sie können nicht auf Kommentare antworten, die noch nicht veröffentlicht wurden.',
	'Your session has been ended.  Cancel the dialog and login again.' => 'Ihre Sitzung wurde beendet. Bitte wählen Sie Abbruch und melden Sie sich erneut an.',
	'Invalid request.' => 'Ungültige Anfrage.',

## lib/MT/App/Wizard.pm
	'The [_1] database driver is required to use [_2].' => 'Ein [_1]-Datenbanktreiber ist erforderlich, um [_2] zu nutzen.',
	'The [_1] driver is required to use [_2].' => 'Ein [_1]-Treiber ist erforderlich, um [_2] zu nutzen.',
	'An error occurred while attempting to connect to the database.  Check the settings and try again.' => 'Bei dem Versuch, eine Verbindung zur Datenbank aufzubauen, ist ein Fehler aufgetreten. Bitte überprüfen Sie Einstellungen und versuchen es erneut.',
	'SMTP Server' => 'SMTP-Server',
	'Sendmail' => 'Sendmail',
	'Test email from Movable Type Configuration Wizard' => 'Testmail vom Movable Type-Konfigurationshelfer',
	'This is the test email sent by your new installation of Movable Type.' => 'Diese Testmail wurde von Ihrer neuen Movable Type-Installation verschickt.',
	'This module is needed to encode special characters, but this feature can be turned off using the NoHTMLEntities option in mt-config.cgi.' => 'Dieses Modul ist zur Sonderzeichenkodierung erforderlich. Sonderzeichenkodierung kann über den Schalter NoHTMLEntities in mt-config.cgi abgeschaltet werden.',
	'This module is needed if you wish to use the TrackBack system, the weblogs.com ping, or the MT Recently Updated ping.' => 'Dieses Modul ist zur Nutzung von TrackBacks, weblogs.com-Pings und dem MT-Kürzlich-Aktualisiert-Ping erforderlich.',
	'This module is needed if you wish to use the MT XML-RPC server implementation.' => 'Dieses Modul ist zur Verwendung des XML-RPC-Servers notwendig.',
	'This module is needed if you would like to be able to overwrite existing files when you upload.' => 'Dieses Modul ist zum Überschreiben bereits vorhandener Dateien beim Hochladen erforderlich.',
	'This module is needed if you would like to be able to create thumbnails of uploaded images.' => 'Dieses Modul ist zur Erzeugung von Vorschaubildern von hochgeladenen Dateien erforderlich.',
	'This module is required by certain MT plugins available from third parties.' => 'Dieses Modul ist für einige MT-Plugins von Drittanbietern erforderlich.',
	'This module accelerates comment registration sign-ins.' => 'Dieses Modul beschleunigt die Anmeldung als Kommentarautor.',
	'This module is needed to enable comment registration.' => 'Dieses Modul ermöglicht die Registrierung von Kommentarautoren.',
	'This module enables the use of the Atom API.' => 'Dieses Modul ermöglicht die Verwendung der ATOM-API.',
	'This module is required in order to archive files in backup/restore operation.' => 'Dieses Modul ist zur Archivierung von Dateien bei der Erstellung und Wiederherstellung von Sicherheitskopien erforderlich.',
	'This module is required in order to compress files in backup/restore operation.' => 'Dieses Modul ist zur Komprimierung von Dateien bei der Erstellung und Wiederherstellung von Sicherheitskopien erforderlich.',
	'This module is required in order to decompress files in backup/restore operation.' => 'Dieses Modul ist zum Entpacken von Dateien bei der Erstellung und Wiederherstellung von Sicherheitskopien erforderlich.',
	'This module and its dependencies are required in order to restore from a backup.' => 'Dieses Modul und seine Abhängigkeiten sind zur Wiederherstellung von Sicherheitskopien erforderlich.',
	'This module and its dependencies are required in order to allow commenters to be authenticated by OpenID providers including Vox and LiveJournal.' => 'Dieses Modul und seine Abhängigkeiten sind zur Authentifizierung von Kommentarautoren mittels OpenID erforderlich (incl. OpenID via LiveJournal und Vox).',
	'This module is required for sending mail via SMTP Server.' => 'Dieses Modul ist zum Verschicken von E-Mails über SMTP-Server erforderlich.', # Translate - New # OK
	'This module is required for file uploads (to determine the size of uploaded images in many different formats).' => 'Dieses Modul ist zur Bestimmung der Größe hochgeladener Dateien erforderlich.',
	'This module is required for cookie authentication.' => 'Dieses Modul ist zur Cookie-Authentifizierung erforderlich.',
	'DBI is required to store data in database.' => 'DBI ist zur Nutzung von Datenbanken erforderlich.',

## lib/MT/App/Upgrader.pm
	'Failed to authenticate using given credentials: [_1].' => 'Authentifizierung fehlgeschlagen: [_1].',
	'You failed to validate your password.' => 'Passwort und Wiederholung des Passworts stimmen nicht überein',
	'You failed to supply a password.' => 'Passwort erforderlich',
	'The e-mail address is required.' => 'Email-Adresse erforderlich',
	'Invalid session.' => 'Ungültige Session',
	'No permissions. Please contact your administrator for upgrading Movable Type.' => 'Bitte kontaktieren Sie Ihren Administrator, um das Upgrade von Movable Type durchzuführen. Sie haben nicht die erforderlichen Rechte.',

## lib/MT/App/NotifyList.pm
	'Please enter a valid email address.' => 'Bitte geben Sie eine gültige Email-Adresse an.',
	'Missing required parameter: blog_id. Please consult the user manual to configure notifications.' => 'Erforderliches Parameter blog_id fehlt. Bitte konfigurieren Sie die Benachrichtungsfunktion entsprechend.',
	'An invalid redirect parameter was provided. The weblog owner needs to specify a path that matches with the domain of the weblog.' => 'Ungültiges Redirect-Parameter. Sie müssen einen zur verwendeten Domain gehörenden Pfad angeben.',
	'The email address \'[_1]\' is already in the notification list for this weblog.' => 'Die Email-Adresse \'[_1]\' ist bereits in der Benachrichtigunsliste für dieses Weblog.',
	'Please verify your email to subscribe' => 'Bitte bestätigen Sie Ihre Email-Adresse',
	'_NOTIFY_REQUIRE_CONFIRMATION' => 'Bitte klicken Sie auf den Bestätigungslink in der Mail, die an [_1] verschickt wurde. So wird sichergestellt, daß die angegebene Email-Adresse wirklich Ihnen gehört.',
	'The address [_1] was not subscribed.' => 'Die Adresse [_1] wurde hinzugefügt.',
	'The address [_1] has been unsubscribed.' => 'Die Adresse [_1] wurde entfernt.',

## lib/MT/App/CMS.pm
	'[quant,_1,entry,entries] tagged &ldquo;[_2]&rdquo;' => '[quant,_1,Eintrag,Einträge] getaggt mit &ldquo;[_2]&rdquo;',
	'Posted by [_1] [_2] in [_3]' => 'Von [_1] [_2] in [_3]',
	'Posted by [_1] [_2]' => 'Von [_1] [_2]',
	'Tagged: [_1]' => 'Getaggt: [_1]',
	'View all entries tagged &ldquo;[_1]&rdquo;' => 'Zeige alle mit &ldquo;[_1]&rdquo getaggten Einträge',
	'No entries available.' => 'Keine Einträge vorhanden.',
	'_WARNING_PASSWORD_RESET_MULTI' => 'Sie sind dabei, möchten die Passwörter der gewählten Benutzer zurücksetzen. Den Benutzern werden dazu zufällig erzeugte neue Passwörter per E-Mail zugeschickt werden.\n\nForsetzen?',
	'_WARNING_DELETE_USER_EUM' => 'Löschen eines Benutzerkontos kann nicht rückgängig gemacht werden und führt zu verwaisten Einträgen. Es wird daher empfohlen, das Benutzerkonto zu belassen und stattdessen dem Benutzer alle Zugriffsrechte zu entziehen. Möchten Sie das Konto dennoch löschen?\nGelöschte Benutzer können ihre Benutzerkonten selbst solange wiederherstellen, wie sie noch im externen Verzeichnis aufgeführt sind.',
	'_WARNING_DELETE_USER' => 'Löschen eines Benutzerkontos kann nicht rückgängig gemacht werden und führt zu verwaisten Einträgen. Es wird daher empfohlen, das Benutzerkonto zu belassen und stattdessen dem Benutzer alle Zugriffsrechte zu entziehen. Möchten Sie das Konto dennoch löschen?\nGelöschte Benutzer können ihre Benutzerkonten selbst solange wiederherstellen, wie sie noch im externen Benutzerverzeichnis geführt sind.',
	'Published [_1]' => '[_1] veröffentlicht',
	'Unpublished [_1]' => '[_1] nicht mehr veröffentlicht',
	'Scheduled [_1]' => '[_1] zeitgeplant',
	'My [_1]' => 'Mein [_1]',
	'[_1] with comments in the last 7 days' => '[_1] mit Kommentaren in den letzten 7 Tagen',
	'[_1] posted between [_2] and [_3]' => '[_1] veröffentlicht zwischen dem [_2] und dem [_3]',
	'[_1] posted since [_2]' => '[_1] veröffentlicht seit [_2]',
	'[_1] posted on or before [_2]' => '[_1] veröffentlicht am oder vor dem [_2]',
	'All comments by [_1] \'[_2]\'' => 'Alle Kommentare von [_1] \'[_2]\'',
	'Commenter' => 'Kommentator',
	'All comments for [_1] \'[_2]\'' => 'Alle Kommentare für  [_1] \'[_2]\'',
	'Comments posted between [_1] and [_2]' => 'Zwischen [_1] und [_2] veröffentlichte Kommentare',
	'Comments posted since [_1]' => 'Seit [_1] veröffentlichte Kommentare',
	'Comments posted on or before [_1]' => 'Bis [_1] veröffentlichte Kommentare',
	'Invalid blog' => 'Ungültiges Blog',
	'Password Recovery' => 'Passwort verschicken',
	'Invalid password recovery attempt; can\'t recover password in this configuration' => 'Ungültiger Versuch der Passwortanforderung. Passwörter können in dieser Konfiguration nicht angefordert werden.',
	'Invalid author_id' => 'Ungültige Autoren-ID',
	'Can\'t recover password in this configuration' => 'Passwörter können in dieser Konfiguration nicht angefordert werden',
	'Invalid user name \'[_1]\' in password recovery attempt' => 'Ungültiger Benutzername \'[_1]\' zur Passwortanforderung verwendet',
	'User name or birthplace is incorrect.' => 'Benutzername oder Geburtsort ungültig.',
	'User has not set birthplace; cannot recover password' => 'Geburtsort nicht angegeben; Passwort kann nicht angefordert werden',
	'Invalid attempt to recover password (used birthplace \'[_1]\')' => 'Ungültiger Versuch der Passwortanforderung (angegebener Geburtsort: \'[_1]\')',
	'User does not have email address' => 'Benutzer hat keine Email-Adresse',
	'Password was reset for user \'[_1]\' (user #[_2]). Password was sent to the following address: [_3]' => 'Passwort von Benutzer \'[_1]\' (#[_2]) zurückgesetzt und an [_3] verschickt',
	'Error sending mail ([_1]); please fix the problem, then try again to recover your password.' => 'Mailversand fehlgeschlagen ([_1]). Überprüfen Sie die entsprechenden Einstellungen und versuchen Sie dann erneut, das Passwort anzufordern.',
	'(newly created user)' => '(neu angelegter Benutzer)',
	'Search Files' => 'Dateien suchen',
	'Invalid group id' => 'Ungültige Gruppen-ID',
	'Users & Groups' => 'Benutzer und Gruppen',
	'Group Roles' => 'Gruppenrollen',
	'Users' => 'Benutzer',
	'Invalid user id' => 'Ungültige Benutzer-ID',
	'User Roles' => 'Benutzerrollen',
	'Roles' => 'Rollen',
	'Group Associations' => 'Gruppenverknüpfungen',
	'User Associations' => 'Benutzerverknüpfungen',
	'Role Users & Groups' => 'Rollen-Benutzer und -Gruppen',
	'Associations' => 'Verknüpfungen',
	'(Custom)' => '(Individuell)',
	'(user deleted)' => '(Benutzer gelöscht)',
	'Invalid type' => 'Ungültiger Typ',
	'No such tag' => 'Kein solcher Tag',
	'None' => 'Kein(e)',
	'You are not authorized to log in to this blog.' => 'Kein Zugang zu diesem Weblog.',
	'No such blog [_1]' => 'Kein Weblog [_1]',
	'Blogs' => 'Blogs',
	'Blog Activity Feed' => 'Aktivitätsprotokoll-Feed',
	'*User deleted*' => 'Benutzer gelöscht',
	'Group Members' => 'Gruppenmitglieder',
	'QuickPost' => 'QuickPost',
	'All Feedback' => 'Jedes Feedback',
	'Activity Log' => 'Aktivitäten',
	'System Activity Feed' => 'System-Aktivitätsfeed',
	'Activity log for blog \'[_1]\' (ID:[_2]) reset by \'[_3]\'' => 'Aktivitätsprotokoll von \'[_1]\' (ID:[_2]) on \'[_3]\' zurückgesetzt',
	'Activity log reset by \'[_1]\'' => 'Aktivitätsprotokoll zurückgesetzt von \'[_1]\'',
	'No blog ID' => 'Keine Weblog-ID',
	'Default' => 'Standard',
	'Import/Export' => 'Import/Export',
	'Invalid parameter' => 'Ungültiges Parameter',
	'Permission denied: [_1]' => 'Zugriff verweigert: [_1]',
	'Load failed: [_1]' => 'Laden fehlgeschlagen: [_1]',
	'(no reason given)' => '(unbekannte Ursache)',
	'(untitled)' => '(ohne Überschrift)',
	'index' => 'Index',
	'archive' => 'Archiv',
	'module' => 'Modul',
	'widget' => 'Widget',
	'system' => 'System',
	'Templates' => 'Vorlagen',
	'One or more errors were found in this template.' => 'Die Vorlage enthält einen oder mehrere Fehler', # Translate - New # OK
	'General Settings' => 'Allgemeine Einstellungen',
	'Publishing Settings' => 'Grundeinstellungen',
	'Plugin Settings' => 'Plugin-Einstellungen',
	'Settings' => 'Einstellungen',
	'Edit TrackBack' => 'TrackBack bearbeiten',
	'Edit Comment' => 'Kommentar bearbeiten',
	'Authenticated Commenters' => 'Authentifizierte Kommentarautoren',
	'Commenter Details' => 'Details zu Kommentator',
	'Commenters' => 'Kommentar- autoren',
	'New Entry' => 'Neuer Eintrag',
	'New Page' => 'Neue Seite',
	'Create template requires type' => 'Zum Anlegen einer Vorlage muss deren gewünschter Typ angegeben werden.',
	'Archive' => 'Archiv',
	'Entry or Page' => 'Eintrag oder Seite',
	'New Template' => 'Neuer Vorlage',
	'New Blog' => 'Neues Blog',
	'pages' => 'Seiten',
	'Create New User' => 'Neues Benutzerkonto anlegen',
	'User requires username' => 'Benutzer erfordert Benutzername',
	'User requires password' => 'Benutzer erfodert Benutzername',
	'User requires password recovery word/phrase' => 'Author erfordert Passwort-Erinnerungssatz',
	'Email Address is required for password recovery' => 'Email-Adresse bei Passwort-Anfrage erforderlich',
	'Website URL is imperfect' => 'Website-URL ungültig', # Translate - New # OK
	'The value you entered was not a valid email address' => 'Email-Adresse ungültig',
	'The e-mail address you entered is already on the Notification List for this blog.' => 'Die angegebene E-Mail-Adresse befindet sich bereits auf der Benachrichtigungsliste für dieses Weblog.',
	'You did not enter an IP address to ban.' => 'Keine IP-Adresse angegeben.',
	'The IP you entered is already banned for this blog.' => 'Die angegebene IP-Adresse ist für dieses Weblog bereits gesperrt.',
	'You did not specify a blog name.' => 'Kein Blog-Name angegeben.',
	'Site URL must be an absolute URL.' => 'Site-URL muß absolute URL sein.',
	'Archive URL must be an absolute URL.' => 'Archiv-URLs müssen absolut sein.',
	'The name \'[_1]\' is too long!' => 'Der Name \'[_1]\' ist zu lang!',
	'A user can\'t change his/her own username in this environment.' => 'Benutzer kann eigenen Benutzernamen in diesem Kontext nicht ändern.',
	'An errror occurred when enabling this user.' => 'Bei der Aktivierung dieses Benutzerkontos ist ein Fehler aufgetreten',
	'Folder \'[_1]\' created by \'[_2]\'' => 'Ordner \'[_1]\' angelegt von \'[_2]\'',
	'Category \'[_1]\' created by \'[_2]\'' => 'Kategorie \'[_1]\' angelegt von \'[_2]\'',
	'The folder \'[_1]\' conflicts with another folder. Folders with the same parent must have unique basenames.' => 'Der Ordner \'[_1]\' steht im Konflikt mit einem anderen Ordner. Ordner im gleichen Unterordner müssen unterschiedliche Basenames haben.',
	'The category name \'[_1]\' conflicts with another category. Top-level categories and sub-categories with the same parent must have unique names.' => 'Der Kategoriename \'[_1]\' steht im Konflikt mit einem anderen Kategorienamen. Hauptkategorien und Unterkategorien der gleichen Ebene müssen unterschiedliche Namen haben.',
	'The category basename \'[_1]\' conflicts with another category. Top-level categories and sub-categories with the same parent must have unique basenames.' => 'Der Kategorie-Basename \'[_1]\' steht im Konflikt mit einem anderen Kategorienamen. Hauptkategorien und Unterkategorien der gleichen Ebene müssen unterschiedliche Basenames haben.',
	'Saving permissions failed: [_1]' => 'Speichern von Rechten fehlgeschlagen: [_1]',
	'Blog \'[_1]\' (ID:[_2]) created by \'[_3]\'' => 'Weblog \'[_1]\' (ID:[_2]) angelegt von \'[_3]\'',
	'User \'[_1]\' (ID:[_2]) created by \'[_3]\'' => 'Benutzer \'[_1]\' (ID:[_2]) angelegt von \'[_3]\'',
	'Template \'[_1]\' (ID:[_2]) created by \'[_3]\'' => 'Vorlage \'[_1]\' (ID:[_2]) angelegt von \'[_3]\'',
	'You cannot delete your own association.' => 'Sie können nicht Ihre eigene Verknüpfung löschen.',
	'You cannot delete your own user record.' => 'Sie können nicht Ihr eigenes Benutzerkonto löschen.',
	'You have no permission to delete the user [_1].' => 'Keine Rechte zum Löschen von Benutzer [_1].',
	'Blog \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Weblog \'[_1]\' (ID:[_2]) gelöscht von \'[_3]\'',
	'Subscriber \'[_1]\' (ID:[_2]) deleted from notification list by \'[_3]\'' => 'Abonnent \'[_1]\' (ID:[_2]) von \'[_3]\' von Benachrichtigungsliste entfernt',
	'User \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Benutzer \'[_1]\' (ID:[_2]) gelöscht von \'[_3]\'',
	'Folder \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Ordner \'[_1]\' (ID:[_2]) gelöscht von \'[_3]\'',
	'Category \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Kategorie \'[_1]\' (ID:[_2]) gelöscht von \'[_3]\'',
	'Comment (ID:[_1]) by \'[_2]\' deleted by \'[_3]\' from entry \'[_4]\'' => 'Kommentar (ID:[_1]) von \'[_2]\' von \'[_3]\' aus Eintrag \'[_4]\' gelöscht',
	'Page \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Seite \'[_1]\' (ID:[_2]) gelöscht von \'[_3]\'',
	'Entry \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Eintrag \'[_1]\' (ID:[_2]) gelöscht von \'[_3]\'',
	'(Unlabeled category)' => '(Namenlose Kategorie)',
	'Ping (ID:[_1]) from \'[_2]\' deleted by \'[_3]\' from category \'[_4]\'' => 'Ping (ID:[_1]) von \'[_2]\' von \'[_3]\' aus Kategorie \'[_4]\' gelöscht',
	'(Untitled entry)' => '(Namenloser Eintrag)',
	'Ping (ID:[_1]) from \'[_2]\' deleted by \'[_3]\' from entry \'[_4]\'' => 'Ping (ID:[_1]) von \'[_2]\' von \'[_3]\' aus Eintrag \'[_4]\' gelöscht',
	'Template \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Vorlage \'[_1]\' (ID:[_2]) gelöscht von \'[_3]\'',
	'Tag \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Tag \'[_1]\' (ID:[_2]) gelöscht von \'[_3]\'',
	'File \'[_1]\' uploaded by \'[_2]\'' => 'Datei \'[_1]\' hochgeladen von \'[_2]\'',
	'File \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Datei \'[_1]\' (ID:[_2]) gelöschen von \'[_3]\'',
	'Permisison denied.' => 'Zugriff verweigert.',
	'The Template Name and Output File fields are required.' => 'Die Felder Vorlagennamen und Dateiname sind erforderlich.',
	'Invalid type [_1]' => 'Ungültiger Typ [_1]',
	'Save failed: [_1]' => 'Speichern fehlgeschlagen: [_1]',
	'Saving object failed: [_1]' => 'Speichern des Objekts fehlgeschlagen: [_1]',
	'No Name' => 'Kein Name',
	'Notification List' => 'Mitteilungssliste',
	'IP Banning' => 'IP-Adressen sperren',
	'Can\'t delete that way' => 'Kann so nicht gelöscht werden',
	'Removing tag failed: [_1]' => 'Tag entfernen fehlgeschlagen: [_1]',
	'You can\'t delete that category because it has sub-categories. Move or delete the sub-categories first if you want to delete this one.' => 'Solange die Kategorie Unterkategorien hat, können Sie die Kategorie nicht löschen.',
	'Loading MT::LDAP failed: [_1].' => 'Laden von MT::LDAP fehlgeschlagen: [_1]',
	'Removing [_1] failed: [_2]' => '[_1] entfernen fehlgeschlagen: [_2]',
	'System templates can not be deleted.' => 'Systemvorlagen können nicht gelöscht werden',
	'Unknown object type [_1]' => 'Unbekannter Objekttyp [_1]',
	'Can\'t load file #[_1].' => 'Kann Datei #[_1] nicht laden.',
	'No such commenter [_1].' => 'Kein Kommentarautor [_1].',
	'User \'[_1]\' trusted commenter \'[_2]\'.' => 'Benutzer \'[_1]\' hat Kommentarautor \'[_2]\' das Vertrauen ausgesprochen',
	'User \'[_1]\' banned commenter \'[_2]\'.' => 'Benutzer \'[_1]\' hat Kommentarautor \'[_2]\' gesperrt',
	'User \'[_1]\' unbanned commenter \'[_2]\'.' => 'Benutzer \'[_1]\' hat die Sperre von Kommentarautor \'[_2]\' aufgehoben',
	'User \'[_1]\' untrusted commenter \'[_2]\'.' => 'Benutzer \'[_1]\' hat Kommentarautor \'[_2]\' das Vertrauen entzogen',
	'Need a status to update entries' => 'Statusangabe erforderlich',
	'Need entries to update status' => 'Einträge erforderlich',
	'One of the entries ([_1]) did not actually exist' => 'Einer der Einträge ([_1]) ist nicht vorhanden',
	'[_1] \'[_2]\' (ID:[_3]) status changed from [_4] to [_5]' => 'Status von [_1] \'[_2]\' (ID:[_3]) von [_4] in [_5] geändert.', # Translate - New # OK
	'You don\'t have permission to approve this comment.' => 'Sie dürfen diesen Kommentar nicht freischalten.',
	'Comment on missing entry!' => 'Kommentar gehört zu fehlendem Eintrag',
	'Orphaned comment' => 'Verwaister Kommentar',
	'Comments Activity Feed' => 'Kommentar-Aktivitätsfeed',
	'Orphaned' => 'Verwaist',
	'Plugin Set: [_1]' => 'Plugin-Set: [_1]',
	'Plugins' => 'Plugins',
	'Junk TrackBacks' => 'TrackBacks als Spam behandeln', # Translate - New # OK
	'TrackBacks where <strong>[_1]</strong> is &quot;[_2]&quot;.' => 'TrackBacks, bei denen <strong>[_1]</strong> &quot;[_2]&quot; ist.', # Translate - New # OK
	'TrackBack Activity Feed' => 'TrackBack-Aktivitätsfeed',
	'No Excerpt' => 'Kein Auzzug',
	'No Title' => 'Keine Überschrift',
	'Orphaned TrackBack' => 'Verwaistes TrackBack',
	'category' => 'Kategorie',
	'Category' => 'Kategorie',
	'Tag' => 'Tag',
	'User' => 'Benutzer',
	'Entry Status' => 'Eintragsstatus',
	'[_1] Feed' => '[_1]-Feed',
	'(user deleted - ID:[_1])' => '(Benutzer gelöscht - ID:[_1])',
	'Invalid date \'[_1]\'; authored on dates must be in the format YYYY-MM-DD HH:MM:SS.' => 'Datum \'[_1]\' ungültig; erforderliches Formst ist JJJJ-MM-TT SS:MM:SS.',
	'Invalid date \'[_1]\'; authored on dates should be real dates.' => 'Ungültiges Datum \'[_1]\'; das Datum muss existieren.',
	'Saving entry \'[_1]\' failed: [_2]' => 'Speichern des Eintrags \'[_1]\' fehlgeschlagen: [_2]',
	'Removing placement failed: [_1]' => 'Entfernen der Platzierung fehlgeschlagen: [_1]',
	'[_1] \'[_2]\' (ID:[_3]) edited and its status changed from [_4] to [_5] by user \'[_6]\'' => '[_1] \'[_2]\' (ID:[_3]) bearbeitet und Status geändert von [_4] in [_5] von Benutzer \'[_6]\'',
	'[_1] \'[_2]\' (ID:[_3]) edited by user \'[_4]\'' => '[_1] \'[_2]\' (ID:[_3]) bearbeitet von Benutzer \'[_4]\'',
	'No such [_1].' => 'Kein [_1].',
	'Same Basename has already been used. You should use an unique basename.' => 'Diese Basename wird bereits verwendet. Bitte verwenden Sie einen eindeutigen Basename.',
	'Your blog has not been configured with a site path and URL. You cannot publish entries until these are defined.' => 'Site Path und URL dieses Weblogs wurden noch nicht konfiguriert. Sie können keine Einträge veröffentlichen, solange das nicht geschehen ist.',
	'Saving [_1] failed: [_2]' => 'Speichern von  [_1] fehlgeschlagen: [_2]',
	'[_1] \'[_2]\' (ID:[_3]) added by user \'[_4]\'' => '[_1] \'[_2]\' (ID:[_3]) hinzugefügt von Benutzer \'[_4]\'',
	'Subfolder' => 'Unterordner',
	'Subcategory' => 'Unterkategorie',
	'The [_1] must be given a name!' => '[_1] muss einen Namen erhalten!',
	'Saving blog failed: [_1]' => 'Speichern des Weblogs fehlgeschlagen: [_1]',
	'Invalid ID given for personal blog clone source ID.' => 'Ungültige ID für Klonvorlage für persönliche Weblogs',
	'If personal blog is set, the default site URL and root are required.' => 'Standard-Site URL und Site Root für persönliche Weblogs erforderlich.',
	'Feedback Settings' => 'Feedback-Einstellungen',
	'Publish error: [_1]' => 'Fehler bei der Veröffentlichung: [_1]',
	'Unable to create preview file in this location: [_1]' => 'Kann Vorschaudatei in [_1] nicht erzeugen.',
	'New [_1]' => 'Neuer [_1]',
	'Publish Site' => 'Site veröffentlichen', # Translate - New # OK
	'index template \'[_1]\'' => 'Indexvorlage \'[_1]\'',
	'[_1] \'[_2]\'' => '[_1] \'[_2]\'',
	'No permissions' => 'Keine Berechtigung',
	'Ping \'[_1]\' failed: [_2]' => 'Ping \'[_1]\' fehlgeschlagen: [_2]',
	'Create New Role' => 'Neue Rolle anlegen',
	'Role name cannot be blank.' => 'Rollenname erforderlich',
	'Another role already exists by that name.' => 'Rolle mit diesem Namen bereits vorhanden',
	'You cannot define a role without permissions.' => 'Rollen ohne Zugriffsrechte nicht möglich',
	'No permissions.' => 'Keine Rechte.',
	'No such entry \'[_1]\'' => 'Kein Eintrag \'[_1]\'',
	'No email address for user \'[_1]\'' => 'Keine Email-Addresse für Benutzer \'[_1]\'',
	'No valid recipients found for the entry notification.' => 'Keine gültigen Empfänger für Benachrichtigungen gefunden.',
	'[_1] Update: [_2]' => '[_1] Update: [_2]',
	'Error sending mail ([_1]); try another MailTransfer setting?' => 'Mailversand fehlgeschlagen([_1]). Überprüfen Sie die MailTransfer-Einstellungen.',
	'Archive Root' => 'Archiv-Root',
	'Site Root' => 'Site-Root',
	'Can\'t load blog #[_1].' => 'Kann Blog #[_1] nicht laden.',
	'You did not choose a file to upload.' => 'Bitte wählen Sie eine Datei aus.',
	'Before you can upload a file, you need to publish your blog.' => 'Bevor Sie eine Datei hochladen können, müssen Sie das Blog zuerst veröffentlichen.',
	'Invalid extra path \'[_1]\'' => 'Ungültiger Zusatzpfad \'[_1]\'',
	'Can\'t make path \'[_1]\': [_2]' => 'Kann Pfad \'[_1]\' nicht anlegen: [_2]',
	'Invalid temp file name \'[_1]\'' => 'Ungültiger temporärer Dateiname \'[_1]\'',
	'Error opening \'[_1]\': [_2]' => 'Fehler beim Öffnen von \'[_1]\': [_2]',
	'Error deleting \'[_1]\': [_2]' => 'Fehler beim Löschen von \'[_1]\': [_2]',
	'File with name \'[_1]\' already exists. (Install File::Temp if you\'d like to be able to overwrite existing uploaded files.)' => 'Es ist bereits eine Datei namens \'[_1]\' vorhanden. (Um bereits vorhandene hochgeladene Dateien überschreiben zu können, installieren Sie File::Temp.)',
	'Error creating temporary file; please check your TempDir setting in your coniguration file (currently \'[_1]\') this location should be writable.' => 'Fehler beim Anlegen der temporären Datei. Bitte überprüfen Sie, ob das in der Konfigurationsdatei eingestellte TempDir (derzeit \'[_1]\') beschreibbar ist.',
	'unassigned' => 'nicht vergeben',
	'File with name \'[_1]\' already exists; Tried to write to tempfile, but open failed: [_2]' => 'Es ist bereits eine Datei namens \'[_1]\' vorhanden. Öffnen der angelegten temporären Datei fehlgeschlagen: [_2]',
	'Error writing upload to \'[_1]\': [_2]' => 'Upload in \'[_1]\' speichern fehlgeschlagen: [_2]',
	'Search & Replace' => 'Suchen & Ersetzen',
	'Assets' => 'Assets',
	'Logs' => 'Logs',
	'Invalid date(s) specified for date range.' => 'Ungültige Datumsangabe',
	'Error in search expression: [_1]' => 'Fehler im Suchausdruck: [_1]',
	'Saving object failed: [_2]' => 'Speichern des Objekts fehlgeschlagen: [_2]',
	'You do not have export permissions' => 'Keine Export-Rechte',
	'You do not have import permissions' => 'Keine Import-Rechte',
	'You do not have permission to create users' => 'Keine Rechte zum Anlegen neuer Benutzer',
	'Importer type [_1] was not found.' => 'Import-Typ [_1] nicht gefunden.',
	'Saving map failed: [_1]' => 'Speichern der Verknüpfung fehlgeschlagen: [_1]',
	'Add a [_1]' => '[_1] hinzufügen',
	'No label' => 'Kein Label',
	'Category name cannot be blank.' => 'Der Name einer Kategorie darf nicht leer sein.',
	'Populating blog with default templates failed: [_1]' => 'Standardvorlagen konnten nicht geladen werden: [_1]',
	'Setting up mappings failed: [_1]' => 'Anlegen der Verknüpfung fehlgeschlagen: [_1]',
	'Error: Movable Type cannot write to the template cache directory. Please check the permissions for the directory called <code>[_1]</code> underneath your blog directory.' => 'Fehler: Movable Type kann nicht in den Vorlagen-Cache-Ordner schreiben. Bitte überprüfen Sie die Rechte für den Ordner <code>[_1]</code> in Ihrem Weblog-Verzeichnis.',
	'Error: Movable Type was not able to create a directory to cache your dynamic templates. You should create a directory called <code>[_1]</code> underneath your blog directory.' => 'Fehler: Movable Type konnte kein Verzeichnis zur Zwischenspeicherung Ihrer dynamischen Vorlagen anlegen. Legen Sie daher manuell einen Ordner namens <code>[_1]</code> in Ihrem Weblog-Verzeichnis an.',
	'That action ([_1]) is apparently not implemented!' => 'Aktion ([_1]) offenbar nicht implementiert!',
	'entry' => 'Eintrag',
	'Error saving entry: [_1]' => 'Speichern des Eintrags fehlgeschlagen: [_1]',
	'Select Blog' => 'Weblog wählen',
	'Selected Blog' => 'Gewähltes Weblog',
	'Type a blog name to filter the choices below.' => 'Geben Sie einen Blognamen ein, um die Auswahl einzuschränken.',
	'Select a System Administrator' => 'Systemadministrator wählen',
	'Selected System Administrator' => 'Gewählter Systemadministrator',
	'Type a username to filter the choices below.' => 'Benutzernamen eingeben um Auswahl einzuschränken',
	'Error saving file: [_1]' => 'Fehler beim Speichern der Datei: [_1]',
	'represents a user who will be created afterwards' => 'steht für ein Benutzerkonto, das später angelegt werden wird',
	'Select Blogs' => 'Weblogs auswählen',
	'Blogs Selected' => 'Ausgewählte Weblogs',
	'Search Blogs' => 'Blogs suchen',
	'Select Users' => 'Gewählte Benutzer',
	'Username' => 'Benutzername',
	'Users Selected' => 'Gewählte Benutzer',
	'Search Users' => 'Benutzer suchen',
	'Select Groups' => 'Gruppen auswählen',
	'Group Name' => 'Gruppenname',
	'Groups Selected' => 'Gewählte Gruppen',
	'Search Groups' => 'Gruppen suchen',
	'Select Roles' => 'Rollen auswählen',
	'Role Name' => 'Rollenname',
	'Roles Selected' => 'Gewählte Rollen',
	'' => '', # Translate - New # OK
	'Grant Permissions' => 'Rechte vergeben',
	'Backup' => 'Backup',
	'Backup & Restore' => 'Sichern & Wiederherstellen',
	'Temporary directory needs to be writable for backup to work correctly.  Please check TempDir configuration directive.' => 'Das temporäre Verzeichnis muss zur Durchführung der Sicherung beschreibbar sein. Bitte überprüfen Sie Ihre TempDir-Einstellung.',
	'Temporary directory needs to be writable for restore to work correctly.  Please check TempDir configuration directive.' => 'Das temporäre Verzeichnis muss zur Durchführung der Wiederherstellung beschreibbar sein. Bitte überprüfen Sie Ihre TempDir-Einstellung.',
	'Blog(s) (ID:[_1]) was/were successfully backed up by user \'[_2]\'' => 'Weblog(s) (ID:[_1]) erfolgreich gesichert von Benutzer \'[_2]\'',
	'Movable Type system was successfully backed up by user \'[_1]\'' => 'Movable Type-System erfolgreich gesichert von Benutzer \'[_1]\'',
	'You must select what you want to backup.' => 'Sie müssen auswählen, was gesichert werden soll.',
	'[_1] is not a number.' => '[_1] ist keine Zahl.',
	'Choose blogs to backup.' => 'Zu sichernde Blogs wählen',
	'Archive::Tar is required to archive in tar.gz format.' => 'Archive::Tar ist für Sicherungen im tar.gz-Format erforderlich.',
	'IO::Compress::Gzip is required to archive in tar.gz format.' => 'IO::Compress::Gzip ist für Sicherungen im tar.gz-Format erforderlich.',
	'Archive::Zip is required to archive in zip format.' => 'Archive::Zip ist für Sicherungen im ZIP-Format erfoderlich.',
	'Copying file [_1] to [_2] failed: [_3]' => 'Kopieren der Datei [_1] nach [_2] fehlgeschlagen: [_3]', # Translate - New # OK
	'Specified file was not found.' => 'Angegebene Datei nicht gefunden.',
	'[_1] successfully downloaded backup file ([_2])' => '[_1] hat Sicherungsdatei erfolgreich heruntergeladen ([_2])',
	'Restore' => 'Wiederherstellen',
	'Required modules (Archive::Tar and/or IO::Uncompress::Gunzip) are missing.' => 'Erforderliche Module (Archive::Tar und/oder IO::Uncompress::Gunzip) nicht vorhanden.',
	'Uploaded file was invalid: [_1]' => 'Die hochgeladene Datei ist ungültig: [_1]',
	'Required module (Archive::Zip) is missing.' => 'Erforderliches Modul Archive::Zip fehlt.',
	'Please use xml, tar.gz, zip, or manifest as a file extension.' => 'Bitte verwenden Sie xml, tar.gz, zip, oder manifest als Dateierweiterung.',
	'Some [_1] were not restored because their parent objects were not restored.' => 'Einige [_1] wurden nicht wiederhergestellt, da ihre Elternobjekte nicht wiederhergestellt wurden.',
	'Some objects were not restored because their parent objects were not restored.  Detailed information is in the <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_1]\');\">activity log</a>.' => 'Einige Objekte wurden nicht wiederhergestellt, da ihre Elternobjekte nicht wiederhergestellt wurden. Details finden Sie im <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_1]\');\">Aktivitätsprotokoll</a>.',
	'Successfully restored objects to Movable Type system by user \'[_1]\'' => 'Objekte erfolgreich wiederhergestellt von Benutzer \'[_1]\'',
	'[_1] is not a directory.' => '[_1] ist kein Verzeichnis.',
	'Error occured during restore process.' => 'Bei der Wiederherstellung ist ein Fehler aufgetreten.',
	'MT::Asset#[_1]: ' => 'MT::Asset#[_1]: ',
	'Some of files could not be restored.' => 'Einige Dateien konnten nicht wiederhergestellt werden.',
	'Please upload [_1] in this page.' => 'Bitte laden Sie [_1] in diese Seite hoch.',
	'File was not uploaded.' => 'Datei wurde nicht hochgeladen.',
	'Restoring a file failed: ' => 'Wiederherstellung einer Datei fehlgeschlagen: ',
	'Some objects were not restored because their parent objects were not restored.' => 'Einige Objekte wurden nicht wiederhergestellt, da ihre Elternobjekte nicht wiederhergestellt wurden.',
	'Some of the files were not restored correctly.' => 'Einige Daten wurden nicht korrekt wiederhergestellt.',
	'Detailed information is in the <a href=\'javascript:void(0)\' onclick=\'closeDialog(\"[_1]\")\'>activity log</a>.' => 'Details finden Sie im <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_1]\');\">Aktivitätsprotokoll</a>.',
	'[_1] has canceled the multiple files restore operation prematurely.' => '[_1] hat die Vorgang zur Wiederherstellung mehrerer Dateien vorzeitig abgebrochen.',
	'Changing Site Path for the blog \'[_1]\' (ID:[_2])...' => 'Ändere Site Path für Weblog\'[_1]\' (ID:[_2])...',
	'Removing Site Path for the blog \'[_1]\' (ID:[_2])...' => 'Entferne Site Path für Weblog \'[_1]\' (ID:[_2])...',
	'Changing Archive Path for the blog \'[_1]\' (ID:[_2])...' => 'Ändere Archive Path für Weblog \'[_1]\' (ID:[_2])...',
	'Removing Archive Path for the blog \'[_1]\' (ID:[_2])...' => 'Entferne Archive Path für Weblog \'[_1]\' (ID:[_2])...',
	'Changing file path for the asset \'[_1]\' (ID:[_2])...' => 'Ändere Pfad für Asset \'[_1]\' (ID:[_2])...',
	'Some of the actual files for assets could not be restored.' => 'Einige Assetdateien konnten nicht wiederhergestellt werden.',
	'Parent comment id was not specified.' => 'ID des Elternkommentars nicht angegeben.',
	'Parent comment was not found.' => 'Elternkommentar nicht gefunden.',
	'You can\'t reply to unapproved comment.' => 'Sie können auf nicht freigegebene Kommentare nicht antworten.',
	'entries' => 'Einträge',
	'This is You' => 'Das sind Sie',
	'Handy Shortcuts' => 'Nützliche Abkürzungen',
	'Movable Type News' => 'News von Movable Type',
	'Blog Stats' => 'Blog-Statistik',
	'Publish Entries' => 'Einträge veröffentlichen',
	'Unpublish Entries' => 'Einträge nicht mehr veröffentlichen',
	'Add Tags...' => 'Tags hinzufügen...',
	'Tags to add to selected entries' => 'Zu gewählten Einträgen hinzuzufügende Tags',
	'Remove Tags...' => 'Tags entfernen...',
	'Tags to remove from selected entries' => 'Von den gewählten Einträgen zu entfernende Tags',
	'Batch Edit Entries' => 'Mehrere Einträge bearbeiten',
	'Publish Pages' => 'Seiten veröffentlichen',
	'Unpublish Pages' => 'Seiten nicht mehr veröffentlichen',
	'Tags to add to selected pages' => 'Zu gewählten Seiten hinzuzufügende Tags',
	'Tags to remove from selected pages' => 'Von gewählten Seiten zu entfernende Tags',
	'Batch Edit Pages' => 'Mehrere Seiten bearbeiten',
	'Tags to add to selected assets' => 'Zu gewählten Assets hinzuzufügende Tags',
	'Tags to remove from selected assets' => 'Von gewählten Assets zu entfernende Tags',
	'Unpublish TrackBack(s)' => 'TrackBacks nicht mehr veröffentlichen',
	'Unpublish Comment(s)' => 'Kommentare nicht mehr veröffentlichen',
	'Trust Commenter(s)' => 'Kommentarautoren vertrauen',
	'Untrust Commenter(s)' => 'Kommentarautoren nicht mehr vertrauen',
	'Ban Commenter(s)' => 'Kommentarautoren sperren',
	'Unban Commenter(s)' => 'Kommentatorsperre aufheben',
	'Recover Password(s)' => 'Passwort anfordern',
	'Delete' => 'Löschen',
	'Comments that are not Spam' => 'Kommentare, die nicht Spam sind',
	'Comments on my posts' => 'Kommentare zu meinen Einträgen',
	'Comments marked as Spam' => 'Als Spam markierte Kommentare',
	'Pending comments' => 'Zu moderierende Kommentare',
	'Published comments' => 'Veröffentlichte Kommentare',
	'My comments' => 'Meine Kommentare',
	'All comments in the last 7 days' => 'Alle Kommentare der letzten 7 Tage',
	'All comments in the last 24 hours' => 'Alle Kommentare der letzten 24 Stunden',
	'Index Templates' => 'Index-Vorlagen',
	'Archive Templates' => 'Archiv-Vorlagen',
	'Template Modules' => 'Vorlagenmodule',
	'System Templates' => 'System-Vorlagen',
	'Tags with entries' => 'Tags von Einträgen',
	'Tags with pages' => 'Tags von Seiten',
	'Tags with assets' => 'Tags von Assets',
	'Create' => 'Neu',
	'Manage' => 'Verwalten',
	'Design' => 'Gestalten',
	'Preferences' => 'Einstellungen',
	'Tools' => 'Tools',
	'Blog' => 'Blog',
	'General' => 'Allgemein',
	'Feedback' => 'Feedback',
	'Spam' => 'Spam',
	'Blog Settings' => 'Blog-Einstellungen',
	'Members' => 'Mitglieder',
	'Address Book' => 'Adressbuch',
	'System Information' => 'Systeminformation',
	'Import' => 'Import',
	'Export' => 'Exportieren',
	'System Overview' => 'Systemeinstellungen',
	'/' => '/',
	'<' => '<',

## lib/MT/App/Viewer.pm
	'Loading blog with ID [_1] failed' => 'Einlesen des Blogs mit der ID [_1] fehlgeschlagen',
	'Template publishing failed: [_1]' => 'Veröffentlichung der Vorlage fehlgeschlagen: [_1]',
	'Invalid date spec' => 'Ungültiges Datumsformat',
	'Can\'t load template [_1]' => 'Kann Vorlage [_1] nicht lesen',
	'Archive publishing failed: [_1]' => 'Veröffentlichung des Archivs fehlgeschlagen: [_1]',
	'Invalid entry ID [_1]' => 'Ungültige Eintrags-ID [_1]',
	'Entry [_1] is not published' => 'Eintrag [_1] nicht veröffentlicht',
	'Invalid category ID \'[_1]\'' => 'Ungültige Kategorie-ID \'[_1]\'',

## lib/MT/App/ActivityFeeds.pm
	'Error loading [_1]: [_2]' => 'Fehler beim Laden von [_1]: [_2]',
	'An error occurred while generating the activity feed: [_1].' => 'Fehler beim Erzeugen des Aktivitäts-Feeds aufgetreten: [_1].',
	'[_1] Weblog TrackBacks' => 'TrackBacks für Weblog [_1]',
	'All Weblog TrackBacks' => 'Alle TrackBacks',
	'[_1] Weblog Comments' => 'Kommentare zu Weblog [_1]',
	'All Weblog Comments' => 'Alle Kommentare',
	'[_1] Weblog Entries' => 'Einträge des Blogs [_1]',
	'All Weblog Entries' => 'Alle Einträge',
	'[_1] Weblog Activity' => 'Weblogaktivität von [_1]',
	'All Weblog Activity' => 'Weblogaktivität gesamt',
	'Movable Type System Activity' => 'Movable Type Systemaktivität',
	'Movable Type Debug Activity' => 'Movable Type Debug-Aktivität',
	'[_1] Weblog Pages' => 'Seiten des Weblogs', # Translate - New # OK
	'All Weblog Pages' => 'Alle Seiten des Weblogs', # Translate - New # OK

## lib/MT/App/Search.pm
	'You are currently performing a search. Please wait until your search is completed.' => 'Suche wird ausgeführt. Bitte warten Sie, bis Ihre Anfrage abgeschlossen ist.',
	'Search failed. Invalid pattern given: [_1]' => 'Suche fehlgeschlagen - ungültiges Suchmuster angegeben: [_1]',
	'Search failed: [_1]' => 'Suche fehlgeschlagen: [_1]',
	'No alternate template is specified for the Template \'[_1]\'' => 'Keine alternative Vorlage für Vorlage \'[_1]\' angegeben',
	'Opening local file \'[_1]\' failed: [_2]' => 'Öffnen der lokalen Datei \'[_1]\' fehlgeschlagen: [_2]',
	'Publishing results failed: [_1]' => 'Veröffentlichung der Suchergebnisse fehlgeschlagen: [_1]',
	'Search: query for \'[_1]\'' => 'Suche nach \'[_1]\'',
	'Search: new comment search' => 'Suche nach neuen Kommentaren',

## lib/MT/App/Trackback.pm
	'You must define a Ping template in order to display pings.' => 'Sie müssen eine Ping-Vorlage definieren, um Pings anzeigen zu können.',
	'Trackback pings must use HTTP POST' => 'Trackbacks müssen HTTP-POST verwenden',
	'Need a TrackBack ID (tb_id).' => 'Benötige TrackBack ID (tb_id).',
	'Invalid TrackBack ID \'[_1]\'' => 'Ungültige TrackBack-ID \'[_1]\'',
	'You are not allowed to send TrackBack pings.' => 'Sie dürfen keine TrackBack-Pings senden.',
	'You are pinging trackbacks too quickly. Please try again later.' => 'Sie senden zu viele TrackBacks zu schnell hintereinander.',
	'Need a Source URL (url).' => 'Quelladresse erforderlich (url).',
	'This TrackBack item is disabled.' => 'TrackBack hier nicht aktiv.',
	'This TrackBack item is protected by a passphrase.' => 'Dieser TrackBack-Eintrag ist passwortgeschützt.',
	'TrackBack on "[_1]" from "[_2]".' => 'TrackBack zu "[_1]" von "[_2]".',
	'TrackBack on category \'[_1]\' (ID:[_2]).' => 'TrackBack für Kategorie \'[_1]\' (ID:[_2])',
	'Can\'t create RSS feed \'[_1]\': ' => 'RSS-Feed kann nicht angelegt werden \'[_1]\': ',
	'New TrackBack Ping to Entry [_1] ([_2])' => 'Neuer TrackBack-Ping bei Eintrag [_1] ([_2])',
	'New TrackBack Ping to Category [_1] ([_2])' => 'Neuer TrackBack-Ping bei Kategorie [_1] ([_2])',

## lib/MT/FileMgr/Local.pm
	'Renaming \'[_1]\' to \'[_2]\' failed: [_3]' => 'Umbenennen von \'[_1]\' in \'[_2]\' fehlgeschlagen: [_3]',
	'Deleting \'[_1]\' failed: [_2]' => 'Löschen von \'[_1]\' fehlgeschlagen: [_2]',

## lib/MT/FileMgr/SFTP.pm
	'SFTP connection failed: [_1]' => 'SFTP-Verbindung fehlgeschlagen: [_1]',
	'SFTP get failed: [_1]' => 'SFTP-"get" fehlgeschlagen: [_1]',
	'SFTP put failed: [_1]' => 'SFTP-"put" fehlgeschlagen: [_1]',
	'Creating path \'[_1]\' failed: [_2]' => 'Anlegen des Ordners \'[_1]\' fehlgeschlagen: [_2]',

## lib/MT/FileMgr/DAV.pm
	'DAV connection failed: [_1]' => 'DAV-Verbindung fehlgeschlagen: [_1]',
	'DAV open failed: [_1]' => 'DAV-"open" fehlgeschlagen: [_1]',
	'DAV get failed: [_1]' => 'DAV-"get" fehlgeschlagen: [_1]',
	'DAV put failed: [_1]' => 'DAV-"put" fehlgeschlagen: [_1]',

## lib/MT/FileMgr/FTP.pm

## lib/MT/Bootstrap.pm
	'Got an error: [_1]' => 'Es ist ein Fehler aufgetreten: [_1]',

## lib/MT/Blog.pm
	'First Blog' => 'Erstes Blog',
	'No default templates were found.' => 'Keine Standardvorlagen gefunden.',
	'Cloned blog... new id is [_1].' => 'Blog geklont... Die neue ID lautet: [_1]',
	'Cloning permissions for blog:' => 'Klone Berechtigungen für Webblog:',
	'[_1] records processed...' => '[_1] Einträge bearbeitet...',
	'[_1] records processed.' => '[_1] Einträge bearbeitet.',
	'Cloning associations for blog:' => 'Klone Verknüpfungen für Weblog:',
	'Cloning entries for blog...' => 'Klone Einträge für Weblog...',
	'Cloning categories for blog...' => 'Klone Kategorien für Weblog...',
	'Cloning entry placements for blog...' => 'Klone Eintragsplatzierung für Weblog...',
	'Cloning comments for blog...' => 'Klone Kommentare für Weblog...',
	'Cloning entry tags for blog...' => 'Klone Tags für Weblog...',
	'Cloning TrackBacks for blog...' => 'Klone TrackBacks für Weblog...',
	'Cloning TrackBack pings for blog...' => 'Klone TrackBack-Pings für Weblog...',
	'Cloning templates for blog...' => 'Klone Vorlagen für Weblog...',
	'Cloning template maps for blog...' => 'Klone Vorlagenzuweisungen für Weblog...',
	'blogs' => 'Blogs', # Translate - Case

## lib/MT/Upgrade.pm
	'Migrating Nofollow plugin settings...' => 'Migriere Nofollow-Einstellunge...',
	'Updating system search template records...' => 'Aktualisiere Suchvorlagen...',
	'Custom ([_1])' => 'Individuelle ([_1])',
	'This role was generated by Movable Type upon upgrade.' => 'Diese Rolle wurde von Movable Type während eines Upgrades angelegt.',
	'Migrating permission records to new structure...' => 'Migriere Benutzerrechte in neue Struktur...',
	'Migrating role records to new structure...' => 'Migriere Rollen in neue Struktur...',
	'Migrating system level permissions to new structure...' => 'Migriere Systemberechtigungen in neue Struktur...',
	'Invalid upgrade function: [_1].' => 'Ungültige Upgrade-Funktion: [_1].',
	'Error loading class [_1].' => 'Fehler beim Laden der Klasse [_1].',
	'Creating initial blog and user records...' => 'Erzeuge erstes Blog und Benutzerkonten...',
	'Error saving record: [_1].' => 'Fehler beim Speichern eines Datensatzes: [_1].',
	'Can administer the blog.' => 'Kann das Blog verwalten.',
	'Editor' => 'Editor',
	'Can upload files, edit all entries/categories/tags on a blog and publish.' => 'Kann Dateien hochladen, alle Einträge, Kategorien und Tags eines Blogs bearbeiten und veröffentlichen.',
	'Can create entries, edit their own, upload files and publish.' => 'Kann Einträge anlegen und veröffentlichen, eigene Einträge bearbeiten und Dateien hochladen., ',
	'Designer' => 'Designer',
	'Can edit, manage and publish blog templates.' => 'Kann Vorlagen bearbeiten, verwalten und veröffentlichen.', # Translate - New # OK
	'Webmaster' => 'Webmaster',
	'Can manage pages and publish blog templates.' => 'Kann Seiten verwalten und Vorlagen veröffentlichen.', # Translate - New # OK
	'Contributor' => 'Autor',
	'Can create entries, edit their own and comment.' => 'Kann Einträge anlegen, kommentieren und eigene Einträge bearbeiten.',
	'Moderator' => 'Moderator',
	'Can comment and manage feedback.' => 'Kann kommentieren und Feedback verwalten',
	'Can comment.' => 'Kann kommentieren.',
	'Removing Dynamic Site Bootstrapper index template...' => 'Entferne Indexvorlage des Dynamic Site Bootstrappers...',
	'Fixing binary data for Microsoft SQL Server storage...' => 'Bereite Binärdaten für Speicherung in Microsoft SQL Server vor...',
	'Creating new template: \'[_1]\'.' => 'Erzeuge neue Vorlage: \'[_1]\'',
	'Mapping templates to blog archive types...' => 'Verknüpfe Vorlagen mit Archiven...',
	'Renaming PHP plugin file names...' => 'Ändere PHP-Plugin-Dateinamen...', # Translate - Case
	'Error renaming PHP files. Please check the Activity Log.' => 'Fehler beim Umbenennen von PHP-Datei. Bitte überprüfen Sie das Aktivitätsprotokoll.', # Translate - New # OK
	'Cannot rename in [_1]: [_2].' => 'Kann [_1] nicht in [_2] umbenennen.',
	'Updating widget template records...' => 'Aktualisiere Widgetvorlagen-Einträge...',
	'Upgrading table for [_1]' => 'Initialisiere Tabelle [_1]',
	'Upgrading database from version [_1].' => 'Upgrade Datenbank von Version [_1]',
	'Database has been upgraded to version [_1].' => 'Datenbank auf Movable Type-Version [_1] aktualisiert',
	'User \'[_1]\' upgraded database to version [_2]' => 'Benutzer \'[_1]\' hat ein Upgrade auf Version [_2] durchgeführt',
	'Plugin \'[_1]\' upgraded successfully to version [_2] (schema version [_3]).' => 'Plugin \'[_1]\' erfolgreich auf Version [_2] (Schemaversion [_3]) aktualisiert.',
	'User \'[_1]\' upgraded plugin \'[_2]\' to version [_3] (schema version [_4]).' => 'Benutzer \'[_1]\' hat für Plugin \'[_2]\' ein Upgrade auf Version [_3] (Schemaversion [_4]) durchgeführt.',
	'Plugin \'[_1]\' installed successfully.' => 'Plugin \'[_1]\' erfolgreich installiert.',
	'User \'[_1]\' installed plugin \'[_2]\', version [_3] (schema version [_4]).' => 'Benutzer \'[_1]\' hat Plugin \'[_2]\' mit Version [_3] (Schema version [_4]) installiert.',
	'Setting your permissions to administrator.' => 'Setze Benutzerrechte auf \'Administrator\'...',
	'Creating configuration record.' => 'Lege Konfiguration ab...',
	'Creating template maps...' => 'Verknüpfe Vorlagen...',
	'Mapping template ID [_1] to [_2] ([_3]).' => 'Verknüpfe Vorlage[_1] mit [_2] ([_3])',
	'Mapping template ID [_1] to [_2].' => 'Verknüpfe Vorlage [_1] mit [_2]',
	'Error loading class: [_1].' => 'Fehler beim Laden einer Klasse: [_1].',
	'Creating entry category placements...' => 'Lege Kategoriezuweisungen an...',
	'Updating category placements...' => 'Aktualisiere Kategorieanordnung...',
	'Assigning comment/moderation settings...' => 'Weise Kommentierungseinstellungen zu...',
	'Setting blog basename limits...' => 'Setze Basename-Limits...',
	'Setting default blog file extension...' => 'Setze Standard-Dateierweitung...',
	'Updating comment status flags...' => 'Aktualisiere Kommentarstatus...',
	'Updating commenter records...' => 'Aktualisiere Kommentarautoren-Datensätze...',
	'Assigning blog administration permissions...' => 'Weise Administrationsrechte zu...',
	'Setting blog allow pings status...' => 'Weise Ping-Status zu...',
	'Updating blog comment email requirements...' => 'Aktualisere Email-Einstellungen der Kommentarfunktion...',
	'Assigning entry basenames for old entries...' => 'Weise Alteinträgen Basenames zu...',
	'Updating user web services passwords...' => 'Aktualisierte Passwörter für Web Services...',
	'Updating blog old archive link status...' => 'Aktualisiere Linkstatus der Alteinträge...',
	'Updating entry week numbers...' => 'Aktualisiere Wochendaten...',
	'Updating user permissions for editing tags...' => 'Weise Nutzerrechte für Tag-Verwaltung zu...',
	'Setting new entry defaults for blogs...' => 'Setze Standardwerte für neue Einträge...',
	'Migrating any "tag" categories to new tags...' => 'Migriere "Tag"-Kategorien zu neuen Tags...',
	'Assigning custom dynamic template settings...' => 'Weise benutzerspezifische Einstellungen für dynamische Vorlagen zu...',
	'Assigning user types...' => 'Weise Benutzerkontenarten zu...',
	'Assigning category parent fields...' => 'Weise Elternkategorien zu...',
	'Assigning template build dynamic settings...' => 'Weise Einstellungen für dynamische Veröffentlichung zu...',
	'Assigning visible status for comments...' => 'Setzte Sichtbarkeitsstatus für Kommentare...',
	'Assigning junk status for comments...' => 'Setze Junk-Status der Kommentare...',
	'Assigning visible status for TrackBacks...' => 'Setzte Sichtbarkeitsstatus für TrackBacks...',
	'Assigning junk status for TrackBacks...' => 'Setze Junk-Status der TrackBacks...',
	'Assigning basename for categories...' => 'Weise Kategorien Basenames zu...',
	'Assigning user status...' => 'Weise Benuzerstatus zu...',
	'Migrating permissions to roles...' => 'Migriere Zugriffsrechte auf Rollen...',
	'Populating authored and published dates for entries...' => 'Übernehme Zeitstempel für Einträge...',
	'Merging comment system templates...' => 'Führe Kommentierungsvorlagen zusammen...', # Translate - New # OK
	'Populating default file template for templatemaps...' => 'Lege Standardvorlagen für Vorlagenzuweisungen fest...',

## lib/MT/Plugin.pm

## lib/MT/Auth.pm
	'Bad AuthenticationModule config \'[_1]\': [_2]' => 'Fehlerhafe AuthenticationModule-Konfiguration \'[_1]\': [_2]',
	'Bad AuthenticationModule config' => 'Fehlerhafe AuthenticationModule-Konfiguration',

## lib/MT/Tag.pm
	'Tag must have a valid name' => 'Tag muss einen gültigen Namen haben',
	'This tag is referenced by others.' => 'Andere Tags verweisen auf dieses Tag.',

## lib/MT/Builder.pm
	'<[_1]> at line [_2] is unrecognized.' => '<[_1]> in Zeile [_2] nicht erkannt.',
	'<[_1]> with no </[_1]> on line #' => '<[_1]> ohne </[_1]> in Zeile #',
	'<[_1]> with no </[_1]> on line [_2].' => '<[_1]> ohne </[_1]> in Zeile [_2].', # Translate - New # OK
	'<[_1]> with no </[_1]> on line [_2]' => '<[_1]> ohne  </[_1]> in Zeile[_2]',
	'Error in <mt:[_1]> tag: [_2]' => 'Fehler in <mt:[_1]>-Tag: [_2]',
	'No handler exists for tag [_1]' => 'Kein Handler für Tag [_1] verfügbar',

## lib/MT/Category.pm
	'Categories must exist within the same blog' => 'Kategorien müssen im gleichen Blog vorhanden sein',
	'Category loop detected' => 'Kategorieschleife festgestellt',

## lib/MT/Template.pm
	'Error reading file \'[_1]\': [_2]' => 'Fehler beim Einlesen der Datei \'[_1]\': [_2]', # Translate - New # OK
	'Publish error in template \'[_1]\': [_2]' => 'Veröffentlichungsfehler in Vorlage \'[_1]\': [_2]',
	'Template with the same name already exists in this blog.' => 'Es ist bereits eine Vorlage mit gleichem Namen in diesem Weblog vorhanden.',
	'You cannot use a [_1] extension for a linked file.' => 'Sie können keine [_1]-Erweiterung für eine verlinkte Datei verwenden.',
	'Opening linked file \'[_1]\' failed: [_2]' => 'Öffenen der verlinkten Datei \'[_1]\' fehlgeschlagen: [_2]',
	'Index' => 'Index',
	'Category Archive' => 'Kategoriearchiv',
	'Comment Listing' => 'Liste der Kommentare',
	'Ping Listing' => 'Liste der Pings',
	'Comment Error' => 'Kommentarfehler',
	'Uploaded Image' => 'Hochgeladendes Bild',
	'Module' => 'Modul',
	'Widget' => 'Widget',

## lib/MT/Entry.pm
	'Draft' => 'Entwurf', # Translate - New # OK
	'Review' => 'Überprüfung', # Translate - New # OK
	'Future' => 'Künftig', # Translate - New # OK

## lib/MT.pm.pre
	'Powered by [_1]' => 'Powered by [_1]',
	'Version [_1]' => 'Version [_1]',
	'http://www.sixapart.com/movabletype/' => 'http://www.movabletype.org/sitede',
	'OpenID URL' => 'OpenID-URL',
	'OpenID is an open and decentralized single sign-on identity system.' => 'OpenID ist ein offenes und dezentrales Single Sign On-System',
	'Sign In' => 'Anmelden',
	'Learn more about OpenID.' => 'Mehr über OpenID erfahren',
	'Your LiveJournal Username' => 'Ihr LiveJournal-Benutzername',
	'Sign in using your LiveJournal username.' => 'Mit LiveJournal-Benutzername anmeldem',
	'Learn more about LiveJournal.' => 'Mehr über LiveJournal erfahren',
	'Your Vox Blog URL' => 'Ihre Vox-Blog-URL',
	'Sign in using your Vox blog URL' => 'Mit Vox-Blog-URL anmelden',
	'Learn more about Vox.' => 'Mehr über Vox erfahren',
	'TypeKey is a free, open system providing you a central identity for posting comments on weblogs and logging into other websites. You can register for free.' => 'TypeKey ist ein offenes, kostenloses Identitätssystem zum Verfassen von Kommentaren in Weblogs und zur Anmeldung an anderen Websites. Melden Sie sich kostenlos an.',
	'Sign in or register with TypeKey.' => 'Mit TypeKey anmelden oder Konto anlegen',
	'Hello, world' => 'Hallo, Welt',
	'Hello, [_1]' => 'Hallo, [_1]',
	'Message: [_1]' => 'Nachricht: [_1]',
	'If present, 3rd argument to add_callback must be an object of type MT::Component or MT::Plugin' => 'Falls vorhanden, muss das drite Argument von add_callback ein MT::Component-Objekt oder ein MT::Plugin sein',
	'4th argument to add_callback must be a CODE reference.' => 'Viertes Argument von add_callback muss eine CODE-Referenz sein.',
	'Two plugins are in conflict' => 'Konflikt zwischen zwei Plugins',
	'Invalid priority level [_1] at add_callback' => 'Ungültiger Prioritätslevel [_1] von add_callback',
	'Unnamed plugin' => 'Plugin ohne Namen',
	'[_1] died with: [_2]' => '[_1] abgebrochen mit [_2]',
	'Bad ObjectDriver config' => 'Fehlerhafte ObjectDriver-Einstellungen',
	'Bad CGIPath config' => 'CGIPath-Einstellung fehlerhaft',
	'Missing configuration file. Maybe you forgot to move mt-config.cgi-original to mt-config.cgi?' => 'Keine Konfigurationsdatei gefunden. Möglicherweise haben Sie vergessen, mt-config.cgi-original in mt-config.cgi umzubennen.',
	'Plugin error: [_1] [_2]' => 'Plugin-Fehler: [_1] [_2]',
	'OpenID' => 'OpenID',
	'LiveJournal' => 'LiveJournal',
	'Vox' => 'Vox',
	'TypeKey' => 'TypeKey',
	'Movable Type default' => 'Movable Type-Standard',
	'Wiki' => 'Wiki',

## mt-static/js/edit.js
	'Enter email address:' => 'Email-Adresse eingeben:',
	'Enter the link address:' => 'Link-Adresse eingeben:',
	'Enter the text to link to:' => 'Link-Text eingeben:',

## mt-static/js/dialog.js
	'(None)' => '(Keine)',

## mt-static/js/assetdetail.js
	'No Preview Available' => 'Vorschau nicht verfügbar',
	'Click to see uploaded file.' => 'Hochgeladene Datei ansehen',

## mt-static/mt.js
	'to delete' => 'zu löschen',
	'to remove' => 'zu entfernen',
	'to enable' => 'zu aktivieren',
	'to disable' => 'zu deaktivieren',
	'delete' => 'löschen',
	'remove' => 'entfernen',
	'You did not select any [_1] to [_2].' => 'Keine [_1] ausgewählt für [_2].',
	'Are you certain you want to remove this role? By doing so you will be taking away the permissions currently assigned to any users and groups associated with this role.' => 'Rolle wirklich entfernen? Entfernen der Rolle enzieht allen derzeit damit verknüpften Benutzern und Gruppen die entsprechenden Zugriffsrechte.',
	'Are you certain you want to remove these [_1] roles? By doing so you will be taking away the permissions currently assigned to any users and groups associated with these roles.' => '[_1] Rolle(n) wirklich entfernen? Entfernen der Rollen enzieht allen derzeit damit verknüpften Benutzern und Gruppen die entsprechenden Zugriffsrechte.',
	'Are you sure you want to [_2] this [_1]?' => '[_1] wirklich [_2]?',
	'Are you sure you want to [_3] the [_1] selected [_2]?' => 'Die [_1] ausgewählten [_2] wirklich [_3]?',
	'You did not select any [_1] to remove.' => 'Keine [_1] zum Entfernen ausgewählt.',
	'Are you sure you want to remove this [_1] from this group?' => 'Diese [_1] wirklich aus der Gruppe löschen?',
	'Are you sure you want to remove the [_1] selected [_2] from this group?' => 'Die [_1] ausgewählten [_2] wirklich aus der Gruppe löschen?',
	'Are you sure you want to remove this [_1]?' => '[_1] wirklich entfernen?',
	'Are you sure you want to remove the [_1] selected [_2]?' => 'Die [_1] ausgewählten [_2] wirklich entfernen?',
	'enable' => 'aktivieren',
	'disable' => 'deaktivieren',
	'You did not select any [_1] [_2].' => 'Sie haben keine [_1] zu [_2] gewählt',
	'You can only act upon a minimum of [_1] [_2].' => 'Nur möglich für mindestens [_1] [_2].',
	'You can only act upon a maximum of [_1] [_2].' => 'Nur möglich für höchstens [_1] [_2].',
	'You must select an action.' => 'Bitte wählen Sie zunächst eine Aktion.',
	'to mark as junk' => 'zum Junk markieren',
	'to remove "junk" status' => 'zum "Junk"-Status zurücksetzen',
	'Enter URL:' => 'URL eingeben:',
	'The tag \'[_2]\' already exists. Are you sure you want to merge \'[_1]\' with \'[_2]\'?' => 'Der Tag \'[_2]\' ist bereits vorhanden. Soll \'[_1]\' wirklich mit \'[_2]\' zusammengeführt werden?',
	'The tag \'[_2]\' already exists. Are you sure you want to merge \'[_1]\' with \'[_2]\' across all weblogs?' => 'Der Tag \'[_2]\' ist bereits vorhanden. Soll \'[_1]\' wirklich in allen Weblogs mit \'[_2]\' zusammengeführt werden?',
	'Loading...' => 'Lade...',
	'[_1] &ndash; [_2] of [_3]' => '[_1] &ndash; [_2] von [_3]',
	'[_1] &ndash; [_2]' => '[_1] &ndash; [_2]', # Translate - New # OK

## search_templates/results_feed.tmpl
	'Search Results for [_1]' => 'Suchergebnisse für [_1]',

## search_templates/comments.tmpl
	'Search for new comments from:' => 'Suche nach Kommentaren:',
	'the beginning' => 'Gesamt',
	'one week back' => 'in der letzten Woche',
	'two weeks back' => 'in den letzten zwei Wochen',
	'one month back' => 'im letzten Monat',
	'two months back' => 'in den letzten zwei Monaten',
	'three months back' => 'in den letzten drei Monaten',
	'four months back' => 'in den letzten vier Monaten',
	'five months back' => 'in den letzten fünf Monaten',
	'six months back' => 'in den letzten sechs Monaten',
	'one year back' => 'im letzten Jahr',
	'Find new comments' => 'Neue Kommentare finden',
	'Posted in [_1] on [_2]' => 'Veröffentlicht in [_1] am [_2]',
	'No results found' => 'Keine Treffer',
	'No new comments were found in the specified interval.' => 'Keine neuen Kommentare im Zeitraum.',
	'Select the time interval that you\'d like to search in, then click \'Find new comments\'' => 'Gewünschten Zeitraum auswählen, dann  \'Neue Kommentare finden\' wählen',

## search_templates/results_feed_rss2.tmpl

## search_templates/default.tmpl
	'SEARCH FEED AUTODISCOVERY LINK PUBLISHED ONLY WHEN A SEARCH HAS BEEN EXECUTED' => 'SEARCH FEED AUTODISCOVERY NUR ANGEZEIGT WENN SUCHE AUSGEFÜHRT',
	'Blog Search Results' => 'Blogsuche - Ergebnisse',
	'Blog search' => 'Blogsuche',
	'STRAIGHT SEARCHES GET THE SEARCH QUERY FORM' => 'EINFACHE SUCHEN - EINFACHES FORMULAR',
	'SEARCH RESULTS DISPLAY' => 'SUCHERGEBNISSANZEIGE',
	'Matching entries from [_1]' => 'Treffer in [_1]',
	'Entries from [_1] tagged with \'[_2]\'' => 'Einträge aus [_1], die getaggt sind mit \'[_2]\'',
	'Posted <MTIfNonEmpty tag="EntryAuthorDisplayName">by [_1] </MTIfNonEmpty>on [_2]' => 'Geschrieben <MTIfNonEmpty tag="EntryAuthorDisplayName">von [_1] </MTIfNonEmpty>am [_2]',
	'Showing the first [_1] results.' => 'Ersten [_1] Treffer',
	'NO RESULTS FOUND MESSAGE' => 'KEINE TREFFER-NACHRICHT',
	'Entries matching \'[_1]\'' => 'Einträge mit \'[_1]\'',
	'Entries tagged with \'[_1]\'' => 'Einträge getaggt mit \'[_1]\'',
	'No pages were found containing \'[_1]\'.' => 'Es wurden keine Seiten gefunden, die \'[_1]\' beinhalten.',
	'By default, this search engine looks for all words in any order. To search for an exact phrase, enclose the phrase in quotes' => 'Die Suchfunktion sucht standardmäßig nach allen angebenen Begriffen in beliebiger Reihenfolge. Um nach einem exakten Ausdruck zu suchen, setzen Sie diesen bitte in Anführungszeichen.',
	'The search engine also supports AND, OR, and NOT keywords to specify boolean expressions' => 'Die boolschen Operatoren AND, OR und NOT werden unterstützt.',
	'END OF ALPHA SEARCH RESULTS DIV' => 'DIV ALPHA SUCHERGEBNISSE ENDE',
	'BEGINNING OF BETA SIDEBAR FOR DISPLAY OF SEARCH INFORMATION' => 'DIV BETA SUCHINFOS ANFANG',
	'SET VARIABLES FOR SEARCH vs TAG information' => 'SETZE VARIABLEN FÜR SUCHE vs TAG-Information',
	'If you use an RSS reader, you can subscribe to a feed of all future entries tagged \'[_1]\'.' => 'Wenn Sie einen Feedreader verwenden, können Sie einen Feed aller neuen mit \'[_1]\' getaggten Einträge abonnieren.',
	'If you use an RSS reader, you can subscribe to a feed of all future entries matching \'[_1]\'.' => 'Wenn Sie einen Feedreader verwenden, können Sie einen Feed aller neuen Einträge mit \'[_1]\' abonnieren.',
	'SEARCH/TAG FEED SUBSCRIPTION INFORMATION' => 'SUCHE/TAG FEED-ABO-INFO',
	'http://www.sixapart.com/about/feeds' => 'http://www.sixapart.com/about/feeds',
	'What is this?' => 'Was ist das?',
	'TAG LISTING FOR TAG SEARCH ONLY' => 'TAG-LISTE NUR FÜR SUCHE',
	'Other Tags' => 'Andere Tags',
	'END OF PAGE BODY' => 'PAGE BODY ENDE',
	'END OF CONTAINER' => 'CONTAINER ENDE',

## tmpl/comment/signup.tmpl
	'Create an account' => 'Konto anlegen',
	'Your login name.' => 'Ihr Anmeldename',
	'Display Name' => 'Anzeigename',
	'The name appears on your comment.' => 'Dieser Name wird unter Ihren Kommentaren angezeigt.',
	'Your email address.' => 'Ihre Email-Adresse',
	'Initial Password' => 'Passwort',
	'Select a password for yourself.' => 'Eigenes Passwort',
	'Password Confirm' => 'Passowrtbestätigung',
	'Repeat the password for confirmation.' => 'Passwort zur Bestätigung wiederholen',
	'Password recovery word/phrase' => 'Erinnerungssatz',
	'This word or phrase will be required to recover the password if you forget it.' => 'Dieser Begriff oder Satz wird abgefragt, wenn ein vergessenes Passwort angefordert wird.',
	'Website URL' => 'Website',
	'The URL of your website. (Optional)' => 'URL Ihrer Website (optional)',
	'Enter your login name.' => 'Geben Sie Ihren Anmeldenamen ein.',
	'Password' => 'Passwort',
	'Enter your password.' => 'Geben Sie Ihr Passwort ein.',
	'Register' => 'Registrieren',

## tmpl/comment/login.tmpl
	'Sign in to comment' => 'Anmelden zum Kommentieren',
	'Sign in using' => 'Anmelden mit',
	'Forgot your password?' => 'Passwort vergessen?',
	'Not a member?&nbsp;&nbsp;<a href="[_1]">Sign Up</a>!' => 'Noch nicht Mitglied?&nbsp;&nbsp;<a href="[_1]">Einfach anmelden</a>!',

## tmpl/comment/profile.tmpl
	'Your Profile' => 'Ihr Profil',
	'New Password' => 'Neues Passwort',
	'Confirm Password' => 'Passwort bestätigen',
	'Password recovery' => 'Passwort anfordern',
	'Save' => 'Speichern',

## tmpl/comment/error.tmpl
	'An error occurred' => 'Es ist ein Fehler aufgetreten',

## tmpl/comment/signup_thanks.tmpl
	'Thanks for signing up' => 'Vielen Dank für Ihre Anmeldung',
	'Before you can leave a comment you must first complete the registration process by confirming your account. An email has been sent to [_1].' => 'Bevor Sie kommentieren können, müssen Sie noch Ihre Registrierung bestätigen. Dazu haben wir Ihnen eine E-Mail an [_1] geschickt.',
	'To complete the registration process you must first confirm your account. An email has been sent to [_1].' => 'Um die Registrierung abzuschließen, bestätigen Sie bitte Ihre Anmeldung. Dazu haben wir Ihnen eine E-Mail an [_1] geschickt.',
	'To confirm and activate your account please check your inbox and click on the link found in the email we just sent you.' => 'Um Ihre Registrierung zu bestätigen und Ihr Konto zu aktivieren, klicken Sie bitte auf den Link in der E-Mail, die wir Ihnen soeben zugeschickt haben.',
	'Return to the original entry.' => 'Zurück zum Ausgangseintrag',
	'Return to the original page.' => 'Zurück zur Ausgangsseite',

## tmpl/comment/register.tmpl

## tmpl/cms/restore_end.tmpl
	'All data restored successfully!' => 'Sämtliche Daten erfolgreich wiederhergestellt!',
	'Make sure that you remove the files that you restored from the \'import\' folder, so that if/when you run the restore process again, those files will not be re-restored.' => 'Vergessen Sie nicht, die verwendeten Dateien aus dem \'import\'-Ordner zu entfernen, damit sie bei künftigen Wiederherstellungen nicht erneut wiederhergestellt werden.',
	'An error occurred during the restore process: [_1] Please check activity log for more details.' => 'Bei der Wiederherstellung ist ein Fehler aufgetreten: [_1]. Bitte überprüfen Sie das Aktivitätsprotokoll.',

## tmpl/cms/import_others.tmpl
	'Start title HTML (optional)' => 'Überschriftenanfang markierender HTML-Code (optional)',
	'End title HTML (optional)' => 'Überschriftenende markierender HTML-Code (optional)',
	'If the software you are importing from does not have title field, you can use this setting to identify a title inside the body of the entry.' => 'Wenn Sie aus einem Weblog-System importieren, das kein eigenes Feld für Überschriften hat, können Sie hier angeben, welche HTML-Ausdrücke den Anfang und das Ende von Überschriften markieren.',
	'Default entry status (optional)' => 'Standard-Eintragsstatus (optional)',
	'If the software you are importing from does not specify an entry status in its export file, you can set this as the status to use when importing entries.' => 'Wenn Sie aus einem Weblog-System importieren, das in seiner Exportdatei den Eintragsstatus nicht vermerkt, können Sie hier angeben, welcher Status den importierten Einträgen zugewiesen werden soll.',
	'Select an entry status' => 'Eintragsstatus wählen',
	'Unpublished' => 'Nicht veröffentlichen',
	'Published' => 'Veröffentlichen',

## tmpl/cms/list_member.tmpl
	'Quickfilters' => 'Schnellfilter',
	'All [_1]' => 'Alle [_1]',
	'change' => 'ändern',
	'Showing only users whose [_1] is [_2].' => 'Nur Benutzer bei denen [_1] [_2] ist',
	'Show only [_1] where' => 'Zeige nur [_1] bei denen',
	'_USER_STATUS_CAPTION' => 'Status',
	'is' => 'ist',
	'enabled' => 'aktiviert',
	'disabled' => 'deaktiviert',
	'Filter' => 'Filter',

## tmpl/cms/list_role.tmpl
	'Roles for [_1] in' => 'Rollen für [_1] in',
	'Roles: System-wide' => 'Systemweite Rollen',
	'You have successfully deleted the role(s).' => 'Rolle(n) erfolgreich gelöscht',
	'Delete selected roles (x)' => 'Gewählte Rollen löschen (x)',
	'role' => 'Rolle',
	'roles' => 'Rollen',
	'Grant another role to [_1]' => '[_1] weitere Rolle zuweisen',
	'Create Role' => 'Rolle anlegen',
	'Role' => 'Rolle',
	'In Weblog' => 'In Weblog',
	'Via Group' => 'Über Gruppe',
	'Weblogs' => 'Weblogs',
	'Created By' => 'Erstellt von',
	'Role Is Active' => 'Rolle ist aktiv',
	'Role Not Being Used' => 'Rolle wird derzeit nicht verwendet',
	'Permissions' => 'Berechtigungen',

## tmpl/cms/cfg_spam.tmpl
	'Spam Settings' => 'Spam-Konfiguration',
	'Your spam preferences have been saved.' => 'Spam-Einstellungen gespeichert.',
	'Auto-Delete Spam' => 'Spam automatisch löschen',
	'If enabled, feedback reported as spam will be automatically erased after a number of days.' => 'Falls aktiviert, wird als Spam markiertes Feedback nach einer Anzahl von Tagen automatisch gelöscht.',
	'Delete Spam After' => 'Spam löschen nach',
	'When an item has been reported as spam for this many days, it is automatically deleted.' => 'Wenn ein Feedback für länger als angegeben als Spam markiert war, wird es automatisch gelöscht.',
	'days' => 'Tagen',
	'Spam Score Threshold' => 'Spam-Schwellenwert',
	'Comments and TrackBacks receive a spam score between -10 (complete spam) and +10 (not spam). Feedback with a score which is lower than the threshold shown above will be reported as spam.' => 'Kommentare und TrackBacks bekommen eine Spam-Bewertung zwischen -10 (sicher Spam) und +10 (kein Spam) zugewiesen. Feedback mit einer geringeren Bewertung als eingestellt werden automatisch als Spam markiert.',
	'Less Aggressive' => 'konservativ',
	'Decrease' => 'Abschwächen',
	'Increase' => 'Verstärken',
	'More Aggressive' => 'aggressiv',
	'Save Changes' => 'Änderungen speichern',
	'Save changes (s)' => 'Änderungen speichern',

## tmpl/cms/preview_entry.tmpl
	'Preview [_1]' => 'Vorschau auf [_1]',
	'Re-Edit this [_1]' => '[_1] erneut bearbeiten',
	'Re-Edit this [_1] (e)' => '[_1] erneut bearbeiten (e)',
	'Save this [_1]' => '[_1] speichern',
	'Save this [_1] (s)' => '[_1] speichern (s)',
	'Cancel (c)' => 'Abbrechen (c)',

## tmpl/cms/edit_entry.tmpl
	'Filename' => 'Dateiname',
	'Basename' => 'Basename',
	'folder' => 'Ordner',
	'folders' => 'Ordner',
	'categories' => 'Kategorien',
	'Create [_1]' => '[_1] anlegen',
	'Edit [_1]' => '[_1] bearbeiten',
	'A saved version of this [_1] was auto-saved [_3]. <a href="[_2]">Recover auto-saved content</a>' => 'Eine gespeicherte Version dieses [_1] wurde automatisch gespeichert [3]. <a href="[_2]">Automatisch gespeicherten Inhalt wiederherstellen</a>.',
	'Your [_1] has been saved. You can now make any changes to the [_1] itself, edit the authored-on date, or edit comments.' => '[_1] gespeichert. Sie können nun den Eintrag oder die Seite selbst, das Veröffentlichtungdatum oder die zugehörigen Kommntare bearbeiten.',
	'Your changes have been saved.' => 'Die Änderungen wurden gespeichert.',
	'One or more errors occurred when sending update pings or TrackBacks.' => 'Es sind ein oder mehrere Fehler beim Senden von TrackBacks aufgetreten.',
	'_USAGE_VIEW_LOG' => 'Im <a href="[_1]">Aktivitätsprotokoll</a> finden Sie nähere Informationen zum Fehler.',
	'Your customization preferences have been saved, and are visible in the form below.' => 'Ihre Anpassungseinstellungen wurden gespeichert und werden im nachfolgenden Formular angezeigt.',
	'Your changes to the comment have been saved.' => 'Ihre am Kommentar vorgenommenen Änderungen wurden gespeichert.',
	'Your notification has been sent.' => 'Ihre Benachrichtigung wurde gesendet.',
	'You have successfully recovered your saved [_1].' => 'Gespeicherte Fassung erfolgreich wiederhergestellt.',
	'An error occurred while trying to recover your saved [_1].' => 'Bei der Wiederherstellung der gespeicherten Fassung ist ein Fehler aufgetreten.',
	'You have successfully deleted the checked comment(s).' => 'Der bzw. die markierten Kommentare wurden erfolgreich gelöscht.',
	'You have successfully deleted the checked TrackBack(s).' => 'TrackBack(s) gelöscht.',
	'Summary' => 'Zusammenfassung',
	'Created [_1] by [_2].' => '[_1] von [_2] angelegt.',
	'Last edited [_1] by [_2].' => 'Von [_2] zuletzt bearbeiteter [_1].',
	'Published [_1].' => '[_1] veröffentlicht.',
	'This [_1] has received <a href="[_4]">[quant,_2,comment,comments]</a> and <a href="[_5]">[quant,_3,trackback,trackbacks]</a>.' => 'Diese(r) [_1] hat <a href="[_4]">[quant,_2,Kommentar,Kommentare]</a> und <a
	href="[_5]">[quant,_3,TrackBack,TrackBacks]</a>.',
	'Useful Links' => 'Nützliche Links',
	'Display Options' => 'Anzeigeoptionen',
	'Fields' => 'Felder',
	'Title' => 'Titel',
	'Body' => 'Textkörper',
	'Excerpt' => 'Zusammenfassung',
	'Keywords' => 'Schlüsselwörter',
	'Publishing' => 'Veröffentlichen',
	'Actions' => 'Aktionen',
	'Top' => 'Anfang',
	'Both' => 'Sowohl als auch',
	'Bottom' => 'Ende',
	'OK' => 'OK',
	'Reset' => 'Zurücksetzen',
	'Your entry screen preferences have been saved.' => 'Die Einstellungen für die Eintragseingabe wurden gespeichert.',
	'Are you sure you want to use the Rich Text editor?' => 'Grafischen Editor wirklich verwenden?',
	'You have unsaved changes to your [_1] that will be lost.' => 'Es liegen nicht gespeicherte Änderungen vor, die verloren gehen werden.',
	'Publish On' => 'Veröffentlichen um',
	'Publish Date' => 'Zeitpunkt der Veröffentlichung',
	'Remove' => 'Entfernen',
	'Make primary' => 'Primär setzen',
	'Add sub category' => 'Unterkategorie hinzufügen',
	'Add [_1] name' => '[_1]-Name hinzufügen',
	'Add new parent [_1]' => 'Neue Eltern-[_1] hinzufügen',
	'Add new' => 'Neue',
	'Preview this [_1] (v)' => 'Vorschau auf [_1]',
	'Delete this [_1] (v)' => '[_1] löschen (v)',
	'Delete this [_1] (x)' => '[_1] löschen (x)',
	'Share this [_1]' => '[_1] teilen',
	'_external_link_target' => '_new',
	'View published [_1]' => 'Veröffentlichten [_1] ansehen',
	'&laquo; Previous' => '&laquo; Vorheriger',
	'Manage [_1]' => '[_1] verwalten',
	'Next &raquo;' => 'Nächster &raquo;',
	'Extended' => 'Erweitert',
	'Format' => 'Format',
	'Decrease Text Size' => 'Textgröße verkleinern',
	'Increase Text Size' => 'Textgröße vergrößern',
	'Bold' => 'Fett',
	'Italic' => 'Kursiv',
	'Underline' => 'Unterstrichen',
	'Strikethrough' => 'Durchstreichen',
	'Text Color' => 'textfarbe',
	'Link' => 'Link',
	'Email Link' => 'E-Mail-Link',
	'Begin Blockquote' => 'Zitat Anfang',
	'End Blockquote' => 'Zitat Ende',
	'Bulleted List' => 'Aufzählung',
	'Numbered List' => 'Nummerierte Liste',
	'Left Align Item' => 'Linksbündig',
	'Center Item' => 'Zentieren',
	'Right Align Item' => 'Rechtsbündig',
	'Left Align Text' => 'Linksbündiger Texts',
	'Center Text' => 'Zentrierter Text',
	'Right Align Text' => 'Rechtsbündiger Text',
	'Insert Image' => 'Bild einfügen',
	'Insert File' => 'Datei einfügen',
	'WYSIWYG Mode' => 'Grafischer Editor',
	'HTML Mode' => 'HTML-Modus',
	'Metadata' => 'Metadaten',
	'(comma-delimited list)' => '(Liste mit Kommatrennung)',
	'(space-delimited list)' => '(Liste mit Leerzeichentrennung)',
	'(delimited by \'[_1]\')' => '(Trennung durch \'[_1]\')',
	'Change [_1]' => '[_1] ändern',
	'Add [_1]' => '[_1] einfügen',
	'Status' => 'Status',
	'You must configure blog before you can publish this [_1].' => 'Vor dem Veröffentlichen müssen Sie das Blog konfigurieren.',
	'Scheduled' => 'Zeitgeplant',
	'Select entry date' => 'Eintragsdatum wählen',
	'Unlock this entry&rsquo;s output filename for editing' => 'Dateinamen manuell bearbeiten',
	'Warning: If you set the basename manually, it may conflict with another entry.' => 'Warnung: Wenn Sie den Basenamen manuell einstellen, ist es nicht auszuschließen, daß der gewählte Name bereits existiert.',
	'Warning: Changing this entry\'s basename may break inbound links.' => 'Warnung: Wenn Sie den Basename nachträglich ändern, können Links von Außen den Eintrag falsch verlinken.',
	'Accept' => 'Annehmen',
	'Comments Accepted' => 'Kommentare angenommen',
	'TrackBacks Accepted' => 'TrackBacks angenommen',
	'Outbound TrackBack URLs' => 'TrackBack-URLs',
	'View Previously Sent TrackBacks' => 'TrackBacks anzeigen',
	'Auto-saving...' => 'Autosicherung...',
	'Last auto-save at [_1]:[_2]:[_3]' => 'Zuletzt automatisch gespeichert um [_1]:[_2]:[_3]',
	'None selected' => 'Keine ausgewählt', # Translate - New # OK

## tmpl/cms/system_check.tmpl

## tmpl/cms/import.tmpl
	'Transfer weblog entries into Movable Type from other Movable Type installations or even other blogging tools or export your entries to create a backup or copy.' => 'Mit der Import/Export-Funktionen können Einträge aus anderen Movable Type-Installationen oder aus anderen Weblog-Systemen übernommen und bestehende Einträge in einem Austauschformat gesichert werden.',
	'Import to' => 'Importieren in',
	'Select a blog for importing.' => 'Wählen Sie das Blog, in das importiert werden soll',
	'None selected.' => 'Auswahl leer.',
	'Select...' => 'Auswählen...',
	'Importing from' => 'Importieren aus',
	'Ownership of imported entries' => 'Besitzer importierter Einträge',
	'Import as me' => 'Einträge unter meinem Namen importieren',
	'Preserve original user' => 'Einträge unter ursprünglichen Namen importieren',
	'If you choose to preserve the ownership of the imported entries and any of those users must be created in this installation, you must define a default password for those new accounts.' => 'Wenn Sie mit ursprünglichen Benutzernamen importieren und einer oder mehrere der Benutzer in dieser Movable Type-Installation noch kein Konto haben, werden entsprechende Benutzerkonten automatisch angelegt. Für diese Konten müssen Sie ein Standardpasswort vergeben.',
	'Default password for new users:' => 'Standard-Passwort für neue Benutzer:',
	'You will be assigned the user of all imported entries.  If you wish the original user to keep ownership, you must contact your MT system administrator to perform the import so that new users can be created if necessary.' => 'Alle importierten Einträge werden Ihnen zugewiesen werden. Wenn Sie möchten, daß die Einträge ihren ursprünglichen Benutzern zugewiesen bleiben, lassen Sie den Import von Ihren Administrator durchführen. Dann werden etwaige erforderliche, aber noch fehlende Benutzerkonten automatisch angelegt.',
	'Upload import file (optional)' => 'Import-Datei hochladen (optional)',
	'If your import file is located on your computer, you can upload it here.  Otherwise, Movable Type will automatically look in the \'import\' folder of your Movable Type directory.' => 'Wenn Sie eine auf Ihrem Computer gespeicherte Importdatei verwenden wollen, laden Sie diese hier hoch. Alternativ verwendet Movable Type automatisch die Importdatei, die es im \'import\'-Unterordner Ihres Movable Type-Verzeichnis findet.',
	'More options' => 'Weitere Optionen',
	'Text Formatting' => 'Textformatierung',
	'Import File Encoding' => 'Kodierung der Importdatei',
	'By default, Movable Type will attempt to automatically detect the character encoding of your import file.  However, if you experience difficulties, you can set it explicitly.' => 'Movable Type versucht automatisch das korrekte Encoding auszuwählen. Sollte das fehlschlagen, können Sie es auch explizit angeben.',
	'<mt:var name="display_name">' => '<mt:var name="display_name">',
	'Default category for entries (optional)' => 'Standard-Kategorie für Einträge (optional)',
	'You can specify a default category for imported entries which have none assigned.' => 'Standardkdategorie für importierte Einträge ohne Kategorie',
	'Select a category' => 'Kategorie auswählen...',
	'Import Entries' => 'Einträge importieren',
	'Import Entries (i)' => 'Einträge importieren (i)',

## tmpl/cms/cfg_system_feedback.tmpl
	'Feedback Settings: System-wide' => 'Systemweite Feedback-Einstellungen',
	'This screen allows you to configure feedback and outbound TrackBack settings for the entire installation.  These settings override any similar settings for individual weblogs.' => 'Hier konfigurieren Sie die Kommentar- und TrackBack-Einstellungen für das Gesamtsystem. Diese Einstellungen sind höherrangig als die entsprechenden Einstellungen der einzelnen Weblogs, d.h. sie setzen diese außer Kraft.',
	'Your feedback preferences have been saved.' => 'Ihre Feedback-Einstellungen wurden gespeichert.',
	'Feedback Master Switch' => 'Feedback-Hauptschalter',
	'Disable Comments' => 'Kommentare ausschalten',
	'This will override all individual weblog comment settings.' => 'Diese Einstellung setzt die entsprechenden Einstellungen der Einzelweblogs außer Kraft',
	'Stop accepting comments on all weblogs' => 'Bei allen Weblogs Kommentare ausschalten',
	'Allow Registration' => 'Registrierung erlauben',
	'Select a system administrator you wish to notify when commenters successfully registered themselves.' => 'Bestimmen Sie, welcher Systemadministrator benachrichtigt werden soll, wenn ein Kommentarautor sich erfolgreich selbst registriert hat.',
	'Allow commenters to register to Movable Type' => 'Kommentarautoren bei Movable Type registrieren lassen',
	'Notify administrators' => 'Administratoren verständigen',
	'Clear' => 'Zurücksetzen',
	'System Email Address Not Set' => 'System-E-Mail-Adresse nicht gesetzt',
	'Note: System Email Address is not set.  Emails will not be sent.' => 'Hinweis: Die System-E-Mail-Adresse ist nicht gesetzt. Die E-Mail kann daher nicht verschickt werden.',
	'Disable TrackBacks' => 'TrackBacks ausschalten',
	'This will override all individual weblog TrackBack settings.' => 'Diese Einstellung setzt die entsprechenden Einstellungen der Einzelweblogs außer Kraft',
	'Stop accepting TrackBacks on all weblogs' => 'Bei allen Weblogs TrackBack ausschalten',
	'Privacy' => 'Privatsphäre',
	'Outbound Notifications' => 'Ausgehende Benachrichtigungen',
	'This feature allows you to disable sending notification pings when a new entry is created.' => 'Mit dieser Funktion können Sie die automatische Versendung von Benachrichtigungs-Pings bei Veröffentlichung eines neuen Eintrags unterbinden.',
	'Disable notification pings' => 'Ausgehende Benachrichtigungen deaktivieren',
	'Allow outbound Trackbacks to' => 'Ausgehende TrackBacks erlauben zu',
	'This feature allows you to limit outbound TrackBacks and TrackBack auto-discovery for the purposes of keeping your installation private.' => 'Um Ihre Installation nichtöffentlich zu machen, können Sie hier begrenzen, zu welchen Sites TrackBacks verschickt werden dürfen.',
	'Any site' => 'beliebigen Sites',
	'No site' => 'keinen Sites',
	'(Disable all outbound TrackBacks.)' => '(Alle ausgehenden TrackBacks deaktivieren)',
	'Only the weblogs on this installation' => 'Weblogs in dieser MT-Installation',
	'Only the sites on the following domains:' => 'zu folgenden Domains:',

## tmpl/cms/edit_template.tmpl
	'Edit Template' => 'Vorlage bearbeiten',
	'Create Template' => 'Vorlage anlegen',
	'Your template changes have been saved.' => 'Vorlagenänderungen gespeichert.',
	'<a href="[_1]" class="rebuild-link">Publish</a> this template.' => 'Vorlage <a href="[_1]" class="rebuild-link">veröffentlichen</a>.', # Translate - New # OK
	'Your [_1] has been published.' => '[_1] erneut veröffentlicht.',
	'View Published Template' => 'Veröffentlichte Vorlage ansehen',
	'List [_1] templates' => 'Zeige [_1]-Vorlagen',
	'Template tag reference' => 'Vorlagen-Tags-Referenz',
	'Includes and Widgets' => 'Includes und Widgets',
	'create' => 'Neu',
	'Save (s)' => 'Sichern (s)',
	'Save this template (s)' => 'Vorlage speichern (s)',
	'Save and Publish this template (r)' => 'Vorlage speichern und veröffentlichen (r)', # Translate - New # OK
	'Save and Publish' => 'Speichern und veröffentlichen', # Translate - New # OK
	'You must set the Template Name.' => 'Sie müssen einen Vorlagennamen vergeben',
	'You must set the template Output File.' => 'Sie müssen einen Dateinamen angeben',
	'Please wait...' => 'Bitte warten...',
	'Error occurred while updating archive maps.' => 'Bei der Aktualisierung der Archivverknüpfungen ist ein Fehler aufgetreten.',
	'Archive map has been successfully updated.' => 'Archivverknüpfung erfolgreich aktualisiert.',
	'Are you sure you want to remove this template map?' => 'Archivverknüpfung wirklich löschen?', # Translate - New # OK
	'Template Name' => 'Vorlagenname',
	'Module Body' => 'Modul-Code',
	'Template Body' => 'Vorlagen-Code',
	'Syntax Highlight On' => 'Syntaxhervorhebung an',
	'Syntax Highlight Off' => 'Syntaxhervorhebung aus',
	'Insert...' => 'Einfügen...',
	'Template Type' => 'Vorlagen-Typ',
	'Custom Index Template' => 'Individuelle Indexvorlage',
	'Output File' => 'Ausgabedatei',
	'Publish Options' => 'Veröffentlichungsoptionen',
	'Enable dynamic publishing for this template' => 'Vorlage dynamisch publizieren',
	'Publish this template automatically when rebuilding index templates' => 'Vorlage bei Neuveröffentlichung von Indexvorlagen automatisch veröffentlichen', # Translate - New # OK
	'Link to File' => 'Mit Datei verlinken',
	'Create New Archive Mapping' => 'Neue Archiv-Verknüpfung einrichten',
	'Archive Type:' => 'Archivierungstyp:',
	'Add' => 'Hinzufügen',

## tmpl/cms/edit_comment.tmpl
	'The comment has been approved.' => 'Kommentar freigeschaltet.',
	'Pending Approval' => 'Freischaltung offen',
	'Comment Reported as Spam' => 'Kommentar als Spam gemeldet',
	'Save this comment (s)' => 'Kommentar(e) speichern',
	'comment' => 'Kommentar',
	'comments' => 'Kommentare',
	'Delete this comment (x)' => 'Diesen Kommentar löschen (x)',
	'Ban This IP' => 'Diese IP-Adresse sperren',
	'Useful links' => 'Nützliche Links',
	'Previous Comment' => 'Vorheriger Kommentar',
	'Next Comment' => 'Nächster Kommentar',
	'Manage Comments' => 'Kommentare verwalten', # Translate - New # OK
	'View entry comment was left on' => 'Eintrag, auf den sich dieser Kommentar bezieht, anzeigen', # Translate - New # OK
	'Reply to this comment' => 'Kommentar beantworten', # Translate - New # OK
	'Update the status of this comment' => 'Kommentarstatus aktualisieren',
	'Approved' => 'Freigeschaltet',
	'Unapproved' => 'Noch nicht freigeschaltet',
	'Reported as Spam' => 'Als Spam gemeldet',
	'View all comments with this status' => 'Alle Kommentare mit diesem Status ansehen',
	'The name of the person who posted the comment' => 'Name der Person, die den Kommentar abgegeben hat',
	'Trusted' => 'vertraut',
	'(Trusted)' => '(vertraut)',
	'Ban&nbsp;Commenter' => 'Kommentarautor&nbsp;sperren',
	'Untrust&nbsp;Commenter' => 'Kommentarautor&nbsp;nicht&nbsp;vertrauen',
	'Banned' => 'Gesperrt',
	'(Banned)' => '(gesperrt)',
	'Trust&nbsp;Commenter' => 'Kommentarautor&nbsp;vertrauen',
	'Unban&nbsp;Commenter' => 'Sperre&nbsp;aufheben',
	'Pending' => 'Nicht veröffentlicht',
	'View all comments by this commenter' => 'Alle Kommentare von diesem Kommentarautor anzeigen',
	'Email' => 'Email',
	'Email address of commenter' => 'E-Mail-Adresse des Kommentarautors',
	'None given' => 'Nicht angegeben',
	'View all comments with this email address' => 'Alle Kommentare von dieser Email-Adresse anzeigen',
	'URL of commenter' => 'URL des Kommentarautors',
	'View all comments with this URL' => 'Alle Kommentare mit dieser URL anzeigen',
	'Entry this comment was made on' => 'Eintrag, auf den sich der Kommentar bezieht',
	'Entry no longer exists' => 'Eintrag nicht mehr vorhanden',
	'View all comments on this entry' => 'Alle Kommentare zu diesem Eintrag anzeigen',
	'Date' => 'Datum',
	'Date this comment was made' => 'Datum, an dem dieser Kommentar abgegeben wurde',
	'View all comments created on this day' => 'Alle Kommentare dieses Tages anzeigen',
	'IP' => 'IP',
	'IP Address of the commenter' => 'IP-Adresse des Kommentarautors',
	'View all comments from this IP address' => 'Alle Kommentare von dieser IP-Adresse anzeigen',
	'Comment Text' => 'Kommentartext',
	'Fulltext of the comment entry' => 'Vollständiger Kommentartext',
	'Responses to this comment' => 'Reaktionen auf diesen Kommentar',
	'Final Feedback Rating' => 'Finales Feedback-Rating',
	'Test' => 'Test',
	'Score' => 'Score',
	'Results' => 'Ergebnis',

## tmpl/cms/edit_role.tmpl
	'Role Details' => 'Rolleneigenschaften',
	'You have changed the permissions for this role. This will alter what it is that the users associated with this role will be able to do. If you prefer, you can save this role with a different name.  Otherwise, be aware of any changes to users with this role.' => 'Sie haben die Nutzerrechte für diese Rolle geändert. Das beeinflusst alle mit dieser Rolle verknüpften Benutzer. Sie können daher die Rolle unter neuem Namen speichern.',
	'_USAGE_ROLE_PROFILE' => 'Rollen und Berechtigungen definieren',
	'There are [_1] User(s) with this role.' => '[_1] Benutzer mit dieser Rolle vorhanden.',
	'Created by' => 'Angelegt von',
	'Check All' => 'Alle markieren',
	'Uncheck All' => 'Alle deaktivieren',
	'Administration' => 'Verwalten',
	'Authoring and Publishing' => 'Schreiben und veröffentlichen',
	'Designing' => 'Gestalten',
	'File Upload' => 'Dateien hochladen',
	'Commenting' => 'Kommentieren',
	'Roles with the same permissions' => 'Rollen mit den gleichen Nutzerrechten',
	'Save this role' => 'Rolle speichern',

## tmpl/cms/dialog/restore_end.tmpl
	'An error occurred during the restore process: [_1] Please check your restore file.' => 'Bei der Wiederherstellung ist ein Fehler aufgetreten: [_1]. Bitte überprüfen Sie die Sicherungsdatei.',
	'All of the data have been restored successfully!' => 'Alle Daten wurden erfolgreich wiederhergestellt!',
	'Next Page' => 'Nächste Seite',
	'The page will redirect to a new page in 3 seconds. [_1]Stop the redirect.[_2]' => 'Diese Seite leitet in drei Sekunden auf eine neue Seite weiter. [_1]Weiterleitung abbrechen[_2].', # Translate - New # OK

## tmpl/cms/dialog/comment_reply.tmpl
	'Reply to comment' => 'Auf Kommentar antworten',
	'On [_1], [_2] commented on [_3]' => '[_2] hat am [_1] [_3] kommentiert', # Translate - New # OK
	'Preview of your comment' => 'Vorschau auf Ihren Kommentar', # Translate - New # OK
	'Your reply:' => 'Ihre Antwort:',
	'Re-edit' => 'Erneut bearbeiten', # Translate - New # OK
	'Re-edit (r)' => 'Erneut bearbeiten (r)', # Translate - New # OK
	'Preview reply (v)' => 'Vorschau (v)', # Translate - New # OK
	'Publish reply (s)' => 'Antwort veröffentlichen', # Translate - New # OK

## tmpl/cms/dialog/restore_upload.tmpl
	'Restore: Multiple Files' => 'Wiederherstellen: Mehrere Dateien', # Translate - New # OK
	'Canceling the process will create orphaned objects.  Are you sure you want to cancel the restore operation?' => 'Abbrechen führt zu verwaisten Objekten. Wiederherstellung wirklich abbrechen?',
	'Please upload the file [_1]' => 'Bitte laden Sie die Datei [_1] hoch', # Translate - New # OK
	'Continue' => 'Weiter',

## tmpl/cms/dialog/asset_list.tmpl
	'Upload New File' => 'Neue Datei hochladen',
	'Upload New Image' => 'Neues Bild hochladen',
	'View All' => 'Alle',
	'Weblog' => 'Weblog',
	'Size' => 'Größe',
	'View File' => 'Datei ansehen',
	'Next' => 'Nächstes',
	'Insert' => 'Einfügen',
	'No assets could be found.' => 'Keine Assets gefunden.',

## tmpl/cms/dialog/asset_options_image.tmpl
	'Display image in entry' => 'Bild in Eintrag anzeigen', # Translate - Case
	'Alignment' => 'Ausrichtung',
	'Left' => 'Links',
	'Center' => 'Zentriert',
	'Right' => 'Rechts',
	'Use thumbnail' => 'Vorschaubild verwenden', # Translate - New # OK
	'width:' => 'Breite:', # Translate - New # OK
	'pixels' => 'Pixel', # Translate - Case
	'Link image to full-size version in a popup window.' => 'Bild mit Großansicht in Popup-Fenster verlinken',
	'Remember these settings' => 'Einstellungen speichern',

## tmpl/cms/dialog/asset_options.tmpl
	'File Options' => 'Dateioptionen',
	'The file named \'[_1]\' has been uploaded. Size: [quant,_2,byte,bytes].' => 'Datei \'[_1]\' hochgeladen. Größe: [quant,_2,Byte,Bytes].',
	'Create entry using this uploaded file' => 'Eintrag mit hochgeladener Datei anlegen', # Translate - New # OK
	'Create a new entry using this uploaded file.' => 'Neuen Eintrag mit hochgeladener Datei anlegen',
	'Finish' => 'Fertigstellen',

## tmpl/cms/dialog/entry_notify.tmpl
	'Send a Notification' => 'Benachrichtigung verschicken', # Translate - New # OK
	'You must specify at least one recipient.' => 'Bitte geben Sie mindestens einen Empfänger an.',
	'Your blog\'s name, this entry\'s title and a link to view it will be sent in the notification.  Additionally, you can add a  message, include an excerpt of the entry and/or send the entire entry.' => 'Benachrichtigungen enthalten den Names Ihres Blogs, den Namen des Eintrags und einen Link zum Eintrag. Zusätzlich können Sie eine persönliche Nachricht eingeben und  den Text des Eintrags oder einen Auszug daraus anhängen.', # Translate - New # OK
	'Recipients' => 'Empfänger', # Translate - New # OK
	'Enter email addresses on separate lines, or comma separated.' => 'Geben Sie pro Zeile nur eine E-Mail-Adresse ein oder trennen Sie mehrere Adressen mit Kommata.', # Translate - New # OK
	'All addresses from Address Book' => 'Alle Adressen aus dem Adressbuch', # Translate - New # OK
	'Optional Message' => 'Nachricht (optional)', # Translate - New # OK
	'Optional Content' => 'Inhalt (optional)', # Translate - New # OK
	'(Entry Body will be sent without any text formatting applied)' => '(Der Text des Eintrags wird ohne Formatierung verschickt)', # Translate - New # OK
	'Send' => 'Absenden', # Translate - New # OK
	'Send notification (n)' => 'Benachrichtigung absenden', # Translate - New # OK

## tmpl/cms/dialog/asset_upload.tmpl
	'You need to configure your blog.' => 'Bitte konfigurieren Sie Ihr Blog.',
	'Your blog has not been published.' => 'Ihr Blog wurde noch nicht veröffentlicht.', # Translate - New # OK
	'Before you can upload a file, you need to publish your blog. [_1]Configure your blog\'s publishing paths[_2] and rebuild your blog.' => 'Bevor Sie eine Datei hochladen können, müssen Sie das Blog veröffentlicht haben. Konfigurieren Sie dazu zuerst die [_1]Veröffentlichungspfade[_2] und veröffentlichen Sie dann das Blog.', # Translate - New # OK
	'Your system or blog administrator needs to publish the blog before you can upload files. Please contact your system or blog administrator.' => 'Bevor Sie eine Datei hochladen können, muss Ihr Systemadministrator das Blog veröffentlicht haben. Bitte wenden Sie daher an Ihren Administrator.', # Translate - New # OK
	'Select File to Upload' => 'Hochzuladende Datei wählen',
	'_USAGE_UPLOAD' => 'Wählen Sie unten den Ordner aus, in den die Datei hochgeladen werden soll. Sie können auch ein Unterverzeichnis angeben. Existiert das Zielverzeichnis noch nicht, wird es automatisch angelegt.',
	'Upload Destination' => 'Zielverzeichnis', # Translate - New # OK
	'Upload' => 'Hochladen',

## tmpl/cms/dialog/asset_replace.tmpl
	'A file named \'[_1]\' already exists. Do you want to overwrite this file?' => 'Eine Datei namens \'[_1]\' ist bereits vorhanden. Möchten Sie sie überschreiben?',

## tmpl/cms/dialog/adjust_sitepath.tmpl
	'Configure New Publishing Paths' => 'Neue Veröffentlichungspfade einstellen', # Translate - New # OK
	'URL is not valid.' => 'URL ungültig',
	'You can not have spaces in the URL.' => 'Die URL darf keine Leerzeichen enthalten',
	'You can not have spaces in the path.' => 'Der Pfad darf keine Leerzeichen enthalten',
	'Path is not valid.' => 'Pfad ungültig',
	'New Site Path:' => 'Neuer Site-Pfad', # Translate - New # OK
	'New Site URL:' => 'Neue Site-URL', # Translate - New # OK
	'New Archive Path:' => 'Neuer Archiv-Pfad', # Translate - New # OK
	'New Archive URL:' => 'Neue Archiv-URL', # Translate - New # OK

## tmpl/cms/dialog/restore_start.tmpl
	'Restoring...' => 'Wiederherstellung...', # Translate - New # OK

## tmpl/cms/dialog/create_association.tmpl
	'You need to create some roles.' => 'Legen Sie zuerst Rollen an.',
	'Before you can do this, you need to create some roles. <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_1]\');\">Click here</a> to create a role.' => 'Legen Sie zuerst Rollen an. <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_1]\');\">Rollen anlegen</a>.',
	'You need to create some groups.' => 'Legen Sie zuerst Gruppen an',
	'Before you can do this, you need to create some groups. <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_1]\');\">Click here</a> to create a group.' => 'Legen Sie zuerst Gruppen an. <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_1]\');\">Gruppen anlegen</a>',
	'You need to create some users.' => 'Legen Sie zuerst Benutzerkonten an',
	'Before you can do this, you need to create some users. <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_1]\');\">Click here</a> to create a user.' => 'Legen Sie zuerst Benutzerkonten an. <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_1]\');\">Benutzerkonten anlegen</a>',
	'You need to create some weblogs.' => 'Legen Sie zuerst Weblogs an',
	'Before you can do this, you need to create some weblogs. <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_1]\');\">Click here</a> to create a weblog.' => 'Legen Sie zuerst Weblogs an. <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_1]\');\">Weblogs anlegen</a>',

## tmpl/cms/install.tmpl
	'Create Your First User' => 'Ersten Benutzer anlegen',
	'The initial account name is required.' => 'Benutzername erforderlich',
	'Password recovery word/phrase is required.' => 'Passwort-Erinnerungsfrage erforderlich',
	'The version of Perl installed on your server ([_1]) is lower than the minimum supported version ([_2]).' => 'Die vorhandene Perl-Version ([_1]) ist nicht aktuell genug ([_2] oder höher erforderlich).',
	'While Movable Type may run, it is an <strong>untested and unsupported environment</strong>.  We strongly recommend upgrading to at least Perl [_1].' => 'Wir empfehlen dringend, die Perl-Installation mindestens auf Version [_1] zu aktualisieren. Movable Type läuft zwar möglicherweise auch mit der vorhandenen Perl-Version, es handelt sich aber um eine <strong>nicht getestete und nicht unterstützte Umgebung</strong>.',
	'Do you want to proceed with the installation anyway?' => 'Möchten Sie die Installation dennoch fortsetzen?',
	'Before you can begin blogging, you must create an administrator account for your system. When you are done, Movable Type will then initialize your database.' => 'Bevor Sie bloggen können, müssen Sie einen Systemadministrator bestimmen. Movable Type wird daraufhin Ihre Datenbank einrichten.',
	'You will need to select a username and password for the administrator account.' => 'Legen Sie den Benutzernamen und das Passwort des Administrator-Accounts fest:',
	'To proceed, you must authenticate properly with your LDAP server.' => 'Um fortfahren zu können müssen Sie sich gegenüber Ihrem LDAP-Server authentifizieren',
	'The name used by this user to login.' => 'Anmeldename dieses Benutzerkontos',
	'The user\'s email address.' => 'Email-Adresse des Benutzers',
	'Language' => 'Sprache',
	'The user\'s preferred language.' => 'Gewünschte Spracheinstellung',
	'Select a password for your account.' => 'Passwort dieses Benutzerkontos',
	'This word or phrase will be required to recover your password if you forget it.' => 'Dieser Satz wird abgefragt, wenn ein vergessenes Passwort angefordert wird',
	'Your LDAP username.' => 'Ihr LDAP-Benutzername.',
	'Enter your LDAP password.' => 'Geben Sie Ihr LDAP-Passwort ein.',

## tmpl/cms/pinging.tmpl
	'Trackback' => 'TrackBack',
	'Pinging sites...' => 'Pings zu Sites senden...',

## tmpl/cms/edit_author.tmpl
	'Create User' => 'Benutzer anlegen',
	'Profile for [_1]' => 'Benutzerprofil von [_1]',
	'Your Web services password is currently' => 'Web Services-Passwort noch nicht gesetzt',
	'_WARNING_PASSWORD_RESET_SINGLE' => 'Sie sind dabei, das Passwort von [_1] zurückzusetzen. Dazu wird ein zufällig erzeugtes neues Passwort per E-Mail an [_2] verschickt werden.\n\nForsetzen?',
	'User Pending' => 'Benutzerkonto schwebend',
	'User Disabled' => 'Benutzerkonto deaktiviert',
	'This profile has been updated.' => 'Profil aktualisiert.',
	'A new password has been generated and sent to the email address [_1].' => 'Ein neues Passwort wurde erzeugt und an die Adresse  [_1] verschickt.',
	'Movable Type Enterprise has just attempted to disable your account during synchronization with the external directory. Some of the external user management settings must be wrong. Please correct your configuration before proceeding.' => 'Movable Type Enterprise hat während der Synchronisation versucht, Ihr Benutzerkonto zu deaktivieren. Das deutet auf einen Fehler in der externen Benutzerverwaltung hin. Überprüfen Sie daher die dortigen Einstellungen, bevor Sie Ihre Arbeit in Movable Type forsetzen.',
	'Personal Weblog' => 'Persönliches Weblog',
	'Create personal weblog for user' => 'Persönliches Weblog für neuen Benutzer anlegen',
	'System Permissions' => 'Zugriffsrechte',
	'Create Weblogs' => 'Weblogs einrichten',
	'Status of user in the system. Disabling a user removes their access to the system but preserves their content and history.' => 'Globaler Benutzerstatus. Deaktivierung eines Benutzerkontos führt zum Ausschluß des Benutzers, von ihm erstellte Inhalte und sein Nutzungsverlauf bleiben jedoch erhalten.',
	'_USER_ENABLED' => 'Aktiviert',
	'_USER_PENDING' => 'Schwebend',
	'_USER_DISABLED' => 'Deaktiviert',
	'The username used to login.' => 'Benutzername (für Anmeldung)',
	'User\'s external user ID is <em>[_1]</em>.' => 'Externe ID des Benutzers: <em>[_1]</em>.',
	'The name used when published.' => 'Anzeigename (für Veröffentlichung)',
	'The email address associated with this user.' => 'Mit diesem Benutzer verknüpfte E-Mail-Adresse',
	'The URL of the site associated with this user. eg. http://www.movabletype.com/' => 'Mit diesem Benutzer verknüpfte Web-Adresse (z.B. http://movabletype.de/)',
	'Preferred language of this user.' => 'Bevorzugte Sprache des Benutzers',
	'Text Format' => 'Textformat',
	'Preferred text format option.' => 'Bevorzugte Formatierungsoption',
	'(Use Blog Default)' => '(Standard verwenden)',
	'Tag Delimiter' => 'Tag-Trennzeichen',
	'Preferred method of separating tags.' => 'Bevorzugtes Trennzeichen für Tags',
	'Comma' => 'Komma',
	'Space' => 'Leerzeichen',
	'Web Services Password' => 'Webdienste-Passwort',
	'For use by Activity feeds and with XML-RPC and Atom-enabled clients.' => 'Erforderlich für Aktivitäts-Feeds und externe Software, die über XML-RPC oder ATOM-API auf das Weblog zugreift',
	'Reveal' => 'Anzeigen',
	'Current Password' => 'Derzeitiges Passwort',
	'Existing password required to create a new password.' => 'Derzeitiges Passwort zur Passwortänderung erforderlich',
	'Enter preferred password.' => 'Bevorzugtes Passwort eingeben',
	'Enter the new password.' => 'Neues Passwort eingeben',
	'This word or phrase will be required to recover a forgotten password.' => 'Dieser Ausdruck wird abgefragt, wenn das Passwort vergessen und ein neues Passwort angefordert wurde.',
	'Save this user (s)' => 'Benutzer speichern',
	'_USAGE_PASSWORD_RESET' => 'Hier können Sie das Passwort dieses Benutzers zurücksetzen. Dazu wird ein zufälliges neues Passwort erzeugt und an folgende Adresse verschickt: [_1].',
	'Initiate Password Recovery' => 'Passwort wiederherstellen',

## tmpl/cms/list_ping.tmpl
	'Manage Trackbacks' => 'TrackBacks verwalten',
	'The selected TrackBack(s) has been approved.' => 'Gewählte TrackBacks freigeschaltet.',
	'All TrackBacks reported as spam have been removed.' => 'Alle als Spam gemeldeten TrackBacks entfernt.',
	'The selected TrackBack(s) has been unapproved.' => 'Gewählte TrackBacks nicht mehr freigeschaltet.',
	'The selected TrackBack(s) has been reported as spam.' => 'Gewählte TrackBack(s) als Spam gemeldet.',
	'The selected TrackBack(s) has been recovered from spam.' => 'Gewählte TrackBacks(s) aus Spam wiederhergestellt',
	'The selected TrackBack(s) has been deleted from the database.' => 'TrackBack(s) aus Datenbank gelöscht.',
	'No TrackBacks appeared to be spam.' => 'Kein TrackBack scheint Spam zu sein.',
	'Show unapproved [_1]' => 'Zeige nicht geprüfte [_1]',
	'[_1] Reported as Spam' => '[_1] als Spam gemeldet',
	'[_1] (Disabled)' => '[_1] (deaktiviert)',
	'Set Web Services Password' => 'Webdienste-Passwort wählen',
	'[_1] where [_2] is [_3]' => '[_1] bei denen [_2] [_3] ist.',
	'Remove filter' => 'Filter löschen',
	'status' => 'Status',
	'approved' => 'Freigeschaltet',
	'unapproved' => 'Nicht freigeschaltet',
	'to publish' => 'zu Veröffentlichen',
	'Publish selected TrackBacks (p)' => 'Ausgewählte TrackBacks veröffentlichen (p)',
	'Delete selected TrackBacks (x)' => 'Ausgewählte TrackBacks löschen (x)',
	'Report as Spam' => 'Als Spam melden',
	'Report selected TrackBacks as spam (j)' => 'Gewählte TrackBacks als Spam melden (j)',
	'Not Junk' => 'Kein Spam',
	'Recover selected TrackBacks (j)' => 'Ausgewählte TrackBacks wiederherstellen (j)',
	'Are you sure you want to remove all TrackBacks reported as spam?' => 'Wirklich alle als Spam gemeldeten TrackBacks löschen?',
	'Empty Spam Folder' => 'Spam-Ordner leeren',
	'Deletes all TrackBacks reported as spam' => 'Löscht alle als Spam gemeldeten TrackBacks',

## tmpl/cms/login.tmpl
	'Signed out' => 'Abgemeldet',
	'Your Movable Type session has ended.' => 'Ihre Movable Type-Sitzung ist abgelaufen.',
	'Your Movable Type session has ended. If you wish to sign in again, you can do so below.' => 'Ihre Movable Type-Sitzung ist abgelaufen. Unten können Sie sich erneut anmelden.',
	'Your Movable Type session has ended. Please sign in again to continue this action.' => 'Ihre Movable Type-Sitzung ist abgelaufen. Bitte melden Sie sich erneut an um den Vorgang fortzusetzen.',

## tmpl/cms/cfg_archives.tmpl
	'Error: Movable Type was not able to create a directory for publishing your blog. If you create this directory yourself, assign sufficient permissions that allow Movable Type to create files within it.' => 'Fehler: Movable Type konnte kein Verzeichnis zur Veröffentlichung Ihres Blogs anlegen. Wenn Sie das Verzeichnis manuell angelegt haben, stellen Sie bitte sicher, daß der Webserver Schreibrechte für das Verzeichnis hat.',
	'Your blog\'s archive configuration has been saved.' => 'Archivkonfiguration gespeichert.',
	'You have successfully added a new archive-template association.' => 'Sie haben erfolgreich eine neue Verknüpfung zwischen Archiven und Vorlagen hinzugefügt.',
	'You may need to update your \'Master Archive Index\' template to account for your new archive configuration.' => 'Eventuell müssen Sie Ihre Vorlage für das Archiv-Index aktualisieren, um die neue Archiv-Konfiguration zu übernehmen.',
	'The selected archive-template associations have been deleted.' => 'Die ausgewählten Verknüpfungen zwischen Archiven und Vorlagen wurden gelöscht.',
	'You must set your Local Site Path.' => 'Sie müssen den Pfad Ihres lokalen Verzeichnis festlegen.',
	'You must set a valid Site URL.' => 'Bitte geben Sie eine gültige Adresse (URL) an.',
	'You must set a valid Local Site Path.' => 'Bitte geben Sie ein gültiges lokales Verzeichnis an.',
	'Publishing Paths' => 'System-Pfade',
	'Site URL' => 'Webadresse (URL)',
	'The URL of your website. Do not include a filename (i.e. exclude index.html). Example: http://www.example.com/blog/' => 'Die URL Ihrer Website. Bitte geben Sie die Adresse ohne Dateinamen ein, beispielsweise so: http://www.beispiel.de/blog/',
	'Unlock this blog&rsquo;s site URL for editing' => 'Blog-URL manuell bearbeiten',
	'Warning: Changing the site URL can result in breaking all the links in your blog.' => 'Hinweis: Eine Änderung der Webadresse kann alle Link zu Ihrem Blog ungültig machen.',
	'The path where your index files will be published. An absolute path (starting with \'/\') is preferred, but you can also use a path relative to the Movable Type directory. Example: /home/melody/public_html/blog' => 'Der Pfad, in dem die Indexdateien abgelegt werden. Eine absolute (mit \'/\' beginnende) Pfadangabe wird bevorzugt, Sie können den Pfad aber auch relativ Sie zu Ihrem Movable Type-Verzeichnis angeben. Beispiel: /home/melanie/public_html/blog',
	'Unlock this blog&rsquo;s site path for editing' => 'Pfad manuell bearbeiten',
	'Note: Changing your site root requires a complete publish of your site.' => 'Hinweis: Im Anschluss an eine Änderung des Wurzelverzeichnisses muss die gesamte Site neu veröffentlicht werden.', # Translate - New # OK
	'Advanced Archive Publishing' => 'Erweiterte Archivoptionen',
	'Select this option only if you need to publish your archives outside of your Site Root.' => 'Wählen Sie diese Option nur, wenn Sie Ihre Archive außerhalb des Site-Root-Verzeichnisses veröffentlichen müssen.',
	'Publish archives outside of Site Root' => 'Archive außerhalb Site Root ablegen',
	'Archive URL' => 'Archivadresse',
	'Enter the URL of the archives section of your website. Example: http://archives.example.com/' => 'Geben Sie die Adresse der Archivsektion Ihrer Website ein, beispielsweise http://archiv.beispiel.de/',
	'Unlock this blog&rsquo;s archive url for editing' => 'Archivadresse manuell bearbeiten',
	'Warning: Changing the archive URL can result in breaking all the links in your blog.' => 'Hinweis: Eine Änderung der Archivadresse kann alle Links zu Ihrem Blog ungültig machen.',
	'Enter the path where your archive files will be published. Example: /home/melody/public_html/archives' => 'Geben Sie den lokalen Pfad zu Ihrem Archiv ein, beispielsweise /home/melanie/public_html/archiv',
	'Warning: Changing the archive path can result in breaking all the links in your blog.' => 'Warnung: Eine Änderung des Archivpfads kann sämtliche Links zu Ihrem Blog ungültig machen.',
	'Publishing Options' => 'Veröffentlichungsoptionen',
	'Preferred Archive Type' => 'Bevorzugter Archivtyp',
	'Used when linking to an archived entry&#8212;for a permalink.' => 'Wird verwendet für Links zu archivierten Einträgen&#8212;für Permalinks',
	'No archives are active' => 'Archive nicht aktiviert',
	'Method' => 'Methode',
	'Publish all templates statically' => 'Alle Vorlagen statisch veröffentlichen',
	'Publish only Archive Templates dynamically' => 'Nur Archivvorlagen dynamisch veröffentlichen',
	'Set each template\'s Publish Options separately' => 'Für jede Vorlage separat wählen',
	'Publish all templates dynamically' => 'Alle Vorlagen dynamisch veröffentlichen',
	'Enable Dynamic Cache' => 'Dynamischen Cache aktivieren',
	'Turn on caching.' => 'Cache verwenden',
	'Enable caching' => 'Cache aktivieren',
	'Enable Conditional Retrieval' => 'Conditional Retrieval aktivieren',
	'Turn on conditional retrieval of cached content.' => 'Conditional Retrieval von Cache-Inhalten aktivieren',
	'Enable conditional retrieval' => 'Conditional Retrieval aktivieren',
	'File Extension for Archive Files' => 'Dateierweiterung für Archivdateien',
	'Enter the archive file extension. This can take the form of \'html\', \'shtml\', \'php\', etc. Note: Do not enter the leading period (\'.\').' => 'Geben Sie die gewünschte Erweiterung der Archivdateien an. Möglich sind \'html\', \'shtml\', \'php\' usw. Hinweis: Geben Sie nicht den führenden Punkt (\'.\') ein.',

## tmpl/cms/cfg_prefs.tmpl
	'Your blog preferences have been saved.' => 'Ihre Blog-Einstellungen wurden gespeichert.',
	'You must set your Blog Name.' => 'Sie haben keinen Blognamen gewählt',
	'You did not select a timezone.' => 'Sie haben keine Zeitzone ausgewählt.',
	'Name your blog. The blog name can be changed at any time.' => 'Geben Sie Ihrem Blog einen Namen. Der Name kann jederzeit geändert werden.',
	'Enter a description for your blog.' => 'Geben Sie eine Beschreibung Ihres Blogs ein.',
	'Timezone' => 'Zeitzone',
	'Select your timezone from the pulldown menu.' => 'Zeitzone des Weblogs',
	'Time zone not selected' => 'Es wurde keine Zeitzone ausgewählt',
	'UTC+13 (New Zealand Daylight Savings Time)' => 'UTC+13 (Neuseeland Sommerzeit)',
	'UTC+12 (International Date Line East)' => 'UTC+12 (Internationale Datumslinie Ost)',
	'UTC+11' => 'UTC+11 (East Australian Daylight Savings Time)',
	'UTC+10 (East Australian Time)' => 'UTC+10 (Ost-Australische Zeit)',
	'UTC+9.5 (Central Australian Time)' => 'UTC+9,5 (Zentral-Australische Zeit)',
	'UTC+9 (Japan Time)' => 'UTC+9 (Japanische Zeit)',
	'UTC+8 (China Coast Time)' => 'UTC+8 (Chinesische Küstenzeit)',
	'UTC+7 (West Australian Time)' => 'UTC+7 (West-Australische Zeit)',
	'UTC+6.5 (North Sumatra)' => 'UTC+6.5 (Nord Sumatra-Zeit)',
	'UTC+6 (Russian Federation Zone 5)' => 'UTC+6 (Russische Föderationszone 5)',
	'UTC+5.5 (Indian)' => 'UTC+5,5 (Indische Zeit)',
	'UTC+5 (Russian Federation Zone 4)' => 'UTC+5 (Russische Föderationszone 4)',
	'UTC+4 (Russian Federation Zone 3)' => 'UTC+4 (Russische Föderationszone 3)',
	'UTC+3.5 (Iran)' => 'UTC+3,5 (Iranische Zeit)',
	'UTC+3 (Baghdad Time/Moscow Time)' => 'UTC+3 (Bagdad-/Moskau-Zeit)',
	'UTC+2 (Eastern Europe Time)' => 'UTC+2 (Osteuropäische Zeit)',
	'UTC+1 (Central European Time)' => 'UTC+1 (Mitteleuropäische Zeit)',
	'UTC+0 (Universal Time Coordinated)' => 'UTC+0 (Universal Time Coordinated)',
	'UTC-1 (West Africa Time)' => 'UTC-1 (Westafrikanische Zeit)',
	'UTC-2 (Azores Time)' => 'UTC-2 (Azoren-Zeit)',
	'UTC-3 (Atlantic Time)' => 'UTC-3 (Atlantische Zeit)',
	'UTC-3.5 (Newfoundland)' => 'UTC-3,5 (Neufundland-Zeit)',
	'UTC-4 (Atlantic Time)' => 'UTC-4 (Atlantische Zeit)',
	'UTC-5 (Eastern Time)' => 'UTC-5 (Ostamerikanische Zeit)',
	'UTC-6 (Central Time)' => 'UTC-6 (Zentralamerikanische Zeit)',
	'UTC-7 (Mountain Time)' => 'UTC-7 (Amerikanische Gebirgszeit)',
	'UTC-8 (Pacific Time)' => 'UTC-8 (Pazifische Zeit)',
	'UTC-9 (Alaskan Time)' => 'UTC-9 (Alaska-Zeit)',
	'UTC-10 (Aleutians-Hawaii Time)' => 'UTC-10 (Aleuten-Hawaii-Zeit)',
	'UTC-11 (Nome Time)' => 'UTC-11 (Alaska, Nome-Zeit)',
	'User Registration' => 'Benutzerregistrierung',
	'Allow registration for Movable Type.' => 'Registrierung bei Movable Type freischalten',
	'Registration Not Enabled' => 'Registierung nicht freischalten',
	'Note: Registration is currently disabled at the system level.' => 'Hinweis: Registrierung derzeit systemweit deaktiviert.',
	'Creative Commons' => 'Creative Commons',
	'Your blog is currently licensed under:' => 'Ihr Blog ist derzeit lizenziert unter:',
	'Change your license' => 'Lizenz ändern',
	'Remove this license' => 'Lizenz entfernen',
	'Your blog does not have an explicit Creative Commons license.' => 'Für dieses Blog liegt keine Creative Commons-Lizenz vor.',
	'Create a license now' => 'Jetzt eine Lizenz erstellen',
	'Replace Word Chars' => 'Word-Zeichen ersetzen',
	'Replace Fields' => 'Felder ersetzen',
	'Extended entry' => 'Erweiterter Eintrag',
	'Smart Replace' => 'Smart Replace',
	'Character entities (&amp#8221;, &amp#8220;, etc.)' => 'Entitäten (&amp#8221;, &amp#8220; usw.)',
	'ASCII equivalents (&quot;, \', ..., -, --)' => 'ASCII-Äquivalente (&quot;, \', ..., -, --)',

## tmpl/cms/error.tmpl

## tmpl/cms/list_association.tmpl
	'Permissions for [_1]' => 'Berechtigungen für [_1]',
	'Group Associations for [1]' => 'Gruppenzuweisungen für [_1]',
	'Permissions: System-wide' => 'Systemweite Berechtigungen',
	'Users &amp; Groups for [_1]' => 'Benutzer und Gruppen für [_1]',
	'Users for [_1]' => 'Benutzer für [_1]',
	'Remove selected assocations (x)' => 'Gewählte Zuweisungen löschen',
	'Revoke Permission' => 'Berechtigung zurückziehen',
	'association' => 'Zuweisung',
	'associations' => 'Zuweisungen',
	'Group Disabled' => 'Gruppe deaktiviert',
	'You have successfully revoked the given permission(s).' => 'Rechte erfolgreich entzogen.',
	'You have successfully granted the given permission(s).' => 'Rechte erfolgreich vergeben.',
	'Add user to a blog' => 'Benutzer zu Blog hinzufügen',
	'You can not create associations for disabled users.' => 'Deaktivierte Benutzerkonten können nicht zugewiesen werden.',
	'Grant Permission' => 'Berechtigungen zuweisen',
	'Add group to a blog' => 'Gruppe zu Blog hinzufügen',
	'You can not create associations for disabled groups.' => 'Deaktivierte Gruppen können nicht zugewiesen werden.',
	'Add [_1] to a blog' => '[_1] zu Blog hinzufügen',
	'Assign Role to Group' => 'Rolle an Gruppe zuweisen',
	'Assign Role to User' => 'Rolle an Benutzer zuweisen',
	'Add a group to this blog' => 'Diesem Blog Gruppe hinzufügen',
	'Add a user to this blog' => 'Diesem Blog Benutzer hinzufügen',
	'Grant permission to a group' => 'Berechtigung an Gruppe zuweisen',
	'Grant permission to a user' => 'Berechtigung an Benutzer zuweisen',
	'User/Group' => 'Benutzer/Gruppe',
	'Created On' => 'Angelegt am/um',

## tmpl/cms/list_comment.tmpl
	'The selected comment(s) has been approved.' => 'Die gewählten Kommentare wurden freigegeben.',
	'All comments reported as spam have been removed.' => 'Alle als Spam markierten Kommentare wurden entfernt.',
	'The selected comment(s) has been unapproved.' => 'Die gewählten Kommentare sind nicht mehr freigegeben',
	'The selected comment(s) has been reported as spam.' => 'Die gewählten Kommentare wurden als Spam gemeldet',
	'The selected comment(s) has been recovered from spam.' => 'Die gewählten Kommentare wurden aus dem Spam wiederhergestellt',
	'The selected comment(s) has been deleted from the database.' => 'Kommentar(e) aus der Datenbank gelöscht.',
	'One or more comments you selected were submitted by an unauthenticated commenter. These commenters cannot be Banned or Trusted.' => 'Nicht authentifizierten Kommentarautoren können weder gesperrt werden noch das Vertrauen ausgesprochen bekommen.',
	'No comments appeared to be spam.' => 'Kein Kommentar scheint Spam zu sein.',
	'Showing only: [_1]' => 'Zeige nur: [_1]',
	'[_1] on entries created within the last [_2] days' => '[_1] zu Einträgen, die in den letzten [_2] Tagen angelegt wurden',
	'[_1] on entries created more than [_2] days ago' => '[_1] zu Einträgen, die vor mehr als [_2] Tagen angelegt wurden',
	'[_1] where [_2] [_3]' => '[_1] bei denen [_2] [_3]',
	'Show' => 'Zeige',
	'all' => 'alle',
	'only' => 'nur',
	'[_1] where' => '[_1] bei denen',
	'entry was created in last' => 'Eintrag angelegt wurde in den letzten',
	'entry was created more than' => 'Eintrag angelegt wurde länger als vor',
	'commenter' => 'Kommentarautor',
	' days.' => 'Tagen.',
	' days ago.' => 'Tagen.',
	' is approved' => 'ist freigegeben',
	' is unapproved' => 'ist nicht freigegeben',
	' is unauthenticated' => 'ist nicht authenifiziert',
	' is authenticated' => 'ist authentifiziert',
	' is trusted' => 'ist vertraut',
	'Approve' => 'Freigeben',
	'Approve selected comments (p)' => 'Markierte Kommentare freigeben (p)',
	'Delete selected comments (x)' => 'Markierte Kommentare löschen (x)',
	'Report the selected comments as spam (j)' => 'Markierte Kommentare als Spam melden (j)',
	'Recover from Spam' => 'Aus Spam wiederherstellen',
	'Recover selected comments (j)' => 'Kommentare wiederherstellen (j)',
	'Are you sure you want to remove all comments reported as spam?' => 'Wirklich alle als Spam gemeldeten Kommentare löschen?',
	'Deletes all comments reported as spam' => 'Alle als Spam gemeldeten Kommentare löschen',

## tmpl/cms/rebuilding.tmpl
	'Publishing...' => 'Veröffentliche...', # Translate - New # OK
	'Publishing [_1]...' => 'Veröffentliche [_1] ...', # Translate - New # OK
	'Publishing [_1]' => 'Veröffentliche [_1]',
	'Publishing [_1] pages [_2]' => 'Veröffentliche [_1] Seiten [_2]',
	'Publishing [_1] dynamic links' => 'Veröffentlichte [_1] dynamische Links',
	'Publishing [_1] pages' => 'Veröffentliche [_1] Seiten',

## tmpl/cms/include/template_table.tmpl
	'Type' => 'Typ',
	'Linked' => 'Verlinkt',
	'Linked Template' => 'Verlinkte Vorlage',
	'Dynamic' => 'Dynamisch',
	'Dynamic Template' => 'Dynamische Vorlage', # Translate - New # OK
	'Published w/Indexes' => 'Mit Indizes veröffentlicht',
	'Published Template w/Indexes' => 'Vorlage mit Indizes veröffentlicht',
	'View' => 'Ansehen',
	'-' => '-',

## tmpl/cms/include/typekey.tmpl
	'Your TypeKey API Key is used to access Six Apart services like its free Authentication service.' => 'Ihr TypeKey API-Schlüssel wird zur Nutzung von Six Apart-Diensten wie unserem kostenlosen Authentifizierungdienst verwendet.',
	'TypeKey Enabled' => 'TypeKey aktiviert',
	'TypeKey is enabled.' => 'TypeKey wird verwendet.',
	'Clear TypeKey Token' => 'TypeKey-Token löschen',
	'TypeKey Setup:' => 'TypeKey-Einstellungen:',
	'TypeKey API Key Removed' => 'TypeKey API-Schlüssel entfernt',
	'Please click the Save Changes button below to disable authentication.' => 'Bitte klicken Sie auf Änderungen speichern, um die Authentifizierung abzuschalten.',
	'TypeKey Not Enabled' => 'TypeKey nicht aktiviert',
	'TypeKey is not enabled.' => 'TypeKey wird nicht verwendet',
	'Enter API Key:' => 'API-Schlüssel eingeben:',
	'Obtain TypeKey API Key' => 'TypeKey API-Schlüssel beziehen',
	'TypeKey API Key Acquired' => 'TypeKey API-Schlüssel bezogen',
	'Please click the Save Changes button below to enable TypeKey.' => 'Bitte klicken Sie auf Änderungen speichern, um TypeKey zu aktivieren.',

## tmpl/cms/include/cfg_entries_edit_page.tmpl
	'Editor Fields' => 'Eingabefelder',
	'_USAGE_ENTRYPREFS' => 'Wählen Sie aus, welche Formularfelder in der Eingabemaske angezeigt werden sollen.',
	'All' => 'Alle',
	'Custom' => 'Eigene',
	'Action Bar' => 'Menüleiste',
	'Select the location of the entry editor\'s action bar.' => 'Gewünschte Position der Menüleiste',
	'Below' => 'Oben',
	'Above' => 'Unten',

## tmpl/cms/include/archive_maps.tmpl
	'Path' => 'Pfad',
	'Custom...' => 'Angepasst...',

## tmpl/cms/include/pagination.tmpl

## tmpl/cms/include/footer.tmpl
	'Dashboard' => 'Dashboard',
	'Compose Entry' => 'Eintrag schreiben',
	'Manage Entries' => 'Einträge verwalten',
	'System Settings' => 'Systemkonfiguration',
	'Help' => 'Hilfe',
	'<a href="[_1]">Movable Type</a> version [_2]' => '<a href="[_1]">Movable Type</a> Version [_2]',
	'with' => 'mit',

## tmpl/cms/include/login_mt.tmpl

## tmpl/cms/include/itemset_action_widget.tmpl
	'More actions...' => 'Weitere Aktionen...',
	'to act upon' => 'bearbeiten',
	'Go' => 'Ausführen',

## tmpl/cms/include/ping_table.tmpl
	'From' => 'Von',
	'Target' => 'Auf',
	'Only show published TrackBacks' => 'Nur veröffentlichte TrackBacks anzeigen',
	'Only show pending TrackBacks' => 'Nur nicht veröffentlichte TrackBacks anzeigen',
	'Edit this TrackBack' => 'TrackBack bearbeiten',
	'Go to the source entry of this TrackBack' => 'Zum Eintrag wechseln, auf den sich das TrackBack bezieht',
	'View the [_1] for this TrackBack' => '[_1] zu dem TrackBack ansehen',
	'Search for all comments from this IP address' => 'Nach Kommentaren von dieser IP-Adresse suchen',

## tmpl/cms/include/anonymous_comment.tmpl
	'Anonymous Comments' => 'Anonyme Kommentare',
	'Require E-mail Address for Anonymous Comments' => 'E-Mail-Adresse von anonymen Kommentarautoren verlangen',
	'If enabled, visitors must provide a valid e-mail address when commenting.' => 'Wenn diese Option aktiv ist, müssen Kommentarautoren eine gültige Email-Adresse angeben.',

## tmpl/cms/include/header.tmpl
	'Send us your feedback on Movable Type' => 'Schicken Sie uns Ihr Feedback zu Movable Type',
	'Feedback?' => 'Feedback?',
	'Hi [_1],' => 'Hallo [_1]',
	'Logout' => 'Abmelden',
	'Select another blog...' => 'Anderes Blog wählen',
	'Create a new blog' => 'Neues Blog anlegen',
	'Write Entry' => 'Eintrag schreiben',
	'Blog Dashboard' => 'Blog-Dashboard',
	'View Site' => 'Ansehen',
	'Search (q)' => 'Suche (q)',

## tmpl/cms/include/cfg_system_content_nav.tmpl

## tmpl/cms/include/tools_content_nav.tmpl

## tmpl/cms/include/blog-left-nav.tmpl
	'Creating' => 'Anlegen',
	'Create New Entry' => 'Neuen Eintrag schreiben',
	'List Entries' => 'Einträge auflisten',
	'List uploaded files' => 'Hochgeladene Dateien auflisten',
	'Community' => 'Feedback',
	'List Comments' => 'Kommentare auflisten',
	'List Commenters' => 'Kommentarautoren auflisten',
	'List TrackBacks' => 'TrackBacks auflisten',
	'Edit Address Book' => 'Adressbuch bearbeiten', # Translate - New # OK
	'Configure' => 'Konfigurieren',
	'List Users &amp; Groups' => 'Benutzer und Gruppen auflisten',
	'Users &amp; Groups' => 'Benutzer und Gruppen',
	'List &amp; Edit Templates' => 'Vorlagen auflisten &amp; bearbeiten',
	'Edit Categories' => 'Kategorien bearbeiten',
	'Edit Tags' => 'Tags bearbeiten',
	'Edit Weblog Configuration' => 'Weblog-Konfiguration bearbeiten',
	'Utilities' => 'Werkzeuge',
	'Search &amp; Replace' => 'Suchen &amp; Ersetzen',
	'_SEARCH_SIDEBAR' => 'Suchen',
	'Backup this weblog' => 'Dieses Weblog sichern',
	'Import &amp; Export Entries' => 'Einträge importieren &amp; exportieren',
	'Import / Export' => 'Import/Export',
	'Rebuild Site' => 'Neu aufbauen',

## tmpl/cms/include/member_table.tmpl
	'Trusted commenter' => 'Vertrauter Kommentator',

## tmpl/cms/include/entry_table.tmpl
	'Last Modified' => 'Zuletzt geändert', # Translate - New # OK
	'Created' => 'Angelegt', # Translate - New # OK
	'Only show unpublished [_1]' => 'Nur nicht veröffentlichte [_1] zeigen',
	'Only show published [_1]' => 'Nur veröffentlichte [_1] zeigen',
	'Only show scheduled [_1]' => 'Nur zeitgeplante [_1] zeigen',
	'View [_1]' => 'Zeige [_1]',

## tmpl/cms/include/notification_table.tmpl
	'Date Added' => 'Hinzugefügt am',
	'Click to edit contact' => 'Klicken um Kontakt zu bearbeiten', # Translate - New # OK

## tmpl/cms/include/display_options.tmpl
	'_DISPLAY_OPTIONS_SHOW' => 'Zeige',
	'[quant,_1,row,rows]' => '[quant,_1,Zeile,Zeilen]',
	'Compact' => 'Kompakt',
	'Expanded' => 'Erweitert',
	'Date Format' => 'Datumsformat',
	'Relative' => 'Relativ (z.B. "Vor 20 Minuten")',
	'Full' => 'Voll',

## tmpl/cms/include/cfg_content_nav.tmpl
	'Web Services' => 'Web-Dienste',

## tmpl/cms/include/blog_table.tmpl

## tmpl/cms/include/backup_end.tmpl
	'All of the data has been backed up successfully!' => 'Alle Daten wurden erfolgreich gesichert!',
	'Download This File' => 'Diese Datei herunterladen',
	'_BACKUP_TEMPDIR_WARNING' => 'Gewünschte Daten erfolgreich im Ordner [_1] gesichert. Bitte laden Sie die angegebenen Dateien  <strong>sofort</strong> aus [_1] herunter und <strong>löschen</strong> Sie sie unmittelbar danach aus dem Ordner, da sie sensible Informationen enthalten.',
	'_BACKUP_DOWNLOAD_MESSAGE' => 'Der Download der Sicherungsdatei wird in einigen Sekunden automatisch beginnen. Sollte das nicht der Fall sein, klicken Sie <a href=\'#\' onclick=\'submit_form()\'>hier</a> um den Download manuell zu starten. Pro Sitzung kann die Sicherungsdatei nur einmal heruntergeladen werden.',
	'An error occurred during the backup process: [_1]' => 'Beim Backup ist ein Fehler aufgetreten: [_1]',

## tmpl/cms/include/import_start.tmpl
	'Importing...' => 'Importieren...',
	'Importing entries into blog' => 'Importiere Einträge...',
	'Importing entries as user \'[_1]\'' => 'Importiere als Benutzer \'[_1]\'...',
	'Creating new users for each user found in the blog' => 'Lege Benutzerkonten an...',

## tmpl/cms/include/users_content_nav.tmpl
	'Profile' => 'Profil',
	'Groups' => 'Gruppen',
	'Group Profile' => 'Gruppenprofile',
	'Details' => 'Details',
	'List Roles' => 'Rollen zeigen',

## tmpl/cms/include/calendar.tmpl

## tmpl/cms/include/overview-left-nav.tmpl
	'List Weblogs' => 'Weblogs anzeigen',
	'List Users and Groups' => 'Benutzer und Gruppen anzeigen',
	'List Associations and Roles' => 'Verknüpfungen und Rollen',
	'Privileges' => 'Berechtigungen',
	'List Plugins' => 'Plugins anzeigen',
	'Aggregate' => 'Übersicht',
	'List Tags' => 'Tags anzeigen',
	'Edit System Settings' => 'Systemeinstellungen bearbeiten',
	'Show Activity Log' => 'Aktivitätsprotokoll anzeigen',

## tmpl/cms/include/comment_table.tmpl
	'Reply' => 'Antworten',
	'Only show published comments' => 'Nur veröffentlichte Kommentare anzeigen',
	'Only show pending comments' => 'Nur nicht veröffentlichte Kommentare anzeigen',
	'Edit this comment' => 'Kommentar bearbeiten',
	'(1 reply)' => '(1 Antwort)',
	'([_1] replies)' => '([_1] Antworten)',
	'Blocked' => 'Gesperrt',
	'Authenticated' => 'Authentifiziert',
	'Edit this [_1] commenter' => '[_1] Kommentarautor bearbeiten',
	'Search for comments by this commenter' => 'Nach Kommentaren von diesem Kommentator suchen',
	'Anonymous' => 'Anonym',
	'View this entry' => 'Eintrag ansehen',
	'Show all comments on this entry' => 'Alle Kommentare zu diesem Eintrag anzeigen',

## tmpl/cms/include/rebuild_stub.tmpl
	'To see the changes reflected on your public site, you should rebuild your site now.' => 'Damit die Änderungen sichtbar werden, sollten Sie das Blog jetzt neu veröffentlichen.',
	'Rebuild my site' => 'Weblog neu veröffentlichen',

## tmpl/cms/include/chromeless_footer.tmpl

## tmpl/cms/include/backup_start.tmpl
	'Tools: Backup' => 'Tools: Sicherung',
	'Backing up Movable Type' => 'Movable Type-Sicherungskopie erstellen',

## tmpl/cms/include/commenter_table.tmpl
	'Identity' => 'ID',
	'Last Commented' => 'Zuletzt kommentiert',
	'Only show trusted commenters' => 'Nur vertrauenswürdige Kommentarautoren anzeigen',
	'Only show banned commenters' => 'Nur gesperrte Kommentarautoren anzeigen',
	'Only show neutral commenters' => 'Nur neutrale Kommentarautoren anzeigen',
	'Edit this commenter' => 'Kommentarautor bearbeiten',
	'View this commenter&rsquo;s profile' => 'Profil des Kommentarautors ansehen',

## tmpl/cms/include/author_table.tmpl
	'Only show enabled users' => 'Nur aktive Benutzerkonten anzeigen',
	'Only show disabled users' => 'Nur deaktivierte Benutzerkoten anzeigen',

## tmpl/cms/include/feed_link.tmpl
	'Activity Feed' => 'Aktivitäts-Feed',
	'Disabled' => 'Ausgeschaltet',

## tmpl/cms/include/import_end.tmpl
	'All data imported successfully!' => 'Import erfolgreich abgeschlossen!',
	'Make sure that you remove the files that you imported from the \'import\' folder, so that if/when you run the import process again, those files will not be re-imported.' => 'Vergessen Sie nicht, die verwendeten Dateien aus dem \'import\'-Ordner zu entfernen, damit sie bei künftigen Importvorgängen nicht erneut importiert werden. ',
	'An error occurred during the import process: [_1]. Please check your import file.' => 'Beim Importieren ist ein Fehler aufgetreten: [_1]. Bitte überprüfen Sie Ihre Import-Datei.',

## tmpl/cms/include/copyright.tmpl
	'Copyright &copy; 2001-<mt:date format="%Y"> Six Apart. All Rights Reserved.' => 'Copyright &copy; 2001-<mt:date format="%Y"> Six Apart. Alle Rechte vorbehalten.',

## tmpl/cms/include/log_table.tmpl
	'No log records could be found.' => 'Keine Protokolleinträge gefunden',
	'Log Message' => 'Protokollnachricht',
	'_LOG_TABLE_BY' => 'Nach',
	'IP: [_1]' => 'IP: [_1]',
	'[_1]' => '[_1]',

## tmpl/cms/include/listing_panel.tmpl
	'Step [_1] of [_2]' => 'Schritt [_1] von [_2]',
	'Go to [_1]' => 'Gehe zu [_1]',
	'Sorry, there were no results for your search. Please try searching again.' => 'Keine Treffer. Bitte suchen Sie erneut.',
	'Sorry, there is no data for this object set.' => 'Keine Daten für diese Objekte vorhanden.',
	'Back' => 'Zurück',
	'Confirm' => 'Bestätigen',

## tmpl/cms/list_blog.tmpl
	'You have successfully deleted the blogs from the Movable Type system.' => 'Die Weblogs wurden erfolgreich aus dem System gelöscht.',
	'Create Blog' => 'Blog anlegen',
	'weblog' => 'Weblog',
	'weblogs' => 'Weblogs',
	'Delete selected blogs (x)' => 'Gewählte Blogs löschen (x)',
	'Are you sure you want to delete this blog?' => 'Dieses Blog wirklich löschen?',

## tmpl/cms/upgrade.tmpl
	'Time to Upgrade!' => 'Zeit für Ihr Upgrade!',
	'Upgrade Check' => 'Upgrade-Überprüfung',
	'Do you want to proceed with the upgrade anyway?' => 'Upgrade dennoch fortsetzen?',
	'A new version of Movable Type has been installed.  We\'ll need to complete a few tasks to update your database.' => 'Es wurde eine neue Version von Movable Type installiert. Ihre Datenbank wird nun auf den aktuellen Stand gebracht.',
	'In addition, the following Movable Type components require upgrading or installation:' => 'Zusätzlich müssen folgende Movable Type-Komponenten installiert oder aktualisiert werden:',
	'The following Movable Type components require upgrading or installation:' => 'Die folgenden Movable Type-Komponenten müssen installiert oder aktualisiert werden:',
	'Begin Upgrade' => 'Upgrade durchführen',
	'Your Movable Type installation is already up to date.' => 'Ihre Movable Type-Installation ist bereits auf dem neuesten Stand.',
	'Return to Movable Type' => 'Zurück zu Movable Type',

## tmpl/cms/list_author.tmpl
	'Users: System-wide' => 'Systemweite Benutzerkonten',
	'_USAGE_AUTHORS_LDAP' => 'Eine Liste aller Benutzerkonten dieser Movable Type-Installation. Durch Anklicken eines Namens können Sie die Rechte des jeweiligen Benutzers festlegen. Um ein Benutzerkonto zu sperren, wählen Sie das Kontrollkästchen neben dem entsprechenden Namen an und klicken auf DEAKTIVIEREN. Der jeweilige Benutzer kann sich dann nicht mehr anmelden.',
	'You have successfully disabled the selected user(s).' => 'Gewählte Benutzerkonten erfolgreich enaktiviert',
	'You have successfully enabled the selected user(s).' => 'Gewählte Benutzerkonten erfolgreich aktiviert',
	'You have successfully deleted the user(s) from the Movable Type system.' => 'Gewählte Benutzerkonten erfolgreich aus Movable Type gelöscht',
	'The deleted user(s) still exist in the external directory. As such, they will still be able to login to Movable Type Enterprise.' => 'Die gelöschten Benutzerkonten sind im externen Verzeichnis weiterhin vorhanden. Die Benutzer können sich daher weiterhin an Movable Type Enterprise anmelden.',
	'You have successfully synchronized users\' information with the external directory.' => 'Benutzerinformationen erfolgreich mit externem Verzeichnis synchronisiert.',
	'Some ([_1]) of the selected user(s) could not be re-enabled because they were no longer found in the external directory.' => 'Einige ([_1]) der gewählten Benutzerkonten konnten nicht reaktiviert werden, da sie im externen Verzeichnis nicht mehr vorhanden sind.',
	'An error occured during synchronization.  See the <a href=\'[_1]\'>activity log</a> for detailed information.' => 'Bei der Synchronisation ist ein Fehler aufgetreten. Sichten Sie das <a href=\'[_1]\'>Aktivitätsprotokoll</a> für nähere Informationen.',
	'Show Enabled Users' => 'Zeige aktivierte Benutzerkonten',
	'Show Disabled Users' => 'Zeige deaktivierte Benutzerkoten',
	'Show All Users' => 'Zeige alle Benutzerkonten',
	'user' => 'Benutzer',
	'users' => 'Benutzer',
	'_USER_ENABLE' => 'Aktivieren',
	'Enable selected users (e)' => 'Gewählte Benutzerkonten aktivieren (e)',
	'_NO_SUPERUSER_DISABLE' => 'Sie sind Verwalter dieser Movable Type-Installation. Sie können daher nicht Ihr eigenes Benutzerkonto deaktivieren.',
	'_USER_DISABLE' => 'Deaktivieren',
	'Disable selected users (d)' => 'Gewählte Benutzerkonten deaktivieren (d)',
	'None.' => 'Keine',
	'(Showing all users.)' => '(Alle Benutzer)',
	'users.' => 'Benutzer',
	'users where' => 'Benutzer mit: ',
	'.' => '.',

## tmpl/cms/popup/recover.tmpl
	'Your password has been changed, and the new password has been sent to your email address ([_1]).' => 'Ihr Passwort wurde geändert, und das neue Passwort wurde an Ihre E-Mail-Adresse gesendet ([_1]).',
	'Return to sign in to Movabale Type' => 'Zur Movable Type-Anmeldeseite zurückkehren',
	'Enter your Movable Type username:' => 'Geben Sie Ihren Benutzernamen ein:',
	'Enter your password recovery word/phrase:' => 'Geben Sie Ihren Erinnerungssatz ein:',
	'Recover' => 'Passwort anfordern',

## tmpl/cms/popup/bm_entry.tmpl
	'Select' => 'Auswählen...',
	'Add new category...' => 'Neue Kategorie hinzufügen...',
	'You must choose a weblog in which to create the new entry.' => 'Bitte wählen Sie, in welchem Weblog der neue Eintrag erscheinen soll.',
	'Select a weblog for this entry:' => 'Weblog für diesen Eintrag ausäwhlen:',
	'Select a weblog' => 'Weblog auswählen',
	'Assign Multiple Categories' => 'Mehrere Kategorien zuweisen',
	'Insert Link' => 'Link einfügen',
	'Insert Email Link' => 'Email-Link einfügen',
	'Quote' => 'Zitat',
	'Extended Entry' => 'Erweiterter Eintrag',
	'Send an outbound TrackBack:' => 'TrackBack (outbound) senden:',
	'Select an entry to send an outbound TrackBack:' => 'Eintrag wählen, zu dem Sie TrackBack senden möchten:',
	'Unlock this entry\'s output filename for editing' => 'Dateiname zur Bearbeitung entsperren',
	'Save this entry (s)' => 'Eintrag speichern (s)',
	'You do not have entry creation permission for any weblogs on this installation. Please contact your system administrator for access.' => 'Sie haben derzeit keine Rechte, Weblogs zu bearbeiten. Bitte kontaktieren Sie Ihren Administrator',

## tmpl/cms/popup/show_upload_html.tmpl
	'Copy and paste this HTML into your entry.' => 'Kopieren Sie den HTML-Code, und fügen Sie ihn in den Eintrag ein.',
	'Upload Another' => 'Weitere hochladen',

## tmpl/cms/popup/rebuilt.tmpl
	'Success' => 'Erfolg',
	'All of your files have been published.' => 'Alle Dateien veröffentlicht.',
	'Your [_1] pages have been published.' => '[_1] Seiten veröffentlicht.',
	'View your site.' => 'Site ansehen',
	'View this page.' => 'Seite ansehen',
	'Publish Again' => 'Nochmal veröffentlichen', # Translate - New # OK

## tmpl/cms/popup/bm_posted.tmpl
	'Your new entry has been saved to [_1]' => 'Ihr Eintrag wurde in [_1] gespeichert',
	', and it has been published to your site' => ' unbd auf Ihrer Site veröffentlicht.',
	'. ' => '. ',
	'View your site' => 'Weblog ansehen',
	'Edit this entry' => 'Eintrag bearbeiten',

## tmpl/cms/popup/category_add.tmpl
	'Add A [_1]' => '[_1] hinzufügen',
	'To create a new [_1], enter a title in the field below, select a parent [_1], and click the Add button.' => 'Um eine neue [_1] anzulegen, geben Sie unten einen Titel ein, wählen eine Elternkategorie und klicken auf Hinzufügen.',
	'[_1] Title:' => '[_1]-Name',
	'Parent [_1]:' => 'Eltern-[_1]',
	'Top Level' => 'Oberste Ebene',
	'Save [_1] (s)' => '[_1] speichern (s)',

## tmpl/cms/popup/rebuild_confirm.tmpl
	'Publish [_1]' => '[_1] veröffentlichen', # Translate - New # OK
	'All Files' => 'Alle Dateien',
	'Index Template: [_1]' => 'Index-Vorlagen: [_1]',
	'Indexes Only' => 'Nur Indizes',
	'[_1] Archives Only' => 'Nur [_1]-Archive',
	'Publish (r)' => 'Veröffentlichen (r)', # Translate - New # OK

## tmpl/cms/popup/pinged_urls.tmpl
	'Here is a list of the previous TrackBacks that were successfully sent:' => 'Liste aller bereits erfolgreich gesendeten TrackBacks:',
	'Here is a list of the previous TrackBacks that failed. To retry these, include them in the Outbound TrackBack URLs list for your entry.:' => 'Liste aller bisher fehlgeschlagenen TrackBacks. Für einen erneuten Sendeversuch bitte in die Liste der zu sendenden TrackBacks kopieren.',

## tmpl/cms/list_entry.tmpl
	'Your [_1] has been deleted from the database.' => '[_1] aus Datenbank gelöscht.',
	'Go back' => 'Zurück',
	'tag (exact match)' => 'Tag (exakt)',
	'tag (fuzzy match)' => 'Tag (fuzzy)',
	'published' => 'veröffentlicht',
	'unpublished' => 'nicht veröffentlicht',
	'scheduled' => 'zeitgeplant',
	'Select A User:' => 'Benutzerkonto auswählen: ',
	'User Search...' => 'Benutzer suchen...',
	'Recent Users...' => 'Letzten Benutzer...',
	'Save these [_1] (s)' => '[_1] speichern (s)',
	'Publish selected [_1] (r)' => 'Gewählte [_1] veröffentlichen (r)', # Translate - New # OK
	'Delete selected [_1] (x)' => 'Gewählte [_1] löschen',
	'page' => 'Seite',
	'publish' => 'Veröffentlichen', # Translate - Case
	'Publish selected pages (r)' => 'Gewählte Seiten veröffentlichen (r)', # Translate - New # OK
	'Delete selected pages (x)' => 'Gewählte Seiten löschen (x)',

## tmpl/cms/recover_password_result.tmpl
	'Recover Passwords' => 'Passwörter wiederherstellen',
	'No users were selected to process.' => 'Es wurden keine Benutzer ausgewählt.',
	'Return' => 'Zurück',

## tmpl/cms/view_log.tmpl
	'The activity log has been reset.' => 'Das Aktivitätsprotokoll wurde zurückgesetzt.',
	'All times are displayed in GMT[_1].' => 'Alle Zeiten in GMT[_1]',
	'All times are displayed in GMT.' => 'Alle Zeiten in GMT',
	'Show only errors' => 'Nur Fehlermeldungen anzeigen',
	'System Activity Log' => 'System-Aktivitätsprotokoll',
	'Filtered' => 'Gefilterte',
	'Filtered Activity Feed' => 'Gefilterter Aktivitätsfeed',
	'Download Filtered Log (CSV)' => 'Gefiltertes Protokoll herunterladen (CSV)',
	'Download Log (CSV)' => 'Protokoll herunterladen (CSV)',
	'Clear Activity Log' => 'Aktivitätsprotokoll zurücksetzen',
	'Are you sure you want to reset activity log?' => 'Aktivitätsprotokoll wirklich zurücksetzen?',
	'Showing all log records' => 'Alle Einträge',
	'Showing log records where' => 'Einträge bei denen',
	'Show log records where' => 'Zeige Einträge bei denen',
	'level' => 'Level',
	'classification' => 'Thema',
	'Security' => 'Sicherheit',
	'Error' => 'Fehler',
	'Information' => 'Information',
	'Debug' => 'Debug',
	'Security or error' => 'Sicherheit oder Fehler',
	'Security/error/warning' => 'Sicherheit/Fehler/Warnung',
	'Not debug' => 'Kein Debug',
	'Debug/error' => 'Debug/Fehler',

## tmpl/cms/list_tag.tmpl
	'Your tag changes and additions have been made.' => 'Tag-Änderungen übernommen.',
	'You have successfully deleted the selected tags.' => 'Markierte Tags erfolgreich gelöscht.',
	'tag' => 'Tag',
	'tags' => 'Tags',
	'Delete selected tags (x)' => 'Markierte Tags löschen (x)',
	'Tag Name' => 'Tag-Name',
	'Click to edit tag name' => 'Klicken, um Tagname zu bearbeiten',
	'Rename' => 'Umbenennen',
	'Show all [_1] with this tag' => 'Alle [_1] mit diesem Tag zeigen',
	'[quant,_1,entry,entries]' => '[quant,_1,Eintrag,Einträge]',
	'An error occurred while testing for the new tag name.' => 'Fehler beim Überprüfen des neuen Tag-Namens aufgetreten.',

## tmpl/cms/restore.tmpl
	'Restore from a Backup' => 'Sicherung wiederherstellen',
	'Perl module XML::SAX and/or its dependencies are missing - Movable Type can not restore the system without it.' => 'Das Per-Modul XML::SAX und/oder seine Abhängigkeiten fehlen. Ohne kann Movable Type das System nicht wiederherstellen.',
	'Backup file' => 'Sicherungsdatei', # Translate - New # OK
	'If your backup file is located on your computer, you can upload it here.  Otherwise, Movable Type will automatically look in the \'import\' folder of your Movable Type directory.' => 'Wenn Sie eine auf Ihrem Computer gespeicherte Sicherungsdatei verwenden wollen, laden Sie diese hier hoch. Alternativ verwendet Movable Type automatisch die Sicherungsdatei, die es im \'import\'-Unterordner Ihres Movable Type-Verzeichnis findet.',
	'Options' => 'Optionen',
	'Check this and files backed up from newer versions can be restored to this system.  NOTE: Ignoring Schema Version can damage Movable Type permanently.' => 'Anwählen, um auch Dateien mit einer neueren Schemaversionen wiederherstellen zu können. HINWEIS: Nichtbeachtung der Schemaverion kann Ihre Movable Type-Installation dauerhaft beschädigen.',
	'Ignore schema version conflicts' => 'Versionskonflikte ignorieren',
	'Restore (r)' => 'Wiederherstellen (r)',

## tmpl/cms/list_category.tmpl
	'Your [_1] changes and additions have been made.' => '[_1]-Änderungen erfolgreich durchgeführt.',
	'You have successfully deleted the selected [_1].' => 'Gewählte [_1] erfolgreich gelöscht.',
	'Create new top level [_1]' => 'Neue Haupt-[_1] anlegen',
	'Collapse' => 'Reduzieren',
	'Expand' => 'Erweitern',
	'Move [_1]' => '[_1] verschieben',
	'Move' => 'Verschieben',
	'[quant,_1,TrackBack,TrackBacks]' => '[quant,_1,TrackBack,TrackBacks]',

## tmpl/cms/setup_initial_blog.tmpl
	'Create Your First Blog' => 'Legen Sie Ihr erstes Blog an',
	'The blog name is required.' => 'Blog-Name erforderlich.',
	'The blog URL is required.' => 'Blog-URL erforderlich.', # Translate - Case
	'The publishing path is required.' => 'Pfadangabe erforderlich.',
	'The timezone is required.' => 'Zeitzone erforderlich.',
	'In order to properly publish your blog, you must provide Movable Type with your blog\'s URL and the path on the filesystem where its files should be published.' => 'Damit Ihr Blog ordnungsgemäßg veröffentlicht werden kann, geben Sie bitte die Webadresse (URL) und den Dateisystempfad an, in denen Movable Type die erforderlich Dateien ablegen soll.',
	'My First Blog' => 'Mein erstes Blog',
	'Publishing Path' => 'Veröffentlichungspfad',
	'Your \'Publishing Path\' is the path on your web server\'s file system where Movable Type will publish all the files for your blog. Your web server must have write access to this directory.' => 'Der Veröffentlichungspfad ist der Pfad auf Ihrem Webserver, in dem Movable Type die für Ihren Blog erforderlichen Dateien ablegt.',
	'Finish install' => 'Installation abschließen',

## tmpl/cms/list_asset.tmpl
	'You have successfully deleted the file(s).' => 'Die Datei(en) wurden erfolgreich gelöscht.',
	'Show Images' => 'Zeige Bilder',
	'Show Files' => 'Zeige Dateien',
	'type' => 'Typ',
	'asset' => 'Asset',
	'assets' => 'Assets',
	'Delete selected assets (x)' => 'Gewählte Assets löschen (x)',

## tmpl/cms/preview_strip.tmpl
	'You are previewing the [_1] titled &ldquo;[_2]&rdquo;' => 'Sie sehen eine Vorschau auf den [_1] namens &ldquo;[_2]&rdquo;',

## tmpl/cms/list_banlist.tmpl
	'IP Banning Settings' => 'IP-Sperren-Einstellungen',
	'You have added [_1] to your list of banned IP addresses.' => 'Sie haben [_1] zur Liste mit gesperrten IP-Adressen hinzugefgt.',
	'You have successfully deleted the selected IP addresses from the list.' => 'Sie haben die ausgewählten IP-Adressen erfolgreich aus der Liste entfernt.',
	'Ban New IP Address' => 'Neue IP-Adresse sperren',
	'IP Address' => 'IP-Adresse',
	'Ban IP Address' => 'IP-Adresse sperren',
	'Date Banned' => 'gesperrt am',

## tmpl/cms/cfg_trackbacks.tmpl
	'TrackBack Settings' => 'TrackBack-Einstellungen',
	'Your TrackBack preferences have been saved.' => 'TrackBack-Einstellungen gespeichert.',
	'Note: TrackBacks are currently disabled at the system level.' => 'Hinweis: TrackBacks sind derzeit im Gesamtsystem deaktiviert.',
	'Accept TrackBacks' => 'TrackBacks zulassen',
	'If enabled, TrackBacks will be accepted from any source.' => 'Legt fest, ob TrackBacks von allen Quellen zugelassen sind',
	'TrackBack Policy' => 'TrackBack-Regeln',
	'Moderation' => 'Moderation',
	'Hold all TrackBacks for approval before they\'re published.' => 'Alle TrackBacks moderieren',
	'Apply \'nofollow\' to URLs' => '\'nofollow\' an URLs anhängen',
	'This preference affects both comments and TrackBacks.' => 'Diese Voreinstellung bezieht sich sowohl auf Kommentare als auch auf TrackBacks.',
	'If enabled, all URLs in comments and TrackBacks will be assigned a \'nofollow\' link relation.' => 'Falls aktiviert, wird für alle Links in Kommentaren und TrackBacks das \'nofollow\'-Attribut gesetzt.',
	'E-mail Notification' => 'Benachrichtigungen',
	'Specify when Movable Type should notify you of new TrackBacks if at all.' => 'Legt fest, ob und wann Sie bei neuen TrackBacks benachrichtigt werden',
	'On' => 'Ein',
	'Only when attention is required' => 'Nur wenn ich etwas machen muss',
	'Off' => 'Aus',
	'Ping Options' => 'Ping-Optionen',
	'TrackBack Auto-Discovery' => 'TrackBack Auto-Discovery',
	'If you turn on auto-discovery, when you write a new entry, any external links will be extracted and the appropriate sites automatically sent TrackBacks.' => 'Auto-Discovery verschickt an alle verlinkten externen Seiten, die TrackBack unterstützen, automatisch TrackBack-Pings.',
	'Enable External TrackBack Auto-Discovery' => 'TrackBack Auto-Discovery (external) aktivieren',
	'Setting Notice' => 'Hinweis zu der Einstellung',
	'Note: The above option may be affected since outbound pings are constrained system-wide.' => 'Hinweis: Die Option ist eventuell betroffen, da Einstellungen zu Pings (outbound) für das Gesamtsystem konfiguriert werden.',
	'Setting Ignored' => 'Einstellung ignoriert',
	'Note: The above option is currently ignored since outbound pings are disabled system-wide.' => 'Hinweis: Diese Option wird ignoriert, da Pings (outbound) für das Gesamtsystem derzeit ausgeschaltet sind.',
	'Enable Internal TrackBack Auto-Discovery' => 'TrackBack Auto-Discovery (internal) aktivieren',

## tmpl/cms/edit_ping.tmpl
	'The TrackBack has been approved.' => 'TrackBack wurde freigeschaltet.',
	'TrackBack Marked as Spam' => 'TrackBack als Spam markiert',
	'Previous' => 'Zurück',
	'List &amp; Edit TrackBacks' => 'TrackBacks anzeigen &amp; bearbeiten',
	'View Entry' => 'Eintrag ansehen',
	'Save this TrackBack (s)' => 'TrackBack speichern (s)',
	'Delete this TrackBack (x)' => 'Dieses TrackBack löschen (x)',
	'Update the status of this TrackBack' => 'TrackBack-Status aktualisieren',
	'Junk' => 'Spam',
	'View all TrackBacks with this status' => 'Alle TrackBacks mit diesem Status ansehen',
	'Source Site' => 'Quellseite',
	'Search for other TrackBacks from this site' => 'Weitere TrackBacks von dieser Seite suchen',
	'Source Title' => 'Quellname',
	'Search for other TrackBacks with this title' => 'Weitere TrackBacks mit diesem Namen suchen',
	'Search for other TrackBacks with this status' => 'Weitere TrackBacks mit diesem Status suchen',
	'Target Entry' => 'Zieleintrag',
	'No title' => 'Kein Name',
	'View all TrackBacks on this entry' => 'Alle TrackBacks bei diesem Eintrag anzeigen',
	'Target Category:' => 'Zielkategorie:',
	'Category no longer exists' => 'Kategorie nicht mehr vorhanden',
	'View all TrackBacks on this category' => 'Alle TrackBacks in dieser Kategorie anzeigen',
	'View all TrackBacks created on this day' => 'Alle TrackBacks dieses Tages anzeigen',
	'View all TrackBacks from this IP address' => 'Alle TrackBacks von dieser IP-Adrese anzeigen',
	'TrackBack Text' => 'TrackBack-Text',
	'Excerpt of the TrackBack entry' => 'TrackBack-Auszug',

## tmpl/cms/cfg_plugin.tmpl
	'Installed Plugins' => 'Installierte Plugins',
	'http://www.sixapart.com/pronet/plugins/' => 'http://www.sixapart.com/pronet/plugins/',
	'Find Plugins' => 'Weitere Plugins',
	'Your plugin settings have been saved.' => 'Ihre Plugins-Einstellungen wurden gespeichert.',
	'Your plugin settings have been reset.' => 'Ihre Plugin-Einstellungen wurden zurückgesetzt.',
	'Your plugins have been reconfigured.' => 'Ihre Plugins wurden neu konfiguriert.',
	'Your plugins have been reconfigured. Since you\'re running mod_perl, you will need to restart your web server for these changes to take effect.' => 'Ihre Plugins wurden neu konfiguriert. Da Sie mod_perl verwenden, müssen Sie Ihren Webserver neu starten, damit die Änderungen wirksam werden.',
	'Are you sure you want to reset the settings for this plugin?' => 'Wollen Sie die Plugin-Einstellungen wirklich zurücksezten?',
	'Disable plugin system?' => 'Plugin-System ausschalten?',
	'Disable this plugin?' => 'Dieses Plugin ausschalten?',
	'Enable plugin system?' => 'Plugin-System einschalten?',
	'Enable this plugin?' => 'Dieses Plugin einschalten?',
	'Disable Plugins' => 'Plugins ausschalten',
	'Enable Plugins' => 'Plugins einschalten',
	'Failed to Load' => 'Fehler beim Laden',
	'Disable' => 'Ausschalten',
	'Enabled' => 'Eingeschaltet',
	'Enable' => 'Einschalten',
	'Documentation for [_1]' => 'Dokumentation zu [_1]',
	'Documentation' => 'Dokumentation',
	'Author of [_1]' => 'Autor von [_1]',
	'More about [_1]' => 'Mehr über [_1]',
	'Plugin Home' => 'Plugin Home',
	'Show Resources' => 'Funktionen anzeigen',
	'Run [_1]' => '[_1] ausführen',
	'Show Settings' => 'Einstellungen anzeigen',
	'Settings for [_1]' => 'Einstellungen von [_1]',
	'Version' => 'Version',
	'Resources Provided by [_1]' => 'Resourcen von [_1]',
	'Tag Attributes' => 'Tag-Attribute',
	'Text Filters' => 'Text-Filter',
	'Junk Filters' => 'Junk-Filter',
	'[_1] Settings' => '[_1]-Einstellungen',
	'Reset to Defaults' => 'Standardwerte setzen',
	'Plugin error:' => 'Plugin-Fehler:',
	'This plugin has not been upgraded to support Movable Type [_1]. As such, it may not be 100% functional. Furthermore, it will require an upgrade once you have upgraded to the next Movable Type major release (when available).' => 'Dieses Plugin wurde noch nicht für Movable Type [_1] portiert. Daher funktioniert es möglicherweise nicht fehlerfrei. Außerdem erfordert es nach Installation der nächsten Movable Type-Version eine zusätzliche Aktualisierung.',
	'No plugins with weblog-level configuration settings are installed.' => 'Es sind keine Plugins installiert, die am Gesamtsystem konfiguriert werden können.',

## tmpl/cms/edit_folder.tmpl
	'Edit Folder' => 'Ordner bearbeiten',
	'Use this page to edit the attributes of the folder [_1]. You can set a description for your folder to be used in your public pages, as well as configuring the TrackBack options for this folder.' => 'Hier können Sie die Attribute des [_1]-Ordners wählen, seine TrackBack-Optionen einstellen und eine Beschreibung eingeben, die auf Ihrer Site angezeigt werden soll.',
	'Your folder changes have been made.' => 'Die Ordneränderungen wurden gespeichert.',
	'You must specify a label for the folder.' => 'Sie müssen diesem Ordner eine Bezeichnung geben',
	'Label' => 'Bezeichnung',
	'Save this folder (s)' => 'Ordner speichern',

## tmpl/cms/bookmarklets.tmpl
	'Configure QuickPost' => 'QuickPost einrichten',
	'_USAGE_BOOKMARKLET_1' => 'Wenn Sie QuickPost einrichten, können Sie einfach neue Einträge veröffentlichen, ohne direkt in Movable Type zu arbeiten.',
	'_USAGE_BOOKMARKLET_2' => 'Sie können die Bestandteile von QuickPost frei konfigurieren und beispielsweise nur die Formularfelder und Schaltflächen aktivieren, die Sie häufig verwenden.',
	'Include:' => 'Anzeigen:',
	'TrackBack Items' => 'TrackBack',
	'Allow Comments' => 'Kommentare zulassen',
	'Allow TrackBacks' => 'TrackBacks zulassen',
	'Create QuickPost' => 'QuickPost einrichten',
	'_USAGE_BOOKMARKLET_3' => 'Um das QuickPost-Lesezeichen zu installieren, ziehen Sie den folgenden Link in die Lesezeichenleiste oder in das Lesezeichenmenü Ihres Browsers:',
	'_USAGE_BOOKMARKLET_5' => 'Falls Sie unter Windows mit dem Internet Explorer arbeiten, können Sie die Option "QuickPost" auch zum Kontextmenü hinzufügen. Klicken Sie dazu auf nachfolgenden Link und bestätigen Sie die Eingabeaufforderung. Um die Einrichtung abzuschließen, beenden Sie anschließend das Programm und starten es daraufhin erneut. Sie erreichen das Kontextmenü, indem Sie im Internet Explorer mit der rechten Maustaste auf eine Webseite klicken.',
	'Add QuickPost to Windows right-click menu' => 'QuickPost zum Kontextmenü von Windows hinzufügen',
	'_USAGE_BOOKMARKLET_4' => 'Nachdem Sie das QuickPost-Lesezeichen eingerichtet haben, können Sie jederzeit einen Eintrag schreiben, ohne dazu das komplette Movable Type-Interface aufrufen oder die gerade besuchte Website verlassen zu müssen. Dazu öffnet sich nach Klick auf den QuickPost-Link ein Pop-Up-Fenster mit einer vereinfachten Movable Type-Eingabemaske.',

## tmpl/cms/backup.tmpl
	'What to backup' => 'Was sichern?',
	'This option will backup Users, Roles, Associations, Blogs, Entries, Categories, Templates and Tags.' => 'Hier können Sie eine Sicherheitskopie Ihrer Blogs erstellen. Sicherungen umfassen Benutzerkonten, Rollen, Verknüpfungen, Blogs, Einträge, Kategoriedefinitionen, Vorlagen und Tags.',
	'Everything' => 'Alles',
	'Choose blogs to backup' => 'Einzelne Blogs auswählen',
	'Type of archive format' => 'Archivformat',
	'The type of archive format to use.' => 'Das zu verwendende Archivformat',
	'tar.gz' => 'tar.gz',
	'zip' => 'ZIP',
	'Don\'t compress' => 'Nicht komprimieren',
	'Number of megabytes per file' => 'Aufteilung',
	'Approximate file size per backup file.' => 'Ungefähre Größe pro Backupdatei (MB)',
	'Don\'t Divide' => 'Nicht aufteilen',
	'Make Backup' => 'Sicherung erstellen',
	'Make Backup (b)' => 'Sicherung erstellen (b)',

## tmpl/cms/cfg_web_services.tmpl
	'Web Services Settings' => 'Webdienste-Einstellungen',
	'Services' => 'Dienste',
	'TypeKey Setup' => 'TypeKey-Setup',
	'Recently Updated Key' => '"Kürzlich aktualisiert"-Schlüssel',
	'If you have received a recently updated key (by virtue of your purchase), enter it here.' => 'Wenn Sie einen "Kürzlich aktualisiert"-Schlüssel erhalten haben, tragen Sie ihn hier ein.',
	'External Notifications' => 'Externe Benachrichtigungen',
	'Notify the following sites upon blog updates' => 'Die folgenden Websites bei Aktualisierungen benachrichtigen',
	'When this blog is updated, Movable Type will automatically notify the selected sites.' => 'Movable Type benachrichtigt die gewählten Sites automatisch, wenn dieses Blog aktualisiert wurde.',
	'Note: This option is currently ignored since outbound notification pings are disabled system-wide.' => 'Hinweis: Diese Einstellung zeigt momentan keine Wirkung, da ausgehende Benachrichtigungs-Ping systemweit deaktiviert sind.',
	'Others:' => 'Andere:',
	'(Separate URLs with a carriage return.)' => '(Pro Zeile eine URL)',

## tmpl/cms/restore_start.tmpl
	'Restoring Movable Type' => 'Movable Type wiederherstellen',

## tmpl/cms/edit_category.tmpl
	'Edit Category' => 'Kategorie bearbeiten',
	'Your category changes have been made.' => 'Die Einstellungen wurden übernommen.',
	'You must specify a label for the category.' => 'Geben Sie einen Namen für die Kategorie an.',
	'This is the basename assigned to your category.' => 'Der dieser Kategorie zugewiesene Basename',
	'Unlock this category&rsquo;s output filename for editing' => 'Dateinamen manuell bearbeiten',
	'Warning: Changing this category\'s basename may break inbound links.' => 'Achtung: Änderungen des Basenames können bestehende externe Links auf diese Kategorieseite ungültig mächen',
	'Inbound TrackBacks' => 'TrackBacks (inbound)',
	'Accept Trackbacks' => 'TrackBacks zulassen',
	'If enabled, TrackBacks will be accepted for this category from any source.' => 'Wenn die Option aktiv ist, sind Kategorie-TrackBacks aus allen Quellen zugelassen',
	'View TrackBacks' => 'TrackBacks ansehen',
	'TrackBack URL for this category' => 'TrackBack-URL für diese Kategorie',
	'_USAGE_CATEGORY_PING_URL' => 'Das ist die Adresse für TrackBacks für diese Kategorie. Wenn Sie sie öffentlich machen, kann jeder, der in seinem Blog einen für diese Kategorie relevanten Eintrag geschrieben hat, einen TrackBack-Ping senden. Mittels TrackBack-Tags können Sie diese TrackBacks dann auf Ihrer Seite anzeigen. Näheres dazu finden Sie in der Dokumentation.',
	'Passphrase Protection' => 'Passphrasenschutz',
	'Optional' => 'optionalen ',
	'Outbound TrackBacks' => 'TrackBacks (outbound)',
	'Trackback URLs' => 'TrackBack-URLs',
	'Enter the URL(s) of the websites that you would like to send a TrackBack to each time you create an entry in this category. (Separate URLs with a carriage return.)' => 'Geben Sie die Adressen der Websites ein, an die Sie automatisch einen TrackBack-Ping schicken möchten, wenn ein neuer Eintrag in dieser Kategorie veröffentlicht wurde. Verwenden Sie für jede Adresse eine neue Zeile.',

## tmpl/cms/list_notification.tmpl
	'You have added [_1] to your address book.' => '[_1] zum Adressbuch hinzugefügt.',
	'You have successfully deleted the selected notifications from your notification list.' => 'Sie haben die ausgewählten Benachrichtigungen erfolgreich aus der Benachrichtigungsliste gelöscht.',
	'Download Address Book (CSV)' => 'Adressbuch herunterladen (CSV)',
	'contact' => 'Kontakt', # Translate - New # OK
	'contacts' => 'Kontakte', # Translate - New # OK
	'Delete selected contacts (x)' => 'Gewählte Kontakte löschen (x)', # Translate - New # OK
	'Create Contact' => 'Kontakt anlegen',
	'URL (Optional):' => 'URL (optional):',
	'Add Contact' => 'Kontakt hinzufügen', # Translate - New # OK

## tmpl/cms/cfg_system_general.tmpl
	'General Settings: System-wide' => 'Systemweite Grundeinstellungen',
	'This screen allows you to set system-wide new user defaults.' => 'Hier können Sie global gültige Voreinstellungen für neue Benutzerkonten vornehmen.',
	'Your settings have been saved.' => 'Die Einstellungen wurden gespeichert.',
	'You must set a valid Default Site URL.' => 'Standard-Site URL erforderlich.',
	'You must set a valid Default Site Root.' => 'Standard-Site Root erforderlich.',
	'System Email Settings' => 'System-E-Mail-Einstellungen',
	'System Email Address' => 'System-E-Mail-Adresse',
	'The email address used in the From: header of each email sent from the system.  The address is used in password recovery, commenter registration, comment, trackback notification, entry notification and a few other minor events.' => 'Die E-Mail-Adresse, die als Absenderadresse der vom System verschickten E-Mails verwendet wird. E-Mails werden vom System verschickt bei Passwortanforderungen, Registrierungen von Kommentarautoren, für Benachrichtigungen über neue Kommentare, TrackBacks und Einträge und in einigen weiteren Fällen.',
	'New User Defaults' => 'Voreinstellungen für neue Benutzer',
	'Personal weblog' => 'Persönliches Weblog',
	'Check to have the system automatically create a new personal weblog when a user is created in the system. The user will be granted a blog administrator role on the weblog.' => 'Wenn diese Option aktiv ist, wird für jeden neu angelegten Benutzer automatisch ein pesönliches Weblog angelegt. Der Benutzer wird für dieses Blog als Blog-Administrator eingetragen.',
	'Automatically create a new weblog for each new user' => 'Für jeden neuen Benutzer automatisch ein neues Weblog anlegen',
	'Personal weblog clone source' => 'Klonvorlage für persönliche Weblogs',
	'Select a weblog you wish to use as the source for new personal weblogs. The new weblog will be identical to the source except for the name, publishing paths and permissions.' => 'Wählen Sie ein Weblog, das als Vorlage für persönliche Weblogs dienen soll. Neue persönliche Blogs sind mit der Vorlage bis auf Name, Pfade und Berechtigungen identisch.',
	'Default Site URL' => 'Standard-Site URL',
	'Define the default site URL for new weblogs. This URL will be appended with a unique identifier for the weblog.' => 'Wählen Sie die Standard-URL für neue Weblogs. Dieser URL wird ein individueller Bezeichner für jedes Weblog angehängt.',
	'Default Site Root' => 'Standard-Site Root',
	'Define the default site root for new weblogs. This path will be appended with a unique identifier for the weblog.' => 'Wählen Sie das Standard-Wurzelverzeichnis für neue Weblogs. Dem Pfad wird ein individueller Bezeichner für jedes Weblog angehängt.',
	'Default User Language' => 'Standard-Sprache',
	'Define the default language to apply to all new users.' => 'Wählen Sie die Standard-Sprache aller neuer Benutzerkonten ',
	'Default Timezone' => 'Standard-Zeitzone',
	'Default Tag Delimiter' => 'Standard-Tag-Trennzeichen',
	'Define the default delimiter for entering tags.' => 'Wählen Sie das Standard-Trennzeichen für die Eingabe von Tags',

## tmpl/cms/dashboard.tmpl
	'Add a Widget...' => 'Widget hinzufügen...',
	'You have attempted to access a page that does not exist. Please navigate to the page you are looking for starting from the dashboard.' => 'Die angeforderte Seite existiert nicht. Bitte wählen Sie die gewünschte Seite über das Dashboard an.',
	'Your Dashboard has been updated.' => 'Dashboard aktualisiert.',
	'You have attempted to use a feature that you do not have permission to access. If you believe you are seeing this message in error contact your system administrator.' => 'Sie haben für die gewünschte Funktion keine Zugriffsrechte. Bei Fragen wenden Sie sich bitte an Ihren Systemadministrator.',
	'Your dashboard is empty!' => 'Ihr Dashboard ist leer!',

## tmpl/cms/cfg_comments.tmpl
	'Comment Settings' => 'Kommentar-Einstellungen',
	'Your preferences have been saved.' => 'Die Einstellungen wurden gespeichert.',
	'Note: Commenting is currently disabled at the system level.' => 'Hinweise: Die Kommentarfunktion ist derzeit für das Gesamtsystem ausgeschaltet.',
	'Comment authentication is not available because one of the needed modules, MIME::Base64 or LWP::UserAgent is not installed. Talk to your host about getting this module installed.' => 'Kommentarauthentifizierung ist derzeit nicht möglich. Ein erforderliches Modul, MIME::Base64 oder LWP::UserAgent, ist nicht installiert. Ihr Administrator kann Ihnen vielleicht weiterhelfen.',
	'Accept Comments' => 'Kommentare zulassen',
	'If enabled, comments will be accepted.' => 'Falls aktiviert, werden Kommentare zugelassen.',
	'Commenting Policy' => 'Kommentierungs-Regeln',
	'Allowed Authentication Methods' => 'Zuässige Authentifizierung-Methoden',
	'Authentication Not Enabled' => 'Authentifizierung nicht aktiviert',
	'Note: You have selected to accept comments from authenticated commenters only but authentication is not enabled. In order to receive authenticated comments, you must enable authentication.' => 'Hinweis: Sie möchten Kommentare nur von authentifizierten Kommentarautoren zulassen. Allerdings haben Sie die Authentifizierung nicht aktiviert.',
	'Native' => 'Nativ',
	'Require E-mail Address for Comments via TypeKey' => 'E-Mail-Adresse für Kommentare via TypeKey erfordern',
	'If enabled, visitors must allow their TypeKey account to share e-mail address when commenting.' => 'Falls aktiviert, müssen Leser, die sich zum Kommentieren mit TypeKey anmelden, von TypeKey ihre E-Mail-Adresse übermitteln lassen. ',
	'Setup other authentication services' => 'Andere Authentifizierungs-Dienste einrichten',
	'OpenID providers disabled' => 'OpenID-Provider deaktiviert',
	'Required module (Digest::SHA1) for OpenID commenter authentication is missing.' => 'Für OpenID-Authentifizierung von Kommentarautoren erforderliches Modul (Digest::SHA1) nicht vorhanden.',
	'Immediately approve comments from' => 'Automatisch Kommentare freischalten von',
	'Specify what should happen to comments after submission. Unapproved comments are held for moderation.' => 'Geben Sie an, was mit neuen Kommentaren geschehen soll. Ungeprüfte Kommentare werden zur Moderierung zurückgehalten.',
	'No one' => 'Niemandem',
	'Trusted commenters only' => 'Nur von vertrauten Kommentarautoren',
	'Any authenticated commenters' => 'Von allen authentifizierten Kommentarautoren',
	'Anyone' => 'Jedermann',
	'Allow HTML' => 'HTML zulassen',
	'If enabled, users will be able to enter a limited set of HTML in their comments. If not, all HTML will be stripped out.' => 'Wenn die Option aktiv ist, darf HTML in Kommentaren verwendet werden. Andernfalls wird HTML aus Kommentaren automatisch herausgefiltert.',
	'Limit HTML Tags' => 'HTML einschränken ',
	'Specifies the list of HTML tags allowed by default when cleaning an HTML string (a comment, for example).' => 'Liste der HTML-Tags, die aus HTML-Kommentaren nicht ausgefiltert werden sollen.',
	'Use defaults' => 'Standardwerte verwenden',
	'([_1])' => '([_1])',
	'Use my settings' => 'Eigene Einstellungen',
	'Disable \'nofollow\' for trusted commenters' => '\'nofollow\' für Kommentare von vertrauten Kommentarautoren nicht verwenden',
	'If enabled, the \'nofollow\' link relation will not be applied to any comments left by trusted commenters.' => 'Falls aktiviert, wird für Links in Kommentaren von vertrauten Kommentarautoren das \'nofollow\'-Attribut nicht gesetzt.',
	'Specify when Movable Type should notify you of new comments if at all.' => 'Legt fest, ob und wann Movable Type Email-Benachrichtigungen über neue Kommentare versendet.',
	'Comment Order' => 'Kommentar-Reihenfolge',
	'Select whether you want visitor comments displayed in ascending (oldest at top) or descending (newest at top) order.' => 'Wählen Sie aus, ob Kommentare von Besuchern in aufsteigender (ältester zuerst) oder absteigender (neuester zuerst) Reihenfolge angezeigt werden sollen.',
	'Ascending' => 'Aufsteigend',
	'Descending' => 'Absteigend',
	'Auto-Link URLs' => 'URLs automatisch verlinken',
	'If enabled, all non-linked URLs will be transformed into links to that URL.' => 'Wenn die Option aktiv ist, werden alle URLs automatisch in HTML-Links umgewandelt.',
	'Specifies the Text Formatting option to use for formatting visitor comments.' => 'Legt fest, welche Textformatierungsoption standardmäßig für Kommentare verwendet werden soll.',
	'CAPTCHA Provider' => 'CAPTCHA-Quelle',
	'Don\'t use CAPTCHA' => 'Keine CAPTCHAs verwenden',
	'No CAPTCHA provider available' => 'Keine CAPTCHA-Quelle verfügbar',
	'No CAPTCHA provider is available in this system.  Please check to see if Image::Magick is installed, and CaptchaImageSourceBase directive points to captcha-source directory under mt-static/images.' => 'Keine CAPTCHA-Quelle verfügbar. Bitte überprüfen Sie, ob Image::Magick installiert ist und die CaptchaImageSourceBase-Direktive auf das Captcha-Quellverzeichnis im Ordner mt-static/images verweist.',
	'Use Comment Confirmation Page' => 'Kommentarbestätigungs-Seite verwenden',
	'Use comment confirmation page' => 'Kommentarbestätigungsseite',

## tmpl/cms/edit_blog.tmpl
	'Your blog configuration has been saved.' => 'Ihre Blog-Konfiguration wurde gespeichert.',
	'You must set your Site URL.' => 'Sie müssen Ihre Webadresse (URL) festlegen.',
	'Your Site URL is not valid.' => 'Die gewählte Webadresse (URL) ist ungültig.',
	'You can not have spaces in your Site URL.' => 'Die Adresse (URL) darf keine Leerzeichen enthalten.',
	'You can not have spaces in your Local Site Path.' => 'Der lokale Pfad darf keine Leerzeichen enthalten.',
	'Your Local Site Path is not valid.' => 'Das gewählte lokale Verzeichnis ist ungültig.',
	'Enter the URL of your public website. Do not include a filename (i.e. exclude index.html). Example: http://www.example.com/weblog/' => 'Geben Sie die Webadresse Ihrer Site ein. Geben Sie die Adresse ohne Dateinamen ein beispielsweise so: http://www.beispiel.de/weblog/',
	'Enter the path where your main index file will be located. An absolute path (starting with \'/\') is preferred, but you can also use a path relative to the Movable Type directory. Example: /home/melody/public_html/weblog' => 'Der Pfad, in dem Startseite Ihres Blog abgelegt werden soll. Eine absolute (mit \'/\' beginnende) Pfadangabe wird bevorzugt, Sie können den Pfad aber auch relativ Sie zu Ihrem Movable Type-Verzeichnis angeben. Beispiel: /home/melanie/public_html/blog',

## tmpl/cms/upgrade_runner.tmpl
	'Initializing database...' => 'Initialisiere Datenbank...',
	'Upgrading database...' => 'Upgrade der Datenbank...',
	'Installation complete.' => 'Installation abgeschlossen.',
	'Upgrade complete.' => 'Upgrade abgeschlossen.',
	'Starting installation...' => 'Starte Installation...',
	'Starting upgrade...' => 'Starte Upgrade...',
	'Error during installation:' => 'Fehler während Installation:',
	'Error during upgrade:' => 'Fehler während Upgrade:',
	'Installation complete!' => 'Installation abgeschlossen!',
	'Upgrade complete!' => 'Upgrade abgeschlossen!',
	'Login to Movable Type' => 'Bei Movable Type anmelden',
	'Your database is already current.' => 'Ihre Datenbank ist bereits auf dem aktuellen Stand.',

## tmpl/cms/edit_commenter.tmpl
	'The commenter has been trusted.' => 'Sie vertrauen diesem Kommentator.',
	'The commenter has been banned.' => 'Dieser Kommentator wurde gesperrt.',
	'Comments from [_1]' => 'Kommentaren von [_1]',
	'Trust' => 'Vertrauen',
	'commenters' => 'Kommentarautoren',
	'Trust commenter' => 'Kommentator vertrauen',
	'Untrust' => 'Nicht vertrauen',
	'Untrust commenter' => 'Kommentator nicht vertrauen',
	'Ban' => 'Sperren',
	'Ban commenter' => 'Kommentator sperren',
	'Unban' => 'Entsperren',
	'Unban commenter' => 'Sperre aufheben',
	'Trust selected commenters' => 'Ausgewählten Kommentarautoren vertrauen',
	'Ban selected commenters' => 'Ausgewählte Kommentarautoren sperren',
	'The Name of the commenter' => 'Name des Kommentarautors',
	'View all comments with this name' => 'Alle Kommentare mit diesem Namen anzeigen',
	'The Identity of the commenter' => 'Identität des Kommentarautors',
	'The Email of the commenter' => 'E-Mail-Adresse des Kommentarautors',
	'Withheld' => 'Zurückgehalten',
	'The URL of the commenter' => 'URL des Kommentarautors',
	'View all comments with this URL address' => 'Alle Kommentare mit dieser URL anzeigen',
	'The trusted status of the commenter' => 'Vertrauensstatus des Kommentarautors',
	'View all commenters with this status' => 'Alle Kommentarautoren mit diesem Status ansehen',

## tmpl/cms/cfg_entry.tmpl
	'Entry Settings' => 'Eintrags-Einstellungen',
	'Display Settings' => 'Anzeige-Einstellungen',
	'Entries to Display' => 'Anzuzeigende Einträge',
	'Select the number of days\' entries or the exact number of entries you would like displayed on your blog.' => 'Geben Sie entweder die maximale Anzahl von Einträgen oder die maximale Anzahl von Tagen an, die auf der StartseiteIhres Weblogs angezeigt werden sollen.',
	'Days' => 'Tage',
	'Entry Order' => 'Eintragsreihenfolge',
	'Select whether you want your entries displayed in ascending (oldest at top) or descending (newest at top) order.' => 'Geben Sie an, ob Einträge in chronologischer (älteste zuerst) oder umgekehrt chronologischer Reihenfolge (neueste zuerst) angezeigt werden sollen.',
	'Excerpt Length' => 'Auszugslänge',
	'Enter the number of words that should appear in an auto-generated excerpt.' => 'Anzahl der Wörter im automatisch generierten Textauszug.',
	'Date Language' => 'Datumsanzeige',
	'Select the language in which you would like dates on your blog displayed.' => 'Sprache für Datumsanzeigen',
	'Czech' => 'Tschechisch',
	'Danish' => 'Dänisch',
	'Dutch' => 'Holländisch',
	'English' => 'Englisch',
	'Estonian' => 'Estnisch',
	'French' => 'Französisch',
	'German' => 'Deutsch',
	'Icelandic' => 'Isländisch',
	'Italian' => 'Italienisch',
	'Japanese' => 'Japanisch',
	'Norwegian' => 'Norwegisch',
	'Polish' => 'Polnisch',
	'Portuguese' => 'Portugiesisch',
	'Slovak' => 'Slowakisch',
	'Slovenian' => 'Slovenisch',
	'Spanish' => 'Spanisch',
	'Suomi' => 'Finnisch',
	'Swedish' => 'Schwedisch',
	'Basename Length' => 'Basename-Länge',
	'Specifies the default length of an auto-generated basename. The range for this setting is 15 to 250.' => 'Setzt den Wert für den automatisch generierten Basename des Eintrags. Mögliche Länge: 15 bis 250.',
	'New Entry Defaults' => 'Standardwerte',
	'Specifies the default Entry Status when creating a new entry.' => 'Gibt an, welcher Eintragsstatus neue Einträge standardmäßig zugewiesen werden soll.',
	'Specifies the default Text Formatting option when creating a new entry.' => 'Gibt an, welche Textformatierungsoption standardmäßig beim Erstellen eines neuen Eintrags verwendet werden soll',
	'Specifies the default Accept Comments setting when creating a new entry.' => 'Legt fest, ob bei neuen Einträgen Kommentare standardmässig zugelassen werden.',
	'Note: This option is currently ignored since comments are disabled either blog or system-wide.' => 'Hinweis: Diese Einstellung zeigt momentan keine Wirkung, da Kommentare blog- oder systemweit deaktiviert sind.',
	'Specifies the default Accept TrackBacks setting when creating a new entry.' => 'Legt fest, ob bei neuen Einträgen TrackBack standardmässig zugelassen werden.',
	'Note: This option is currently ignored since TrackBacks are disabled either blog or system-wide.' => 'Hinweis: Diese Einstellungen zeigen momentan keine Wirkung, da TrackBacks blog- oder systemweit deaktiviert sind.',
	'Default Editor Fields' => 'Standard-Editorfelder',

## tmpl/cms/search_replace.tmpl
	'You must select one or more item to replace.' => 'Wählen Sie mindestens ein Element aus.',
	'Search Again' => 'Erneut suchen',
	'Submit search (s)' => 'Suchen (s)', # Translate - New # OK
	'Replace' => 'Ersetzen',
	'Replace Checked' => 'Markierung ersetzen',
	'Case Sensitive' => 'Groß/Kleinschreibung',
	'Regex Match' => 'Regex-Match',
	'Limited Fields' => 'Felder eingrenzen',
	'Date Range' => 'Zeitspanne',
	'Reported as Spam?' => 'Als Spam melden?',
	'Search Fields:' => 'Felder durchsuchen:',
	'E-mail Address' => 'Email-Addresse',
	'Source URL' => 'Quell-URL',
	'Page Body' => 'Seitenkörper',
	'Extended Page' => 'Erweiterte Seite',
	'Text' => 'Text',
	'Output Filename' => 'Ausgabe-Dateiname',
	'Linked Filename' => 'Verlinkter Dateiname',
	'To' => 'An',
	'Successfully replaced [quant,_1,record,records].' => '[quant,_1,Element,Elemente] erfolgreich ersetzt.', # Translate - New # OK
	'Showing first [_1] results.' => 'Zeige die ersten [_1] Treffer.',
	'Show all matches' => 'Zeige alle Treffer',
	'[quant,_1,result,results] found' => '[quant,_1,Ergebnis,Ergebnisse] gefunden',
	'No entries were found that match the given criteria.' => 'Keine den Kritierien entsprechenden Einträge gefunden.',
	'No comments were found that match the given criteria.' => 'Keine den Kritierien entsprechenden Kommentare gefunden.',
	'No TrackBacks were found that match the given criteria.' => 'Keine den Kritierien entsprechenden TrackBacks gefunden.',
	'No commenters were found that match the given criteria.' => 'Keine den Kritierien entsprechenden Kommentarautoren gefunden.',
	'No pages were found that match the given criteria.' => 'Keine den Kritierien entsprechenden Seiten gefunden.',
	'No templates were found that match the given criteria.' => 'Keine den Kritierien entsprechenden Vorlagen gefunden.',
	'No log messages were found that match the given criteria.' => 'Keine den Kritierien entsprechenden Logeinträge gefunden.',
	'No users were found that match the given criteria.' => 'Keine den Kritierien entsprechenden Benutzer gefunden.',
	'No weblogs were found that match the given criteria.' => 'Keine den Kritierien entsprechenden Weblogs gefunden.',

## tmpl/cms/widget/new_user.tmpl
	'Welcome to Movable Type' => 'Willkommen zu Movable Type',
	'Welcome to Movable Type, the world\'s most powerful blogging, publishing and social media platform. To help you get started we have provided you with links to some of the more common tasks new users like to perform:' => 'Willkommen zu Movable Type, der leistungsfähigsten Blogging-, Publizierungs- und Social Media-Plattfom. Um Ihnen den Einstieg zu erleichtern, haben wir Ihnen einige Links zu den Funktionen, die für neue Benutzer besonders interessant sind, zusammengestellt:',
	'Write your first post' => 'Den ersten Eintrag schreiben',
	'What would a blog be without content? Start your Movable Type experience by creating your very first post.' => 'Was ist ei Blog ohne Inhalt? Schreiben Sie jetzt Ihren ersten Eintrag mit Movable Type!',
	'Design your blog' => 'Das Blog gestalten',
	'Customize the look and feel of your blog quickly by selecting a design from one of our professionally designed themes.' => 'Gestalten Sie Ihr Blog nach Ihren Vorstellungen. Mit unseren professionellen Designvorlagen geht das ganz schnell!',
	'Explore what\'s new in Movable Type 4' => 'Neu in Movable Type 4',
	'Whether you\'re new to Movable Type or using it for the first time, learn more about what this tool can do for you.' => 'Für Neueinsteiger wie für erfahrende Movable Type-Anwender: erfahren Sie, was Movable Type für Sie leisten kann!',

## tmpl/cms/widget/blog_stats.tmpl
	'Error retrieving recent entries.' => 'Fehler beim Einlesen der aktuellen Einträge.',
	'Loading recent entries...' => 'Lade aktuelle Einträge...',
	'Jan.' => 'Jan.',
	'Feb.' => 'Feb.',
	'March' => 'März',
	'April' => 'April',
	'May' => 'Mai',
	'June' => 'Juni',
	'July.' => 'Juli',
	'Aug.' => 'Aug.',
	'Sept.' => 'Sep.',
	'Oct.' => 'Okt.',
	'Nov.' => 'Nov.',
	'Dec.' => 'Dez.',
	'Movable Type was unable to locate your \'mt-static\' directory. Please configure the \'StaticFilePath\' configuration setting in your mt-config.cgi file, and create a writable \'support\' directory underneath your \'mt-static\' directory.' => 'Movable Type konnte Ihr \'mt-static\'-Verzeichnis nicht finden. Bitte überprüfen Sie die \'StaticFilePath\'-Direktive in der Konfigurationsdatei mt-config.cgi und legen Sie ein vom Webserver beschreibbares Verzeichnis \'support\' im \'mt-static\'-Verzeichnis an.',
	'Movable Type was unable to write to its \'support\' directory. Please create a directory at this location: [_1], and assign permissions that will allow the web server write access to it.' => 'Movable Type kann auf den Ordner \'support\' nicht schreibend zugreifen. Legen Sie hier: [_1] ein solches Verzeichnis an und stellen Sie sicher, daß der Webserver Schreibrechte für diesen Ordner besitzt.',
	'Most Recent Comments' => 'Aktuelle Kommentare',
	'[_1][_2], [_3] on [_4]' => '[_1][_2], [_3] zu [_4]',
	'View all comments' => 'Alle Kommentare',
	'No comments available.' => 'Keine Kommentare vorhanden.',
	'Most Recent Entries' => 'Aktuelle Einträge',
	'...' => '...',
	'View all entries' => 'Alle Einträge',
	'[_1] [_2] - [_3] [_4]' => '[_1] [_2] - [_3] [_4]',
	'You have <a href=\'[_3]\'>[quant,_1,comment,comments] from [_2]</a>' => 'Sie haben <a href=\'[_3]\'>[quant,_1,Kommentar,Kommentare] von [_2]</a>',
	'You have <a href=\'[_3]\'>[quant,_1,entry,entries] from [_2]</a>' => 'Sie haben <a href=\'[_3]\'>[quant,_1,Eintrag,Einträge] von [_2]</a>',

## tmpl/cms/widget/new_install.tmpl
	'Thank you for installing Movable Type' => 'Vielen Dank, daß Sie sich für Movable Type entschieden haben.',
	'Congratulations on installing Movable Type, the world\'s most powerful blogging, publishing and social media platform. To help you get started we have provided you with links to some of the more common tasks new users like to perform:' => 'Herzlichen Glückwunsch zur Installation von Movable Type, der leistungsfähigsten Blogging-, Publizierungs- und Social Media-Plattfom. Um Ihnen den Einstieg zu erleichtern, haben wir Ihnen einige Links zu den Funktionen, die für neue Benutzer besonders interessant sind, zusammengestellt:',
	'Add more users to your blog' => 'Weitere Benutzer einladen',
	'Start building your network of blogs and your community now. Invite users to join your blog and promote them to authors.' => 'Bauen Sie ein Netzwerk auf und laden Sie weitere Personen ein, Mitautoren Ihres Blogs zu werden!',

## tmpl/cms/widget/mt_news.tmpl
	'News' => 'Neuigkeiten',
	'MT News' => 'Neues von MT',
	'Learning MT' => 'MT lernen',
	'Hacking MT' => 'MT hacken',
	'Pronet' => 'Pronet',
	'No Movable Type news available.' => 'Es liegen keine Movable Type-Nachrichten vor.',
	'No Learning Movable Type news available.' => 'Es liegen keine Movable Type lernen-Nachrichten vor',

## tmpl/cms/widget/custom_message.tmpl
	'This is you' => 'Das sind Sie',
	'Welcome to [_1].' => 'Willkommen bei [_1].',
	'You can manage your blog by selecting an option from the menu located to the left of this message.' => 'Sie können Ihr Blog von dem Menü, das Sie links von dieser Nachricht finden, aus verwalten.',
	'If you need assistance, try:' => 'Falls Sie Hilfe benötigen, stehen folgende Möglichkeiten zur Verfügung:',
	'Movable Type User Manual' => 'Movable Type Benutzerhandbuch',
	'http://www.sixapart.com/movabletype/support' => 'http://www.sixapart.com/movabletype/support',
	'Movable Type Technical Support' => 'Movable Type Technischer Support',
	'Movable Type Community Forums' => 'Movable Type Community-Foren',
	'Change this message.' => 'Diese Nachricht ändern.',
	'Edit this message.' => 'Diese Nachricht ändern.',

## tmpl/cms/widget/mt_shortcuts.tmpl
	'Trackbacks' => 'TrackBacks',
	'Import Content' => 'Inhalt importieren',
	'Blog Preferences' => 'Blog-Einstellungen',

## tmpl/cms/widget/this_is_you.tmpl
	'Your <a href="[_1]">last post</a> was [_2].' => 'Ihr <a href="[_1]">letzter Eintrag</a> ist [_2].',
	'You have <a href="[_1]">[quant,_2,draft,drafts]</a>.' => 'Sie haben <a href="[_1]>[quant,_2,Entwurf,Entwürfe]</a>.',
	'You\'ve written <a href="[_1]">[quant,_2,post,posts]</a> with <a href="[_3]">[quant,_4,comment,comments]</a>.' => 'Sie haben <a href="[_1]">[quant,_2,Eintrag,Einträge]</a> mit <a href="[_3]">[quant,_4,Kommentar,Kommentaren]</a> geschrieben. ',
	'You\'ve written <a href="[_1]">[quant,_2,post,posts]</a>.' => 'Sie haben <a href="[_1]">[quant,_2,Eintrag,Einträge]</a> geschrieben.',
	'Edit your profile' => 'Profil bearbeiten',

## tmpl/cms/export.tmpl
	'You must select a blog to export.' => 'Sie müssen ein Blog wählen, das exportiert werden soll.',
	'_USAGE_EXPORT_1' => 'Hier können Sie die Einträge, Kommentare und TrackBacks des ausgewählten Blogs exportieren. Ein Export stellt <em>keine</em> komplette Sicherungskopie des Weblogs dar.',
	'Export from' => 'Exportieren aus',
	'Select a blog for exporting.' => 'Zu exportierendes Blog wählen',
	'Export Blog' => 'Blog exportieren',
	'Export Blog (e)' => 'Blog exportieren (e)',

## tmpl/cms/list_commenter.tmpl
	'_USAGE_COMMENTERS_LIST' => 'Eine Liste der authentifizierten Kommentarautoren von [_1]. Unten können weitere Informationen zu den Autoren aufrufen oder ihren Status ändern.',
	'The selected commenter(s) has been given trusted status.' => 'Diese Kommentarautoren haben den Status vertrauenswürdig.',
	'Trusted status has been removed from the selected commenter(s).' => 'Der Vertraut-Status wurde für die ausgewählten Kommentarautoren aufgehoben.',
	'The selected commenter(s) have been blocked from commenting.' => 'Die ausgewählten Kommentarautoren wurden für Kommentare gesperrt.',
	'The selected commenter(s) have been unbanned.' => 'Die Kommentarsperre wurde für die ausgewählten Kommentarautoren aufgehoben.',
	'(Showing all commenters.)' => '(Zeige alle Kommentarautoren)',
	'Showing only commenters whose [_1] is [_2].' => 'Zeige nur Kommentarautoren bei denen [_1] [_2] ist',
	'Commenter Feed' => 'Kommentarautoren-Feed',
	'commenters.' => 'Kommentarautoren',
	'commenters where' => 'Kommentare deren',
	'trusted' => 'vertraut',
	'untrusted' => 'nicht vertraut',
	'banned' => 'gesperrt',
	'unauthenticated' => 'nicht authentifiziert',
	'authenticated' => 'authentifiziert',

## tmpl/cms/list_folder.tmpl
	'[quant,_1,page,pages]' => '[quant,_1,Seite,Seiten]',

## tmpl/cms/list_template.tmpl
	'Blog Templates' => 'Blog-Vorlagen',
	'Blog Publishing Settings' => 'Veröffentlichtungs-Einstellungen',
	'template' => 'Vorlage',
	'templates' => 'Vorlagen',
	'Delete selected templates (x)' => 'Gewählte Vorlagen löschen (x)', # Translate - New # OK
	'You have successfully deleted the checked template(s).' => 'Vorlage(n) erfolgreich gelöscht.',
	'Create new Entry template' => 'Neue Eintrags-Vorlage anlegen',
	'Create new Page template' => 'Neue Seiten-Vorlage anlegen',
	'Create new Entry Listing template' => 'Neue Eintragsverzeichnis-Vorlage anlegen',
	'Create new Category template' => 'Neue Kategorie-Vorlage anlegen',
	'Create new [_1] template' => 'Neue [_1]-Vorlage anlegen',
	'Create Template...' => 'Lege Vorlage an...',
	'Blank Template' => 'Leere Vorlage',

## tmpl/wizard/cfg_dir.tmpl
	'Temporary Directory Configuration' => 'Konfiguration des temporären Verzeichnisses',
	'You should configure you temporary directory settings.' => 'Hier legen Sie fest, in welchem Verzeichnis temporäre Dateien gespeichert werden.',
	'Your TempDir has been successfully configured. Click \'Continue\' below to continue configuration.' => 'TempDir erfolgreich konfiguriert. Sie können die Konfiguration nun fortsetzen.',
	'[_1] could not be found.' => '[_1] nicht gefunden',
	'TempDir is required.' => 'TempDir ist erforderlich',
	'TempDir' => 'TempDir',
	'The physical path for temporary directory.' => 'Pfad Ihres temporären Verzeichnisses',

## tmpl/wizard/blog.tmpl
	'Setup Your First Blog' => 'Richten Sie Ihr erstes Blog ein',

## tmpl/wizard/start.tmpl
	'Your Movable Type configuration file already exists. The Wizard cannot continue with this file present.' => 'Es ist bereits eine Konfigurationsdatei vorhanden. Wenn Sie den Konfigurationshelfer erneut ausführen möchten, entfernen Sie die Datei zuerst aus Ihrem Movable Type-Verzeichnis.',
	'Movable Type requires that you enable JavaScript in your browser. Please enable it and refresh this page to proceed.' => 'Movable Type erfordert JavaScript. Bitte aktivieren Sie es in Ihren Browsereinstellungen und laden diese Seite dann neu.',
	'This wizard will help you configure the basic settings needed to run Movable Type.' => 'Dieser Konfigurationshelfer hilft Ihnen, die zur Installation von Movable Type Enterprise erforderlichen Einstellungen vorzunehmen.',
	'Error: \'[_1]\' could not be found.  Please move your static files to the directory first or correct the setting if it is incorrect.' => 'Fehler: \'[_1]\' nicht gefunden. Bitte kopieren Sie erst die statischen Dateien in den Ordner oder überprüfen Sie Einstellungen, falls das bereits geschehen ist.',
	'Configure Static Web Path' => 'Statischen Web-Pfad konfigurieren',
	'Movable Type ships with directory named [_1] which contains a number of important files such as images, javascript files and stylesheets. (The elements that make this page look so pretty!)' => 'Movable Type wird mit einem Ordner namens [_1] ausgeliefert, der einige wichtige Bild-, Javascript- und Stylesheet-Dateien enthält.',
	'The [_1] directory is in the main Movable Type directory which this wizard script is also in, but due to the curent server\'s configuration the [_1] directory is not accessible in its current location and must be moved to a web-accessible location (e.g. into your web document root directory, where your published website exists).' => 'Der [_1]-Ordner befindet sich im Hauptverzeichnis von Movable Type und enthält auch den Konfigurationshelfer. Momentan ist der Ordner vom Webserver jedoch nicht erreichbar. Verschieben Sie ihn daher an einen Ort, auf den der Webserver zugreifen kann (z.B. Document Root).',
	'This directory has either been renamed or moved to a location outside of the Movable Type directory.' => 'Das Verzeichnis wurde entweder umbenannt oder an einen Ort außerhalb des Movable Type-Verzeichnisses verschoben.',
	'Once the [_1] directory is in a web-accessible location, specify the location below.' => 'Wenn Sie den [_1]-Ordner an einen vom Webserver erreichbaren Ort verschoben haben, geben Sie die Adresse unten an.',
	'This URL path can be in the form of [_1] or simply [_2]' => 'Die Adresse kann in dieser Form: [_1] oder einfach als [_2] angegeben werden. ',
	'Static web path' => 'Statischer Pfad',
	'Begin' => 'Anfangen',

## tmpl/wizard/configure.tmpl
	'Database Configuration' => 'Datenbankkonfiguration',
	'You must set your Database Path.' => 'Pfad zur Datenbank erforderlich',
	'You must set your Database Name.' => 'Geben Sie Ihren Datenbanknamen an.',
	'You must set your Username.' => 'Geben Sie Ihren Benutzernamen an.',
	'You must set your Database Server.' => 'Geben Sie Ihren Datenbankserver an.',
	'Your database configuration is complete.' => 'Ihre Datenbank-Konfiguration ist abgeschlossen.',
	'You may proceed to the next step.' => 'Sie können mit dem nächsten Schritt fortfahren.',
	'Please enter the parameters necessary for connecting to your database.' => 'Bitte geben Sie die Paramter für Ihre Datenbankverbindung ein.',
	'Show Current Settings' => 'Derzeitige Einstellugen anzeigen',
	'Database Type' => 'Datenbanktyp',
	'Select One...' => 'Auswählen...',
	'If your database type is not listed in the menu above, then you need to <a target="help" href="[_1]">install the Perl module necessary to connect to your database</a>.  If this is the case, please check your installation and <a href="javascript:void(0)" onclick="[_2]">re-test your installation</a>.' => 'Erscheint Ihr Datenbanktyp nicht in obigem Menü, <a target="help" href="[_1]">installieren Sie bitte die für Ihren Datenbanktyp notwendigen Perl-Module</a>. Sollte das bereits geschehen sein, überprüfen Sie die Installation und <a href="#" onclick="[_2]">führen den Systemtest erneut aus</a>.',
	'Database Path' => 'Datenbankpfad',
	'The physical file path for your SQLite database. ' => 'Physischer Pfad zur SQLite-Datenbank',
	'A default location of \'./db/mt.db\' will store the database file underneath your Movable Type directory.' => 'Mit der  Voreinstellung \'./db/mt.db\' wird die Datenbankdatei unterhalb Ihres Movable Type-Verzeichnisses angelegt.',
	'Database Server' => 'Hostname',
	'This is usually \'localhost\'.' => 'Meistens \'localhost\'',
	'Database Name' => 'Datenbankname',
	'The name of your SQL database (this database must already exist).' => 'Name Ihrer SQL-Datenbank (die Datenbank muss bereits vorhanden sein)',
	'The username to login to your SQL database.' => 'Benutzername für Ihre SQL-Datenbank',
	'The password to login to your SQL database.' => 'Passwort für Ihre SQL-Datenbank',
	'Show Advanced Configuration Options' => 'Erweiterte Optionen anzeigen',
	'Database Port' => 'Port',
	'This can usually be left blank.' => 'Braucht normalerweise nicht angegeben zu werden',
	'Database Socket' => 'Socket',
	'Publish Charset' => 'Zeichenkodierung',
	'MS SQL Server driver must use either Shift_JIS or ISO-8859-1.  MS SQL Server driver does not support UTF-8 or any other character set.' => 'Der Microsoft SQL Server-Treiber unterstützt ausschließlich die Zeichenkodierungen Shift_JIS und ISO-8859-1.  UTF-8 oder andere Kodierungen können nicht verwendet werden.',
	'Test Connection' => 'Verbindung testen',

## tmpl/wizard/optional.tmpl
	'Mail Configuration' => 'Mailkonfiguration',
	'Your mail configuration is complete.' => 'Ihre Mail-Konfiguration ist abgeschlossen.',
	'Check your email to confirm receipt of a test email from Movable Type and then proceed to the next step.' => 'Überprüfen Sie den Eingang der Testmail in Ihrem Postfach und fahren dann mit dem nächsten Schritt fort.',
	'Show current mail settings' => 'Derzeitige Mail-Einstellungen anzeigen',
	'Periodically Movable Type will send email to inform users of new comments as well as other other events. For these emails to be sent properly, you must instruct Movable Type how to send email.' => 'Movable Type verschickt beispielsweise zur Benachrichtigung bei neuen Kommentaren E-Mails. Geben Sie daher bitte hier an, wie diese Mails verschickt werden sollen.',
	'An error occurred while attempting to send mail: ' => 'Mailversand fehlgeschlagen: ',
	'Send email via:' => 'E-Mails schicken mit:',
	'sendmail Path' => 'sendmail-Pfad',
	'The physical file path for your sendmail binary.' => 'Pfad zu sendmail',
	'Outbound Mail Server (SMTP)' => 'SMTP-Server',
	'Address of your SMTP Server.' => 'Adresse Ihres SMTP-Servers',
	'Mail address for test sending' => 'Empfängeradresse für Testmail',
	'Send Test Email' => 'Test-Email verschicken',

## tmpl/wizard/complete.tmpl
	'Config File Created' => 'Konfigurationsdatei angelegt',
	'You selected to create the mt-config.cgi file manually, however it could not be found. Please cut and paste the following text into a file called \'mt-config.cgi\' into the root directory of Movable Type (the same directory in which mt.cgi is found).' => 'Sie wollten die Konfigurationsdatei mt-config.cgi manuell anlegen. Sie kann jedoch nicht gefunden werden. Kopieren Sie daher folgenden Text in eine Datei namens \'mt-config.cgi\' und legen diese dann im Movable Type-Hauptverzeichnis ab (das Verzeichnis, in dem Sie auch die Datei mt.cgi finden).',
	'If you would like to check the directory permissions and retry, click the \'Retry\' button.' => 'Bitte überprüfen Sie, ob Schreibrechte für das Verzeichnis vorliegen und klicken dann auf "Erneut versuchen"',
	'We were unable to create your Movable Type configuration file. This is most likely the result of a permissions problem. To resolve this problem you will need to make sure that your Movable Type home directory (the directory that contains mt.cgi) is writable by your web server.' => 'Die Movable Type-Konfigurationsdatei kann nicht angelegt werden. Das liegt fast immer an mangelnden Zugriffsrechten. Stellen Sie daher sicher, daß der Webserver Schreibrechte für das Movable Type-Hauptverzeichnis hat (das Verzeichnis, in dem Sie auch die Datei mt.cgi finden).',
	'Congratulations! You\'ve successfully configured [_1].' => 'Herzlichen Glückwunsch! Sie haben [_1] erfolgreich konfiguriert.',
	'Your configuration settings have been written to the file <tt>[_1]</tt>. To reconfigure them, click the \'Back\' button below.' => 'Ihre Einstellungen wurden in der Datei <tt>[_1]</tt> gespeichert. Um die Einstellungen erneut zu ändern, klicken Sie bitte auf \'Zurück\'.',
	'I will create the mt-config.cgi file manually.' => 'Ich werde mt-config.cgi manuell anlegen.',
	'Retry' => 'Erneut versuchen',

## tmpl/wizard/packages.tmpl
	'Requirements Check' => 'Überprüfung der Systemvoraussetzungen',
	'The following Perl modules are required in order to make a database connection.  Movable Type requires a database in order to store your blog\'s data.  Please install one of the packages listed here in order to proceed.  When you are ready, click the \'Retry\' button.' => 'Die folgenden Perl-Module sind zur Herstellung einer Datenbankverbindung notwendig. Movable Type speichert Ihre Blogdaten in einer Datenbank. Bitte installieren Sie die hier genannten Pakete und klicken danach auf \'Erneut versuchen\'.',
	'All required Perl modules were found.' => 'Alle notwendigen Perl-Module sind vorhanden.',
	'You are ready to proceed with the installation of Movable Type.' => 'Sie können die Installation von Movable Type fortsetzen.',
	'Note: One or more optional Perl modules could not be found. You may install them now and click \'Retry\' or continue without them. They can be installed at any time if needed.' => 'Hinweis: Mindestens ein optional erforderliches Perl-Modul wurde nicht gefunden. Sie können die Module entweder jetzt installieren und dann auf \'Erneut versuchen\' klicken oder die Installation ohne die optionalen Module fortsetzen. Sie können diese Module auch jederzeit nachträglich installieren.',
	'<a href="javascript:void(0)" onclick="[_1]">Display list of optional modules</a>' => '<a href="javascript:void(0)" onclick="[_1]">Optionale Module anzeigen</a>',
	'One or more Perl modules required by Movable Type could not be found.' => 'Mindestens ein von Movable Type erforderliche Perl-Modul wurde nicht gefunden.',
	'The following Perl modules are required for Movable Type to run properly. Once you have met these requirements, click the \'Retry\' button to re-test for these packages.' => 'Die folgenden Pakete sind nicht vorhanden, zur Ausführung von Movable Type aber zwingend erforderlich. Bitte installieren Sie sie und klicken dann auf \'Erneut versuchen\'.',
	'Missing Database Modules' => 'Fehlende Datenbank-Module',
	'Missing Optional Modules' => 'Fehlende optionale Module',
	'Missing Required Modules' => 'Fehlende erforderliche Module',
	'Minimal version requirement: [_1]' => 'Mindestens erforderliche Version: [_1]',
	'Learn more about installing Perl modules.' => 'Mehr über die Installation von Perl-Modulen erfahren',
	'Your server has all of the required modules installed; you do not need to perform any additional module installations.' => 'Alle erforderlichen Pakete vorhanden. Sie brauchen keine weiteren Pakete zu installieren.',

## tmpl/error.tmpl
	'Missing Configuration File' => 'Fehlende Konfigurationsdatei',
	'_ERROR_CONFIG_FILE' => 'Ihre Movable Type-Konfigurationsdatei fehlt, ist fehlerhaft oder kann nicht gelesen werden. Anweisungen zur Konfiguration finden Sie im Abschnitt <a href="javascript:void(0)">Installation and Configuration</a> der Movable Type-Dokumentation.',
	'Database Connection Error' => 'Verbindung mit Datenbank fehlgeschlagen',
	'_ERROR_DATABASE_CONNECTION' => 'Die Datenbankeinstellungen in Ihrer Konfigurationsdatei fehlen oder sind fehlerhaft. Anweisungen zur Konfiguration finden Sie im Abschnitt <a href="javascript:void(0)">Installation and Configuration</a> der Movable Type-Dokumentation.',
	'CGI Path Configuration Required' => 'CGI-Pfad muß eingestellt sein',
	'_ERROR_CGI_PATH' => 'Die CGIPath-Angabe in Ihrer Konfigurationsdatei fehlt oder ist fehlerhaft. Anweisungen zur Konfiguration finden Sie im Abschnitt <a href="javascript:void(0)">Installation and Configuration</a> der Movable Type-Dokumentation.',

## tmpl/email/footer-email.tmpl
	'Powered by Movable Type' => 'Powered by Movable Type',

## tmpl/email/commenter_confirm.tmpl
	'Thank you registering for an account to comment on [_1].' => 'Danke, daß Sie ein Benutzerkonto angelegt haben, um [_1] zu kommentieren.',
	'For your own security and to prevent fraud, we ask that you please confirm your account and email address before continuing. Once confirmed you will immediately be allowed to comment on [_1].' => 'Zu Ihrer eigenen Sicherheit und zur Vermeidung von Mißbrauch bitten wie Sie, daß Sie zuerst Ihre E-Mail-Adresse und Ihre Anmeldung bestätigen.',
	'To confirm your account, please click on or cut and paste the following URL into a web browser:' => 'Um Ihre Anmeldung zu bestätigen, klicken Sie bitte auf folgende Adresse (oder kopieren Sie sie und fügen Sie sie in Adresszeile Ihres Web-Browsers ein):',
	'If you did not make this request, or you don\'t want to register for an account to comment on [_1], then no further action is required.' => 'Sollten Sie sich nicht selbst angemeldet haben oder sollten Sie doch kein Konto anlegen wollen, um [_1] kommentieren zu können, brauchen Sie nichts zu tun.',
	'Thank you very much for your understanding.' => 'Vielen Dank für Ihr Verständnis.',
	'Sincerely,' => 'Ihr',

## tmpl/email/verify-subscribe.tmpl
	'Thanks for subscribing to notifications about updates to [_1]. Follow the link below to confirm your subscription:' => 'Vielen Dank, daß Sie die Aktualisierungsbenachrichtungen von [_1] abonnieren möchten. Bitte folgen Sie zur Bestätigung diesem Link:',
	'If the link is not clickable, just copy and paste it into your browser.' => 'Wenn der Link nicht anklickbar ist, kopieren Sie ihn einfach und fügen ihn in der Adresszeile Ihres Browers ein.',

## tmpl/email/recover-password.tmpl
	'_USAGE_FORGOT_PASSWORD_1' => 'Sie haben ein neues Movable Type-Passwort angefordert. Es wurde automatisch ein neues Passwort erzeugt. Es lautet:',
	'_USAGE_FORGOT_PASSWORD_2' => 'Mit diesem Passwort können Sie sich nun am System anmelden. Im Anschluss sollten Sie ein Passwort Ihrer Wahl einstellen.',

## tmpl/email/new-ping.tmpl
	'An unapproved TrackBack has been posted on your blog [_1], for entry #[_2] ([_3]). You need to approve this TrackBack before it will appear on your site.' => 'Ihr Weblog [_1] hat auf Eintrag #[_2] ("[_3]") ein noch nicht freigeschaltetes TrackBack erhalten. Sie müssen dieses TrackBack freischalten, damit es auf Ihrem Weblog erscheint.',
	'An unapproved TrackBack has been posted on your blog [_1], for category #[_2], ([_3]). You need to approve this TrackBack before it will appear on your site.' => 'Ihr Weblog [_1] hat auf Kategorie #[_2] ("[_3]") ein noch nicht freigeschaltetes TrackBack erhalten. Sie müssen dieses TrackBack freischalten, damit es auf Ihrem Weblog erscheint.',
	'Approve this TrackBack' => 'TrackBack freigeben',
	'A new TrackBack has been posted on your blog [_1], on entry #[_2] ([_3]).' => 'Ein neues TrackBack wurde bei Ihrem Weblog [_1] registriert, zu Eintrag #[_2] ([_3]).',
	'A new TrackBack has been posted on your blog [_1], on category #[_2] ([_3]).' => 'Ein neues TrackBack wurde bei Ihrem Weblog [_1] registriert, zu Kategorie #[_2] ([_3]).',
	'View this TrackBack' => 'TrackBack ansehen',
	'Report this TrackBack as spam' => 'TrackBack als Spam melden',

## tmpl/email/new-comment.tmpl
	'An unapproved comment has been posted on your blog [_1], for entry #[_2] ([_3]). You need to approve this comment before it will appear on your site.' => 'Ihr Weblog [_1] hat auf Eintrag #[_2] ("[_3]") einen noch nicht freigeschalteten Kommentar erhalten. Sie müssen diesen Kommentar freischalten, damit er auf Ihrem Weblog erscheint.',
	'Approve this comment:' => 'Kommentar freischalten:',
	'A new comment has been posted on your blog [_1], on entry #[_2] ([_3]).' => 'Auf Ihrem Blog [_1] wurde zu Eintag #[_2] ("[_3]") ein neuer Kommentar veröffentlicht.',
	'View this comment' => 'Kommentar ansehen',
	'Report this comment as spam' => 'Kommentar als Spam melden',

## tmpl/email/notify-entry.tmpl
	'A new post entitled \'[_1]\' has been published to [_2].' => 'In [_2] wurde ein neuer Eintrag namens \'[_1]\'.',
	'View post' => 'Eintrag ansehen',
	'Post Title' => 'Name des Eintrags',
	'Message from Sender' => 'Mitteilung des Absenders',
	'You are receiving this email either because you have elected to receive notifications about new content on [_1], or the author of the post thought you would be interested. If you no longer wish to receive these emails, please contact the following person:' => 'Sie erhalten diese E-Mail, da Sie entweder Nachrichten über Aktualisierungen von [_1] bestellt haben oder da der Autor dachte, daß dieser Eintrag für Sie von Interesse sein könnte. Wenn Sie solche Mitteilungen nicht länger erhalten wollen, wenden Sie sich bitte an ',

## tmpl/email/commenter_notify.tmpl
	'This email is to notify you that a new user has successfully registered on the blog \'[_1].\' Listed below you will find some useful information about this new user.' => 'Ein neuer Benutzer hat sich erfolgreich für \'[_1]\' registriert. Hier einige Details zum neuen Benutzer:',
	'Full Name' => 'Ganzer Name',
	'To view or edit this user, please click on or cut and paste the following URL into a web browser:' => 'Um alle Benutzerdaten zu sehen oder zu bearbeiten, klicken Sie bitte auf folgende Adresse (oder kopieren Sie sie und fügen Sie sie in Adresszeile Ihres Web-Browsers ein):',

## tmpl/feeds/feed_page.tmpl
	'Untitled' => 'Ohne Name',
	'Unpublish' => 'Nicht mehr veröffentlichen',
	'More like this' => 'Ähnliche Einträge',
	'From this blog' => 'Aus diesem Blog',
	'From this author' => 'Von diesem Autoren',
	'On this day' => 'An diesem Tag',

## tmpl/feeds/login.tmpl
	'Movable Type Activity Log' => 'Movable Type Aktivitätsprotokoll',
	'This link is invalid. Please resubscribe to your activity feed.' => 'Dieser Link ist ungültig. Bitte abonnieren Sie Ihren Aktivitäts-Feed erneut.',

## tmpl/feeds/error.tmpl

## tmpl/feeds/feed_entry.tmpl

## tmpl/feeds/feed_ping.tmpl
	'Source blog' => 'Quelle',
	'On this entry' => 'Zu diesem Eintrag',
	'By source blog' => 'Nach Quelle',
	'By source title' => 'Nach Name der Quelle',
	'By source URL' => 'By URL der Quelle',

## tmpl/feeds/feed_comment.tmpl
	'By commenter identity' => 'Nach Kommentarautoren-Identität',
	'By commenter name' => 'Nach Kommentarautoren-Name',
	'By commenter email' => 'Nach Kommentarautoren-Email',
	'By commenter URL' => 'Nach Kommentarautoren-URL',

## plugins/feeds-app-lite/tmpl/config.tmpl
	'Feeds.App Lite Widget Creator' => 'Feeds.App Lite Widget Creator',
	'Configure feed widget settings' => 'Feed-Widget konfigurieren', # Translate - New # OK
	'Enter a title for your widget.  This will also be displayed as the title of the feed when used on your published blog.' => 'Vergeben Sie einen Namen für das Widget. Dieser Name wird auch als Name des Feeds in Ihrem Blog angezeigt werden.',
	'[_1] Feed Widget' => '[_1]-Feed-Widget', # Translate - New # OK
	'Select the maximum number of entries to display.' => 'Anzahl der Einträge, die höchstens angezeigt werden sollen.',
	'3' => '3',
	'5' => '5',
	'10' => '10',

## plugins/feeds-app-lite/tmpl/select.tmpl
	'Multiple feeds were found' => 'Mehrere Feeds gefunden', # Translate - New # OK
	'Select the feed you wish to use. <em>Feeds.App Lite supports text-only RSS 1.0, 2.0 and Atom feeds.</em>' => 'Wählen SIe den zu verwendenden Feed. <em>Feeds.App Lite unterstützt RSS 1.0-, RSS 2.0- und ATOM-Feeds.</em>', # Translate - New # OK
	'URI' => 'URI',

## plugins/feeds-app-lite/tmpl/start.tmpl
	'You must enter a feed or site URL to proceed' => 'Geben Sie bitte eine Feed- oder Website-URL an.', # Translate - New # OK
	'Create a widget from a feed' => 'Feed als Widget anzeigen', # Translate - New # OK
	'Enter the URL of a feed, or the URL of a site that has a feed.' => 'Geben Sie die URL eines Feeds oder einer Website, die Feeds anbietet, ein:',

## plugins/feeds-app-lite/tmpl/msg.tmpl
	'No feeds could be discovered using [_1]' => 'Keine Feeds per [_1] entdeckt.', # Translate - New # OK
	'An error occurred processing [_1]. Check <a href="javascript:void(0)" onclick="closeDialog(\'http://www.feedvalidator.org/check.cgi?url=[_2]\')">here</a> for more detail and please try again.' => 'Fehler beim Einlesen von [_1]. Beachten Sie die  <a href="javascript:void(0)" onclick="closeDialog(\'http://www.feedvalidator.org/check.cgi?url=[_2]\')">Hinweise des Feed Validators</a> und versuchen Sie es ggf. erneut.',
	'A widget named <strong>[_1]</strong> has been created.' => 'Widget namens <strong>[_1]</strong> angelegt.', # Translate - New # OK
	'You may now <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">edit &ldquo;[_1]&rdquo;</a> or include the widget in your blog using <a href="javascript:void(0)" onclick="closeDialog(\'[_3]\')">WidgetManager</a> or the following MTInclude tag:' => 'Sie können &ldquo;[_1]&rdquo; jetzt <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">bearbeiten</a> oder in Ihr Blog <a href="javascript:void(0)" onclick="closeDialog(\'[_3]\')">einbinden</a>. Alternativ können Sie dazu auch diesen MTInclude-Befehl verwenden:', # Translate - New # OK
	'You may now <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">edit &ldquo;[_1]&rdquo;</a> or include the widget in your blog using the following MTInclude tag:' => 'Sie können &ldquo;[_1]&rdquo; jetzt <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">bearbeiten</a> oder mit diesem MTInclude-Befehl in Ihr Blog einbinden:', # Translate - New # OK
	'Create Another' => 'Weiteres Widget anlegen',

## plugins/feeds-app-lite/mt-feeds.pl
	'Feeds.App Lite helps you republish feeds on your blogs. Want to do more with feeds in Movable Type?' => 'Mit Feeds.App Lite können Sie Feeds in Ihre Blogs integrieren. Noch mehr Möglichkeiten erhalten Sie durch ein',
	'Upgrade to Feeds.App' => 'Upgrade auf Feeds.App',
	'\'[_1]\' is a required argument of [_2]' => '\'[_1]\' ist ein erforderliches Argument von [_2]',
	'MT[_1] was not used in the proper context.' => 'MT[_1] außerhalb seines Kontexts verwendet.',
	'Feeds.App Lite' => 'Feeds.App Lite',

## plugins/feeds-app-lite/lib/MT/Feeds/Lite.pm
	'An error occurred processing [_1]. The previous version of the feed was used. A HTTP status of [_2] was returned.' => 'Beim Einlesen von [_1] ist ein Fehler aufgetreten (zurückgegebener HTTP-Status: [_2]). Es wird die zuletzt erfolgreich eingelesene Version des Feeds verwendet. ',
	'An error occurred processing [_1]. A previous version of the feed was not available.A HTTP status of [_2] was returned.' => 'eim Einlesen von [_1] ist ein Fehler aufgetreten (zurückgegebener HTTP-Status: [_2]). Es liegt keine vorherige Version des Feeds vor.',

## plugins/Textile/textile2.pl
	'Textile 2' => 'Textile 2',

## plugins/Markdown/SmartyPants.pl
	'Markdown With SmartyPants' => 'Markdown mit SmartyPants',

## plugins/Markdown/Markdown.pl
	'Markdown' => 'Markdown',

## plugins/WXRImporter/tmpl/options.tmpl
	'Before you import WordPress posts to Movable Type, we recommend that you <a href=\'[_1]\'>configure your blog\'s publishing paths</a> first.' => 'Bevor Sie WordPress-Einträge in Movable Type importieren, sollten Sie zuerst die <a href=\'[_1]\'>Veröffentlichungspfade Ihres Weblogs einstellen</a>.', # Translate - New # OK
	'Upload path for this WordPress blog' => 'Uploadpfad für dieses WordPress-Blog',
	'Replace with' => 'Ersetzen durch',

## plugins/WXRImporter/WXRImporter.pl
	'WordPress eXtended RSS (WXR)' => 'WordPress eXtended RSS (WXR)',

## plugins/WXRImporter/lib/WXRImporter/Import.pm

## plugins/WXRImporter/lib/WXRImporter/WXRHandler.pm
	'File is not in WXR format.' => 'Datei ist nicht im WXR-Format.',
	'Saving asset (\'[_1]\')...' => 'Speichere Asset (\'[_1]\')...',
	' and asset will be tagged (\'[_1]\')...' => ' und Asset wird mit (\'[_1]\') getaggt werden...',
	'Saving page (\'[_1]\')...' => 'Speichere Seite (\'[_1]\')...',

## plugins/TemplateRefresh/tmpl/results.tmpl
	'Backup and Refresh Templates' => 'Vorlagen sichern und neu aufbauen',
	'No templates were selected to process.' => 'Keine Vorlagen ausgewählt.',

## plugins/TemplateRefresh/TemplateRefresh.pl
	'Error loading default templates.' => 'Laden der Standard-Vorlagen fehlgeschlagen.',
	'Insufficient permissions to modify templates for weblog \'[_1]\'' => 'Keine Rechte zur Bearbeitung der Vorlagen von Weblog \'[_1]\'',
	'Processing templates for weblog \'[_1]\'' => 'Verarbeite Vorlage des Weblogs \'[_1]\'',
	'Refreshing (with <a href="?__mode=view&amp;blog_id=[_1]&amp;_type=template&amp;id=[_2]">backup</a>) template \'[_3]\'.' => 'Bauee Vorlage \'[_3]\'  (mit <a href="?__mode=view&amp;blog_id=[_1]&amp;_type=template&amp;id=[_2]">Backup</a>) neu auf.',
	'Refreshing template \'[_1]\'.' => 'Baue Vorlage \'[_1]\' neu auf',
	'Error creating new template: ' => 'Fehler beim Anlegen der neuen Vorlage',
	'Created template \'[_1]\'.' => 'Vorlage \'[_1]\' angelegt.',
	'Insufficient permissions for modifying templates for this weblog.' => 'Unzureichende Benutzerrechte für die Bearbeitung von Vorlagen',
	'Skipping template \'[_1]\' since it appears to be a custom template.' => 'Überspringe Vorlage \'[_1]\', da es ein Custom Template zu sein scheint.',
	'Refresh Template(s)' => 'Vorlage(n) neu aufbauen',

## plugins/ExtensibleArchives/DatebasedCategories.pl
	'CATEGORY-YEARLY_ADV' => 'CATEGORY-YEARLY_ADV',
	'CATEGORY-MONTHLY_ADV' => 'CATEGORY-MONTHLY_ADV',
	'CATEGORY-DAILY_ADV' => 'CATEGORY-DAILY_ADV',
	'CATEGORY-WEEKLY_ADV' => 'CATEGORY-WEEKLY_ADV',
	'category/sub_category/yyyy/index.html' => 'kategorie/unter_kategorie/jjjj/index.html',
	'category/sub-category/yyyy/index.html' => 'kategorie/unter-kategorie/jjjj/index.html',
	'category/sub_category/yyyy/mm/index.html' => 'kategorie/unter_kategorie/jjjj/mm/index.html',
	'category/sub-category/yyyy/mm/index.html' => 'kategorie/unter-kategorie/jjjj/mm/index.html',
	'category/sub_category/yyyy/mm/dd/index.html' => 'kategorie/unter_kategorie/jjjj/mm/tt/index.html',
	'category/sub-category/yyyy/mm/dd/index.html' => 'kategorie/unter-kategorie/jjjj/mm/tt/index.html',
	'category/sub_category/yyyy/mm/day-week/index.html' => 'kategorie/unter_kategorie/jjjj/mm/tag-woche/index.html',
	'category/sub-category/yyyy/mm/day-week/index.html' => 'kategorie/unter-kategorie/jjjj/mm/tag-woche/index.html',

## plugins/ExtensibleArchives/AuthorArchive.pl
	'AUTHOR_ADV' => 'AUTHOR_ADV',
	'AUTHOR-YEARLY_ADV' => 'AUTHOR-YEARLY_ADV',
	'AUTHOR-MONTHLY_ADV' => 'AUTHOR-MONTHLY_ADV',
	'AUTHOR-WEEKLY_ADV' => 'AUTHOR-WEEKLY_ADV',
	'AUTHOR-DAILY_ADV' => 'AUTHOR-DAILY_ADV',
	'author_display_name/index.html' => 'benutzer_name/index.html',
	'author-display-name/index.html' => 'benutzer-name/index.html',
	'author_display_name/yyyy/index.html' => 'benutzer_name/jjjj/index.html',
	'author-display-name/yyyy/index.html' => 'benutzer-name/jjjj/index.html',
	'author_display_name/yyyy/mm/index.html' => 'benutzer_name/jjjj/mm/index.html',
	'author-display-name/yyyy/mm/index.html' => 'benutzer-name/jjjj/mm/index.html',
	'author_display_name/yyyy/mm/day-week/index.html' => 'benutzer_name/jjjj/mm/tag-woche/index.html',
	'author-display-name/yyyy/mm/day-week/index.html' => 'benutzer-name/jjjj/mm/tag-woche/index.html',
	'author_display_name/yyyy/mm/dd/index.html' => 'benutzer_name/jjjj/mm/tt/index.html',
	'author-display-name/yyyy/mm/dd/index.html' => 'benutzer-name/jjjj/mm/tt/index.html',

## plugins/Cloner/cloner.pl
	'Cloning Weblog' => 'Klone Weblog',
	'Finished! You can <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_1]\');\">return to the weblogs listing</a> or <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_2]\');\">configure the Site root and URL of the new weblog</a>.' => 'Fertig! Kehren Sie zur <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_1]\');\">Liste aller Weblogs</a> zurück oder <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_2]\');\">konfigurieren Sie das neue Blog</a>.',
	'No weblog was selected to clone.' => 'Keine Klonvorlage gewählt.',
	'This action can only be run for a single weblog at a time.' => 'Diese Aktion kann nur für jeweils ein einziges Weblog ausgeführt werden.',
	'Invalid blog_id' => 'Ungültige blog_id',
	'Clone Weblog' => 'Weblog klonen',

## plugins/WidgetManager/tmpl/header.tmpl
	'Movable Type Publishing Platform' => 'Movable Type Publishing Platform',
	'Main Menu' => 'Hauptmenü',
	'Welcome' => 'Willkommen',
	'Go to:' => 'Gehe zu:',
	'Select a blog' => 'Blog auswählen...',
	'System-wide listing' => 'Globale Auflistung',

## plugins/WidgetManager/tmpl/edit.tmpl
	'Edit Widget Set' => 'Widgetgruppe bearbeiten', # Translate - New # OK
	'Please use a unique name for this widget set.' => 'Bitte verwenden Sie für die Widgetgruppe einen eindeutigen Namen.', # Translate - New # OK
	'You already have a widget set named \'[_1].\' Please use a unique name for this widget set.' => 'Eine Widgetgruppe namens \'[_1]\' ist bereits vorhanden. Bitte wählen Sie einen noch nicht verwendeten Namen.', # Translate - New # OK
	'Your changes to the Widget Set have been saved.' => 'Änderungen gespeichert.', # Translate - New # OK
	'Set Name' => 'Name vergeben', # Translate - New # OK
	'Drag and drop the widgets you want into the <strong>Installed</strong> column.' => 'Ziehen Sie die Widgets, die Sie verwenden möchten, in die Spalte <strong>Installierte Widgets</strong>.',
	'Installed Widgets' => 'Installierte Widgets',
	'Available Widgets' => 'Verfügbare Widgets',

## plugins/WidgetManager/tmpl/list.tmpl
	'Widgets' => 'Widgets',
	'Widget Set' => 'Widgetgruppe',
	'Widget Sets' => 'Widgetgruppen', # Translate - New # OK
	'Delete selected Widget Sets (x)' => 'Gewählte Widget-Gruppen löschen', # Translate - New # OK
	'Helpful Tips' => 'Nützliche Hinweise', # Translate - New # OK
	'To add a widget set to your templates, use the following syntax:' => 'Um eine Widgetgruppe in eine Vorlage einzubinden, verwenden Sie folgenden Code:', # Translate - New # OK
	'<strong>&lt;$MTWidgetSet name=&quot;Name of the Widget Set&quot;$&gt;</strong>' => '<strong>&lt;$MTWidgetSet name=&quot;Name der Widgetgruppe&quot;$&gt;</strong>', # Translate - New # OK
	'Your changes to the widget set have been saved.' => 'Änderungen gespeichert.', # Translate - New # OK
	'You have successfully deleted the selected widget set(s) from your blog.' => 'Widget-Gruppe(n) erfolgreich gelöscht.', # Translate - New # OK
	'New Widget Set' => 'Neue Widgetgruppe', # Translate - New # OK
	'Create Widget Set' => 'Widgetgruppe anlegen', # Translate - New # OK

## plugins/WidgetManager/WidgetManager.pl

## plugins/WidgetManager/default_widgets/monthly_archive_list.tmpl

## plugins/WidgetManager/default_widgets/technorati_search.tmpl
	'Technorati' => 'Technorati',
	'<a href=\'http://www.technorati.com/\'>Technorati</a> search' => '<a href=\'http://www.technorati.com/\'>Technorati</a>-Suche',
	'this blog' => 'in diesem Blog',
	'all blogs' => 'in allen Blogs',
	'Blogs that link here' => 'Blogs, die Links auf diese Seite enthalte',

## plugins/WidgetManager/default_widgets/calendar.tmpl
	'Monthly calendar with links to each day\'s posts' => 'Monatskalender mit Links zu allen Einträgen',
	'Sunday' => 'Sonntag',
	'Sun' => 'So',
	'Monday' => 'Montag',
	'Mon' => 'Mo',
	'Tuesday' => 'Dienstag',
	'Tue' => 'Di',
	'Wednesday' => 'Mittwoch',
	'Wed' => 'Mi',
	'Thursday' => 'Donnerstag',
	'Thu' => 'Do',
	'Friday' => 'Freitag',
	'Fri' => 'Fr',
	'Saturday' => 'Samstag',
	'Sat' => 'Sa',

## plugins/WidgetManager/default_widgets/signin.tmpl
	'You are signed in as ' => 'Sie sind angemeldet als',
	'You do not have permission to sign in to this blog.' => 'Sie haben keine Anmelderechte für dieses Blog.',

## plugins/WidgetManager/default_widgets/category_archive_list.tmpl

## plugins/WidgetManager/default_widgets/recent_comments.tmpl
	'Recent Comments' => 'Neueste Kommentare',

## plugins/WidgetManager/default_widgets/monthly_archive_dropdown.tmpl
	'Select a Month...' => 'Monat auswählen...',

## plugins/WidgetManager/default_widgets/tag_cloud_module.tmpl
	'Tag cloud' => 'Tag Cloud',

## plugins/WidgetManager/default_widgets/powered_by.tmpl
	'_POWERED_BY' => 'Powered by<br /><a href="http://www.movabletype.org/sitede/"><$MTProductName$></a>',

## plugins/WidgetManager/default_widgets/creative_commons.tmpl
	'This weblog is licensed under a' => 'Dieser Weblog steht unter einer',
	'Creative Commons License' => 'Creative Commons-Lizenz',

## plugins/WidgetManager/default_widgets/search.tmpl

## plugins/WidgetManager/default_widgets/recent_posts.tmpl

## plugins/WidgetManager/default_widgets/subscribe_to_feed.tmpl

## plugins/WidgetManager/lib/WidgetManager/CMS.pm
	'Can\'t duplicate the existing \'[_1]\' Widget Manager. Please go back and enter a unique name.' => 'Kann Widgetgruppe \' [_1]\' nicht duplizieren. Bitte geben Sie einen bisher noch nicht verwendeten Namen ein.',
	'Widget Manager' => 'Widgetgruppen',
	'Moving [_1] to list of installed modules' => 'Setze [_1] auf Liste der installierten Module.',
	'First Widget Manager' => 'Erste Widgetgruppe',

## plugins/WidgetManager/lib/WidgetManager/Plugin.pm
	'Can\'t find included template widget \'[_1]\'' => 'Kann in Vorlage angegebenes Widget \'[_1]\' nicht finden',

## plugins/MultiBlog/tmpl/system_config.tmpl
	'Default system aggregation policy' => 'Systemweite Voreinstellungen für Aggregation',
	'Allow' => 'Zulassen',
	'Disallow' => 'Nicht zulassen',
	'Cross-blog aggregation will be allowed by default.  Individual blogs can be configured through the blog-level MultiBlog settings to restrict access to their content by other blogs.' => 'Verwendung von Bloginhalten in anderen Blogs dieser Installation systemweit erlauben. Auf Blog-Ebene gemachte Einstellungen sind vorranging, so daß diese Voreinstellung für einzelne Blogs außer Kraft gesetzt werden kann.',
	'Cross-blog aggregation will be disallowed by default.  Individual blogs can be configured through the blog-level MultiBlog settings to allow access to their content by other blogs.' => 'Verwendung von Bloginhalten in anderen Blogs dieser Installation systemweit nicht erlauben. Auf Blog-Ebene gemachte Einstellungen sind vorranging, so daß diese Voreinstellung für einzelne Blogs außer Kraft gesetzt werden kann.',

## plugins/MultiBlog/tmpl/dialog_create_trigger.tmpl
	'Create MultiBlog Trigger' => 'MultiBlog-Auslöser definieren', # Translate - New # OK

## plugins/MultiBlog/tmpl/blog_config.tmpl
	'When' => 'Wenn',
	'Any Weblog' => 'Jedes Blog',
	'Trigger' => 'Auslöser',
	'Action' => 'Aktion',
	'Content Privacy' => 'Externer Zugriff auf Inhalte',
	'Specify whether other blogs in the installation may publish content from this blog. This setting takes precedence over the default system aggregation policy found in the system-level MultiBlog configuration.' => 'Hier können Sie festlegen, ob andere Blogs dieser Movable Type-Installation die Inhalte dieses Blogs verwenden dürfen oder nicht. Diese Einstellung hat Vorrang vor der globalen MultiBlog-Konfiguration.',
	'Use system default' => 'System-Voreinstellung verwenden',
	'MTMultiBlog tag default arguments' => 'MultiBlog-Standardargumente',
	'Enables use of the MTMultiBlog tag without include_blogs/exclude_blogs attributes. Comma-separated BlogIDs or \'all\' (include_blogs only) are acceptable values.' => 'Ermöglicht die Verwendung von MTMultiBlog ohne include_blogs- und exclude_blogs-Attribute. Erlaubte Werte sind \'all\' oder per Kommata getrennte BlogIDs.',
	'Include blogs' => 'Blogs einbeziehen',
	'Exclude blogs' => 'Blogs nicht einbeziehen',
	'Current Rebuild Triggers:' => 'Derzeitige Auslöser für erneute Veröffentlichung:',
	'Create New Rebuild Trigger' => 'Nehttp://www.fotocommunity.de/pc/pc/extra/buddies/display/9417254uen Auslöser für erneute Veröffentlichung anlegen',
	'You have not defined any rebuild triggers.' => 'Es sind keine Auslöser für erneute Veröffentlichung definiert.',

## plugins/MultiBlog/multiblog.pl
	'MultiBlog allows you to publish templated or raw content from other blogs and define rebuild dependencies and access controls between them.' => 'Mit MultiBlog können Sie Inhalte anderer Blogs dieser Installation per Vorlage formatiert oder in Rohform übernehmen, Abhängigkeiten zur automatischen Neuveröffentlichung bei Erscheinen neuer Inhalte definieren und Zugriffsrechte der Blogs untereinander festlegen.',
	'MultiBlog' => 'MultiBlog',
	'Create New Trigger' => 'Neuen Auslöser anlegen',
	'Weblog Name' => 'Weblogname',
	'Search Weblogs' => 'Weblogs suchen',
	'When this' => 'Wenn',
	'* All Weblogs' => '* Alle Weblogs',
	'Select to apply this trigger to all weblogs' => 'Auslöser auf alle Weblogs anwenden',
	'saves an entry' => 'ein Eintrag gespeichert wird',
	'publishes an entry' => 'ein Eintrag veröffentlicht wird',
	'publishes a comment' => 'ein Kommentar veröffentlicht wird',
	'publishes a TrackBack' => 'ein TrackBack veröffentlicht wird', # Translate - New # OK
	'rebuild indexes.' => 'Indizes neu aufbauen.',
	'rebuild indexes and send pings.' => 'Indizes neu aufbauen und Pings senden.',

## plugins/MultiBlog/lib/MultiBlog.pm
	'The include_blogs, exclude_blogs, blog_ids and blog_id attributes cannot be used together.' => 'Die Attribute include_blogs, exclude_blog, blog_ids und blog_id können nicht gemeinsam verwendet werden.',
	'The attribute exclude_blogs cannot take "all" for a value.' => '"All" ist kein gültiger Wert für exclude_blogs.',
	'The value of the blog_id attribute must be a single blog ID.' => 'blog_id erfordert genau eine Blog-ID als Wert.',
	'The value for the include_blogs/exclude_blogs attributes must be one or more blog IDs, separated by commas.' => 'include_blogs und exclude_blogs erfordern mindestens eine Blog-ID als Wert. Mehrere IDs sind per Komma zu trennen.',

## plugins/MultiBlog/lib/MultiBlog/Tags/MultiBlog.pm
	'MTMultiBlog tags cannot be nested.' => 'MTMultiBlog-Tags können nicht veschachtelt werden.',
	'Unknown "mode" attribute value: [_1]. Valid values are "loop" and "context".' => 'Ungültiges "mode"-Attribut [_1]. Gültige Werte sind "loop" und "context".',

## plugins/spamlookup/tmpl/lookup_config.tmpl
	'Lookups monitor the source IP addresses and hyperlinks of all incoming feedback. If a comment or TrackBack comes from a blacklisted IP address or contains a blacklisted domain, it can be held for moderation or scored as junk and placed into the blog\'s Junk folder. Additionally, advanced lookups on TrackBack source data can be performed.' => 'Von eingehendem Feedback können die IP-Adressen und die enthaltenen Hyperlinks  in Schwarzlisten nachgeschlagen werden. Stammt ein eingehender Kommentar oder TrackBack von einer dort gelisteten IP-Adresse oder enthält er Links zu einer dort gelisteten Domain, kann er  automatisch zur Moderation zurückgehalten oder als Spam angesehen werden. Für TrackBacks sind zusätzliche Prüfungen möglich.',
	'IP Address Lookups:' => 'IP-Adressen nachschlagen',
	'Moderate feedback from blacklisted IP addresses' => 'Feedback von schwarzgelisteten IP-Adressen moderieren',
	'Junk feedback from blacklisted IP addresses' => 'Feedback von schwarzgelisteten IP-Adressen als Spam ansehen',
	'Adjust scoring' => 'Gewichtung anpassen',
	'Score weight:' => 'Gewichtung',
	'Less' => 'Kleiner',
	'More' => 'Größer',
	'block' => 'sperren',
	'none' => 'Kein(e)',
	'IP Blacklist Services' => 'IP-Sperrdienste',
	'Domain Name Lookups:' => 'Domainnamen nachschlagen',
	'Moderate feedback containing blacklisted domains' => 'Feedback von schwarzgelisteten Domains moderieren',
	'Junk feedback containing blacklisted domains' => 'Feedback von schwarzgelisteten Domains als Spam ansehen',
	'Domain Blacklist Services' => 'Domain-Schwarzlisten',
	'Advanced TrackBack Lookups' => 'Zusätzliche TrackBack-Prüfungen',
	'Moderate TrackBacks from suspicious sources' => 'TrackBacks aus dubiosen Quellen moderieren',
	'Junk TrackBacks from suspicious sources' => 'TrackBacks aus dubiosen Quellen als Spam ansehen',
	'To prevent lookups for some IP addresses or domains, list them below. Place each entry on a line by itself.' => 'IP-Adressen und Domains, die nicht nachgeschlagen werden sollen, können Sie hier aufführen. Verwenden Sie für jeden Eintrag eine eigene Zeile.',
	'Lookup Whitelist:' => 'Weißliste',

## plugins/spamlookup/tmpl/word_config.tmpl
	'Incomming feedback can be monitored for specific keywords, domain names, and patterns. Matches can be held for moderation or scored as junk. Additionally, junk scores for these matches can be customized.' => 'Eingehendes Feedback kann auf wählbare Schlüsselbegriffe, Domainnamen und Muster durchsucht werden. Feedback mit Treffern kann automatisch zur Moderation zurückgehalten oder als Spam angesehen werden.',
	'Keywords to Moderate' => 'Bei Auftreten dieser Schlüsselwörter Feedback moderieren',
	'Keywords to Junk' => 'Bei Auftreten dieser Schlüsselwörter Feedback als Spam ansehen',

## plugins/spamlookup/tmpl/url_config.tmpl
	'Link filters monitor the number of hyperlinks in incoming feedback. Feedback with many links can be held for moderation or scored as junk. Conversely, feedback that does not contain links or only refers to previously published URLs can be positively rated. (Only enable this option if you are sure your site is already spam-free.)' => 'Die Anzahl der in eingehendem Feedback enthaltenen Hyperlinks kann kontrolliert werden. Feedback mit sehr vielen Links kann automatisch zur Moderation zurückgehalten oder als Spam angesehen werden. Umgekehrt kann Feedback, das gar keine Links enthält oder nur solche, die zuvor bereits freigegeben wurden, automatisch positiv bewertet werden.',
	'Link Limits' => 'Link-Grenzwert',
	'Credit feedback rating when no hyperlinks are present' => 'Feedback ohne enthaltene Hyperlinks positiv bewerten',
	'Moderate when more than' => 'Moderieren bei mehr als',
	'link(s) are given' => 'Link(s)',
	'Junk when more than' => 'Als Spam ansehen bei mehr als',
	'Link Memory' => 'Bereits veröffentlichte Links',
	'Credit feedback rating when &quot;URL&quot; element of feedback has been published before' => 'Feedback positiv bewerten, wenn die Quelladresse (URL) bereits veröffentlicht wurde.',
	'Only applied when no other links are present in message of feedback.' => 'Nur anwenden, wenn keine anderen Links im Feedbacktext enthalten sind',
	'Exclude URLs from comments published within last [_1] days.' => 'URLs aus Kommentaren, die in den letzten [_1] Tagen veröffentlicht wurden, ausnehmen.',
	'Email Memory' => 'Bereits veröffentlichte E-Mail-Adressen',
	'Credit feedback rating when previously published comments are found matching on the &quot;Email&quot; address' => 'Feedback positiv bewerten, wenn bereits zuvor Kommentare von der gleichen E-Mail-Adresse veröffentlicht wurden.',
	'Exclude Email addresses from comments published within last [_1] days.' => 'E-Mail-Adressen aus Kommentaren, die in den letzten [_1] Tagen veröffentlicht wurden, ausnehmen.',

## plugins/spamlookup/spamlookup.pl
	'SpamLookup module for using blacklist lookup services to filter feedback.' => 'SpamLookup-Modul zur Nutzung von Schwarzlisten zur Feedback-Filterung',
	'SpamLookup IP Lookup' => 'SpamLookup für IP-Adressen',
	'SpamLookup Domain Lookup' => 'SpamLookup für Domains',
	'SpamLookup TrackBack Origin' => 'SpamLookup für TrackBack-Herkunft',
	'Despam Comments' => 'Spam aus Kommentaren entfernen',
	'Despam TrackBacks' => 'Spam aus TrackBacks entfernen',
	'Despam' => 'Spam entfernen',

## plugins/spamlookup/spamlookup_urls.pl
	'SpamLookup - Link' => 'SpamLookup für Links',
	'SpamLookup module for junking and moderating feedback based on link filters.' => 'SpamLookup-Modul zur Überprüfung von Links zur Feedback-Filterung',
	'SpamLookup Link Filter' => 'SpamLookup zur Linkfilterung',
	'SpamLookup Link Memory' => 'SpamLookup zur Betrachtung bereits veröffentlichter Links',
	'SpamLookup Email Memory' => 'SpamLookup zur Betrachtung bereits veröffentlichter E-Mail-Adressen',

## plugins/spamlookup/lib/spamlookup.pm
	'Failed to resolve IP address for source URL [_1]' => 'Kann IP-Adresse für Quelladresse [_1] nicht auflösen',
	'Moderating: Domain IP does not match ping IP for source URL [_1]; domain IP: [_2]; ping IP: [_3]' => 'Moderation: Die IP-Adresse der Domain ([_2]) stimmt nicht mit der Ping-IP-Adresse ([_3]) überein. URL: [_1]',
	'Domain IP does not match ping IP for source URL [_1]; domain IP: [_2]; ping IP: [_3]' => 'Die IP-Adresse der Domain ([_2]) stimmt nicht mit der Ping-IP-Adresse ([_3]) überein. URL: [_1]',
	'No links are present in feedback' => 'Keine Links enthalten',
	'Number of links exceed junk limit ([_1])' => 'Anzahl der Links übersteigt Spam-Grenzwert ([_1] Links)',
	'Number of links exceed moderation limit ([_1])' => 'Anzahl der Links übersteigt Moderations-Grenzwert ([_1] Links)',
	'Link was previously published (comment id [_1]).' => 'Link wurde bereits veröffentlicht (Kommentar [_1])',
	'Link was previously published (TrackBack id [_1]).' => 'Link wurde bereits veröffentlicht (TrackBack [_1])',
	'E-mail was previously published (comment id [_1]).' => 'E-Mail-Adresse wurde bereits veröffentlicht (Kommentar [_1])',
	'Word Filter match on \'[_1]\': \'[_2]\'.' => 'Schlüsselwortfilter angesprochen bei \'[_1]\': \'[_2]\'.',
	'Moderating for Word Filter match on \'[_1]\': \'[_2]\'.' => 'Moderierung: Schlüsselwortfilter angesprochen bei \'[_1]\': \'[_2]\'.',
	'domain \'[_1]\' found on service [_2]' => 'Domain \'[_1]\'gefunden bei [_2]',
	'[_1] found on service [_2]' => '[_1] gefunden bei [_2]',

## plugins/spamlookup/spamlookup_words.pl
	'SpamLookup module for moderating and junking feedback using keyword filters.' => 'SpamLookup-Modul für automatische Einordnung von Feedback zur Moderation oder als Spam nach Schlüsselbegriffen',
	'SpamLookup Keyword Filter' => 'SpamLookup Schlüsselbegriff-Filter',

## plugins/StyleCatcher/stylecatcher.pl
	'<p>You must define a global theme repository where themes can be stored locally.  If a particular blog has not been configured for it\'s own theme paths, it will use these settings directly. If a blog has it\'s own theme paths, then the theme will be copied to that location when applied to that weblog. The paths defined here must physically exist and be writable by the webserver.</p>' => '<p>StyleCatcher erfordert eine globale Themenbibliothek, um Designvorlagen lokal speichern zu können. Wird bei einem Blog kein Pfad zum verwendeten Thema angegeben, wird automatisch auf den hier angegebenen Pfad zurückgegriffen. Andernfalls werden verwendete Designvorlagen in den entsprechenden Ordner kopiert. Die hier angegebenen Ordner müssen bereits vorhanden und mit Schreibrechten ausgestattet sein.</p>',
	'<p style="color: #f00;"><strong>NOTE:</strong> StyleCatcher must first be configured from the system-level plugins listing before it can be used on any blog.</p>' => '<p style="color: #f00;"><strong>WICHTIG:</strong> StyleCatcher muss, bevor es in einem Blog eingesetzt wird, zuerst aus dem systemweiten Plugin-Verzeichnis heraus konfiguriert werden.</p>',
	'<p>If you wish to store your themes locally for this blog, you can configure your theme URL and path below.  Although downloaded themes will still be stored in the system-level directory, they will be copied to this directory when they are applied. The paths defined here must physically exist and be writable by the webserver.</p>' => '<p>Sollen die in diesem Blog verwendeten Themen lokal gespeichert werden, geben Sie hier bitte den gewünschten Speicherort an. Heruntergeladene Themen werden zuerst im globalen Themenverzeichnis gespeichert und bei Anwendung in das hier angegebene Verzeichnis kopiert. Die Ordner müssen bereits vorhanden und vom Webserver beschreibbar sein.',
	'Theme Root URL:' => 'Wurzeladresse für Themen:',
	'Theme Root Path:' => 'Wurzelverzeichnis für Themen:',
	'Style Library URL:' => 'Adresse der Stilvorlagenbibliothek:',
	'Unable to create the theme root directory. Error: [_1]' => 'Konnte Themen-Wurzelverzeichnis nicht anlegen: [_1]',
	'Unable to write base-weblog.css to themeroot. File Manager gave the error: [_1]. Are you sure your theme root directory is web-server writable?' => 'Konnte base-weblog.css nicht im Themen-Wurzelverzeichnis anlegen: [_1]. Hat der Webserver Schreibrechte für das Verzeichnis?',
	'Styles' => 'Stilvorlagen',

## plugins/StyleCatcher/tmpl/header.tmpl

## plugins/StyleCatcher/tmpl/view.tmpl
	'Select a Style' => 'Stilvorlage auswählen',
	'Please select a weblog to apply this theme.' => 'Bitte wählen Sie, auf welches Weblog dieses Thema angewendet werden soll.',
	'Please click on a theme before attempting to apply a new design to your blog.' => 'Bitte klicken Sie auf ein Thema bevor sie ein neues Design auf Ihr Weblog übertragen möchten.',
	'Applying...' => 'Übertrage...',
	'Choose this Design' => 'Dieses Design wählen',
	'Error applying theme: ' => 'Fehler bei Übertragung des Themas:',
	'The selected theme has been applied!' => 'Das gewählte Thema wurde übertragen!',
	'Find Style' => 'Stilvorlagen finden',
	'Theme or Repository URL:' => 'URL des Themas oder der Themensammlung',
	'Download Styles' => 'Stilvorlagen herunterladen',
	'Current theme for your weblog' => 'Derzeitiges Thema Ihres Weblogs',
	'Current Theme' => 'Derzeitiges Thema',
	'Current themes for your weblogs' => 'Derzeitiges Thema Ihrer Weblogs',
	'Current Themes' => 'Derzeitige Themen',
	'Locally saved themes' => 'Lokal gespeicherte Themen',
	'Saved Themes' => 'Gespeicherte Themen',
	'Single themes from the web' => 'Einzelne Themen aus dem Internet',
	'More Themes' => 'Weitere Themen',
	'Show Details' => 'Detail anzeigen',
	'Hide Details' => 'Details verbergen',
	'Select a Weblog...' => 'Weblog wählen...',
	'Apply Selected Design' => 'Gewähltes Design anwenden',
	'You don\'t appear to have any weblogs with a \'Theme Stylesheet\' template that you have rights to edit. Please check your blog(s) for this template.' => 'Sie scheinen für kein Weblog Bearbeitungsberechtigung für \'Themenstylesheet\'-Vorlagen zu haben. Bitte überprüfen Sie Ihre Blogs auf diese Vorlage.',
	'Error loading themes! -- [_1]' => 'Fehler beim Laden von Themen -- [_1]',

## plugins/StyleCatcher/lib/StyleCatcher/CMS.pm
	'Could not create [_1] folder - Check that your \'themes\' folder is webserver-writable.' => 'Konnte Ordner [_1] nicht anlegen. Bitte überprüfen Sie, ob Ihr Webserver Schreibrechte für den Ordner \'themes\' hat.',
	'Successfully applied new theme selection.' => 'Neues Thema erfolgreich übertragen.',

);

## New words: 749

1;
