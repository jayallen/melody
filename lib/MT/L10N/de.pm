# Copyright 2003-2008 Six Apart. This code cannot be redistributed without
# permission from www.sixapart.com.
#
# $Id:$

package MT::L10N::de;
use strict;
use MT::L10N;
use MT::L10N::en_us;
use vars qw( @ISA %Lexicon );
@ISA = qw( MT::L10N::en_us );

## The following is the translation table.

%Lexicon = (

## php/lib/function.mtassettype.php
	'image' => 'Bild', # Translate - Case # OK
	'Image' => 'Bild',
	'file' => 'Datei', # Translate - New # OK
	'File' => 'Datei', # Translate - New # OK
	'audio' => 'Töne',
	'Audio' => 'Töne',
	'video' => 'Video',
	'Video' => 'Video',

## php/lib/function.mtvar.php
	'You used a [_1] tag without a valid name attribute.' => '[_1] ohne gültiges Namensattribut verwendet.',
	'\'[_1]\' is not a valid function for a hash.' => '\'[_1]\' ist keine gültige Hash-Funktion.',
	'\'[_1]\' is not a valid function for an array.' => '\'[_1]\' ist keine gültige Array-Funktion.',
	'[_1] [_2] [_3] is illegal.' => '[_1] [_2] [_3] ist ungültig.',

## php/lib/function.mtwidgetmanager.php
	'Error: widgetset [_1] is empty.' => 'Fehler: Die Widgetgruppe [_1] ist leer.', # Translate - New # OK
	'Error compiling widgetset [_1]' => 'Fehler bei Kompilierung der Widgetgruppe [_1]', # Translate - New # OK

## php/lib/archive_lib.php
	'Page' => 'Seite',
	'Individual' => 'Individuell',
	'Yearly' => 'Jährlich',
	'Monthly' => 'Monatlich',
	'Daily' => 'Täglich',
	'Weekly' => 'Wöchentlich',
	'Author' => 'Autor',
	'(Display Name not set)' => '(Kein Anzeigename gewählt)',
	'Author Yearly' => 'Autor jährlich',
	'Author Monthly' => 'Autor monatlich',
	'Author Daily' => 'Autor täglich',
	'Author Weekly' => 'Autor wöchentlich',
	'Category Yearly' => 'Kategorie jährlich',
	'Category Monthly' => 'Kategorie monatlich',
	'Category Daily' => 'Kategorie täglich',
	'Category Weekly' => 'Kategorie wöchentlich',

## php/lib/function.mtcommentreplylink.php
	'Reply' => 'Antworten',

## php/lib/block.mtsethashvar.php

## php/lib/block.mtif.php

## php/lib/function.mtremotesigninlink.php
	'TypeKey authentication is not enabled in this blog.  MTRemoteSignInLink can\'t be used.' => 'TypeKey-Authentifizierung ist in diesem Blog nicht aktiviert. MTRemoteSignInLink kann daher nicht verwendet werden.',

## php/lib/block.mtauthorhaspage.php
	'No author available' => 'Kein Autor verfügbar',

## php/lib/block.mtauthorhasentry.php

## php/lib/function.mtproductname.php
	'[_1] [_2]' => '[_1] [_2]',

## php/lib/captcha_lib.php
	'Captcha' => 'Captcha',
	'Type the characters you see in the picture above.' => 'Geben Sie die Buchstaben ein, die Sie in obigem Bild sehen.',

## php/lib/function.mtcommentauthorlink.php
	'Anonymous' => 'Anonym',

## php/lib/MTUtil.php
	'userpic-[_1]-%wx%h%x' => 'userpic-[_1]-%wx%h%x',

## php/lib/function.mtsetvar.php
	'\'[_1]\' is not a hash.' => '\'[_1]\' ist kein Hash-Wert.',
	'Invalid index.' => 'Ungültiger Index.',
	'\'[_1]\' is not an array.' => '\'[_1]\' ist kein Array.',
	'\'[_1]\' is not a valid function.' => '\'[_1]\' ist keine gültige Funktion.',

## php/lib/block.mtassets.php
	'sort_by="score" must be used in combination with namespace.' => 'Sort_by="score" erfordert einen Namespace.',

## php/lib/block.mtsetvarblock.php

## php/lib/block.mtentries.php

## php/lib/function.mtauthordisplayname.php

## php/lib/function.mtentryclasslabel.php
	'page' => 'erneut veröffentlichen',
	'entry' => 'Eintrag',
	'Entry' => 'Eintrag',

## php/mt.php.pre
	'Page not found - [_1]' => 'Seite nicht gefunden - [_1]', # Translate - New # OK

## default_templates/comment_response.mtml
	'Confirmation...' => 'Bestätigung',
	'Your comment has been submitted!' => 'Ihr Kommentar ist eingegangen!',
	'Thank you for commenting.' => 'Vielen Dank für Ihren Kommentar.',
	'Your comment has been received and held for approval by the blog owner.' => 'Ihr Kommentar wurde abgeschickt. Er erscheint, sobald der Blogbetreiber ihn freigeschaltet hat.',
	'Comment Submission Error' => 'Fehler beim Kommentieren',
	'Your comment submission failed for the following reasons: [_1]' => 'Ihr Kommentar konnte aus folgenden Gründen nicht abgeschickt werden: [_1]', # Translate - New # OK
	'HTML Head' => 'HTML-Kopf', # Translate - New # OK
	'Banner Header' => 'Banner-Kopf', # Translate - New # OK
	'Return to the <a href="[_1]">original entry</a>.' => '<a href="[_1]">Zurück zum Eintrag</a>',
	'Sidebar' => 'Seitenleiste',
	'Banner Footer' => 'Banner-Fuß', # Tr anslate - New # OK

## default_templates/notify-entry.mtml
	'A new [lc,_3] entitled \'[_1]\' has been published to [_2].' => 'Ein neuer [_3] namens \'[_1]\' wurde auf [_2] veröffentlicht.',
	'View entry:' => 'Eintrag ansehen:',
	'View page:' => 'Seite ansehen:',
	'[_1] Title: [_2]' => 'Titel: [_2]',
	'Publish Date: [_1]' => 'Veröffentlichungsdatum:',
	'Message from Sender:' => 'Nachricht des Absenders:',
	'You are receiving this email either because you have elected to receive notifications about new content on [_1], or the author of the post thought you would be interested. If you no longer wish to receive these emails, please contact the following person:' => 'Sie erhalten diese E-Mail, da Sie entweder Nachrichten über Aktualisierungen von [_1] bestellt haben oder da der Autor dachte, daß dieser Eintrag für Sie von Interesse sein könnte. Wenn Sie solche Mitteilungen nicht länger erhalten wollen, wenden Sie sich bitte an ',

## default_templates/main_index.mtml
	'Entry Summary' => 'Zusammenfassung',
	'Archives' => 'Archiv',

## default_templates/monthly_archive_dropdown.mtml
	'Select a Month...' => 'Monat auswählen...',

## default_templates/page.mtml
	'Trackbacks' => 'TrackBacks',
	'Comments' => 'Kommentare',

## default_templates/entry_summary.mtml
	'By [_1] on [_2]' => 'Von [_1] am [_2]',
	'1 Comment' => '1 Kommentar', # Translate - New # OK
	'# Comments' => '# Kommentare', # Translate - New # OK
	'1 TrackBack' => '1 TrackBack', # Translate - New # OK
	'# TrackBacks' => '# TrackBacks', # Translate - New # OK
	'Tags' => 'Tags',
	'Continue reading <a href="[_1]" rel="bookmark">[_2]</a>.' => '<a rel="bookmark" href="[_1]">[_2]</a> weiterlesen', # Translate - New # OK
	
## default_templates/category_archive_list.mtml
	'Categories' => 'Kategorien',
	'[_1] ([_2])' => '[_1] ([_2])',

## default_templates/recent_comments.mtml
	'Recent Comments' => 'Aktuelle Kommentare', # Translate - Improved (2) # OK
	'<a href="[_1]">[_2] commented on [_3]</a>: [_4]' => '<a href="[_1]">[_2] meinte zu [_3]</a>: [_4]',

## default_templates/new-ping.mtml
	'An unapproved TrackBack has been posted on your blog [_1], for entry #[_2] ([_3]). You need to approve this TrackBack before it will appear on your site.' => 'In Ihrem Weblog [_1] ist ein noch nicht freigeschaltetes TrackBack zum Eintrag [_3] (#[_2]) eingegangen. Schalten Sie das TrackBack frei, damit es auf Ihrem Weblog erscheint.',
	'An unapproved TrackBack has been posted on your blog [_1], for category #[_2], ([_3]). You need to approve this TrackBack before it will appear on your site.' => 'In Ihrem Weblog [_1] ist ein noch nicht freigeschaltetes TrackBack für die Kategorie [_3] (#[_2]) eingegangen. Schalten Sie das TrackBack frei, damit es auf Ihrem Weblog erscheint.',
	'A new TrackBack has been posted on your blog [_1], on entry #[_2] ([_3]).' => 'In Ihrem Weblog [_1] ist ein neuer TrackBack zum Eintrag [_3] (#[_2]) eingegangen.',
	'A new TrackBack has been posted on your blog [_1], on category #[_2] ([_3]).' => 'In Ihrem Weblog [_1] ist ein neuer TrackBack für die Kategorie [_3] (#[_2]) eingegangen.',
	'Excerpt' => 'Zusammenfassung',
	'URL' => 'URL',
	'Title' => 'Titel',
	'Blog' => 'Blog',
	'IP address' => 'IP-Adresse',
	'Approve TrackBack' => 'TrackBack annehmen',
	'View TrackBack' => 'TrackBack ansehen',
	'Report TrackBack as spam' => 'TrackBack als Spam melden',
	'Edit TrackBack' => 'TrackBack bearbeiten',

## default_templates/current_author_monthly_archive_list.mtml
	'[_1]: Monthly Archives' => '[_1]: Monatsarchive',

## default_templates/main_index_widgets_group.mtml
	'This is a custom set of widgets that are conditioned to only appear on the homepage (or "main_index"). More info: [_1]' => 'Dies ist eine spezielle Widgetgrupe, die nur auf der Startseite angezeigt wird.',
	'Recent Entries' => 'Aktuelle Einträge',
	'Recent Assets' => 'Aktuelle Assets', # Translate - Improved (2) # OK
	'Tag Cloud' => 'Tag-Wolke',

## default_templates/commenter_notify.mtml
	'This email is to notify you that a new user has successfully registered on the blog \'[_1]\'. Listed below you will find some useful information about this new user.' => 'Ein neuer Benutzer hat sich erfolgreich für das Blog \'[_1]\' registriert. Unten finden Sie nähere Informationen über diesen Benutzer.',
	'New User Information:' => 'Informationen über den neuen Benutzer:',
	'Username: [_1]' => 'Benutzername: [_1]',
	'Full Name: [_1]' => 'Voller Name: [_1]',
	'Email: [_1]' => 'E-Mail-Adresse:',
	'To view or edit this user, please click on or cut and paste the following URL into a web browser:' => 'Um alle Benutzerdaten zu sehen oder zu bearbeiten, klicken Sie bitte auf folgende Adresse (oder kopieren Sie sie und fügen Sie sie in Adresszeile Ihres Web-Browsers ein):',

## default_templates/footer-email.mtml
	'Powered by Movable Type [_1]' => 'Powered by Movable Type [_1]',

## default_templates/verify-subscribe.mtml
	'Thanks for subscribing to notifications about updates to [_1]. Follow the link below to confirm your subscription:' => 'Vielen Dank, daß Sie die die Benachrichtungen über Aktualisierungen von [_1] abonniert haben. Bitte klicken Sie zur Bestätigung auf folgenden Link:',
	'If the link is not clickable, just copy and paste it into your browser.' => 'Wenn der Link nicht anklickbar ist, kopieren Sie ihn einfach und fügen ihn in der Adresszeile Ihres Browers ein.',

## default_templates/archive_widgets_group.mtml
	'This is a custom set of widgets that are conditioned to serve different content based upon what type of archive it is included. More info: [_1]' => 'Dies ist eine spezielle Widgetgruppe, die vom jeweiligen Archivtyp abhängige Inhalte ausgibt.',
	'Current Category Monthly Archives' => 'Monatsarchive der aktuellen Kategorie',
	'Category Archives' => 'Kategoriearchive',
	'Monthly Archives' => 'Monatsarchive',

## default_templates/technorati_search.mtml
	'Technorati' => 'Technorati',
	'<a href=\'http://www.technorati.com/\'>Technorati</a> search' => '<a href=\'http://www.technorati.com/\'>Technorati</a>-Suche',
	'this blog' => 'in diesem Blog',
	'all blogs' => 'in allen Blogs',
	'Search' => 'Suchen:',
	'Blogs that link here' => 'Blogs, die Links auf diese Seite enthalte',

## default_templates/syndication.mtml
	'Subscribe to feed' => 'Feed abonnieren',
	'Subscribe to this blog\'s feed' => 'Feed dieses Blogs abonnieren',
	'Search results matching &ldquo;<$mt:SearchString$>&rdquo;' => 'Suchergebnisse für &#8222;<$MTSearchString$>&#8221;', # Translate - Improved (3) # OK

## default_templates/date_based_author_archives.mtml
	'Author Yearly Archives' => 'Jährliche Autorenarchive',
	'Author Monthly Archives' => 'Monatliche Autorenarchive',
	'Author Weekly Archives' => 'Wöchentliche Autorenarchive',
	'Author Daily Archives' => 'Tägliche Autorenarchive',

## default_templates/category_entry_listing.mtml
	'[_1] Archives' => '[_1] Archive',
	'Recently in <em>[_1]</em> Category' => 'Neues in der Kategorie <em>[_1]</em>',
	'Main Index' => 'Übersicht',

## default_templates/comment_throttle.mtml
	'If this was a mistake, you can unblock the IP address and allow the visitor to add it again by logging in to your Movable Type installation, going to Blog Config - IP Banning, and deleting the IP address [_1] from the list of banned addresses.' => 'Sie können die Sperrung dieser Adresse aufheben, indem Sie den Eintrag [_1] aus der Sperrliste unter Konfigurieren > Blog > IP-Sperren entfernen.',
	'A visitor to your blog [_1] has automatically been banned by adding more than the allowed number of comments in the last [_2] seconds.' => 'Die IP-Adrese eines Besuchers Ihres Weblogs [_1] wurde automatisch gesperrt, da er in den letzten [_2] Sekunden mehr Kommentare als zulässig zu veröffentlichen versucht hat.',
	'This has been done to prevent a malicious script from overwhelming your weblog with comments. The banned IP address is' => 'Dadurch wird verhindert, daß bosärtige Skripte Ihr Blog mit Spam-Kommentaren fluten können. Die gesperrte IP-Adresse lautet',

## default_templates/current_category_monthly_archive_list.mtml
	'[_1]' => '[_1]',

## default_templates/monthly_archive_list.mtml
	'[_1] <a href="[_2]">Archives</a>' => '<a href="[_2]">[_1]</a>',

## default_templates/new-comment.mtml
	'An unapproved comment has been posted on your blog [_1], for entry #[_2] ([_3]). You need to approve this comment before it will appear on your site.' => 'In Ihrem Weblog [_1] ist ein noch nicht freigeschalteter Kommentar zum Eintrag "[_3]" (#[_2]) eingegangen. Schalten Sie den Kommentar frei, damit er auf Ihrem Weblog erscheint.',
	'A new comment has been posted on your blog [_1], on entry #[_2] ([_3]).' => 'In Ihrem Weblog [_1] ist ein neuer Kommentar zum Eintrag "[_3]" (#[_2]) eingegangen:',
	'Commenter name: [_1]' => 'Name des Kommentarautors: [_1]',
	'Commenter email address: [_1]' => 'E-Mail-Adresse des Kommentarautors: [_1]',
	'Commenter URL: [_1]' => 'Web-Adresse (URL) des Kommentarautors:',
	'Commenter IP address: [_1]' => 'IP-Adresse des Kommentarautors:',
	'Approve comment:' => 'Kommentar freischalten:',
	'View comment:' => 'Kommentar ansehen:',
	'Edit comment:' => 'Kommentar bearbeiten:',
	'Report comment as spam:' => 'Kommentar als Spam melden:',

## default_templates/signin.mtml
	'JavaScript' => 'JavaScript',
	'Sign In' => 'Anmelden',
	'You are signed in as ' => 'Sie sind angemeldet als',
	'sign out' => 'abmelden',
	'You do not have permission to sign in to this blog.' => 'Sie haben keine Berechtigung zur Anmeldung an diesem Blog.',

## default_templates/about_this_page.mtml
	'About this Entry' => 'Über diese Seite',
	'About this Archive' => 'Über dieses Archiv',
	'About Archives' => 'Über die Archive',
	'This page contains links to all the archived content.' => 'Diese Seite enthält Links zu allen archivierten Einträgen.',
	'This page contains a single entry by [_1] published on <em>[_2]</em>.' => 'Diese Seite enthält einen einen einzelnen Eintrag von [_1] vom <em>[_2]</em>.',
	'<a href="[_1]">[_2]</a> was the previous entry in this blog.' => '<a href="[_1]">[_2]</a> ist der vorherige Eintrag in diesem Blog.',
	'<a href="[_1]">[_2]</a> is the next entry in this blog.' => '<a href="[_1]">[_2]</a> ist der nächste Eintrag in diesem Blog.',
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

## default_templates/pages_list.mtml
	'Pages' => 'Seiten',

## default_templates/entry.mtml

## default_templates/recover-password.mtml
	'_USAGE_FORGOT_PASSWORD_1' => 'Sie haben ein neues Movable Type-Passwort angefordert. Es wurde automatisch ein neues Passwort erzeugt. Es lautet:',
	'_USAGE_FORGOT_PASSWORD_2' => 'Mit diesem Passwort können Sie sich nun am System anmelden via dieser URL. Im Anschluss sollten Sie ein neues Passwort Ihrer Wahl einstellen.',
	'Mail Footer' => 'Mail-Signatur',

## default_templates/trackbacks.mtml
	'No TrackBacks' => 'Keine TrackBacks', # Translate - New # OK
	'TrackBack URL: <span id="trackbacks-link">[_1]</span>' => 'TrackBack-URL: <span id="trackbacks-link">[_1]</span>', # Translate - New # OK
	'<a href="[_1]">[_2]</a> from [_3] on <a href="[_4]">[_5]</a>' => '<a href="[_1]">[_2]</a> von [_3] zu <a href="[_4]">[_5]</a>',
	'[_1] <a href="[_2]">Read More</a>' => '[_1] <a href="[_2]">Mehr</a>',

## default_templates/javascript.mtml
	'moments ago' => 'vor einem Augenblick',
	'[quant,_1,hour,hours] ago' => 'vor [quant,_1,Stunde,Stunden]',
	'[quant,_1,minute,minutes] ago' => 'vor [quant,_1,Minute,Minuten]',
	'[quant,_1,day,days] ago' => 'vor [quant,_1,Tag,Tagen]',
	'<a href="[_1]">Edit</a>' => '<a href="[_1]">Bearbeiten</a>', # Translate - New # OK
	'Submit' => 'Abschicken',
	'Preview' => 'Vorschau',
	'You do not have permission to comment on this blog. ([_1]sign out[_2])' => 'Sie haben nicht die notwendige Berechtigung, um in diesem Blog Kommentare zu schreiben. ([_1]Abmelden[_2])', # Translate - New # OK
	'Thanks for signing in, [_1]. ([_2]sign out[_3])' => 'Danke für Ihre Anmeldung, [_1]. ([_2]Abmelden[_2])', # Translate - New # OK
	'[_1]Sign in[_2] to comment.' => '[_1]Anmelden[_2] um zu kommentieren', # Translate - New # OK
	'[_1]Sign in[_2] to comment, or comment anonymously.' => '[_1]Anmelden[_2] um zu kommentieren oder anonym kommentieren', # Translate - New # OK
	'Replying to <a href="#comment-[_1]">comment from [_2]</a>' => 'Auf <a href="#comment-[_1]">Kommentar von [_2]</a> antworten', # Translate - New # OK

## default_templates/archive_index.mtml
	'Author Archives' => 'Autorenarchive',
	'Category Monthly Archives' => 'Monatliche Kategoriearchive',

## default_templates/recent_entries.mtml

## default_templates/calendar.mtml
	'Monthly calendar with links to daily posts' => 'Monatskalender mit Link zu Tagesarchiven',
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

## default_templates/sidebar.mtml
	'2-column layout - Sidebar' => '2-spaltiges Layout - Seitenleiste',
	'3-column layout - Primary Sidebar' => '3-spaltiges Layout - Primär-Seitenleiste',
	'3-column layout - Secondary Sidebar' => '3-spaltiges Layout - Sekundär-Seitenleiste',

## default_templates/creative_commons.mtml
	'This blog is licensed under a <a href="[_1]">Creative Commons License</a>.' => 'Dieses Blog steht unter einer <a href="[_1]">Creative Commons-Lizenz</a>.',

## default_templates/banner_footer.mtml
	'_POWERED_BY' => 'Powered by<br /><a href="http://www.movabletype.org/sitede/"><$MTProductName$></a>',

## default_templates/comments.mtml
	'No Comments' => 'Keine Kommentare', # Translate - New # OK
	'[_1] replied to <a href="[_2]">comment from [_3]</a>' => '[_1] hat auf den <a href="[_2]">Kommentar von [_3]</a> geantwortet</a>', # Translate - New # OK
	'Leave a comment' => 'Jetzt kommentieren',
	'Name' => 'Name',
	'Email Address' => 'E-Mail-Adresse',
	'Remember personal info?' => 'Persönliche Angaben speichern?',
	'(You may use HTML tags for style)' => '(HTML-Tags zur Textformatierung erlaubt)',

## default_templates/monthly_entry_listing.mtml

## default_templates/search_results.mtml
	'Search Results' => 'Suchergebnisse',
	'Results matching &ldquo;[_1]&rdquo;' => 'Suchergebnisse für &#8222;[_1]&#8221;', # Translate - Improved (3) # OK
	'Results tagged &ldquo;[_1]&rdquo;' => 'Mit &#8222;[_1]&#8221; getaggt', # Translate - Improved (3) # OK
	'Previous' => 'Zurück',
	'Next' => 'Vor',
	'No results found for &ldquo;[_1]&rdquo;.' => 'Keine Suchergebnisse für &#8222;[_1]&#8221; gefunden', # Translate - Improved (3) # OK
	'Instructions' => 'Anleitung',
	'By default, this search engine looks for all words in any order. To search for an exact phrase, enclose the phrase in quotes:' => 'Die Suchfunktion sucht nach allen angebenen Begriffen in beliebiger Reihenfolge. Um nach einem exakten Ausdruck zu suchen, setzen Sie diesen bitte in Anführungszeichen:',
	'movable type' => 'Movable Type',
	'The search engine also supports AND, OR, and NOT keywords to specify boolean expressions:' => 'Die boolschen Operatoren AND, OR und NOT werden unterstützt:',
	'personal OR publishing' => 'Schrank OR Schublade',
	'publishing NOT personal' => 'Regal NOT Schrank',

## default_templates/dynamic_error.mtml
	'Page Not Found' => 'Seite nicht gefunden',

## default_templates/comment_preview.mtml
	'Previewing your Comment' => 'Vorschau Ihres Kommentars',
	'Cancel' => 'Abbrechen',

## default_templates/powered_by.mtml
	'_MTCOM_URL' => 'http://www.movabletype.com/',

## default_templates/date_based_category_archives.mtml
	'Category Yearly Archives' => 'Jährliche Kategoriearchive',
	'Category Weekly Archives' => 'Wöchentliche Kategoriearchive',
	'Category Daily Archives' => 'Tägliche Kategoriearchive',

## default_templates/author_archive_list.mtml
	'Authors' => 'Autoren',

## default_templates/tag_cloud.mtml

## default_templates/recent_assets.mtml

## default_templates/search.mtml
	'Case sensitive' => 'Groß/Kleinschreibung beachten',
	'Regex search' => 'Reguläre Ausdrücke verwenden',

## default_templates/commenter_confirm.mtml
	'Thank you registering for an account to comment on [_1].' => 'Danke, daß Sie sich zum Kommentieren von [_1] registriert haben.',
	'For your own security and to prevent fraud, we ask that you please confirm your account and email address before continuing. Once confirmed you will immediately be allowed to comment on [_1].' => 'Zu Ihrer eigenen Sicherheit und zur Vermeidung von Mißbrauch bestätigen Sie bitte Ihre Anmeldung und Ihre E-Mail-Adresse.',
	'To confirm your account, please click on or cut and paste the following URL into a web browser:' => 'Klicken Sie dazu auf folgenden Link (oder kopieren Sie Adresse und fügen Sie sie in Adresszeile Ihres Web-Browsers ein):',
	'If you did not make this request, or you don\'t want to register for an account to comment on [_1], then no further action is required.' => 'Sollten Sie sich nicht angemeldet haben oder sollten Sie sich doch nicht registrieren wollen, brauchen Sie nichts weiter zu tun.',
	'Thank you very much for your understanding.' => 'Vielen Dank',
	'Sincerely,' => ' ',

## lib/MT/Asset/Image.pm
	'Images' => 'Bilder',
	'Actual Dimensions' => 'Ausgangsgröße',
	'[_1] x [_2] pixels' => '[_1] x [_2] Pixel',
	'Error cropping image: [_1]' => 'Beschnittfehler: [_1]',
	'Error scaling image: [_1]' => 'Skalierungsfehler: [_1]',
	'Error converting image: [_1]' => 'Konvertierungsfehler: [_1]',
	'Error creating thumbnail file: [_1]' => 'Fehler beim Erzeugen des Vorschaubilds: [_1]',
	'%f-thumb-%wx%h%x' => '%f-thumb-%wx%h%x',
	'Can\'t load image #[_1]' => 'Kann Bild #[_1] nicht laden',
	'View image' => 'Bild ansehen',
	'Permission denied setting image defaults for blog #[_1]' => 'Keine Benutzerrechte zur Änderung der Bild-Voreinstellungen für Weblog #[_1]',
	'Thumbnail image for [_1]' => 'Vorschaubild für [_1]',
	'Invalid basename \'[_1]\'' => 'Ungültiger Basisname \'[_1]\'',
	'Error writing to \'[_1]\': [_2]' => 'Fehler beim Speichern unter\'[_1]\': [_2]',
	'Popup Page for [_1]' => 'Popup-Seite für [_1]',

## lib/MT/Asset/Video.pm
	'Videos' => 'Videos',

## lib/MT/Asset/Audio.pm

## lib/MT/Bootstrap.pm
	'Got an error: [_1]' => 'Es ist ein Fehler aufgetreten: [_1]',

## lib/MT/Page.pm
	'Folder' => 'Ordner',
	'Load of blog failed: [_1]' => 'Das Weblog konnte nicht geladen werden: [_1]',

## lib/MT/BasicAuthor.pm
	'authors' => 'Autoren',

## lib/MT/Placement.pm
	'Category Placement' => 'Kategorie-Platzierung',

## lib/MT/TaskMgr.pm
	'Unable to secure lock for executing system tasks. Make sure your TempDir location ([_1]) is writable.' => 'Konnte Lock für Systemtask nicht setzen. Stellen Sie sicher, daß Schreibrechte für das temporäre Verzeichnis ([_1]) vorhanden sind.',
	'Error during task \'[_1]\': [_2]' => 'Fehler bei Ausführung des Tasks \'[_1]\': [_2]',
	'Scheduled Tasks Update' => 'Aktualisierung geplanter Aufgaben',
	'The following tasks were run:' => 'Folgende Tasks wurden ausgeführt:',

## lib/MT/Asset.pm
	'Asset' => 'Asset',
	'Assets' => 'Assets',
	'Description' => 'Beschreibung',
	'Location' => 'Ort',

## lib/MT/Category.pm
	'Category' => 'Kategorien',
	'Categories must exist within the same blog' => 'Kategorien müssen im gleichen Blog vorhanden sein',
	'Category loop detected' => 'Kategorieschleife festgestellt',

## lib/MT/Notification.pm
	'Contact' => 'Kontakt',
	'Contacts' => 'Kontakte',

## lib/MT/Session.pm
	'Session' => 'Sitzung',

## lib/MT/Image.pm
	'Perl module Image::Size is required to determine width and height of uploaded images.' => 'Das Perl-Modul Image::Size ist zur Bestimmung von Höhe und Breite hochgeladener Bilddateien erforderlich.',
	'File size exceeds maximum allowed: [_1] > [_2]' => 'Maximale Dateigröße überschritten: [_1] > [_2]',
	'Can\'t load Image::Magick: [_1]' => 'Image::Magick kann nicht geladen werden: [_1]',
	'Reading file \'[_1]\' failed: [_2]' => 'Datei \'[_1]\' kann nicht gelesen werden: [_2]',
	'Reading image failed: [_1]' => 'Bild kann nicht geladen werden: [_1]',
	'Scaling to [_1]x[_2] failed: [_3]' => 'Skalieren auf [_1]x[_2] fehlgeschlagen: [_3]',
	'Cropping a [_1]x[_1] square at [_2],[_3] failed: [_4]' => 'Quadratischer Beschnitt von [_1]x[_2] Pixeln ab [_2],[_3] fehlgeschlagen: [_4]',
	'Converting image to [_1] failed: [_2]' => 'Konvertierung des Fotos in [_1] fehlgeschlagen: [_2]',
	'Can\'t load IPC::Run: [_1]' => 'IPC::Run kann nicht geladen werden: [_1]',
	'Unsupported image file type: [_1]' => 'Nicht unterstütztes Bildformat: [_1]', # Translate - New # OK
	'Cropping to [_1]x[_1] failed: [_2]' => 'Beschneiden auf [_1]x[_1] fehlgeschlagen: [_2]',
	'Converting to [_1] failed: [_2]' => 'Konvertierung in [_1] fehlgeschlagen: [_2]',
	'You do not have a valid path to the NetPBM tools on your machine.' => 'Kein gültiger Pfad zu den NetPBM-Tools gefunden.',

## lib/MT/Trackback.pm
	'TrackBack' => 'TrackBack',
	'TrackBacks' => 'TrackBacks',

## lib/MT/Util/Archive/Tgz.pm
	'Type must be tgz.' => 'Typ muss .tgz sein.',
	'Could not read from filehandle.' => 'Dateihandle nicht lesbar.',
	'File [_1] is not a tgz file.' => '[_1] ist keine .tgz-Datei',
	'File [_1] exists; could not overwrite.' => '[_1] existiert bereits und konnte nicht überschrieben werden',
	'Can\'t extract from the object' => 'Kann aus Objekt nicht extrahieren',
	'Can\'t write to the object' => 'Kann Objekt nicht beschreiben',
	'Both data and file name must be specified.' => 'Sowohl der Daten- als auch der Dateiname müssen angegeben werden.',

## lib/MT/Util/Archive/Zip.pm
	'Type must be zip' => 'Typ muss .zip sein.',
	'File [_1] is not a zip file.' => '[_1] ist keine .zip-Datei',

## lib/MT/Util/Archive.pm
	'Type must be specified' => 'Typangabe erforderlich',
	'Registry could not be loaded' => 'Konnte Registry nicht laden',

## lib/MT/Util/Captcha.pm
	'Movable Type default CAPTCHA provider requires Image::Magick.' => 'Zur Nutzung der in Movable Type integrierten CAPTCHA-Quelle ist Image::Magick erforderlich.',
	'You need to configure CaptchaSourceImageBase.' => 'Bitte konfigurieren Sie CaptchaSourceImageBase',
	'Image creation failed.' => 'Bilderzeugung fehlgeschlagen.',
	'Image error: [_1]' => 'Bildfehler: [_1]',

## lib/MT/Upgrade.pm
	'Comment Posted' => 'Kommentar veröffentlicht',
	'Your comment has been posted!' => 'Ihr Kommentar wurde veröffentlicht!',
	'Comment Pending' => 'Kommentar noch nicht freigegeben',
	'Your comment submission failed for the following reasons:' => 'Ihr Kommentar konnte aus folgenden Gründen nicht abgeschickt werden:',
	'[_1]: [_2]' => '[_1]: [_2]',
	'Moving metadata storage for categories...' => 'Verschiebe Metadatenspeicher für Kategorien...', # Translate - New # OK
	'Upgrading metadata storage for [_1]' => 'Aktualisiere Metadatenspeicher für [_1]', # Translate - New # OK
	'Migrating Nofollow plugin settings...' => 'Migriere Nofollow-Einstellungen...',
	'Updating system search template records...' => 'Aktualisiere Suchvorlagen...',
	'Custom ([_1])' => 'Individuell ([_1])',
	'This role was generated by Movable Type upon upgrade.' => 'Diese Rolle wurde von Movable Type während eines Upgrades angelegt.',
	'Migrating permission records to new structure...' => 'Migriere Benutzerrechte in neue Struktur...',
	'Migrating role records to new structure...' => 'Migriere Rollen in neue Struktur...',
	'Migrating system level permissions to new structure...' => 'Migriere Systemberechtigungen in neue Struktur...',
	'Invalid upgrade function: [_1].' => 'Ungültige Upgrade-Funktion: [_1].',
	'Error loading class [_1].' => 'Fehler beim Laden der Klasse [_1].',
	'Creating initial blog and user records...' => 'Erzeuge erstes Blog und Benutzerkonten...',
	'Error saving record: [_1].' => 'Fehler beim Speichern eines Datensatzes: [_1].',
	'First Blog' => 'Erstes Blog',
	'I just finished installing Movable Type [_1]!' => 'Ich habe soeben Movable Type [_1] installiert!',
	'Welcome to my new blog powered by Movable Type. This is the first post on my blog and was created for me automatically when I finished the installation process. But that is ok, because I will soon be creating posts of my own!' => 'Willkommen zu meinem neuen Movable Type-Blog. Dieser Eintrag hier ist nur ein automatisch erzeugter Platzhalter, damit hier etwas steht, bis ich meine ersten eigenen Einträge geschrieben habe.',
	'Movable Type also created a comment for me as well so that I could see what a comment will look like on my blog once people start submitting comments on all the posts I will write.' => 'Ein Beispielkommentar wurde auch gleich angelegt, so daß man sehen kann, wie die Kommentare von Lesern dargestellt werden werden.',
	'Blog Administrator' => 'Blog-Administrator',
	'Can administer the blog.' => 'Kann das Blog verwalten',
	'Editor' => 'Editor',
	'Can upload files, edit all entries/categories/tags on a blog and publish the blog.' => 'Kann alle Einträge, Kategorien und Tags bearbeiten, Dateien hochladen und das Blog veröffentlichen',
	'Can create entries, edit their own, upload files and publish.' => 'Kann Einträge anlegen und veröffentlichen, eigene Einträge bearbeiten und Dateien hochladen',
	'Designer' => 'Designer',
	'Can edit, manage and publish blog templates.' => 'Kann Vorlagen bearbeiten, verwalten und veröffentlichen',
	'Webmaster' => 'Webmaster',
	'Can manage pages and publish blog templates.' => 'Kann Seiten verwalten und Vorlagen veröffentlichen',
	'Contributor' => 'Gastautor',
	'Can create entries, edit their own and comment.' => 'Kann Einträge anlegen, kommentieren und eigene Einträge bearbeiten',
	'Moderator' => 'Moderator',
	'Can comment and manage feedback.' => 'Kann kommentieren und Feedback verwalten',
	'Commenter' => 'Kommentarautor',
	'Can comment.' => 'Kann kommentieren',
	'Removing Dynamic Site Bootstrapper index template...' => 'Entferne Indexvorlage des Dynamic Site Bootstrappers...',
	'Creating new template: \'[_1]\'.' => 'Erzeuge neue Vorlage: \'[_1]\'',
	'Mapping templates to blog archive types...' => 'Verknüpfe Vorlagen mit Archiven...',
	'Renaming PHP plugin file names...' => 'Ändere PHP-Plugin-Dateinamen...',
	'Error renaming PHP files. Please check the Activity Log.' => 'Fehler beim Umbenennen von PHP-Datei. Bitte überprüfen Sie das Aktivitätsprotokoll.',
	'Cannot rename in [_1]: [_2].' => 'Kann [_1] nicht in [_2] umbenennen.',
	'Updating widget template records...' => 'Aktualisiere Widgetvorlagen...',
	'Removing unnecessary indexes...' => 'Entferne nicht verwendete Indizes...', # Translate - New # OK
	'Upgrading table for [_1] records...' => 'Aktualisiere Tabelle für [_1]-Einträge...',
	'Upgrading database from version [_1].' => 'Aktualisiere Datenbank von Version [_1].',
	'Database has been upgraded to version [_1].' => 'Datenbank auf Movable Type-Version [_1] aktualisiert',
	'User \'[_1]\' upgraded database to version [_2]' => 'Benutzer \'[_1]\' hat ein Upgrade auf Version [_2] durchgeführt',
	'Plugin \'[_1]\' upgraded successfully to version [_2] (schema version [_3]).' => 'Plugin \'[_1]\' erfolgreich auf Version [_2] (Schemaversion [_3]) aktualisiert',
	'User \'[_1]\' upgraded plugin \'[_2]\' to version [_3] (schema version [_4]).' => 'Benutzer \'[_1]\' hat für Plugin \'[_2]\' ein Upgrade auf Version [_3] (Schemaversion [_4]) durchgeführt',
	'Plugin \'[_1]\' installed successfully.' => 'Plugin \'[_1]\' erfolgreich installiert',
	'User \'[_1]\' installed plugin \'[_2]\', version [_3] (schema version [_4]).' => 'Benutzer \'[_1]\' hat Plugin \'[_2]\' mit Version [_3] (Schema version [_4]) installiert',
	'Setting your permissions to administrator.' => 'Setze Benutzerrechte auf \'Administrator\'...',
	'Comment Response' => 'Kommentarantworten',
	'Creating configuration record.' => 'Erzeuge Konfigurationseinträge...',
	'Creating template maps...' => 'Verknüpfe Vorlagen...',
	'Mapping template ID [_1] to [_2] ([_3]).' => 'Verknüpfe Vorlage [_1] mit [_2] ([_3])',
	'Mapping template ID [_1] to [_2].' => 'Verknüpfe Vorlage [_1] mit [_2]',
	'Error loading class: [_1].' => 'Fehler beim Laden einer Klasse: [_1]',
	'Error saving [_1] record # [_3]: [_2]... [_4].' => 'Fehler beim Speichern eines Datensatzes (#[_3], [_1]): [_2]... [_4].',
	'Creating entry category placements...' => 'Lege Kategoriezuweisungen an...',
	'Updating category placements...' => 'Aktualisiere Kategorieanordnung...',
	'Assigning comment/moderation settings...' => 'Weise Kommentierungseinstellungen zu...',
	'Setting blog basename limits...' => 'Setze Basisnamen-Limits...',
	'Setting default blog file extension...' => 'Setze Standard-Dateierweitung...',
	'Updating comment status flags...' => 'Aktualisiere Kommentarstatus...',
	'Updating commenter records...' => 'Aktualisiere Kommentarautoren-Datensätze...',
	'Assigning blog administration permissions...' => 'Weise Administrationsrechte zu...',
	'Setting blog allow pings status...' => 'Weise Ping-Status zu...',
	'Updating blog comment email requirements...' => 'Aktualisiere E-Mail-Einstellungen der Kommentarfunktion...',
	'Assigning entry basenames for old entries...' => 'Weise Alteinträgen Basisnamen zu...',
	'Updating user web services passwords...' => 'Aktualisierte Passwörter für Webdienste...',
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
	'Assigning junk status for comments...' => 'Setze Junkstatus der Kommentare...',
	'Assigning visible status for TrackBacks...' => 'Setzte Sichtbarkeitsstatus für TrackBacks...',
	'Assigning junk status for TrackBacks...' => 'Setze Junkstatus der TrackBacks...',
	'Assigning basename for categories...' => 'Weise Kategorien Basisnamen zu...',
	'Assigning user status...' => 'Weise Benuzerstatus zu...',
	'Migrating permissions to roles...' => 'Migriere Berechtigung auf Rollen...',
	'Populating authored and published dates for entries...' => 'Übernehme Zeitstempel für Einträge...',
	'Classifying category records...' => 'Klassifiziere Kategoriedaten...',
	'Classifying entry records...' => 'Klassifizere Eintragsdaten...',
	'Merging comment system templates...' => 'Führe Kommentierungsvorlagen zusammen...',
	'Populating default file template for templatemaps...' => 'Lege Standardvorlagen für Vorlagenzuweisungen fest...',
	'Removing unused template maps...' => 'Entferne nicht benötigte Vorlagenzuweisungen',
	'Assigning user authentication type...' => 'Weise Art der Benutzerauthentifizierung zu...',
	'Adding new feature widget to dashboard...' => 'Füge "Neue Features"-Widget zum Übersichtsseite hinzu...',
	'Moving OpenID usernames to external_id fields...' => 'Setze OpenID-Benutzernamen als external_id-Felder...',
	'Assigning blog template set...' => 'Weise Vorlagengruppe zu...',
	'Assigning blog page layout...' => 'Weise Blog-Seitenlayout zu...',
	'Assigning author basename...' => 'Weise Autoren-Basisnamen zu...', # Translate - New # OK
	'Assigning entry comment and TrackBack counts...' => 'Weise Kommentar- und TrackBack-Zahlen zu...', # Translate - New # OK
	'Assigning embedded flag to asset placements...' => 'Weise Embedded-Flag an Asset-Platzierungen zu...', # Translate - New # OK
	'Replacing %C format to MTCategoryLabel...' => 'Ersetze %C-Format bei MTCategoryLabel...', # Translate - New # OK

## lib/MT/Core.pm
	'System Administrator' => 'System verwalten',
	'Create Blogs' => 'Blogs anlegen',
	'Manage Plugins' => 'Plugins verwalten',
	'Manage Templates' => 'Vorlagen verwalten',
	'View System Activity Log' => 'Systemaktivitätsprotokoll einsehen',
	'Configure Blog' => 'Blog konfigurieren',
	'Set Publishing Paths' => 'Veröffentlichungspfade setzen',
	'Manage Categories' => 'Kategorien verwalten',
	'Manage Tags' => 'Tags verwalten',
	'Manage Address Book' => 'Adressbuch verwalten',
	'View Activity Log' => 'Aktivitätsprotokoll ansehen',
	'Create Entries' => 'Neuer Eintrag',
	'Publish Entries' => 'Einträge veröffentlichen',
	'Send Notifications' => 'Benachrichtigungen versenden',
	'Edit All Entries' => 'Alle Einträge bearbeiten',
	'Manage Pages' => 'Seiten verwalten',
	'Publish Blog' => 'Blog veröffentlichen',
	'Upload File' => 'Datei hochladen',
	'Save Image Defaults' => 'Bild-Voreinstellungen speichern',
	'Manage Assets' => 'Assets verwalten',
	'Post Comments' => 'Kommentare schreiben',
	'Manage Feedback' => 'Feedback verwalten',
	'Error creating performance logs directory, [_1]. Please either change the permissions to make it writable or specify an alternate using the PerformanceLoggingPath configuration directive: [_2]' => 'Beim Anlegen des Leistungsprotrokolls-Verzeichnis ist ein Fehler aufgetreten - [_1]. Bitte vergeben Sie entweder Schreibrechte für das Verzeichnis oder geben Sie mittels PerformanceLoggingPath ein anderes an: [_2]', # Translate - New # OK
	'Error creating performance logs: PerformanceLoggingPath setting must be a directory path, not a file: [_1]' => 'Beim Anlegen des Leistungsprotrokolls ist ein Fehler aufgetreten: PerformanceLoggingPath muss auf ein Verzeichnis, nicht auf eine Datei zeigen', # Translate - New # OK
	'Error creating performance logs: PerformanceLoggingPath directory exists but is not writeable: [_1]' => 'Beim Anlegen des Leistungsprotrokolls ist ein Fehler aufgetreten: das PerformanceLoggingPath-Verzeichnis ist vorhanden, kann aber nicht beschrieben werden - [_1]', # Translate - New # OK
	'MySQL Database' => 'MySQL-Datenbank',
	'PostgreSQL Database' => 'PostgreSQL-Datenbank',
	'SQLite Database' => 'SQLite-Datenbank',
	'SQLite Database (v2)' => 'SQLite-Datenbank (v2)',
	'Convert Line Breaks' => 'Zeilenumbrüche konvertieren',
	'Rich Text' => 'Grafischer Editor',
	'Movable Type Default' => 'Movable Type-Standard',
	'weblogs.com' => 'weblogs.com',
	'technorati.com' => 'technorati.com',
	'google.com' => 'google.com',
	'Classic Blog' => 'Klassisches Blog',
	'Publishes content.' => 'Veröffentlicht Inhalte.',
	'Synchronizes content to other server(s).' => 'Synchronisiert Inhalte mit anderen Servern.',
	'zip' => 'ZIP',
	'tar.gz' => 'tar.gz',
	'Entries List' => 'Eintragsliste',
	'Blog URL' => 'Blog-URL',
	'Blog ID' => 'Blog-ID',
	'Blog Name' => 'Name des Blogs',
	'Entry Body' => 'Eintragstext',
	'Entry Excerpt' => 'Eintragsauszug',
	'Entry Link' => 'Eintragslink',
	'Entry Extended Text' => 'Erweiterter Text',
	'Entry Title' => 'Eintragstitel',
	'If Block' => 'If-Block',
	'If/Else Block' => 'If-Else-Block',
	'Include Template Module' => 'Include-Vorlagenmodul',
	'Include Template File' => 'Include-Vorlagendatei',
	'Get Variable' => 'Variable lesen',
	'Set Variable' => 'Variable setzen',
	'Set Variable Block' => 'Variablenblock setzen',
	'Widget Set' => 'Widgetgruppe',
	'Publish Scheduled Entries' => 'Zeitgeplante Einträge veröffentlichen',
	'Junk Folder Expiration' => 'Junk-Ordner-Einstellungen',
	'Remove Temporary Files' => 'Temporäre Dateien löschen',
	'Remove Expired User Sessions' => 'Abgelaufene Sessions löschen',

## lib/MT/ArchiveType/AuthorMonthly.pm
	'AUTHOR-MONTHLY_ADV' => 'monatliche Autorenarchive',
	'author/author-display-name/yyyy/mm/index.html' => 'autor/anzeigename-des-autors/jjjj/mm/index.html', # Translate - New # OK
	'author/author_display_name/yyyy/mm/index.html' => 'autor/anzeigename_des_autors/jjjj/mm/index.html', # Translate - New # OK

## lib/MT/ArchiveType/Yearly.pm
	'YEARLY_ADV' => 'Jahresarchive',
	'yyyy/index.html' => 'jjjj/index.html',

## lib/MT/ArchiveType/Page.pm
	'PAGE_ADV' => 'Seitenarchive',
	'folder-path/page-basename.html' => 'Ordner-Pfad/Seiten-Name.html',
	'folder-path/page-basename/index.html' => 'Ordner-Pfad/Seiten-Name/index.html',
	'folder_path/page_basename.html' => 'Ordner_Pfad/Seiten_Name.html',
	'folder_path/page_basename/index.html' => 'Ordner_Pfad/Seiten_Name/index.html',

## lib/MT/ArchiveType/Category.pm
	'CATEGORY_ADV' => 'Kategoriearchive',
	'category/sub-category/index.html' => 'Kategorie/Unter-Kategorie/index.html',
	'category/sub_category/index.html' => 'Kategorie/Unter_Kategorie/index.html',

## lib/MT/ArchiveType/CategoryMonthly.pm
	'CATEGORY-MONTHLY_ADV' => 'monatliche Kategoriearchive',
	'category/sub-category/yyyy/mm/index.html' => 'kategorie/unter-kategorie/jjjj/mm/index.html',
	'category/sub_category/yyyy/mm/index.html' => 'kategorie/unter_kategorie/jjjj/mm/index.html',

## lib/MT/ArchiveType/AuthorWeekly.pm
	'AUTHOR-WEEKLY_ADV' => 'wöchentliche Autorenarchive',
	'author/author-display-name/yyyy/mm/day-week/index.html' => 'autor/anzeigename-des-autors/jjjj/mm/tag-woche/index.html', # Translate - New # OK
	'author/author_display_name/yyyy/mm/day-week/index.html' => 'autor/anzeigename_des_autors/jjjj/mm/tag-woche/index.html', # Translate - New # OK

## lib/MT/ArchiveType/AuthorDaily.pm
	'AUTHOR-DAILY_ADV' => 'tägliche Autorenarchive',
	'author-display-name/yyyy/mm/dd/index.html' => 'benutzer-name/jjjj/mm/tt/index.html',
	'author_display_name/yyyy/mm/dd/index.html' => 'benutzer_name/jjjj/mm/tt/index.html',

## lib/MT/ArchiveType/Individual.pm
	'INDIVIDUAL_ADV' => 'Einzelarchive',
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

## lib/MT/ArchiveType/CategoryWeekly.pm
	'CATEGORY-WEEKLY_ADV' => 'wöchentliche Kategoriearchive',
	'category/sub-category/yyyy/mm/day-week/index.html' => 'kategorie/unter-kategorie/jjjj/mm/tag-woche/index.html',
	'category/sub_category/yyyy/mm/day-week/index.html' => 'kategorie/unter_kategorie/jjjj/mm/tag-woche/index.html',

## lib/MT/ArchiveType/AuthorYearly.pm
	'AUTHOR-YEARLY_ADV' => 'jährliche Autorenarchive',
	'author/author-display-name/yyyy/index.html' => 'autor/anzeigename-des-autors/jjjj/index.html', # Translate - New # OK
	'author/author_display_name/yyyy/index.html' => 'autor/anzeigename_des_autors/jjjj/index.html', # Translate - New # OK

## lib/MT/ArchiveType/Monthly.pm
	'MONTHLY_ADV' => 'Monatsarchive',
	'yyyy/mm/index.html' => 'jjjj/mm/index.html',

## lib/MT/ArchiveType/CategoryDaily.pm
	'CATEGORY-DAILY_ADV' => 'tägliche Kategoriearchive',
	'category/sub-category/yyyy/mm/dd/index.html' => 'kategorie/unter-kategorie/jjjj/mm/tt/index.html',
	'category/sub_category/yyyy/mm/dd/index.html' => 'kategorie/unter_kategorie/jjjj/mm/tt/index.html',

## lib/MT/ArchiveType/Weekly.pm
	'WEEKLY_ADV' => 'Wochenarchive',
	'yyyy/mm/day-week/index.html' => 'jjjj/mm/Tag-Woche/index.html',

## lib/MT/ArchiveType/Author.pm
	'AUTHOR_ADV' => 'Autorenarchive',
	'Author (#[_1])' => 'Autor (#[_1])',
	'author/author-display-name/index.html' => 'autor/anzeigename-des-autors/index.html', # Translate - New # OK
	'author/author_display_name/index.html' => 'autor/anzeigename_des_autors/index.html', # Translate - New # OK

## lib/MT/ArchiveType/Daily.pm
	'DAILY_ADV' => 'Tagesarchive',
	'yyyy/mm/dd/index.html' => 'jjjj/mm/tt/index.html',

## lib/MT/ArchiveType/CategoryYearly.pm
	'CATEGORY-YEARLY_ADV' => 'jährliche Kategoriearchive',
	'category/sub-category/yyyy/index.html' => 'kategorie/unter-kategorie/jjjj/index.html',
	'category/sub_category/yyyy/index.html' => 'kategorie/unter_kategorie/jjjj/index.html',

## lib/MT/ObjectTag.pm
	'Tag Placement' => 'Tag-Platzierung',
	'Tag Placements' => 'Tag-Platzierungen',

## lib/MT/Author.pm
	'User' => 'Benutzer',
	'Users' => 'Benutzer',
	'The approval could not be committed: [_1]' => 'Freigabe Konnte nicht übernommen werden: [_1]',

## lib/MT/ObjectAsset.pm
	'Asset Placement' => 'Asset-Platzierung',

## lib/MT/XMLRPC.pm
	'No WeblogsPingURL defined in the configuration file' => 'Keine WeblogsPingURL in der Konfigurationsdatei definiert',
	'No MTPingURL defined in the configuration file' => 'Keine MTPingURL in der Konfigurationsdatei definiert',
	'Can\'t load blog #[_1].' => 'Kann Blog #[_1] nicht laden.',
	'HTTP error: [_1]' => 'HTTP-Fehler: [_1]',
	'Ping error: [_1]' => 'Ping-Fehler: [_1]',

## lib/MT/Association.pm
	'Association' => 'Verknüpfung',
	'Associations' => 'Verknüpfungen',
	'association' => 'Verknüpfungen',
	'associations' => 'Verknüpfungen',

## lib/MT/ConfigMgr.pm
	'Alias for [_1] is looping in the configuration.' => 'Alias für [_1] bildet eine Schleife.',
	'Error opening file \'[_1]\': [_2]' => 'Fehler beim Öffnen der Datei \'[_1]\': [_2]',
	'Config directive [_1] without value at [_2] line [_3]' => 'Konfigurationsanweisung [_1] ohne Wert [_2] in Zeile [_3]',
	'No such config variable \'[_1]\'' => 'Konfigurationsvariable \'[_1]\' nicht vorhanden',

## lib/MT/BackupRestore.pm
	'Backing up [_1] records:' => 'Sichere [_1]-Einträge:',
	'[_1] records backed up...' => '[_1] Einträge gesichert...',
	'[_1] records backed up.' => '[_1] Einträge gesichert',
	'There were no [_1] records to be backed up.' => 'Keine [_1]-Einträge zu sichern',
	'Can\'t open directory \'[_1]\': [_2]' => 'Kann Verzeichnis \'[_1]\' nicht öffnen: [_2]',
	'No manifest file could be found in your import directory [_1].' => 'Keine Manifest-Datei im Importverzeichnis [_1] gefunden.',
	'Can\'t open [_1].' => 'Kann [_1] nicht öffnen.',
	'Manifest file [_1] was not a valid Movable Type backup manifest file.' => 'Manifest-Datei [_1] ist keine gültige Movable Type Backup-Manifest-Datei.',
	'Manifest file: [_1]' => 'Manifest-Datei: [_1]',
	'Path was not found for the file ([_1]).' => 'Pfad zu Datei ([_1]) nicht gefunden.',
	'[_1] is not writable.' => 'Kein Schreibzugriff auf [_1]',
	'Error making path \'[_1]\': [_2]' => 'Fehler beim Anlegen des Ordners \'[_1]\': [_2]',
	'Copying [_1] to [_2]...' => 'Kopiere [_1] nach [_2]...',
	'Failed: ' => 'Fehler: ',
	'Done.' => 'Fertig.',
	'Restoring asset associations ... ( [_1] )' => 'Stelle Asset-Zuweisungen wieder her... ( [_1] )',
	'Restoring asset associations in entry ... ( [_1] )' => 'Stelle Asset-Zuweisungen in Eintrag wieder her... ( [_1] )',
	'Restoring asset associations in page ... ( [_1] )' => 'Stelle Asset-Zuweisungen in Seite wieder her ... ( [_1] )',
	'Restoring url of the assets ( [_1] )...' => 'Stelle Asset-URLs wieder her... ( [_1] )',
	'Restoring url of the assets in entry ( [_1] )...' => 'Stelle Asset-URLs in Eintrag wieder her... ( [_1] )',
	'Restoring url of the assets in page ( [_1] )...' => 'Stelle Asset-URLs in Seite wieder her ... ( [_1] )',
	'ID for the file was not set.' => 'ID für Datei nicht gesetzt.',
	'The file ([_1]) was not restored.' => 'Datei ([_1]) nicht wiederhergestellt.',
	'Changing path for the file \'[_1]\' (ID:[_2])...' => 'Ändere Pfad für Datei \'[_1]\' (ID:[_2])....',
	'failed' => 'Fehlgeschlagen',
	'ok' => 'OK',

## lib/MT/TemplateMap.pm
	'Archive Mapping' => 'Archiv-Verknüpfung',
	'Archive Mappings' => 'Archiv-Verknüpfungen',

## lib/MT/Plugin/JunkFilter.pm
	'[_1]: [_2][_3] from rule [_4][_5]' => '[_1]: [_2][_3] aus Regel [_4][_5]',
	'[_1]: [_2][_3] from test [_4]' => '[_1]: [_2][_3] aus Test [_4]',

## lib/MT/Auth/TypeKey.pm
	'Sign in requires a secure signature.' => 'Die Anmeldung erfordert eine sichere Signatur.',
	'The sign-in validation failed.' => 'Bei der Bestätigung der Anmeldung ist ein Fehler aufgetreten.',
	'This weblog requires commenters to pass an email address. If you\'d like to do so you may log in again, and give the authentication service permission to pass your email address.' => 'Kommentarautoren müssen eine E-Mail-Adresse angeben. Wenn Sie das tun möchten, melden Sie sich an und erlauben Sie dem Authentifizierungsdienst, Ihre E-Mail-Adresse weiterzuleiten.',
	'Couldn\'t save the session' => 'Session konnte nicht gespeichert werden',
	'This blog requires commenters to provide an email address' => 'In diesem Blog muss zum Kommentieren eine E-Mail-Adresse angegeben werden.',
	'Couldn\'t get public key from url provided' => 'Public Key konnte von der angegebenen Adresse nicht gelesen werden',
	'No public key could be found to validate registration.' => 'Kein Public Key zur Validierung gefunden.',
	'TypeKey signature verif\'n returned [_1] in [_2] seconds verifying [_3] with [_4]' => 'TypeKey-Signaturbestätigung gab [_1] zurück (nach [_2] Sekunden) und bestätigte [_3] mit [_4]',
	'The TypeKey signature is out of date ([_1] seconds old). Ensure that your server\'s clock is correct' => 'Die TypeKey-Signatur ist veraltet ([_1] seconds old). Stellen Sie sicher, daß die Uhr Ihres Servers richtig geht.',

## lib/MT/Auth/MT.pm
	'Passwords do not match.' => 'Passwörter stimmen nicht überein.',
	'Failed to verify current password.' => 'Kann Passwort nicht überprüfen.',
	'Password hint is required.' => 'Passwort-Erinnerungssatz erforderlich.',

## lib/MT/Auth/OpenID.pm
	'Invalid request.' => 'Ungültige Anfrage.',
	'The address entered does not appear to be an OpenID' => 'Die eingegebene Adresse scheint keine OpenID zu sein',
	'The text entered does not appear to be a web address' => 'Der eingegebene Text scheint keine Webadresse zu sein',
	'Unable to connect to [_1]: [_2]' => 'Es konnte keine Verbindung zu [_1] hergestellt werden: [_2]',
	'Could not verify the OpenID provided: [_1]' => 'Die angegebene OpenID konnte nicht verifiziert werden: [_1]',

## lib/MT/Blog.pm
	'Blogs' => 'Blogs',
	'No default templates were found.' => 'Keine Standardvorlagen gefunden.',
	'Cloned blog... new id is [_1].' => 'Blog geklont... Die neue ID lautet: [_1]',
	'Cloning permissions for blog:' => 'Klone Berechtigungen für Webblog:',
	'[_1] records processed...' => '[_1] Einträge bearbeitet...',
	'[_1] records processed.' => '[_1] Einträge bearbeitet.',
	'Cloning associations for blog:' => 'Klone Verknüpfungen für Weblog:',
	'Cloning entries and pages for blog...' => 'Klone Einträge und Seiten für Weblog...', # Translate - New # OK
	'Cloning categories for blog...' => 'Klone Kategorien für Weblog...',
	'Cloning entry placements for blog...' => 'Klone Eintragsplatzierung für Weblog...',
	'Cloning comments for blog...' => 'Klone Kommentare für Weblog...',
	'Cloning entry tags for blog...' => 'Klone Tags für Weblog...',
	'Cloning TrackBacks for blog...' => 'Klone TrackBacks für Weblog...',
	'Cloning TrackBack pings for blog...' => 'Klone TrackBack-Pings für Weblog...',
	'Cloning templates for blog...' => 'Klone Vorlagen für Weblog...',
	'Cloning template maps for blog...' => 'Klone Vorlagenzuweisungen für Weblog...',
	'blog' => 'Blog',
	'blogs' => 'Blogs',

## lib/MT/TheSchwartz/ExitStatus.pm
	'Job Exit Status' => 'Job-Zielstatus',

## lib/MT/TheSchwartz/FuncMap.pm
	'Job Function' => 'Job-Funktion',

## lib/MT/TheSchwartz/Error.pm
	'Job Error' => 'Job-Fehler',

## lib/MT/TheSchwartz/Job.pm
	'Job' => 'Job',

## lib/MT/TBPing.pm
	'Load of blog \'[_1]\' failed: [_2]' => 'Das Weblog \'[_1]\' konnte nicht geladen werden: [_2]',

## lib/MT/Builder.pm
	'<[_1]> at line [_2] is unrecognized.' => '<[_1]> in Zeile [_2] nicht erkannt.',
	'<[_1]> with no </[_1]> on line #' => '<[_1]> ohne </[_1]> in Zeile #',
	'<[_1]> with no </[_1]> on line [_2].' => '<[_1]> ohne </[_1]> in Zeile [_2].',
	'<[_1]> with no </[_1]> on line [_2]' => '<[_1]> ohne  </[_1]> in Zeile[_2]',
	'Error in <mt[_1]> tag: [_2]' => 'Fehler im Vorlagenbefehl <mt[_1]>: [_2]', # Translate - New # OK
	'Unknown tag found: [_1]' => 'Unbekannter Vorlagenbefehl gefunden: [_1]',

## lib/MT/ObjectDriver/Driver/DBD/SQLite.pm
	'Can\'t open \'[_1]\': [_2]' => 'Kann \'[_1]\' nicht öffnen: [_2]',

## lib/MT/CMS/AddressBook.pm
	'No permissions.' => 'Keine Berechtigung..',
	'No entry ID provided' => 'Keine Eintrags-ID angegeben',
	'No such entry \'[_1]\'' => 'Kein Eintrag \'[_1]\'',
	'No email address for user \'[_1]\'' => 'Keine E-Mail-Addresse für Benutzer \'[_1]\'',
	'No valid recipients found for the entry notification.' => 'Keine gültigen Empfänger für Benachrichtigungen gefunden.',
	'[_1] Update: [_2]' => '[_1] Update: [_2]',
	'Error sending mail ([_1]); try another MailTransfer setting?' => 'Mailversand fehlgeschlagen([_1]). Überprüfen Sie die MailTransfer-Einstellungen.',
	'Please select a blog.' => 'Bitte wählen Sie ein Blog',
	'Permission denied.' => 'Keine Berechtigung.',
	'The value you entered was not a valid email address' => 'E-Mail-Adresse ungültig',
	'The e-mail address you entered is already on the Notification List for this blog.' => 'Die angegebene E-Mail-Adresse befindet sich bereits auf der Benachrichtigungsliste für dieses Weblog.',
	'Subscriber \'[_1]\' (ID:[_2]) deleted from address book by \'[_3]\'' => 'Abonnent \'[_1]\' (ID: [_2]) von \'[_3]\' aus Adressbuch gelöscht',

## lib/MT/CMS/Template.pm
	'index' => 'Index',
	'archive' => 'Archiv',
	'module' => 'Modul',
	'widget' => 'Widget',
	'email' => 'E-Mail',
	'system' => 'System',
	'Templates' => 'Vorlagen',
	'One or more errors were found in this template.' => 'Die Vorlage enthält einen oder mehrere Fehler',
	'Create template requires type' => 'Zum Anlegen einer Vorlage muss deren gewünschter Typ angegeben werden.',
	'Archive' => 'Archiv',
	'Entry or Page' => 'Eintrag oder Seite',
	'New Template' => 'Neuer Vorlage',
	'Index Templates' => 'Index-Vorlagen',
	'Archive Templates' => 'Archiv-Vorlagen',
	'Template Modules' => 'Vorlagenmodule',
	'System Templates' => 'System-Vorlagen',
	'Email Templates' => 'E-Mail-Vorlagen', # Translate - New # OK
	'Template Backups' => 'Vorlagen-Sicherungen', # Translate - New # OK
	'Can\'t locate host template to preview module/widget.' => 'Kann Host-Vorlage für Vorschaumodul/Vorschauwidget nicht finden.', # Translate - New # OK
	'Publish error: [_1]' => 'Fehler bei der Veröffentlichung: [_1]',
	'Unable to create preview file in this location: [_1]' => 'Kann Vorschaudatei in [_1] nicht erzeugen.',
	'Lorem ipsum' => 'Lorem ipsum', # Translate - New # OK
	'LOREM_IPSUM_TEXT' => 'LOREM_IPSUM_TEXT', # Translate - New # OK
	'LORE_IPSUM_TEXT_MORE' => 'LOREM_IPSUM_TEXT_MORE', # Translate - New # OK
	'sample, entry, preview' => 'Beispiel, Eintrag, Vorschau', # Translate - New # OK
	'No permissions' => 'Keine Berechtigung',
	'Populating blog with default templates failed: [_1]' => 'Standardvorlagen konnten nicht geladen werden: [_1]',
	'Setting up mappings failed: [_1]' => 'Die Verknüpfung konnte nicht angelegt werden: [_1]',
	'Saving map failed: [_1]' => 'Die Verknüpfung konnte nicht gespeichert werden: [_1]',
	'You should not be able to enter 0 as the time.' => '0 sollte nicht als Zeit eingegeben werden können.', # Translate - New # OK
	'You must select at least one event checkbox.' => 'Bitte wählen Sie mindestens ein Ereignis-Auswahlkästchen an', # Translate - New # OK
	'Template \'[_1]\' (ID:[_2]) created by \'[_3]\'' => 'Vorlage \'[_1]\' (ID:[_2]) angelegt von \'[_3]\'',
	'Template \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Vorlage \'[_1]\' (ID:[_2]) gelöscht von \'[_3]\'',
	'No Name' => 'Kein Name',
	'Orphaned' => 'Verwaist',
	'Global Templates' => 'Globale Vorlagen',
	' (Backup from [_1])' => '(Sicherung von [_1])',
	'Error creating new template: ' => 'Fehler beim Anlegen der neuen Vorlage',
	'Skipping template \'[_1]\' since it appears to be a custom template.' => 'Überspringe Vorlage \'[_1]\', da es ein Custom Template zu sein scheint.',
	'Refreshing template <strong>[_3]</strong> with <a href="?__mode=view&amp;blog_id=[_1]&amp;_type=template&amp;id=[_2]">backup</a>' => 'Baue Vorlage <strong>[_3]</strong> mit <a href="?__mode=view&amp;blog_id=[_1]&amp;_type=template&amp;id=[_2]">Backup</a> neu auf.',
	'Skipping template \'[_1]\' since it has not been changed.' => 'Überspringe Vorlage \'[_1]\', da sie unverändert ist...',
	'Copy of [_1]' => 'Kopie von [_1]', # Translate - New # OK
	'Permission denied: [_1]' => 'Zugriff verweigert: [_1]',
	'Save failed: [_1]' => 'Speichern fehlgeschlagen: [_1]',
	'Invalid ID [_1]' => 'Ungültige ID [_1]', # Translate - New # OK
	'Saving object failed: [_1]' => 'Das Objekt konnte nicht gespeichert werden: [_1]',
	'Load failed: [_1]' => 'Laden fehlgeschlagen: [_1]',
	'(no reason given)' => '(unbekannte Ursache)',
	'Removing [_1] failed: [_2]' => '[_1] konnte nicht entfernt werden: [_2]',
	'template' => 'Vorlage',
	'Restoring widget set [_1]... ' => 'Stelle Widgetgruppe [_1] wieder her...', # Translate - New # OK
	'Failed.' => 'Fehlgeschlagen.', # Translate - New # OK

## lib/MT/CMS/Search.pm
	'No [_1] were found that match the given criteria.' => 'Keine den Kriterien entsprechenden [_1] gefunden.',
	'Extended Entry' => 'Erweiterter Eintrag',
	'Keywords' => 'Schlüsselwörter',
	'Basename' => 'Basisname',
	'Comment Text' => 'Kommentartext',
	'IP Address' => 'IP-Adresse',
	'Source URL' => 'Quell-URL',
	'Page Body' => 'Seitenkörper',
	'Extended Page' => 'Erweiterte Seite',
	'Template Name' => 'Vorlagenname',
	'Text' => 'Text',
	'Linked Filename' => 'Verlinkter Dateiname',
	'Output Filename' => 'Ausgabe-Dateiname',
	'Filename' => 'Dateiname',
	'Label' => 'Bezeichnung',
	'Log Message' => 'Eintrag',
	'Username' => 'Benutzername',
	'Display Name' => 'Angezeigter Name',
	'Site URL' => 'Webadresse (URL)',
	'Site Root' => 'Wurzelverzeichnis',
	'Search & Replace' => 'Suchen & Ersetzen',
	'Invalid date(s) specified for date range.' => 'Ungültige Datumsangabe',
	'Error in search expression: [_1]' => 'Fehler im Suchausdruck: [_1]',
	'Saving object failed: [_2]' => 'Das Objekt konnte nicht gespeichert werden: [_2]',

## lib/MT/CMS/Import.pm
	'Import/Export' => 'Import/Export',
	'You do not have import permissions' => 'Keine Import-Rechte',
	'You do not have permission to create users' => 'Keine Rechte zum Anlegen neuer Benutzer',
	'You need to provide a password if you are going to create new users for each user listed in your blog.' => 'Sollen für die Benutzer Ihres Blogs neue Benutzerkonten angelegt werden, müssen Sie ein Passwort angeben.',
	'Importer type [_1] was not found.' => 'Import-Typ [_1] nicht gefunden.',

## lib/MT/CMS/Folder.pm
	'The folder \'[_1]\' conflicts with another folder. Folders with the same parent must have unique basenames.' => 'Der Ordner \'[_1]\' steht im Konflikt mit einem anderen Ordner. Ordner im gleichen Unterordner müssen unterschiedliche Basisnamen haben.',
	'Folder \'[_1]\' created by \'[_2]\'' => 'Ordner \'[_1]\' angelegt von \'[_2]\'',
	'The name \'[_1]\' is too long!' => 'Der Name \'[_1]\' ist zu lang!',
	'Folder \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Ordner \'[_1]\' (ID:[_2]) gelöscht von \'[_3]\'',

## lib/MT/CMS/Tag.pm
	'Invalid type' => 'Ungültiger Typ',
	'New name of the tag must be specified.' => 'Neuer Tagname erforderlich',
	'No such tag' => 'Kein solcher Tag',
	'Error saving entry: [_1]' => 'Der Eintrag konnte nicht gespeichert werden: [_1]',
	'Error saving file: [_1]' => 'Fehler beim Speichern der Datei: [_1]',
	'Tag \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Tag \'[_1]\' (ID:[_2]) gelöscht von \'[_3]\'',
	'Entries' => 'Einträge',

## lib/MT/CMS/Category.pm
	'Subfolder' => 'Unterordner',
	'Subcategory' => 'Unterkategorie',
	'Saving [_1] failed: [_2]' => '[_1] konnte nicht gespeichert werden: [_2]',
	'The [_1] must be given a name!' => '[_1] muss einen Namen erhalten!',
	'Add a [_1]' => '[_1] hinzufügen',
	'No label' => 'Keine Bezeichnung',
	'Category name cannot be blank.' => 'Die Bezeichnung einer Kategorie darf nicht leer sein.',
	'The category name \'[_1]\' conflicts with another category. Top-level categories and sub-categories with the same parent must have unique names.' => 'Der Kategoriename \'[_1]\' steht im Konflikt mit einem anderen Kategorienamen. Hauptkategorien und Unterkategorien der gleichen Ebene müssen unterschiedliche Namen haben.',
	'The category basename \'[_1]\' conflicts with another category. Top-level categories and sub-categories with the same parent must have unique basenames.' => 'Der Kategorie-Basisname \'[_1]\' steht im Konflikt mit einem anderen Kategorienamen. Hauptkategorien und Unterkategorien der gleichen Ebene müssen unterschiedliche Basisnamen haben.',
	'Category \'[_1]\' created by \'[_2]\'' => 'Kategorie \'[_1]\' angelegt von \'[_2]\'',
	'Category \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Kategorie \'[_1]\' (ID:[_2]) gelöscht von \'[_3]\'',
	'Saving category failed: [_1]' => 'Die Kategorie konnte nicht gespeichert werden: [_1]',

## lib/MT/CMS/TrackBack.pm
	'Junk TrackBacks' => 'TrackBacks als Spam behandeln',
	'TrackBacks where <strong>[_1]</strong> is &quot;[_2]&quot;.' => 'TrackBacks, mit <strong>[_1]</strong> &quot;[_2]&quot;',
	'TrackBack Activity Feed' => 'TrackBackfeed',
	'(Unlabeled category)' => '(Namenlose Kategorie)',
	'Ping (ID:[_1]) from \'[_2]\' deleted by \'[_3]\' from category \'[_4]\'' => 'Ping (ID:[_1]) von \'[_2]\' von \'[_3]\' aus Kategorie \'[_4]\' gelöscht',
	'(Untitled entry)' => '(Namenloser Eintrag)',
	'Ping (ID:[_1]) from \'[_2]\' deleted by \'[_3]\' from entry \'[_4]\'' => 'Ping (ID:[_1]) von \'[_2]\' von \'[_3]\' aus Eintrag \'[_4]\' gelöscht',
	'No Excerpt' => 'Kein Auszug',
	'No Title' => 'Keine Überschrift',
	'Orphaned TrackBack' => 'Verwaistes TrackBack',
	'category' => 'Kategorien',

## lib/MT/CMS/User.pm
	'Create User' => 'Benutzerkonto anlegen',
	'Can\'t load role #[_1].' => 'Kann Rolle #[_1] nicht laden.', # Translate - New # OK
	'Roles' => 'Rollen',
	'Create Role' => 'Rolle anlegen',
	'(user deleted)' => '(Benutzer gelöscht)',
	'*User deleted*' => 'Benutzer gelöscht',
	'(newly created user)' => '(neu angelegter Benutzer)',
	'User Associations' => 'Benutzerverknüpfungen',
	'Role Users & Groups' => 'Rollen-Benutzer und -Gruppen',
	'(Custom)' => '(Individuell)',
	'The user' => 'Der Benutzer',
	'Role name cannot be blank.' => 'Rollenname erforderlich',
	'Another role already exists by that name.' => 'Es ist bereits eine Rolle mit diesem Namen vorhanden.',
	'You cannot define a role without permissions.' => 'Sie können keine Rollen ohne Berechtigungen definieren.',
	'General Settings' => 'Allgemeine Einstellungen',
	'Invalid ID given for personal blog clone source ID.' => 'Ungültige ID für Klonvorlage für persönliche Weblogs',
	'If personal blog is set, the default site URL and root are required.' => 'Standard-Site URL und Site Root für persönliche Weblogs erforderlich.',
	'Select a entry author' => 'Eintragsautor wählen', # Translate - New # OK
	'Selected author' => 'Gewählter Autor', # Translate - New # OK
	'Type a username to filter the choices below.' => 'Geben Sie einen Benutzernamen ein, um die Auswahl einzuschränken', # Translate - Improved (1) # OK
	'Entry author' => 'Eintragsautor', # Translate - New # OK
	'Select a System Administrator' => 'Systemadministrator wählen',
	'Selected System Administrator' => 'Gewählter Systemadministrator',
	'represents a user who will be created afterwards' => 'steht für ein Benutzerkonto, das später angelegt werden wird',
	'Select Blogs' => 'Weblogs auswählen',
	'Blogs Selected' => 'Gewählte Weblogs',
	'Search Blogs' => 'Blogs suchen',
	'Select Users' => 'Gewählte Benutzer',
	'Users Selected' => 'Gewählte Benutzer',
	'Search Users' => 'Benutzer suchen',
	'Select Roles' => 'Rollen auswählen',
	'Role Name' => 'Rollenname',
	'Roles Selected' => 'Gewählte Rollen',
	'' => ' ',
	'Grant Permissions' => 'Rechte zuweisen',
	'You cannot delete your own association.' => 'Sie können nicht Ihre eigene Verknüpfung löschen.',
	'You cannot delete your own user record.' => 'Sie können nicht Ihr eigenes Benutzerkonto löschen.',
	'You have no permission to delete the user [_1].' => 'Keine Rechte zum Löschen von Benutzer [_1].',
	'User requires username' => 'Benutzername erforderlich',
	'User requires display name' => 'Anzeigename erforderlich', # Translate - New # OK
	'A user with the same name already exists.' => 'Ein Benutzer mit diesem Namen existiert bereits',
	'User requires password' => 'Passwort erforderlich',
	'User requires password recovery word/phrase' => 'Passwort-Erinnerungssatz erforderlich',
	'Email Address is required for password recovery' => 'E-Mail-Adresse erforderlich (für Passwort-Anforderungen)',
	'Website URL is imperfect' => 'Website-URL ungültig',
	'User \'[_1]\' (ID:[_2]) created by \'[_3]\'' => 'Benutzer \'[_1]\' (ID:[_2]) angelegt von \'[_3]\'',
	'User \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Benutzer \'[_1]\' (ID:[_2]) gelöscht von \'[_3]\'',

## lib/MT/CMS/Asset.pm
	'Files' => 'Dateien',
	'Can\'t load file #[_1].' => 'Kann Datei #[_1] nicht laden.',
	'File \'[_1]\' uploaded by \'[_2]\'' => 'Datei \'[_1]\' hochgeladen von \'[_2]\'',
	'File \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Datei \'[_1]\' (ID:[_2]) gelöschen von \'[_3]\'',
	'All Assets' => 'Alle Assets',
	'Untitled' => 'Ohne Name',
	'Archive Root' => 'Archiv-Wurzel',
	'Please select a file to upload.' => 'Bitte wählen Sie eine hochzuladende Datei aus.',
	'Invalid filename \'[_1]\'' => 'Ungültiger Dateiname \'[_1]\'',
	'Please select an audio file to upload.' => 'Bitte wählen Sie aus, welche Audiodatei hochgeladen werden soll.',
	'Please select an image to upload.' => 'Bitte wählen Sie aus, welche Bilddatei hochgeladen werden soll.',
	'Please select a video to upload.' => 'Bitte wählen Sie aus, welches Video hochgeladen werden soll.',
	'Before you can upload a file, you need to publish your blog.' => 'Bevor Sie eine Datei hochladen können, müssen Sie das Blog zuerst veröffentlichen.',
	'Invalid extra path \'[_1]\'' => 'Ungültiger Zusatzpfad \'[_1]\'',
	'Can\'t make path \'[_1]\': [_2]' => 'Kann Pfad \'[_1]\' nicht anlegen: [_2]',
	'Invalid temp file name \'[_1]\'' => 'Ungültiger temporärer Dateiname \'[_1]\'',
	'Error opening \'[_1]\': [_2]' => 'Fehler beim Öffnen von \'[_1]\': [_2]',
	'Error deleting \'[_1]\': [_2]' => 'Fehler beim Löschen von \'[_1]\': [_2]',
	'File with name \'[_1]\' already exists. (Install File::Temp if you\'d like to be able to overwrite existing uploaded files.)' => 'Es ist bereits eine Datei namens \'[_1]\' vorhanden. (Um bereits vorhandene hochgeladene Dateien überschreiben zu können, installieren Sie File::Temp.)',
	'Error creating temporary file; please check your TempDir setting in your coniguration file (currently \'[_1]\') this location should be writable.' => 'Fehler beim Anlegen der temporären Datei. Bitte überprüfen Sie, ob das in der Konfigurationsdatei eingestellte TempDir (derzeit \'[_1]\') beschreibbar ist.',
	'unassigned' => 'nicht vergeben',
	'File with name \'[_1]\' already exists; Tried to write to tempfile, but open failed: [_2]' => 'Es ist bereits eine Datei namens \'[_1]\' vorhanden. Die angelegte temporäre Datei konnte nicht geöffnet werden: [_2]',
	'Could not create upload path \'[_1]\': [_2]' => 'Konnte Hochladepfad \'[_1]\' nicht anlegen: [_2]',
	'Error writing upload to \'[_1]\': [_2]' => 'Die hochgeladene Datei konnte nicht in \'[_1]\' gespeichert werden: [_2]',
	'<' => '<',
	'/' => '/',

## lib/MT/CMS/Log.pm
	'All Feedback' => 'Feedback',
	'Publishing' => 'Veröffentlichung',
	'Activity Log' => 'Aktivitäten',
	'System Activity Feed' => 'Systemfeed',
	'Activity log for blog \'[_1]\' (ID:[_2]) reset by \'[_3]\'' => 'Aktivitätsprotokoll von \'[_1]\' (ID:[_2]) on \'[_3]\' zurückgesetzt',
	'Activity log reset by \'[_1]\'' => 'Aktivitätsprotokoll zurückgesetzt von \'[_1]\'',

## lib/MT/CMS/Export.pm
	'You do not have export permissions' => 'Keine Export-Rechte',

## lib/MT/CMS/Blog.pm
	'Publishing Settings' => 'Veröffentlichungs-Einstellungen',
	'Plugin Settings' => 'Plugin-Einstellungen',
	'Settings' => 'Einstellungen',
	'New Blog' => 'Neues Blog',
	'Blog Activity Feed' => 'Aktivitätsfeed',
	'Go Back' => 'Zurück',
	'Can\'t load entry #[_1].' => 'Kann Eintrag #[_1] nicht laden.', # Translate - New # OK
	'Can\'t load template #[_1].' => 'Kann Vorlage #[_1] nicht laden.', # Translate - New # OK
	'index template \'[_1]\'' => 'Indexvorlage \'[_1]\'',
	'[_1] \'[_2]\'' => '[_1] \'[_2]\'',
	'Publish Site' => 'Site veröffentlichen',
	'Invalid blog' => 'Ungültiges Blog',
	'Select Blog' => 'Weblog wählen',
	'Selected Blog' => 'Gewähltes Weblog',
	'Type a blog name to filter the choices below.' => 'Geben Sie einen Blognamen ein, um die Auswahl einzuschränken.',
	'Saving permissions failed: [_1]' => 'Die Rechte konnten nicht gespeichert werden: [_1]',
	'Blog \'[_1]\' (ID:[_2]) created by \'[_3]\'' => 'Weblog \'[_1]\' (ID:[_2]) angelegt von \'[_3]\'',
	'You did not specify a blog name.' => 'Kein Blog-Name angegeben.',
	'Site URL must be an absolute URL.' => 'Site-URL muß eine absolute URL sein.',
	'Archive URL must be an absolute URL.' => 'Archiv-URLs müssen absolut sein.',
	'You did not specify an Archive Root.' => 'Kein Archiv-Wurzelverzeichnis angebeben.',
	'Blog \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Weblog \'[_1]\' (ID:[_2]) gelöscht von \'[_3]\'',
	'Saving blog failed: [_1]' => 'Das Weblog konnte nicht gespeichert werden: [_1]',
	'Error: Movable Type cannot write to the template cache directory. Please check the permissions for the directory called <code>[_1]</code> underneath your blog directory.' => 'Fehler: Movable Type kann nicht in den Vorlagen-Cache-Ordner schreiben. Bitte überprüfen Sie die Rechte für den Ordner <code>[_1]</code> in Ihrem Weblog-Verzeichnis.',
	'Error: Movable Type was not able to create a directory to cache your dynamic templates. You should create a directory called <code>[_1]</code> underneath your blog directory.' => 'Fehler: Movable Type konnte kein Verzeichnis zur Zwischenspeicherung Ihrer dynamischen Vorlagen anlegen. Legen Sie daher manuell einen Ordner namens <code>[_1]</code> in Ihrem Weblog-Verzeichnis an.',

## lib/MT/CMS/Dashboard.pm
	'Better, Stronger, Faster' => 'Besser, stärker, schneller', # Translate - New # OK
	'A concerted effort has been made to make significant improvements to Movable Type\'s performance and reliability with added features like Server Side Includes and Template Module Caching.' => 'Movable Type wurde in den Punkten Leistung und Zuverlässigkeit signifikant verbessert und durch Funktionen wie Server Side Includes und Vorlagenmodul-Caching erweitert.', # Translate - New # OK
	'Improved Template Management' => 'Verbesserte Vorlagenverwaltung', # Translate - New # OK
	'The template editing interface has been enhanced to make designers more efficient at updating their site\'s design.' => 'Der überarbeitete Vorlagen-Editor ermöglicht Gestaltern Designs schneller umzusetzen.', # Translate - New # OK
	'Threaded Comments' => 'Thread-Darstellung für Kommentare', # Translate - New # OK
	'Allow commenters on your blog to reply to each other increasing user engagement and creating more dynamic conversations.' => 'Kommentautoren können jetzt direkt auf andere Kommentare antworten. So können Konversationen dynamischer geführt und die Nutzerbeteiliung erhöht werden.', # Translate - New # OK

## lib/MT/CMS/Common.pm
	'Permisison denied.' => 'Zugriff verweigert.',
	'The Template Name and Output File fields are required.' => 'Die Felder Vorlagennamen und Dateiname sind erforderlich.',
	'Invalid type [_1]' => 'Ungültiger Typ [_1]',
	'Invalid parameter' => 'Ungültiges Parameter',
	'Notification List' => 'Mitteilungssliste',
	'IP Banning' => 'IP-Adressen sperren',
	'Removing tag failed: [_1]' => 'Der Tag konnte nicht entfernt werden: [_1]',
	'You can\'t delete that category because it has sub-categories. Move or delete the sub-categories first if you want to delete this one.' => 'Solange die Kategorie Unterkategorien hat, können Sie die Kategorie nicht löschen.',
	'Loading MT::LDAP failed: [_1].' => 'MT::LDAP konnte nicht geladen werden: [_1]',
	'System templates can not be deleted.' => 'Systemvorlagen können nicht gelöscht werden',

## lib/MT/CMS/BanList.pm
	'You did not enter an IP address to ban.' => 'Keine IP-Adresse angegeben.',
	'The IP you entered is already banned for this blog.' => 'Die angegebene IP-Adresse ist für dieses Weblog bereits gesperrt.',

## lib/MT/CMS/Plugin.pm
	'Plugin Set: [_1]' => 'Plugin-Gruppe: [_1]',
	'Individual Plugins' => 'Individuelle Plugins',

## lib/MT/CMS/Tools.pm
	'Password Recovery' => 'Neues Passwort anfordern',
	'That action ([_1]) is apparently not implemented!' => 'Aktion ([_1]) offenbar nicht implementiert!',
	'Invalid password recovery attempt; can\'t recover password in this configuration' => 'Ungültiger Versuch der Passwortanforderung. Passwörter können in dieser Konfiguration nicht angefordert werden.',
	'Invalid author_id' => 'Ungültige Autoren-ID',
	'Backup' => 'Sichern',
	'Backup & Restore' => 'Sichern & Wiederherstellen',
	'Temporary directory needs to be writable for backup to work correctly.  Please check TempDir configuration directive.' => 'Das temporäre Verzeichnis muss zur Durchführung der Sicherung beschreibbar sein. Bitte überprüfen Sie Ihre TempDir-Einstellung.',
	'Temporary directory needs to be writable for restore to work correctly.  Please check TempDir configuration directive.' => 'Das temporäre Verzeichnis muss zur Durchführung der Wiederherstellung beschreibbar sein. Bitte überprüfen Sie Ihre TempDir-Einstellung.',
	'[_1] is not a number.' => '[_1] ist keine Zahl.',
	'Copying file [_1] to [_2] failed: [_3]' => 'Die Datei [_1] konnte nicht nach [_2] kopiert werden: [_3]',
	'Specified file was not found.' => 'Angegebene Datei nicht gefunden.',
	'[_1] successfully downloaded backup file ([_2])' => '[_1] hat Sicherungsdatei erfolgreich heruntergeladen ([_2])',
	'Restore' => 'Wiederherstellen',
	'MT::Asset#[_1]: ' => 'MT::Asset#[_1]: ',
	'Some of the actual files for assets could not be restored.' => 'Einige Assetdateien konnten nicht wiederhergestellt werden.',
	'Please use xml, tar.gz, zip, or manifest as a file extension.' => 'Bitte verwenden Sie xml, tar.gz, zip, oder manifest als Dateierweiterung.',
	'Unknown file format' => 'Unbekanntes Dateiformat',
	'Some objects were not restored because their parent objects were not restored.' => 'Einige Objekte wurden nicht wiederhergestellt, da ihre Elternobjekte nicht wiederhergestellt wurden.',
	'Detailed information is in the <a href=\'javascript:void(0)\' onclick=\'closeDialog(\"[_1]\")\'>activity log</a>.' => 'Details finden Sie im <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_1]\');\">Aktivitätsprotokoll</a>.',
	'[_1] has canceled the multiple files restore operation prematurely.' => '[_1] hat die Vorgang zur Wiederherstellung mehrerer Dateien vorzeitig abgebrochen.',
	'Changing Site Path for the blog \'[_1]\' (ID:[_2])...' => 'Ändere Sitepfad für Weblog\'[_1]\' (ID:[_2])...',
	'Removing Site Path for the blog \'[_1]\' (ID:[_2])...' => 'Entferne Sitepfad für Weblog \'[_1]\' (ID:[_2])...',
	'Changing Archive Path for the blog \'[_1]\' (ID:[_2])...' => 'Ändere Archivpfad für Weblog \'[_1]\' (ID:[_2])...',
	'Removing Archive Path for the blog \'[_1]\' (ID:[_2])...' => 'Entferne Archivpfadfür Weblog \'[_1]\' (ID:[_2])...',
	'Changing file path for the asset \'[_1]\' (ID:[_2])...' => 'Ändere Pfad für Asset \'[_1]\' (ID:[_2])...',
	'Please upload [_1] in this page.' => 'Bitte laden Sie [_1] in diese Seite hoch.',
	'File was not uploaded.' => 'Datei wurde nicht hochgeladen.',
	'Restoring a file failed: ' => 'Die Datei konnte nicht wiederhergestellt werden: ',
	'Some of the files were not restored correctly.' => 'Einige Daten wurden nicht korrekt wiederhergestellt.',
	'Successfully restored objects to Movable Type system by user \'[_1]\'' => 'Objekte erfolgreich wiederhergestellt von Benutzer \'[_1]\'',
	'Can\'t recover password in this configuration' => 'Passwörter können in dieser Konfiguration nicht angefordert werden',
	'Invalid user name \'[_1]\' in password recovery attempt' => 'Ungültiger Benutzername \'[_1]\' zur Passwortanforderung verwendet',
	'User name or password hint is incorrect.' => 'Benutzername oder Antwort auf Erinnerungsfrage falsch.',
	'User has not set pasword hint; cannot recover password' => 'Erinnerungsfrage nicht gesetzt; neues Passwort kann deshalb nicht angefordert werden',
	'Invalid attempt to recover password (used hint \'[_1]\')' => 'Ungültiger Versuch einer Passwortanforderung (verwendeter Erinnerungssatz: \'[_1]\'',
	'User does not have email address' => 'Benutzer hat keine E-Mail-Adresse',
	'Password was reset for user \'[_1]\' (user #[_2]). Password was sent to the following address: [_3]' => 'Passwort von Benutzer \'[_1]\' (#[_2]) zurückgesetzt und an [_3] verschickt',
	'Error sending mail ([_1]); please fix the problem, then try again to recover your password.' => 'Beim Mailversand ist ein Fehler aufgetreten ([_1]). Überprüfen Sie die entsprechenden Einstellungen und versuchen Sie dann erneut, ein neues Passwort anzufordern.',
	'Some objects were not restored because their parent objects were not restored.  Detailed information is in the <a href="javascript:void(0);" onclick="closeDialog(\'[_1]\');">activity log</a>.' => 'Einige Objekte wurden nicht wiederhergestellt, da ihre Elternobjekte ebenfalls nicht widerhergestellt wurden. Details finden Sie im <a href="javascript:void(0);" onclick="closeDialog(\'[_1]\');">Aktivitätsprotokoll</a>.',
	'[_1] is not a directory.' => '[_1] ist kein Verzeichnis.',
	'Error occured during restore process.' => 'Bei der Wiederherstellung ist ein Fehler aufgetreten.',
	'Some of files could not be restored.' => 'Einige Dateien konnten nicht wiederhergestellt werden.',
	'Uploaded file was not a valid Movable Type backup manifest file.' => 'Die hochgeladene Datei ist keine gültige Movable Type Backup-Manifest-Datei.',
	'Blog(s) (ID:[_1]) was/were successfully backed up by user \'[_2]\'' => 'Weblog(s) (ID:[_1]) erfolgreich gesichert von Benutzer \'[_2]\'',
	'Movable Type system was successfully backed up by user \'[_1]\'' => 'Movable Type-System erfolgreich gesichert von Benutzer \'[_1]\'',
	'Some [_1] were not restored because their parent objects were not restored.' => 'Einige [_1] wurden nicht wiederhergestellt, da ihre Elternobjekte nicht wiederhergestellt wurden.',

## lib/MT/CMS/Entry.pm
	'(untitled)' => '(ohne Überschrift)',
	'New Entry' => 'Neuer Eintrag',
	'New Page' => 'Neue Seite',
	'None' => 'Kein(e)',
	'pages' => 'Seiten',
	'Tag' => 'Tag',
	'Entry Status' => 'Eintragsstatus',
	'[_1] Feed' => '[_1]-Feed',
	'Can\'t load template.' => 'Kann Vorlage nicht laden.', # Translate - New # OK
	'New [_1]' => 'Neuer [_1]',
	'No such [_1].' => 'Kein [_1].',
	'Same Basename has already been used. You should use an unique basename.' => 'Dieser Basisname wird bereits verwendet. Bitte verwenden Sie einen eindeutigen Basisnamen.',
	'Your blog has not been configured with a site path and URL. You cannot publish entries until these are defined.' => 'Site Path und URL dieses Weblogs wurden noch nicht konfiguriert. Sie können keine Einträge veröffentlichen, solange das nicht geschehen ist.',
	'Invalid date \'[_1]\'; authored on dates must be in the format YYYY-MM-DD HH:MM:SS.' => 'Datum \'[_1]\' ungültig; erforderliches Formst ist JJJJ-MM-TT SS:MM:SS.',
	'Invalid date \'[_1]\'; authored on dates should be real dates.' => 'Ungültiges Datum \'[_1]\'; das Datum muss existieren.',
	'[_1] \'[_2]\' (ID:[_3]) added by user \'[_4]\'' => '[_1] \'[_2]\' (ID:[_3]) hinzugefügt von Benutzer \'[_4]\'',
	'[_1] \'[_2]\' (ID:[_3]) edited and its status changed from [_4] to [_5] by user \'[_6]\'' => '[_1] \'[_2]\' (ID:[_3]) bearbeitet und Status geändert von [_4] in [_5] von Benutzer \'[_6]\'',
	'[_1] \'[_2]\' (ID:[_3]) edited by user \'[_4]\'' => '[_1] \'[_2]\' (ID:[_3]) bearbeitet von Benutzer \'[_4]\'',
	'Saving placement failed: [_1]' => 'Die Platzierung konnte nicht geladen werden: [_1]',
	'Saving entry \'[_1]\' failed: [_2]' => 'Der Eintrag \'[_1]\' konnte nicht gespeichert werden: [_2]',
	'Removing placement failed: [_1]' => 'Die Platzierung konnte nicht entfernt werden: [_1]',
	'Ping \'[_1]\' failed: [_2]' => 'Ping \'[_1]\' fehlgeschlagen: [_2]',
	'(user deleted - ID:[_1])' => '(Benutzer gelöscht - ID:[_1])',
	'<a href="[_1]">QuickPost to [_2]</a> - Drag this link to your browser\'s toolbar then click it when you are on a site you want to blog about.' => '<a href="[_1]">QuickPost für [_2]</a> - Ziehen Sie diesen Link in die Lesezeichenleiste Ihres Browsers und klicken Sie darauf, wenn Sie sich auf einer Website befinden, über die Sie bloggen möchten.',
	'Entry \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Eintrag \'[_1]\' (ID:[_2]) gelöscht von \'[_3]\'',
	'Need a status to update entries' => 'Statusangabe erforderlich',
	'Need entries to update status' => 'Einträge erforderlich',
	'One of the entries ([_1]) did not actually exist' => 'Einer der Einträge ([_1]) ist nicht vorhanden',
	'[_1] \'[_2]\' (ID:[_3]) status changed from [_4] to [_5]' => 'Status von [_1] \'[_2]\' (ID:[_3]) von [_4] in [_5] geändert.',

## lib/MT/CMS/Comment.pm
	'Edit Comment' => 'Kommentar bearbeiten',
	'Orphaned comment' => 'Verwaister Kommentar',
	'Comments Activity Feed' => 'Kommentarfeed',
	'Commenters' => 'Kommentarautoren',
	'Authenticated Commenters' => 'Authentifizierte Kommentarautoren',
	'No such commenter [_1].' => 'Kein Kommentarautor [_1].',
	'User \'[_1]\' trusted commenter \'[_2]\'.' => 'Benutzer \'[_1]\' hat Kommentarautor \'[_2]\' das Vertrauen ausgesprochen',
	'User \'[_1]\' banned commenter \'[_2]\'.' => 'Benutzer \'[_1]\' hat Kommentarautor \'[_2]\' gesperrt',
	'User \'[_1]\' unbanned commenter \'[_2]\'.' => 'Benutzer \'[_1]\' hat die Sperrung von Kommentarautor \'[_2]\' aufgehoben',
	'User \'[_1]\' untrusted commenter \'[_2]\'.' => 'Benutzer \'[_1]\' hat Kommentarautor \'[_2]\' das Vertrauen entzogen',
	'Feedback Settings' => 'Feedback-Einstellungen',
	'An error occurred: [_1]' => 'Es ist ein Fehler aufgetreten: [_1]',
	'Parent comment id was not specified.' => 'ID des Elternkommentars nicht angegeben.',
	'Parent comment was not found.' => 'Elternkommentar nicht gefunden.',
	'You can\'t reply to unapproved comment.' => 'Sie können auf nicht freigegebene Kommentare nicht antworten.',
	'Comment (ID:[_1]) by \'[_2]\' deleted by \'[_3]\' from entry \'[_4]\'' => 'Kommentar (ID:[_1]) von \'[_2]\' von \'[_3]\' aus Eintrag \'[_4]\' gelöscht',
	'You don\'t have permission to approve this comment.' => 'Sie haben keine Berechtigung zur Freischaltung dieses Kommentars.',
	'Comment on missing entry!' => 'Kommentar gehört zu fehlendem Eintrag',
	'You can\'t reply to unpublished comment.' => 'Sie können nicht auf Kommentare antworten, die noch nicht veröffentlicht wurden.',
	'Registered User' => 'Registrierter Benutzer',

## lib/MT/Compat/v3.pm
	'uses: [_1], should use: [_2]' => 'verwendet [_1], sollte [_2] verwenden',
	'uses [_1]' => 'verwendet [_1]',
	'No executable code' => 'Kein ausführbarer Code',
	'Publish-option name must not contain special characters' => 'Der Optionsname darf keine Sonderzeichen enthalten.',

## lib/MT/ObjectScore.pm
	'Object Score' => 'Objektbewertung',
	'Object Scores' => 'Objektbewertungen',

## lib/MT/FileMgr/Local.pm
	'Opening local file \'[_1]\' failed: [_2]' => 'Die lokale Datei \'[_1]\' konnte nicht veröffentlicht werden: [_2]',
	'Renaming \'[_1]\' to \'[_2]\' failed: [_3]' => '\'[_1]\' konnte nicht in \'[_2]\' umbenannt werden: [_3]',
	'Deleting \'[_1]\' failed: [_2]' => '\'[_1]\' konnte nicht gelöscht werden: [_2]',

## lib/MT/FileMgr/FTP.pm
	'Creating path \'[_1]\' failed: [_2]' => 'Der Ordner \'[_1]\' konnte nicht angelegt werden: [_2]',

## lib/MT/FileMgr/DAV.pm
	'DAV connection failed: [_1]' => 'DAV-Verbindung fehlgeschlagen: [_1]',
	'DAV open failed: [_1]' => 'DAV-"open" fehlgeschlagen: [_1]',
	'DAV get failed: [_1]' => 'DAV-"get" fehlgeschlagen: [_1]',
	'DAV put failed: [_1]' => 'DAV-"put" fehlgeschlagen: [_1]',

## lib/MT/FileMgr/SFTP.pm
	'SFTP connection failed: [_1]' => 'SFTP-Verbindung fehlgeschlagen: [_1]',
	'SFTP get failed: [_1]' => 'SFTP-"get" fehlgeschlagen: [_1]',
	'SFTP put failed: [_1]' => 'SFTP-"put" fehlgeschlagen: [_1]',

## lib/MT/BackupRestore/ManifestFileHandler.pm

## lib/MT/BackupRestore/BackupFileHandler.pm
	'Uploaded file was backed up from Movable Type with the newer schema version ([_1]) than the one in this system ([_2]).  It is not safe to restore the file to this version of Movable Type.' => 'Die hochgeladene Datei wurde aus einer Movable Type-Installation mit einer neueren Schema-Version ([_1]) als der hier vorhandenen ([_2]) gesichert. Es wird daher nicht empfohlen, die Datei mit dieser Movable Type-Version zu verwenden.',
	'[_1] is not a subject to be restored by Movable Type.' => '[_1] wird Movable Type nicht wiederhergestellt.',
	'[_1] records restored.' => '[_1] Einträge wiederhergestellt.',
	'Restoring [_1] records:' => 'Stelle [_1]-Einträge wieder her:',
	'User with the same name as the name of the currently logged in ([_1]) found.  Skipped the record.' => 'Benutzer mit dem Namen des derzeit angemeldeten Benutzers ([_1]) gefunden. Eintrag übersprungen.',
	'User with the same name \'[_1]\' found (ID:[_2]).  Restore replaced this user with the data backed up.' => 'Benutzer mit gleichem Namen \'[_1]\' gefunden (ID:[_2]).  Die Benutzerdaten wurden entsprechend ersetzt.',
	'Tag \'[_1]\' exists in the system.' => 'Tag \'[_1]\' bereits im System vorhanden.',
	'[_1] records restored...' => '[_1] Einträge wiederhergstellt...',

## lib/MT/Import.pm
	'Can\'t rewind' => 'Kann nicht zurückspulen',
	'No readable files could be found in your import directory [_1].' => 'Im Import-Verzeichnis [_1] konnten keine lesbaren Dateien gefunden werden.',
	'Importing entries from file \'[_1]\'' => 'Importieren der Einträge aus Datei \'[_1]\'',
	'Couldn\'t resolve import format [_1]' => 'Kann Importformat [_1] nicht auflösen',
	'Movable Type' => 'Movable Type',
	'Another system (Movable Type format)' => 'Anderes System (Movable Type-Format)',

## lib/MT/IPBanList.pm
	'IP Ban' => 'IP-Sperre',
	'IP Bans' => 'IP-Sperren',

## lib/MT/Folder.pm
	'Folders' => 'Ordner',

## lib/MT/Tag.pm
	'Tag must have a valid name' => 'Tags müssen gültige Namen haben',
	'This tag is referenced by others.' => 'Andere Tags verweisen auf dieses Tag.',

## lib/MT/App.pm
	'First Weblog' => 'Erstes Weblog',
	'Error loading blog #[_1] for user provisioning. Check your NewUserTemplateBlogId setting.' => 'Fehler beim Laden von Blog #[_1] zur Nutzerbereitstellug. Bitte überprüfen Sie Ihre NewUserTemplateBlogId-Einstellung.',
	'Error provisioning blog for new user \'[_1]\' using template blog #[_2].' => 'Fehler bei Bereitstellung des Blogs für neuen Benutzer \'[_1]\' nach Vorlage Blog #[_2].',
	'Error creating directory [_1] for blog #[_2].' => 'Fehler beim Anlegen des Ordners [_1] für Blog #[_2])',
	'Error provisioning blog for new user \'[_1] (ID: [_2])\'.' => 'Fehler bei Bereitstellung des Blogs für neuen Benutzer \'[_1] (ID: [_2]\'.',
	'Blog \'[_1] (ID: [_2])\' for user \'[_3] (ID: [_4])\' has been created.' => 'Blog \'[_1] (ID: [_2])\' für Benutzer \'[_3] (ID: [_4])\' erfolgreich angelegt.',
	'Error assigning blog administration rights to user \'[_1] (ID: [_2])\' for blog \'[_3] (ID: [_4])\'. No suitable blog administrator role was found.' => 'Fehler bei Zuweisung von Administratorensrechten für Blog \'[_3] (ID: [_4])\') an Benutzer \'[_1] (ID: [_2])\'. Keine passende Administratorenrolle gefunden.',
	'The login could not be confirmed because of a database error ([_1])' => 'Anmeldung konnte aufgrund eines Datenbankfehlers nicht durchgeführt werden ([_1])',
	'Our apologies, but you do not have permission to access any blogs within this installation. If you feel you have reached this message in error, please contact your Movable Type system administrator.' => 'Sie haben keine Zugriffsrechte auf Blogs dieser Movable Type-Installation. Sollte diese Meldung irrtümlich angezeigt werden, wenden Sie sich bitte an Ihren Administrator.',
	'Invalid login.' => 'Benutzername oder Passwort ungültig',
	'Failed login attempt by unknown user \'[_1]\'' => 'Fehlgeschlagener Anmeldeversuch von unbekanntem Benutzer \'[_1]\'',
	'Failed login attempt by disabled user \'[_1]\'' => 'Fehlgeschlagener Anmeldeversuch von deaktiviertem Benutzer \'[_1]\'',
	'This account has been disabled. Please see your system administrator for access.' => 'Dieses Benutzerkonto wurde gesperrt. Bitte wenden Sie sich an den Administrator.',
	'Failed login attempt by pending user \'[_1]\'' => 'Fehlgeschlagener Anmeldeversuch von schwebendem Benutzer \'[_1]\'',
	'This account has been deleted. Please see your system administrator for access.' => 'Dieses Benutzerkonto wurde gelöscht. Bitte wenden Sie sich an den Administrator.',
	'User cannot be created: [_1].' => 'Kann Benutzerkonto nicht anlegen: [_1].',
	'User \'[_1]\' has been created.' => 'Benutzerkonto \'[_1]\' angelegt.',
	'User \'[_1]\' (ID:[_2]) logged in successfully' => 'Benutzerkonto \'[_1]\' (ID:[_2]) erfolgreich angemeldet',
	'Invalid login attempt from user \'[_1]\'' => 'Ungültiger Anmeldeversuch von Benutzer \'[_1]\'',
	'User \'[_1]\' (ID:[_2]) logged out' => 'Benutzer \'[_1]\' (ID:[_2]) abgemeldet',
	'User requires password.' => 'Passwort erforderlich',
	'User requires password recovery word/phrase.' => 'Passwort-Erinnerungssatz erforderlich',
	'URL is invalid.' => 'URL ist ungültig',
	'User requires username.' => 'Benutzername erforderlich',
	'User requires display name.' => 'Anzeigename erforderlich',
	'Email Address is invalid.' => 'E-Mail-Adresse ungültig',
	'Email Address is required for password recovery.' => 'E-Mail-Adresse erforderlich (für Passwort-Anforderungen)',
	'Text entered was wrong.  Try again.' => 'Der eingegebene Text ist falsch. Bitte versuchen Sie es erneut.',
	'Something wrong happened when trying to process signup: [_1]' => 'Bei der Bearbeitung der Registrierung ist ein Fehler aufgetreten: [_1]',
	'New Comment Added to \'[_1]\'' => 'Neuer Kommentar zu \'[_1]\' eingegangen',
	'System Email Address is not configured.' => 'System-E-Mail-Adresse nicht konfiguriert.',
	'Close' => 'Schließen',
	'The file you uploaded is too large.' => 'Die hochgeladene Datei ist zu gross.',
	'Unknown action [_1]' => 'Unbekannte Aktion [_1]',
	'Warnings and Log Messages' => 'Warnungen und Logmeldungen',
	'Removed [_1].' => '[_1] entfernt.',

## lib/MT/Log.pm
	'Log message' => 'Protokolleintrag', # Translate - Improved (1) # OK
	'Log messages' => 'Protokolleinträge', # Translate - New # OK
	'Page # [_1] not found.' => 'Seite # [_1] nicht gefunden.',
	'Entry # [_1] not found.' => 'Eintrag #[_1] nicht gefunden.',
	'Comment # [_1] not found.' => 'Kommentar #[_1] nicht gefunden.',
	'TrackBack # [_1] not found.' => 'TrackBack #[_1] nicht gefunden.',

## lib/MT/Template/Context.pm
	'The attribute exclude_blogs cannot take \'all\' for a value.' => '\'all\' ist kein gültiges exclude_blogs-Parameter.',
	'You used an \'[_1]\' tag outside of the context of a author; perhaps you mistakenly placed it outside of an \'MTAuthors\' container?' => 'Sie haben einen \'[_1]\'-Vorlagenbefehl außerhalb eines Autoren-Kontexts verwendet - \'MTAuthors\'-Container erforderlich',
	'You used an \'[_1]\' tag outside of the context of an entry; perhaps you mistakenly placed it outside of an \'MTEntries\' container?' => '\'[_1]\'-Vorlagenbefehl außerhalb eines Eintrags-Kontexts verwendet - \'MTEntries\'-Container erforderlich.',
	'You used an \'[_1]\' tag outside of the context of a comment; perhaps you mistakenly placed it outside of an \'MTComments\' container?' => '\'[_1]\'-Vorlagenbefehl außerhalb eines Kommentar-Kontexts verwendet - \'MTComments\'-Container erforderlich.',
	'You used an \'[_1]\' tag outside of the context of a ping; perhaps you mistakenly placed it outside of an \'MTPings\' container?' => '\'[_1]\'-Vorlagenbefehl außerhalb eines Ping-Kontextes verwendet - \'MTPings\'-Container erforderlich.',
	'You used an \'[_1]\' tag outside of the context of an asset; perhaps you mistakenly placed it outside of an \'MTAssets\' container?' => '\'[_1]\'-Vorlagenbefehl außerhalb eines Asset-Kontexts verwendet - möglicherweise außerhalb eines \'MTAssets\'-Containers?',
	'You used an \'[_1]\' tag outside of the context of an page; perhaps you mistakenly placed it outside of an \'MTPages\' container?' => '\'[_1]\'-Vorlagenbefehl außerhalb eines Seiten-Kontexts verwendet - möglicherweise außerhalb eines \'MTPages\'-Containers?',

## lib/MT/Template/ContextHandlers.pm
	'All About Me' => 'Alles über mich', # Translate - New # OK
	'Remove this widget' => 'Dieses Widget entfernen',
	'[_1]Publish[_2] your site to see these changes take effect.' => '[_1]Veröffentlichen[_2] Sie Ihre Site, um die Änderungen wirksam werden zu lassen.',
	'Actions' => 'Aktionen',
	'Warning' => 'Warnung',
	'http://www.movabletype.org/documentation/appendices/tags/%t.html' => 'http://www.movabletype.org/documentation/appendices/tags/%t.html',
	'No [_1] could be found.' => 'Keine [_1] gefunden.',
	'Invalid tag [_1] specified.' => 'Ungültiger Vorlagenbefehl [_1] angegeben.',
	'No template to include specified' => 'Keine einzubindende Vorlage angegeben', # Translate - New # OK
	'Recursion attempt on [_1]: [_2]' => 'Rekursionsversuch bei [_1]: [_2]',
	'Can\'t find included template [_1] \'[_2]\'' => 'Kann verwendete Vorlage [_1] \'[_2]\' nicht finden',
	'Writing to \'[_1]\' failed: [_2]' => 'Auf \'[_1]\' konnte nicht geschrieben werden: [_2]',
	'Can\'t find blog for id \'[_1]' => 'Kann Blog für ID \'[_1]\' nicht finden',
	'Can\'t find included file \'[_1]\'' => 'Kann verwendete Datei \'[_1]\' nicht finden',
	'Error opening included file \'[_1]\': [_2]' => 'Fehler beim Öffnen der verwendeten Datei \'[_1]\': [_2]',
	'Recursion attempt on file: [_1]' => 'Rekursionsversuch bei Datei [_1]',
	'Unspecified archive template' => 'Nicht spezifizierte Archivvorlage',
	'Error in file template: [_1]' => 'Fehler in Dateivorlage: [_1]',
	'Can\'t load template' => 'Kann Vorlage nicht laden',
	'Can\'t find template \'[_1]\'' => 'Kann Vorlage \'[_1]\' nicht finden',
	'Can\'t find entry \'[_1]\'' => 'Kann Eintrag \'[_1]\' nicht finden',
	'[_1] is not a hash.' => '[_1] ist kein Hash-Wert.',
	'You have an error in your \'[_2]\' attribute: [_1]' => 'Fehler im \'[_2]\'-Attribut: [_1]',
	'You have an error in your \'tag\' attribute: [_1]' => 'Fehler im \'tag\'-Attribut: [_1]',
	'No such user \'[_1]\'' => 'Kein Benutzer \'[_1]\'',
	'You used <$MTEntryFlag$> without a flag.' => 'Sie haben <$MTEntryFlag$> ohne Flag verwendet.',
	'You used an [_1] tag for linking into \'[_2]\' archives, but that archive type is not published.' => 'Sie haben mit einem [_1]-Vorlagenbefehl \'[_2]\'-Archive verlinkt, ohne diese vorher zu veröffentlichen.',
	'Could not create atom id for entry [_1]' => 'Konnte keine ATOM-ID für Eintrag [_1] erzeugen',
	'To enable comment registration, you need to add a TypeKey token in your weblog config or user profile.' => 'Um die Registrierung von Kommentarautoren zu ermöglichen, geben Sie ein TypeKey-Token in den Weblogeinstellungen oder dem Benutzerenprofil an.',
	'The MTCommentFields tag is no longer available; please include the [_1] template module instead.' => 'Der MTCommentFields-Befehl ist nicht mehr verfügbar. Bitte verwenden Sie stattdessen das [_1]-Vorlagenmodul.',
	'Comment Form' => 'Kommentarformular',
	'You used an [_1] tag without a date context set up.' => 'Sie haben einen [_1]-Vorlagenbefehl ohne Datumskontext verwendet.',
	'[_1] can be used only with Daily, Weekly, or Monthly archives.' => '[_1] kann nur mit Tages-, Wochen- oder Monatsarchiven verwendet werden.',
	'Group iterator failed.' => 'Gruppeniterator fehlgeschlagen.',
	'You used an [_1] tag outside of the proper context.' => 'Sie haben einen [_1]-Vorlagenbefehl außerhalb seines Kontexts verwendet.',
	'Could not determine entry' => 'Konnte Eintrag nicht bestimmen',
	'Invalid month format: must be YYYYMM' => 'Ungültiges Datumsformat: richtig ist JJJJMM',
	'No such category \'[_1]\'' => 'Keine Kategorie \'[_1]\'',
	'[_1] cannot be used without publishing Category archive.' => '[_1] kann nur zusammen mit Kategoriearchiven verwendet werden.',
	'<\$MTCategoryTrackbackLink\$> must be used in the context of a category, or with the \'category\' attribute to the tag.' => '<\$MTCategoryTrackbackLink\$> muss im Kategoriekontext stehen oder mit dem \'category\'-Attribut des Tags.',
	'You failed to specify the label attribute for the [_1] tag.' => 'Kein Label-Attribut des [_1]-Tags angegeben.',
	'[_1] used outside of [_2]' => '[_1] außerhalb [_2] verwendet',
	'MT[_1] must be used in a [_2] context' => 'MT[_1] muss in einem [_2]-Kontext stehen',
	'Cannot find package [_1]: [_2]' => 'Kann Paket [_1] nicht finden: [_2]',
	'Error sorting [_2]: [_1]' => 'Fehler beim Sortieren von [_2]: [_1]',
	'Edit' => 'Bearbeiten',
	'You used an [_1] without a author context set up.' => '[_1] ohne vorhandenen Autorenkontext verwendet.',
	'Can\'t load user.' => 'Kann Benutzerkonto nicht laden.',
	'Division by zero.' => 'Teilung durch Null.',
	'name is required.' => 'Name erforderlich.', # Translate - New # OK
	'Specified WidgetSet not found.' => 'Angegebene Widgetgruppe nicht gefunden.', # Translate - New # OK
	'Can\'t find included template widget \'[_1]\'' => 'Kann in Vorlage angegebenes Widget \'[_1]\' nicht finden',

## lib/MT/App/Search/Legacy.pm
	'You are currently performing a search. Please wait until your search is completed.' => 'Die Suche wird ausgeführt. Bitte warten Sie, bis Ihre Anfrage abgeschlossen ist.',
	'Search failed. Invalid pattern given: [_1]' => 'Suche fehlgeschlagen - ungültiges Suchmuster angegeben: [_1]',
	'Search failed: [_1]' => 'Suche fehlgeschlagen: [_1]',
	'No alternate template is specified for the Template \'[_1]\'' => 'Keine alternative Vorlage für Vorlage \'[_1]\' angegeben',
	'Publishing results failed: [_1]' => 'Die Suchergebnisse konnten nicht veröffentlicht werden: [_1]',
	'Search: query for \'[_1]\'' => 'Suche: Suche nach \'[_1]\'',
	'Search: new comment search' => 'Suche: Suche nach neuen Kommentaren',

## lib/MT/App/Search/TagSearch.pm
	'TagSearch works with MT::App::Search.' => 'TagSearch verwendet MT::App::Search.', # Translate - New # OK

## lib/MT/App/NotifyList.pm
	'Please enter a valid email address.' => 'Bitte geben Sie eine gültige E-Mail-Adresse an.',
	'Missing required parameter: blog_id. Please consult the user manual to configure notifications.' => 'Erforderliches Parameter blog_id fehlt. Bitte konfigurieren Sie die Benachrichtungsfunktion entsprechend.',
	'An invalid redirect parameter was provided. The weblog owner needs to specify a path that matches with the domain of the weblog.' => 'Ungültiges Redirect-Parameter. Sie müssen einen zur verwendeten Domain gehörenden Pfad angeben.',
	'The email address \'[_1]\' is already in the notification list for this weblog.' => 'Die E-Mail-Adresse \'[_1]\' ist bereits in der Benachrichtigunsliste für dieses Weblog.',
	'Please verify your email to subscribe' => 'Bitte bestätigen Sie Ihre E-Mail-Adresse',
	'_NOTIFY_REQUIRE_CONFIRMATION' => 'Um den Vorgang abzuschließen, klicken Sie bitte auf den Link in der E-Mail, die an [_1] verschickt wurde. Damit stellen Sie sicher, daß die E-Mail-Adresse korrekt eingegeben wurde und wirklich Ihnen gehört.',
	'The address [_1] was not subscribed.' => 'Die Adresse [_1] wurde hinzugefügt.',
	'The address [_1] has been unsubscribed.' => 'Die Adresse [_1] wurde entfernt.',

## lib/MT/App/Comments.pm
	'Error assigning commenting rights to user \'[_1] (ID: [_2])\' for weblog \'[_3] (ID: [_4])\'. No suitable commenting role was found.' => 'Fehler bei der Zuweisung von Kommentierungsrechten an Benutzer \'[_1] (ID: [_2])\' für Weblog \'[_3] (ID: [_4])\'. Keine geeignete Kommentierungsrolle gefunden.',
	'Invalid commenter login attempt from [_1] to blog [_2](ID: [_3]) which does not allow Movable Type native authentication.' => 'Ungültiger Anmeldeversuch von Kommentarautor [_1] an Weblog [_2](ID: [_3]) - native Movable Type-Authentifizierung bei diesem Weblog nicht zulässig.',
	'Invalid login' => 'Login ungültig',
	'Successfully authenticated but signing up is not allowed.  Please contact system administrator.' => 'Authentifizierung erfolgreich, aber Registrierung nicht erlaubt. Bitte wenden Sie sich an den Systemadministrator.',
	'You need to sign up first.' => 'Sie müssen sich zuerst registrieren.',
	'Login failed: permission denied for user \'[_1]\'' => 'Anmeldung fehlgeschlagen: Zugriff verweigert für Benutzer \'[_1]\'',
	'Login failed: password was wrong for user \'[_1]\'' => 'Anmeldung fehlgeschlagen: Passwort für Benutzer \'[_1]\' falsch',
	'Signing up is not allowed.' => 'Registrierung derzeit nicht erlaubt.',
	'Movable Type Account Confirmation' => 'Movable Type-Anmeldungsbestätigung',
	'Commenter \'[_1]\' (ID:[_2]) has been successfully registered.' => 'Kommentarautor \'[_1]\' (ID:[_2]) erfolgreich registriert.',
	'Thanks for the confirmation.  Please sign in to comment.' => 'Vielen Dank für Ihre Bestätigung. Sie können sich jetzt anmelden und kommentieren.',
	'[_1] registered to the blog \'[_2]\'' => '[_1] hat sich für das Blog \'[_2]\' registriert.',
	'No id' => 'Keine ID',
	'No such comment' => 'Kein entsprechender Kommentar',
	'IP [_1] banned because comment rate exceeded 8 comments in [_2] seconds.' => 'IP [_1] gesperrt, da mehr als 8 Kommentare in [_2] Sekunden abgegeben wurden.',
	'IP Banned Due to Excessive Comments' => 'IP-Adresse wegen exzessiver Kommentarabgabe gesperrt',
	'Invalid request' => 'Ungültige Anfrage',
	'No entry_id' => 'Entry_id fehlt',
	'No such entry \'[_1]\'.' => 'Kein Eintrag \'[_1]\'.',
	'_THROTTLED_COMMENT' => 'Sie haben zu viele Kommentare in schneller Folge abgegeben. Bitte versuchen Sie es in einigen Augenblicken erneut.',
	'Comments are not allowed on this entry.' => 'Bei diesem Eintrag sind Kommentare nicht erlaubt.',
	'Comment text is required.' => 'Kommentartext ist Pflichtfeld.',
	'Registration is required.' => 'Registrierung erforderlich',
	'Name and email address are required.' => 'Name und E-Mail-Adresse sind Pflichtfelder',
	'Invalid email address \'[_1]\'' => 'Ungültige E-Mail-Adresse \'[_1]\'',
	'Invalid URL \'[_1]\'' => 'Ungültige Web-Adresse (URL) \'[_1]\'',
	'Comment save failed with [_1]' => 'Der Kommentar konnte nicht gespeichert werden: [_1]',
	'Comment on "[_1]" by [_2].' => 'Kommentar zu "[_1]" von [_2].',
	'Publish failed: [_1]' => 'Veröffentlichung fehlgeschlagen: [_1]',
	'Failed comment attempt by pending registrant \'[_1]\'' => 'Fehlgeschlagener Kommentierungsversuch durch schwebenden Kommentarautoren \'[_1]\'',
	'The sign-in attempt was not successful; please try again.' => 'Anmeldeversuch nicht erfolgreich. Bitte versuchen Sie es erneut.',
	'No entry was specified; perhaps there is a template problem?' => 'Es wurde kein Eintrag angegeben. Vielleicht gibt es ein Problem mit der Vorlage?',
	'Somehow, the entry you tried to comment on does not exist' => 'Der Eintrag, den Sie kommentieren möchten, existiert nicht.',
	'Invalid entry ID provided' => 'Ungültige Eintrags-ID angegeben', # Translate - New # OK
	'Invalid commenter ID' => 'Ungültige Kommentarautoren-ID',
	'All required fields must have valid values.' => 'Alle erforderlichen Felder müssen gültige Werte aufweisen.',
	'Commenter profile has successfully been updated.' => 'Kommentarautorenprofil erfolgreich aktualisiert.',
	'Commenter profile could not be updated: [_1]' => 'Kommentarautorenprofil konnte nicht aktualisiert werden: [_1]',

## lib/MT/App/Search.pm
	'Invalid type: [_1]' => 'Ungültiger Typ: [_1]', # Translate - New # OK
	'Search: failed storing results in cache.  [_1] is not available: [_2]' => 'Suche: konnte Ergebnisse nicht zwischenspeichern. [_1] ist nicht verfügbar: [_2]', # Translate - New # OK
	'Invalid format: [_1]' => 'Ungültiges Format: [_1]', # Translate - New # OK
	'Unsupported type: [_1]' => 'Nicht unterstützter Typ: [_1]', # Translate - New # OK
	'Invalid query: [_1]' => 'Ungültige Suchanfrage: [_1]', # Translate - New # OK
	'No search term was specified.' => 'Es wurde kein Suchbegriff angegeben.', # Translate - New # OK
	'Invalid value: [_1]' => 'Ungültiger Wert: [_1]', # Translate - New # OK
	'No column was specified to search for [_1].' => 'Keine Spalte zur Suche nach [_1] angegeben.', # Translate - New # OK
	'Throttled' => 'Gedrosselt', # Translate - New # OK

## lib/MT/App/Trackback.pm
	'Invalid entry ID \'[_1]\'' => 'Ungültige entry_id \'[_1]\'',
	'You must define a Ping template in order to display pings.' => 'Sie müssen eine Ping-Vorlage definieren, um Pings anzeigen zu können.',
	'Trackback pings must use HTTP POST' => 'Trackbacks müssen HTTP-POST verwenden',
	'Need a TrackBack ID (tb_id).' => 'Benötige TrackBack-ID (tb_id).',
	'Invalid TrackBack ID \'[_1]\'' => 'Ungültige TrackBack-ID \'[_1]\'',
	'You are not allowed to send TrackBack pings.' => 'Sie haben keine Berechtigung, TrackBack-Pings zu senden.',
	'You are pinging trackbacks too quickly. Please try again later.' => 'Sie senden zu viele TrackBack-Pings zu schnell hintereinander. Bitte versuchen Sie es später erneut.',
	'Need a Source URL (url).' => 'Quelladresse erforderlich (URL).',
	'This TrackBack item is disabled.' => 'Dieser TrackBack-Eintrag ist deaktiviert.',
	'This TrackBack item is protected by a passphrase.' => 'Dieser TrackBack-Eintrag ist passwortgeschützt.',
	'TrackBack on "[_1]" from "[_2]".' => 'TrackBack zu "[_1]" von "[_2]".',
	'TrackBack on category \'[_1]\' (ID:[_2]).' => 'TrackBack für Kategorie \'[_1]\' (ID:[_2])',
	'Can\'t create RSS feed \'[_1]\': ' => 'RSS-Feed kann nicht angelegt werden \'[_1]\': ',
	'New TrackBack Ping to Entry [_1] ([_2])' => 'Neuer TrackBack-Ping für Eintrag [_2] (#[_1])',
	'New TrackBack Ping to Category [_1] ([_2])' => 'Neuer TrackBack-Ping für Kategorie [_2] (#[_1])',

## lib/MT/App/Upgrader.pm
	'Failed to authenticate using given credentials: [_1].' => 'Authentifizierung fehlgeschlagen: [_1].',
	'You failed to validate your password.' => 'Die Passwörter sind nicht identisch.',
	'You failed to supply a password.' => 'Bitte geben Sie Ihr Passwort an.',
	'The e-mail address is required.' => 'Bitte geben Sie Ihre E-Mail-Adresse an.',
	'The path provided below is not writable.' => 'Der unten angegebene Pfad ist nicht beschreibbar.',
	'Invalid session.' => 'Ungültige Session',
	'No permissions. Please contact your administrator for upgrading Movable Type.' => 'Bitte kontaktieren Sie Ihren Administrator, um das Upgrade von Movable Type durchzuführen. Sie haben nicht die erforderlichen Rechte.',
	'Movable Type has been upgraded to version [_1].' => 'Movable Type erfolgreich auf Version [_1] aktualisiert.',

## lib/MT/App/Wizard.pm
	'The [_1] database driver is required to use [_2].' => 'Ein [_1]-Datenbanktreiber ist erforderlich, um eine [_2] zu nutzen.',
	'The [_1] driver is required to use [_2].' => 'Ein [_1]-Treiber ist erforderlich, um [_2] zu nutzen.',
	'An error occurred while attempting to connect to the database.  Check the settings and try again.' => 'Es konnte keine Verbindung zur Datenbank aufgebaut werden. Bitte überprüfen Sie die Einstellungen und versuchen Sie es erneut.',
	'SMTP Server' => 'SMTP-Server',
	'Sendmail' => 'Sendmail',
	'Test email from Movable Type Configuration Wizard' => 'Testmail vom Movable Type-Konfigurationshelfer',
	'This is the test email sent by your new installation of Movable Type.' => 'Diese Testmail wurde von Ihrer neuen Movable Type-Installation verschickt.',
	'This module is needed to encode special characters, but this feature can be turned off using the NoHTMLEntities option in mt-config.cgi.' => 'Dieses Modul ist zur Sonderzeichenkodierung erforderlich. Sonderzeichenkodierung kann über den Schalter NoHTMLEntities in mt-config.cgi abgeschaltet werden.',
	'This module is needed if you wish to use the TrackBack system, the weblogs.com ping, or the MT Recently Updated ping.' => 'Dieses Modul ist zur Nutzung von TrackBacks, weblogs.com-Pings und dem MT-Kürzlich-Aktualisiert-Ping erforderlich.',
	'This module is needed if you wish to use the MT XML-RPC server implementation.' => 'Dieses Modul ist zur Verwendung des XML-RPC-Servers notwendig.',
	'This module is needed if you would like to be able to overwrite existing files when you upload.' => 'Dieses Modul ist zum Überschreiben bereits vorhandener Dateien beim Hochladen erforderlich.',
	'List::Util is optional; It is needed if you want to use the Publish Queue feature.' => 'List::Util ist optional. Erforderlich zur Nutzung der Veröffentlichungs-Warteschlange.',
	'Scalar::Util is optional; It is needed if you want to use the Publish Queue feature.' => 'Scalar::Util ist optional. Erforderlich zur Nutzung der Veröffentlichungs-Warteschlange.', # Translate - New # OK
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
	'This module is required for sending mail via SMTP Server.' => 'Dieses Modul ist zum Verschicken von E-Mails über SMTP-Server erforderlich.',
	'This module is used in test attribute of MTIf conditional tag.' => 'Dieses Modul ist für das test-Attribut des MTif conditional-Befehls erforderlich.',
	'This module is required for file uploads (to determine the size of uploaded images in many different formats).' => 'Dieses Modul ist zur Bestimmung der Größe hochgeladener Dateien erforderlich.',
	'This module is required for cookie authentication.' => 'Dieses Modul ist zur Cookie-Authentifizierung erforderlich.',
	'DBI is required to store data in database.' => 'DBI ist zur Nutzung von Datenbanken erforderlich.',
	'CGI is required for all Movable Type application functionality.' => 'CGI ist für sämtliche Movable Type-Funktionen erforderlich.',
	'File::Spec is required for path manipulation across operating systems.' => 'File::Spec ist zur Vereinheitlichung von Pfadangaben über Betriebssystemgrenzen hinweg erforerlich. ',

## lib/MT/App/CMS.pm
	'This action will restore your global templates to factory settings without creating a backup. Click OK to continue or Cancel to abort.' => 'Diese Aktion setzt Ihre globalen Vorlagen auf die Werkseinstellungen zurück, ohne von den vorhandenen Vorlagen eine Sicherungskopie zu erstellen. Klicken Sie auf OK um fortzusetzen oder brechen Sie ab.',
	'_WARNING_PASSWORD_RESET_MULTI' => 'Sie sind dabei, die Passwörter mehrerer Benutzer zurücksetzen. Den Benutzern werden dazu zufällig erzeugte neue Passwörter per E-Mail zugeschickt werden.\n\nForsetzen?',
	'_WARNING_DELETE_USER_EUM' => 'Löschen eines Benutzerkontos kann nicht rückgängig gemacht werden und führt zu verwaisten Einträgen. Es wird daher empfohlen, das Benutzerkonto zu belassen und stattdessen dem Benutzer alle Berechtigungen zu entziehen. Möchten Sie das Konto dennoch löschen?\nGelöschte Benutzer können ihre Benutzerkonten selbst solange wiederherstellen, wie sie noch im externen Verzeichnis aufgeführt sind.',
	'_WARNING_DELETE_USER' => 'Löschen eines Benutzerkontos kann nicht rückgängig gemacht werden und führt zu verwaisten Einträgen. Es wird daher empfohlen, das Benutzerkonto zu belassen und stattdessen dem Benutzer alle Berechtigungen zu entziehen. Möchten Sie das Konto dennoch löschen?',
	'Published [_1]' => 'Veröffentlichte [_1]',
	'Unpublished [_1]' => 'Nicht veröffentlichte [_1]',
	'Scheduled [_1]' => 'Zeitgeplante [_1]',
	'My [_1]' => 'Meine [_1]',
	'[_1] with comments in the last 7 days' => '[_1] mit Kommentaren in den letzten 7 Tagen',
	'[_1] posted between [_2] and [_3]' => 'Zwischen dem [_2] und dem [_3] veröffentlichte [_1]',
	'[_1] posted since [_2]' => 'Seit dem [_2] veröffentlichte [_1]',
	'[_1] posted on or before [_2]' => 'Am oder vor dem [_2] veröffentlichte [_1]',
	'All comments by [_1] \'[_2]\'' => 'Alle Kommentare von [_1] \'[_2]\'',
	'All comments for [_1] \'[_2]\'' => 'Alle Kommentare für  [_1] \'[_2]\'',
	'Comments posted between [_1] and [_2]' => 'Zwischen [_1] und [_2] veröffentlichte Kommentare',
	'Comments posted since [_1]' => 'Seit [_1] veröffentlichte Kommentare',
	'Comments posted on or before [_1]' => 'Bis [_1] veröffentlichte Kommentare',
	'You are not authorized to log in to this blog.' => 'Kein Zugang zu diesem Weblog.',
	'No such blog [_1]' => 'Kein Weblog [_1]',
	'Edit Template' => 'Vorlage bearbeiten',
	'Unknown object type [_1]' => 'Unbekannter Objekttyp [_1]',
	'Error during publishing: [_1]' => 'Fehler bei der Veröffentlichung: [_1]',
	'This is You' => 'Das sind Sie',
	'Handy Shortcuts' => 'Schnellzugriff',
	'Movable Type News' => 'News von Movable Type',
	'Blog Stats' => 'Statistik',
	'Refresh Blog Templates' => 'Blog-Vorlagen neu aufbauen',
	'Refresh Global Templates' => 'Globale Vorlagen neu aufbauen',
	'Use Publishing Profile' => 'Verwende Veröffentlichungsprofil', # Translate - New # OK
	'Unpublish Entries' => 'Einträge nicht mehr veröffentlichen',
	'Add Tags...' => 'Tags hinzufügen...',
	'Tags to add to selected entries' => 'Zu gewählten Einträgen hinzuzufügende Tags',
	'Remove Tags...' => 'Tags entfernen...',
	'Tags to remove from selected entries' => 'Von gewählten Einträgen zu entfernende Tags',
	'Batch Edit Entries' => 'Mehrere Einträge bearbeiten',
	'Unpublish Pages' => 'Seiten nicht mehr veröffentlichen',
	'Tags to add to selected pages' => 'Zu gewählten Seiten hinzuzufügende Tags',
	'Tags to remove from selected pages' => 'Von gewählten Seiten zu entfernende Tags',
	'Batch Edit Pages' => 'Mehrere Seiten bearbeiten',
	'Tags to add to selected assets' => 'Zu gewählten Assets hinzuzufügende Tags',
	'Tags to remove from selected assets' => 'Von gewählten Assets zu entfernende Tags',
	'Unpublish TrackBack(s)' => 'TrackBack(s) nicht mehr veröffentlichen',
	'Unpublish Comment(s)' => 'Kommentar(e) nicht mehr veröffentlichen',
	'Trust Commenter(s)' => 'Kommentarautor(en) vertrauen',
	'Untrust Commenter(s)' => 'Kommentarautor(en) nicht mehr vertrauen',
	'Ban Commenter(s)' => 'Kommentarautor(en) sperren',
	'Unban Commenter(s)' => 'Kommentator(en) nicht mehr sperren',
	'Recover Password(s)' => 'Passwort anfordern',
	'Delete' => 'Löschen',
	'Refresh Template(s)' => 'Vorlage(n) neu aufbauen',
	'Publish Template(s)' => 'Vorlage(n) veröffentlichen',
	'Clone Template(s)' => 'Vorlage(n) klonen', # Translate - New # OK
	'Non-spam TrackBacks' => 'TrackBacks (außer Spam)',
	'TrackBacks on my entries' => 'TrackBacks zu meinen Einträgen',
	'Published TrackBacks' => 'Veröffentlichte TrackBacks',
	'Unpublished TrackBacks' => 'Unveröffentlichte TrackBacks',
	'TrackBacks marked as Spam' => 'Als Spam markierte TrackBacks',
	'All TrackBacks in the last 7 days' => 'Alle TrackBacks der letzten 7 Tage',
	'Non-spam Comments' => 'Kommentare (außer Spam)',
	'Comments on my entries' => 'Kommentare zu meinen Einträgen',
	'Pending comments' => 'Zu moderierende Kommentare',
	'Spam Comments' => 'Spam-Kommentare',
	'Published comments' => 'Veröffentlichte Kommentare',
	'Comments in the last 7 days' => 'Kommentare der letzten 7 Tage',
	'E-mail Templates' => 'E-Mail-Vorlagen',
	'Tags with entries' => 'Eintrags-Tags',
	'Tags with pages' => 'Seiten-Tags',
	'Tags with assets' => 'Assets-Tags',
	'Enabled Users' => 'Aktive Benutzerkonten',
	'Disabled Users' => 'Deaktivierte Benutzerkonten',
	'Pending Users' => 'Wartende Benutzer',
	'Create' => 'Neu',
	'Manage' => 'Verwalten',
	'Design' => 'Gestalten',
	'Preferences' => 'Konfigurieren',
	'Tools' => 'Tools',
	'Address Book' => 'Adressbuch',
	'Widgets' => 'Widgets',
	'General' => 'Allgemein',
	'Feedback' => 'Feedback',
	'Comment' => 'Kommentar',
	'Registration' => 'Registrierung',
	'Spam' => 'Spam',
	'Web Services' => 'Webdienste',
	'Plugins' => 'Plugins',
	'Import' => 'Importieren',
	'Export' => 'Exportieren',
	'System Information' => 'Systeminformation',
	'System Overview' => 'Systemübersicht',

## lib/MT/App/Viewer.pm
	'Loading blog with ID [_1] failed' => 'Das Blog mit der ID [_1] konte nicht geladen werden',
	'Template publishing failed: [_1]' => 'Die Vorlage konnte nicht veröffentlicht werden: [_1]',
	'Invalid date spec' => 'Ungültiges Datumsformat',
	'Can\'t load templatemap' => 'Kann Vorlagenzuweisungen nicht laden', # Translate - New # OK
	'Can\'t load template [_1]' => 'Kann Vorlage [_1] nicht laden', # Translate - Improved (1) # OK
	'Archive publishing failed: [_1]' => 'Das Archiv konnte nicht veröffentlicht werden: [_1]',
	'Invalid entry ID [_1]' => 'Ungültige Eintrags-ID [_1]',
	'Entry [_1] is not published' => 'Eintrag [_1] nicht veröffentlicht',
	'Invalid category ID \'[_1]\'' => 'Ungültige Kategorie-ID \'[_1]\'',

## lib/MT/App/ActivityFeeds.pm
	'Error loading [_1]: [_2]' => 'Fehler beim Laden von [_1]: [_2]',
	'An error occurred while generating the activity feed: [_1].' => 'Fehler beim Anlegen des Aktivitäts-Feeds: [_1].',
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
	'[_1] Weblog Pages' => 'Seiten des Weblogs',
	'All Weblog Pages' => 'Alle Seiten des Weblogs',

## lib/MT/AtomServer.pm
	'[_1]: Entries' => '[_1]: Einträge', # Translate - New # OK
	'PreSave failed [_1]' => 'PreSave fehlgeschlagen [_1]',
	'User \'[_1]\' (user #[_2]) added [lc,_4] #[_3]' => '[_4] (#[_3]) von Benutzer \'[_1]\' (Benutzer-Nr. [_2]) hinzugefügt.',
	'User \'[_1]\' (user #[_2]) edited [lc,_4] #[_3]' => '[_4] (#[_3]) von Benutzer \'[_1]\' (Benutzer-Nr. [_2]) bearbeitet.',

## lib/MT/PluginData.pm
	'Plugin Data' => 'Plugin-Daten',

## lib/MT/Plugin.pm
	'Publish' => 'Veröffentlichen',
	'My Text Format' => 'Mein Textformat',

## lib/MT/Entry.pm
	'Draft' => 'Entwurf',
	'Review' => 'Zur Überprüfung',
	'Future' => 'Künftig',

## lib/MT/Role.pm
	'Role' => 'Rolle',

## lib/MT/Config.pm
	'Configuration' => 'Konfiguration',

## lib/MT/ImportExport.pm
	'No Blog' => 'Kein Blog',
	'Need either ImportAs or ParentAuthor' => 'Entweder ImportAs oder ParentAuthor erforderlich',
	'Creating new user (\'[_1]\')...' => 'Lege neuen Benutzer an (\'[_1]\')...',
	'Saving user failed: [_1]' => 'Das Benutzerkonto konnte nicht gespeichert werden: [_1]',
	'Assigning permissions for new user...' => 'Weise neuem Benutzer Berechigungen zu...',
	'Saving permission failed: [_1]' => 'Die Berechtigungen konnten nicht gespeichert werden: [_1]',
	'Creating new category (\'[_1]\')...' => 'Lege neue Kategorie an (\'[_1]\')...',
	'Invalid status value \'[_1]\'' => 'Ungültiger Status-Wert \'[_1]\'',
	'Invalid allow pings value \'[_1]\'' => 'Ungültiger Ping-Status \'[_1]\'',
	'Can\'t find existing entry with timestamp \'[_1]\'... skipping comments, and moving on to next entry.' => 'Kann vorhandenen Eintrag mit Zeitstempel \'[_1]\' nicht finden, überspringe Kommentare und fahre mit nächstem Eintrag fort...',
	'Importing into existing entry [_1] (\'[_2]\')' => 'Importiere in vorhandenen Eintrag [_1] (\'[_2]\')',
	'Saving entry (\'[_1]\')...' => 'Speichere Eintrag (\'[_1]\')...',
	'ok (ID [_1])' => 'OK',
	'Saving entry failed: [_1]' => 'Der Eintrag konnte nicht gespeichert werden: [_1]',
	'Creating new comment (from \'[_1]\')...' => 'Lege neuen Kommentar an (von \'[_1]\')...',
	'Saving comment failed: [_1]' => 'Der Kommentar konnte nicht gespeichert werden: [_1]',
	'Entry has no MT::Trackback object!' => 'Eintrag hat kein MT::Trackback-Objekt!',
	'Creating new ping (\'[_1]\')...' => 'Erzeuge neuen Ping an (\'[_1]\')...',
	'Saving ping failed: [_1]' => 'Der Ping konnte nicht gespeichert werden: [_1]',
	'Export failed on entry \'[_1]\': [_2]' => 'Export bei Eintrag \'[_1]\' fehlgeschlagen: [_2]',
	'Invalid date format \'[_1]\'; must be \'MM/DD/YYYY HH:MM:SS AM|PM\' (AM|PM is optional)' => 'Ungültiges Datumsformat \'[_1]\';  muss \'MM/TT/JJJJ HH:MM:SS AM|PM\' sein (AM|PM optional)',

## lib/MT/Template.pm
	'Template' => 'Vorlage',
	'File not found: [_1]' => 'Datei nicht gefunden: [_1]', # Translate - New # OK
	'Error reading file \'[_1]\': [_2]' => 'Fehler beim Einlesen der Datei \'[_1]\': [_2]',
	'Publish error in template \'[_1]\': [_2]' => 'Veröffentlichungsfehler in Vorlage \'[_1]\': [_2]',
	'Template with the same name already exists in this blog.' => 'Es ist bereits eine Vorlage mit gleichem Namen in diesem Weblog vorhanden.',
	'You cannot use a [_1] extension for a linked file.' => 'Sie können keine [_1]-Erweiterung für eine verlinkte Datei verwenden.',
	'Opening linked file \'[_1]\' failed: [_2]' => 'Die verlinkte Datei \'[_1]\' konnte nicht geöffnet werden: [_2]',
	'Index' => 'Index',
	'Category Archive' => 'Kategoriearchiv',
	'Comment Listing' => 'Liste der Kommentare',
	'Ping Listing' => 'Liste der Pings',
	'Comment Preview' => 'Kommentarvorschau',
	'Comment Error' => 'Kommentarfehler',
	'Dynamic Error' => 'Dynamischer Fehler',
	'Uploaded Image' => 'Hochgeladendes Bild',
	'Module' => 'Modul',
	'Widget' => 'Widget',

## lib/MT/JunkFilter.pm
	'Action: Junked (score below threshold)' => 'Aktion: Als Junk eingestuft (Bewertung unterschreitet Schwellenwert)',
	'Action: Published (default action)' => 'Aktion: Veröffentlicht (Standardaktion)',
	'Junk Filter [_1] died with: [_2]' => 'Junk-Filter [_1] abgebrochen: [_2]',
	'Unnamed Junk Filter' => 'Namenloser Junk Filter',
	'Composite score: [_1]' => 'Gesamtbewertung: [_1]',

## lib/MT/Util.pm
	'moments from now' => 'in einem Augenblick',
	'[quant,_1,hour,hours] from now' => 'in [quant,_1,Stunde,Stunden]',
	'[quant,_1,minute,minutes] from now' => 'in [quant,_1,Minute,Minuten]',
	'[quant,_1,day,days] from now' => 'in [quant,_1,Tag,Tagen]',
	'less than 1 minute from now' => 'in weniger als 1 Minute',
	'less than 1 minute ago' => 'vor weniger als 1 Minute',
	'[quant,_1,hour,hours], [quant,_2,minute,minutes] from now' => 'in [quant,_1,Stunde,Stunden] [quant,_1,Minute,Minuten]',
	'[quant,_1,hour,hours], [quant,_2,minute,minutes] ago' => 'vor [quant,_1,Stunde,Stunden] [quant,_1,Minute,Minuten]',
	'[quant,_1,day,days], [quant,_2,hour,hours] from now' => 'in [quant,_1,Tag,Tagen] [quant,_1,Stunde,Stunden]',
	'[quant,_1,day,days], [quant,_2,hour,hours] ago' => 'vor [quant,_1,Tag,Tagen] [quant,_1,Stunde,Stunden]',
	'[quant,_1,second,seconds] from now' => 'in [quant,_1,Sekunde,Sekunden]', # Translate - New # OK
	'[quant,_1,second,seconds]' => '[quant,_1,Sekunde,Sekunden]', # Translate - New # OK
	'[quant,_1,minute,minutes], [quant,_2,second,seconds] from now' => 'in [quant,_1,Minute,Minuten] und [quant,_2,Sekunde,Sekunden]', # Translate - New # OK
	'[quant,_1,minute,minutes], [quant,_2,second,seconds]' => '[quant,_1,Minute,Minuten] und [quant,_2,Sekunde,Sekunden]', # Translate - New # OK
	'[quant,_1,minute,minutes]' => '[quant,_1,Minute,Minuten]', # Translate - New # OK
	'[quant,_1,hour,hours], [quant,_2,minute,minutes]' => '[quant,_1,Stunde,Stunden] und [quant,_2,Minute,Minuten]', # Translate - New # OK
	'[quant,_1,hour,hours]' => '[quant,_1,Stunde,Stunden]', # Translate - New # OK
	'[quant,_1,day,days], [quant,_2,hour,hours]' => '[quant,_1,Tag,Tage] und [quant,_2,Stunde,Stunden]', # Translate - New # OK
	'[quant,_1,day,days]' => '[quant,_1,Tag,Tage]', # Translate - New # OK

## lib/MT/Mail.pm
	'Unknown MailTransfer method \'[_1]\'' => 'Unbekannte MailTransfer-Methode \'[_1]\'',
	'Sending mail via SMTP requires that your server have Mail::Sendmail installed: [_1]' => 'Für das Versenden von E-Mail mittels SMTP ist Mail::Sendmail erforderlich: [_1]',
	'Error sending mail: [_1]' => 'Fehler beim Versenden von Mail: [_1]',
	'You do not have a valid path to sendmail on your machine. Perhaps you should try using SMTP?' => 'Kein gültiger sendmail-Pfad gefunden. Versuchen Sie stattdessen SMTP zu verwenden.',
	'Exec of sendmail failed: [_1]' => 'Sendmail konnte nicht ausgeführt werden: [_1]',

## lib/MT/Worker/Publish.pm
	'Background Publishing Done' => 'Veröffentlichung im Hintergrund abgeschlossen', # Translate - New # OK
	'Published: [_1]' => 'Veröffentlicht: [_1]', # Translate - New # OK
	'-- set complete ([quant,_1,file,files] in [_2] seconds)' => '-- Gruppe komplett ([quant,_1,Datei,Dateien in [_2] Sekunden)',

## lib/MT/Worker/Sync.pm
	'Synchrnizing Files Done' => 'Synchronisierung der Dateien abgeschlossen', # Translate - New # OK
	'Done syncing files to [_1] ([_2])' => 'Die Dateien wurden mit [_1] ([_2]) synchronisiert', # Translate - New # OK

## lib/MT/Auth.pm
	'Bad AuthenticationModule config \'[_1]\': [_2]' => 'Fehlerhafte AuthenticationModule-Konfiguration \'[_1]\': [_2]',
	'Bad AuthenticationModule config' => 'Fehlerhafte AuthenticationModule-Konfiguration',

## lib/MT/WeblogPublisher.pm
	'Archive type \'[_1]\' is not a chosen archive type' => 'Archivtyp \'[_1]\' wurde vorher nicht ausgewählt',
	'Parameter \'[_1]\' is required' => 'Parameter \'[_1]\' erforderlich',
	'You did not set your blog publishing path' => 'Veröffentlichungspfade nicht gesetzt',
	'The same archive file exists. You should change the basename or the archive path. ([_1])' => 'Diese Archivdatei existiert bereits. Ändern Sie entweder den Basisnamen oder den Archivpfad. ([_1])',
	'An error occurred publishing [_1] \'[_2]\': [_3]' => 'Fehler bei der Veröffentlichung von  [_1] \'[_2]\': [_3]',
	'An error occurred publishing date-based archive \'[_1]\': [_2]' => 'Fehler bei Veröffentlichtung des Archivs \'[_1]\': [_2]',
	'Renaming tempfile \'[_1]\' failed: [_2]' => 'Temporäre Datei \'[_1]\' konnte nicht umbenannt werden: [_2]',
	'Template \'[_1]\' does not have an Output File.' => 'Vorlage \'[_1]\' hat keine Ausgabedatei.',
	'An error occurred while publishing scheduled entries: [_1]' => 'Fehler bei der Veröffentlichung zeitgeplanter Einträge: [_1]',

## lib/MT/Permission.pm
	'Permission' => 'Berechtigung',
	'Permissions' => 'Berechtigungen',

## lib/MT/Scorable.pm
	'Object must be saved first.' => 'Objekt muss zuerst gespeichert werden.',
	'Already scored for this object.' => 'Bewertung für dieses Objekt bereits abgegeben.',
	'Could not set score to the object \'[_1]\'(ID: [_2])' => 'Konnte Bewertung für Objekt \'[_1]\' (ID: [_2]) nicht speichern.',

## lib/MT/XMLRPCServer.pm
	'Invalid timestamp format' => 'Ungültiges Zeitstempel-Format',
	'No web services password assigned.  Please see your user profile to set it.' => 'Kein Passwort für Webdienste vergeben. Das Passwort kann im Benutzerprofil angegeben werden.',
	'Requested permalink \'[_1]\' is not available for this page' => 'Der gewünschte Permalink \'[_1]\' ist für diese Seite nicht verfügbar.',
	'Saving folder failed: [_1]' => 'Speichern des Ordners fehlgeschlagen: [_1]',
	'No blog_id' => 'Blog_id fehlt',
	'Invalid blog ID \'[_1]\'' => 'Ungültige Blog-ID \'[_1]\'',
	'Value for \'mt_[_1]\' must be either 0 or 1 (was \'[_2]\')' => '\'mt_[_1]\' kann nur 0 oder 1 sein (war \'[_2]\')',
	'Not privileged to edit entry' => 'Keine Bearbeitungsrechte',
	'Entry \'[_1]\' ([lc,_5] #[_2]) deleted by \'[_3]\' (user #[_4]) from xml-rpc' => 'Eintrag \'[_1]\' ([_5] #[_2]) von \'[_3]\' (Benutzer-Nr. [_4]) per XML-RPC gelöscht',
	'Not privileged to get entry' => 'Keine Leserechte',
	'Not privileged to set entry categories' => 'Keine Rechte zur Vergabe von Kategorien',
	'Not privileged to upload files' => 'Keine Upload-Rechte',
	'No filename provided' => 'Kein Dateiname angegeben',
	'Error writing uploaded file: [_1]' => 'Fehler beim Schreiben der hochgeladenen Datei: [_1]',
	'Template methods are not implemented, due to differences between the Blogger API and the Movable Type API.' => 'Funktionen zum Zugriff auf Vorlagen sind auf Grund von Unterschieden zwischen der Blogger-API und der MovableType-API nicht implementiert.',

## lib/MT/Component.pm
	'Loading template \'[_1]\' failed: [_2]' => 'Die Vorlage \'[_1]\' konnte nicht geladen werden: [_2]',

## lib/MT/Comment.pm
	'Load of entry \'[_1]\' failed: [_2]' => 'Der Eintrag \'[_1]\' konnte nicht geladen werden: [_2]',

## lib/MT/DefaultTemplates.pm
	'Archive Index' => 'Archivindex',
	'Stylesheet' => 'Stylesheet',
	'Feed - Recent Entries' => 'Feed - Aktuelle Einträge', # Translate - New # OK
	'RSD' => 'RSD',
	'Monthly Entry Listing' => 'Einträge nach Monat', # Translate - New # OK
	'Category Entry Listing' => 'Einträge nach Kategorie', # Translate - New # OK
	'Displays error, pending or confirmation message for comments.' => 'Zeigt Bestätigungs-, Moderations- und Fehlermeldungen zu neuen Kommentaren an',
	'Displays preview of comment.' => 'Zeigt eine Vorschau des Kommentars an.',
	'Displays errors for dynamically published templates.' => 'Zeigt Fehlermeldungen für dynamisch veröffentlichte Vorlagen an.',
	'Popup Image' => 'Popup-Bild',
	'Displays image when user clicks a popup-linked image.' => 'Zeigt Bilder als Pop-Ups an, wenn auf ein Vorschaubild geklickt wird ',
	'Displays results of a search.' => 'Zeigt Suchergebnisse an.',
	'About This Page' => 'Über diese Seite',
	'Archive Widgets Group' => 'Archiv-Widgetgruppe', # Translate - New # OK
	'Current Author Monthly Archives' => 'Monatsarchive des aktuellen Autors',
	'Calendar' => 'Kalendar',
	'Creative Commons' => 'Creative Commons',
	'Home Page Widgets Group' => 'Startseiten-Widgetgruppe', # Translate - New # OK
	'Monthly Archives Dropdown' => 'Monatsarchive (Dropdown)',
	'Page Listing' => 'Seitenübersicht',
	'Powered By' => 'Powered by',
	'Syndication' => 'Syndizierung',
	'Technorati Search' => 'Technorati-Suche',
	'Date-Based Author Archives' => 'Datumsbasierte Autorenarchive',
	'Date-Based Category Archives' => 'Datumsbasierte Kategoriearchive',
	'Comment throttle' => 'Kommentarbegrenzung',
	'Commenter Confirm' => 'Kommentarautorenbestätigung',
	'Commenter Notify' => 'Kommentarautorenbenachrichtigung',
	'New Comment' => 'Neuer Kommentar',
	'New Ping' => 'Neuer Ping',
	'Entry Notify' => 'Eintragsbenachrichtigung',
	'Subscribe Verify' => 'Abonnementbestätigung',

## lib/MT.pm.pre
	'Powered by [_1]' => 'Powered by [_1]',
	'Version [_1]' => 'Version [_1]',
	'http://www.sixapart.com/movabletype/' => 'http://www.movabletype.org/sitede',
	'OpenID URL' => 'OpenID-URL',
	'Sign in using your OpenID identity.' => 'Mit Ihrer OpenID-Kennung anmelden',
	'OpenID is an open and decentralized single sign-on identity system.' => 'OpenID ist ein offenes und dezentrales Single Sign On-System',
	'Sign in' => 'Anmelden',
	'Learn more about OpenID.' => 'Mehr über OpenID erfahren',
	'Your LiveJournal Username' => 'Ihr LiveJournal-Benutzername',
	'Sign in using your Vox blog URL' => 'Mit Ihrer Vox-Blog-URL anmelden',
	'Learn more about LiveJournal.' => 'Mehr über LiveJournal erfahren',
	'Your Vox Blog URL' => 'Ihre Vox-Blog-URL',
	'Learn more about Vox.' => 'Mehr über Vox erfahren',
	'TypeKey is a free, open system providing you a central identity for posting comments on weblogs and logging into other websites. You can register for free.' => 'TypeKey ist ein offenes Identitätssystem, mit dem Sie sich zum Verfassen von Kommentaren und zu anderen Zwecken an Websites anmelden können. TypeKey ist ein kostenloser Dienst.',
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
	'Missing configuration file. Maybe you forgot to move mt-config.cgi-original to mt-config.cgi?' => 'Keine Konfigurationsdatei gefunden. Haben Sie möglicheweise vergessen, mt-config.cgi-original in mt-config.cgi umzubennen?',
	'Plugin error: [_1] [_2]' => 'Plugin-Fehler: [_1] [_2]',
	'Loading template \'[_1]\' failed.' => 'Die Vorlage \'[_1]\' konnte nicht geladen werden.',
	'__PORTAL_URL__' => '__PORTAL_URL__',
	'http://www.movabletype.org/documentation/' => 'http://www.movabletype.org/documentation/',
	'OpenID' => 'OpenID',
	'LiveJournal' => 'LiveJournal',
	'Vox' => 'Vox',
	'TypeKey' => 'TypeKey',
	'Movable Type default' => 'Movable Type-Standard',

## mt-static/mt.js
	'delete' => 'löschen',
	'remove' => 'entfernen',
	'enable' => 'aktivieren',
	'disable' => 'deaktivieren',
	'You did not select any [_1] to [_2].' => 'Keine [_1] zu [_2] gewählt.',
	'Are you sure you want to [_2] this [_1]?' => '[_1] wirklich [_2]?',
	'Are you sure you want to [_3] the [_1] selected [_2]?' => 'Die [_1] ausgewählten [_2] wirklich [_3]?',
	'Are you certain you want to remove this role? By doing so you will be taking away the permissions currently assigned to any users and groups associated with this role.' => 'Rolle wirklich entfernen? Entfernen der Rolle entzieht allen derzeit damit verknüpften Benutzern und Gruppen die entsprechenden Berechtigungen.',
	'Are you certain you want to remove these [_1] roles? By doing so you will be taking away the permissions currently assigned to any users and groups associated with these roles.' => '[_1] Rolle(n) wirklich entfernen? Entfernen der Rollen entzieht allen derzeit damit verknüpften Benutzern und Gruppen die entsprechenden Berechtigungen.',
	'You did not select any [_1] [_2].' => 'Sie haben keine [_1] [_2] gewählt',
	'You can only act upon a minimum of [_1] [_2].' => 'Nur möglich für mindestens [_1] [_2].',
	'You can only act upon a maximum of [_1] [_2].' => 'Nur möglich für höchstens [_1] [_2].',
	'You must select an action.' => 'Bitte wählen Sie zunächst eine Aktion.',
	'to mark as spam' => 'zur Markierung als Spam',
	'to remove spam status' => 'zum Entfernen des Spam-Status',
	'Enter email address:' => 'E-Mail-Adresse eingeben:',
	'Enter URL:' => 'URL eingeben:',
	'The tag \'[_2]\' already exists. Are you sure you want to merge \'[_1]\' with \'[_2]\'?' => 'Der Tag \'[_2]\' ist bereits vorhanden. Soll \'[_1]\' wirklich mit \'[_2]\' zusammengeführt werden?',
	'The tag \'[_2]\' already exists. Are you sure you want to merge \'[_1]\' with \'[_2]\' across all weblogs?' => 'Der Tag \'[_2]\' ist bereits vorhanden. Soll \'[_1]\' wirklich in allen Weblogs mit \'[_2]\' zusammengeführt werden?',
	'Loading...' => 'Lade...',
	'[_1] &ndash; [_2] of [_3]' => '[_1] &ndash; [_2] von [_3]',
	'[_1] &ndash; [_2]' => '[_1] &ndash; [_2]',

## mt-static/js/dialog.js
	'(None)' => '(Keine)',

## mt-static/js/assetdetail.js
	'No Preview Available' => 'Vorschau nicht verfügbar',
	'View uploaded file' => 'Hochgeladene Datei ansehen',

## search_templates/comments.tmpl
	'Search for new comments from:' => 'Suche nach neuen Kommentaren:',
	'the beginning' => 'ingesamt',
	'one week back' => 'der letzten Woche',
	'two weeks back' => 'der letzten zwei Wochen',
	'one month back' => 'des letzten Monats',
	'two months back' => 'der letzten zwei Monate',
	'three months back' => 'der letzten drei Monate',
	'four months back' => 'der letzten vier Monate',
	'five months back' => 'der letzten fünf Monate',
	'six months back' => 'der letzten sechs Monate',
	'one year back' => 'des letzten Jahres',
	'Find new comments' => 'Neue Kommentare finden',
	'Posted in [_1] on [_2]' => 'Veröffentlicht in [_1] am [_2]',
	'No results found' => 'Keine Treffer',
	'No new comments were found in the specified interval.' => 'Keine neuen Kommentare in diesem Zeitraum gefunden.',
	'Select the time interval that you\'d like to search in, then click \'Find new comments\'' => 'Wählen Sie den gewünschten Zeitraum und klicken Sie dann auf \'Neue Kommentare finden\'.',

## search_templates/default.tmpl
	'SEARCH FEED AUTODISCOVERY LINK PUBLISHED ONLY WHEN A SEARCH HAS BEEN EXECUTED' => 'SEARCH FEED AUTODISCOVERY-LINK WIRD NUR ANGEZEIGT, WENN EINE SUCHE AUSGEFÜHRT WURDE',
	'Blog Search Results' => 'Suchergebnisse',
	'Blog search' => 'Blogsuche',
	'STRAIGHT SEARCHES GET THE SEARCH QUERY FORM' => 'EINFACHE SUCHEN - EINFACHES FORMULAR',
	'Search this site' => 'Diese Site durchsuchen',
	'Match case' => 'Groß-/Kleinschreibung beachten',
	'SEARCH RESULTS DISPLAY' => 'SUCHERGEBNISSANZEIGE',
	'Matching entries from [_1]' => 'Treffer in [_1]',
	'Entries from [_1] tagged with \'[_2]\'' => 'Mit \'[_2]\' getaggte Einträge aus [_1]',
	'Posted <MTIfNonEmpty tag="EntryAuthorDisplayName">by [_1] </MTIfNonEmpty>on [_2]' => 'Geschrieben <MTIfNonEmpty tag="EntryAuthorDisplayName">von [_1] </MTIfNonEmpty>am [_2]',
	'Showing the first [_1] results.' => 'Erste [_1] Treffer',
	'NO RESULTS FOUND MESSAGE' => 'KEINE TREFFER-NACHRICHT',
	'Entries matching \'[_1]\'' => 'Einträge mit \'[_1]\'',
	'Entries tagged with \'[_1]\'' => 'Mit \'[_1]\' getaggte Einträge',
	'No pages were found containing \'[_1]\'.' => 'Keine Seiten mit \'[_1]\' gefunden.',
	'By default, this search engine looks for all words in any order. To search for an exact phrase, enclose the phrase in quotes' => 'Die Suchfunktion sucht standardmäßig nach allen angebenen Begriffen in beliebiger Reihenfolge. Um nach einem exakten Ausdruck zu suchen, setzen Sie diesen bitte in Anführungszeichen.',
	'The search engine also supports AND, OR, and NOT keywords to specify boolean expressions' => 'Die boolschen Operatoren AND, OR und NOT werden unterstützt.',
	'END OF ALPHA SEARCH RESULTS DIV' => 'DIV ALPHA SUCHERGEBNISSE ENDE',
	'BEGINNING OF BETA SIDEBAR FOR DISPLAY OF SEARCH INFORMATION' => 'DIV BETA SUCHINFOS ANFANG',
	'SET VARIABLES FOR SEARCH vs TAG information' => 'SETZE VARIABLEN FÜR SUCHE VS TAG-Information',
	'If you use an RSS reader, you can subscribe to a feed of all future entries tagged \'[_1]\'.' => 'Wenn Sie einen Feedreader verwenden, können Sie einen Feed aller neuen mit \'[_1]\' getaggten Einträge abonnieren.',
	'If you use an RSS reader, you can subscribe to a feed of all future entries matching \'[_1]\'.' => 'Wenn Sie einen Feedreader verwenden, können Sie einen Feed aller neuen Einträge mit \'[_1]\' abonnieren.',
	'SEARCH/TAG FEED SUBSCRIPTION INFORMATION' => 'SUCHE/TAG FEED-ABO-INFO',
	'Feed Subscription' => 'Feed abonnieren',
	'http://www.sixapart.com/about/feeds' => 'http://www.sixapart.com/about/feeds',
	'What is this?' => 'Was ist das?',
	'TAG LISTING FOR TAG SEARCH ONLY' => 'TAG-LISTE NUR FÜR SUCHE',
	'Other Tags' => 'Andere Tags',
	'END OF PAGE BODY' => 'PAGE BODY ENDE',
	'END OF CONTAINER' => 'CONTAINER ENDE',

## search_templates/results_feed_rss2.tmpl
	'Search Results for [_1]' => 'Suchergebnisse für [_1]',

## search_templates/results_feed.tmpl

## tmpl/wizard/optional.tmpl
	'Mail Configuration' => 'Mailkonfigurierung',
	'Your mail configuration is complete.' => 'Ihre Mail-Konfigurierung ist abgeschlossen.',
	'Check your email to confirm receipt of a test email from Movable Type and then proceed to the next step.' => 'Überprüfen Sie den Eingang der Testmail in Ihrem Postfach und fahren Sie dann mit dem nächsten Schritt fort.',
	'Back' => 'Zurück',
	'Continue' => 'Weiter',
	'Show current mail settings' => 'Mail-Einstellungen anzeigen',
	'Periodically Movable Type will send email to inform users of new comments as well as other other events. For these emails to be sent properly, you must instruct Movable Type how to send email.' => 'Geben Sie an, auf welchem Wege Movable Type E-Mails verschicken soll. E-Mails werden beispielsweise zur Benachrichtigung über neue Kommentare verschickt.',
	'An error occurred while attempting to send mail: ' => 'Mailversand fehlgeschlagen: ',
	'Send email via:' => 'E-Mails versenden per:',
	'Select One...' => 'Auswählen...',
	'sendmail Path' => 'sendmail-Pfad',
	'The physical file path for your sendmail binary.' => 'Pfad zu sendmail',
	'Outbound Mail Server (SMTP)' => 'SMTP-Server',
	'Address of your SMTP Server.' => 'Adresse Ihres SMTP-Servers',
	'Mail address for test sending' => 'Empfängeradresse für Testmail',
	'Send Test Email' => 'Testmail verschicken',

## tmpl/wizard/complete.tmpl
	'Configuration File' => 'Konfigurationsdatei',
	'The [_1] configuration file can\'t be located.' => 'Die [_1]-Konfigurationsdatei kann nicht gefunden werden.',
	'Please use the configuration text below to create a file named \'mt-config.cgi\' in the root directory of [_1] (the same directory in which mt.cgi is found).' => 'Kopieren Sie folgenden Text in eine Datei namens \'mt-config.cgi\' und legen diese im Movable Type-Hauptverzeichnis ab (das Verzeichnis, in dem sich auch die Datei mt.cgi befindet)',
	'The wizard was unable to save the [_1] configuration file.' => 'Die [_1]-Konfigurationsdatei konnte nicht gespeichert werden.',
	'Confirm your [_1] home directory (the directory that contains mt.cgi) is writable by your web server and then click \'Retry\'.' => 'Bitte überprüfen Sie, ob der Webserver Schreibrechte für Ihr [_1]-Hauptverzeichnis hat und klicken Sie dann auf "Erneut versuchen".',
	'Congratulations! You\'ve successfully configured [_1].' => 'Herzlichen Glückwunsch! Sie haben die [_1] erfolgreich konfiguriert.',
	'Your configuration settings have been written to the following file:' => 'Ihre Einstellungen wurden in folgender Datei gespeichert:',
	'To reconfigure the settings, click the \'Back\' button below.' => 'Um Änderungen an den Einstellungen vorzunehmen, klicken Sie auf \'Zurück\'.',
	'Show the mt-config.cgi file generated by the wizard' => 'Vom Konfigurationshelfer erzeugte mt-config.cgi-Datei anzeigen',
	'I will create the mt-config.cgi file manually.' => 'Ich werde mt-config.cgi manuell anlegen',
	'Retry' => 'Erneut versuchen',

## tmpl/wizard/cfg_dir.tmpl
	'Temporary Directory Configuration' => 'Konfigurierung des temporären Verzeichnisses',
	'You should configure you temporary directory settings.' => 'Hier legen Sie fest, in welchem Verzeichnis temporäre Dateien gespeichert werden.',
	'Your TempDir has been successfully configured. Click \'Continue\' below to continue configuration.' => 'TempDir erfolgreich konfiguriert. Sie können die Konfigurierung nun fortsetzen.',
	'[_1] could not be found.' => '[_1] nicht gefunden.',
	'TempDir is required.' => 'TempDir ist erforderlich.',
	'TempDir' => 'TempDir',
	'The physical path for temporary directory.' => 'Pfad Ihres temporären Verzeichnisses',
	'Test' => 'Test',

## tmpl/wizard/start.tmpl
	'Welcome to Movable Type' => 'Willkommen zu Movable Type',
	'Configuration File Exists' => 'Es ist bereits eine Konfigurationsdatei vorhanden',
	'A configuration (mt-config.cgi) file already exists, <a href="[_1]">sign in</a> to Movable Type.' => 'Es ist bereits eine Konfigurationsdatei (mt-config.cgi) vorhanden. Sie können sich daher sofort <a href="[_1]">bei Movable Type anmelden</a>.',
	'To create a new configuration file using the Wizard, remove the current configuration file and then refresh this page' => 'Um mit dem Konfigurationshelfer eine neue Konfigurationsdatei zu erzeugen, entfernen Sie die vorhandene Konfigurationsdatei und laden Sie diese Seite neu.',
	'Movable Type requires that you enable JavaScript in your browser. Please enable it and refresh this page to proceed.' => 'Movable Type erfordert JavaScript. Bitte aktivieren Sie es in Ihren Browsereinstellungen und laden diese Seite dann neu.',
	'This wizard will help you configure the basic settings needed to run Movable Type.' => 'Dieser Konfigurationshelfer hilft Ihnen, die zum Betrieb von Movable Type erforderlichen Grundeinstellungen vorzunehmen.',
	'<strong>Error: \'[_1]\' could not be found.</strong>  Please move your static files to the directory first or correct the setting if it is incorrect.' => '<strong>Fehler: \'[_1]\' konnte nicht gefunden werden.</strong> Bitte kopieren Sie erst die statischen Dateien in den Ordner oder überprüfen Sie, falls das bereits geschehen ist, die Einstellungen.',
	'Configure Static Web Path' => 'Statischen Web-Pfad konfigurieren',
	'Movable Type ships with directory named [_1] which contains a number of important files such as images, javascript files and stylesheets.' => 'Movable Type wird mit einem Verzeichnis namens [_1] ausgeliefert, das einige wichtige Bild-, JavaScript- und Stylesheet-Dateien enthält.',
	'The [_1] directory is in the main Movable Type directory which this wizard script resides, but due to your web server\'s configuration, the [_1] directory is not accessible in this location and must be moved to a web-accessible location (e.g., your web document root directory).' => 'Der [_1]-Ordner befindet sich im Hauptverzeichnis von Movable Type, ist aufgrund der Serverkonfiguration vom Webserver aber nicht erreichbar. Verschieben Sie den Ordner [_1] daher an einen Ort, auf dem der Webserver zugreifen kann (z.B. Document Root).',
	'This directory has either been renamed or moved to a location outside of the Movable Type directory.' => 'Das Verzeichnis wurde entweder umbenannt oder an einen Ort außerhalb des Movable Type-Verzeichnisses verschoben.',
	'Once the [_1] directory is in a web-accessible location, specify the location below.' => 'Wenn Sie den [_1]-Ordner an einen vom Webserver erreichbaren Ort verschoben haben, geben Sie die Adresse unten an.',
	'This URL path can be in the form of [_1] or simply [_2]' => 'Die Adresse kann in dieser Form: [_1] oder einfach als [_2] angegeben werden. ',
	'This path must be in the form of [_1]' => 'Der Pfad muss in dieser Form angegeben werden: [_1]',
	'Static web path' => 'Statischer Webpfad',
	'Static file path' => 'Statischer Dateipfad',
	'Begin' => 'Anfangen',

## tmpl/wizard/packages.tmpl
	'Requirements Check' => 'Überprüfung der Systemvoraussetzungen',
	'The following Perl modules are required in order to make a database connection.  Movable Type requires a database in order to store your blog\'s data.  Please install one of the packages listed here in order to proceed.  When you are ready, click the \'Retry\' button.' => 'Die folgenden Perl-Module sind zur Herstellung einer Datenbankverbindung erforderlich (Movable Type speichert Ihre Daten in einer Datenbank). Bitte installieren Sie die hier genannten Pakete und klicken Sie danach auf \'Erneut versuchen\'.',
	'All required Perl modules were found.' => 'Alle erforderlichen Perl-Module sind vorhanden.',
	'You are ready to proceed with the installation of Movable Type.' => 'Sie können die Installation von Movable Type fortsetzen.',
	'Some optional Perl modules could not be found. <a href="javascript:void(0)" onclick="[_1]">Display list of optional modules</a>' => 'Einige optionale Perl-Module wurden nicht gefunden. <a href="javascript:void(0)" onclick="[_1]">Optionale Module anzeigen</a>',
	'One or more Perl modules required by Movable Type could not be found.' => 'Mindestens ein von Movable Type erforderliche Perl-Modul wurde nicht gefunden.',
	'The following Perl modules are required for Movable Type to run properly. Once you have met these requirements, click the \'Retry\' button to re-test for these packages.' => 'Die folgenden Pakete sind nicht vorhanden, zur Ausführung von Movable Type aber erforderlich. Bitte installieren Sie sie und klicken dann auf \'Erneut versuchen\'.',
	'Some optional Perl modules could not be found. You may continue without installing these optional Perl modules. They may be installed at any time if they are needed. Click \'Retry\' to test for the modules again.' => 'Einige optionale Perl-Module wurden nicht gefunden. Die Installation kann ohne diese Module fortgesetzt werden. Sie können jederzeit bei Bedarf nachinstalliert werden. \'Erneut versuchen\' wiederholt die Modulsuche.',
	'Missing Database Modules' => 'Fehlende Datenbank-Module',
	'Missing Optional Modules' => 'Nicht vorhandene optionale Module',
	'Missing Required Modules' => 'Fehlende erforderliche Module',
	'Minimal version requirement: [_1]' => 'Mindestens erforderliche Version: [_1]',
	'Learn more about installing Perl modules.' => 'Mehr über die Installation von Perl-Modulen erfahren',
	'Your server has all of the required modules installed; you do not need to perform any additional module installations.' => 'Alle erforderlichen Pakete vorhanden. Sie brauchen keine weiteren Pakete zu installieren.',

## tmpl/wizard/configure.tmpl
	'Database Configuration' => 'Datenbankkonfigurierung',
	'You must set your Database Path.' => 'Pfad zur Datenbank erforderlich',
	'You must set your Database Name.' => 'Geben Sie Ihren Datenbanknamen an.',
	'You must set your Username.' => 'Geben Sie Ihren Benutzernamen an.',
	'You must set your Database Server.' => 'Geben Sie Ihren Datenbankserver an.',
	'Your database configuration is complete.' => 'Ihre Datenbankkonfigurierung ist abgeschlossen.',
	'You may proceed to the next step.' => 'Sie können mit dem nächsten Schritt fortfahren.',
	'Please enter the parameters necessary for connecting to your database.' => 'Bitte geben Sie zur Herstellung der Datenkbankverbindung notwendigen Daten ein.',
	'Show Current Settings' => 'Einstellungen anzeigen',
	'Database Type' => 'Datenbanktyp',
	'If your database type is not listed in the menu above, then you need to <a target="help" href="[_1]">install the Perl module necessary to connect to your database</a>.  If this is the case, please check your installation and <a href="javascript:void(0)" onclick="[_2]">re-test your installation</a>.' => 'Erscheint Ihr Datenbanktyp nicht in obigem Menü, <a target="help" href="[_1]">installieren Sie bitte die für Ihren Datenbanktyp notwendigen Perl-Module</a>. Sollte das bereits geschehen sein, überprüfen Sie die Installation und <a href="#" onclick="[_2]">führen Sie den Systemtest erneut aus</a>.',
	'Database Path' => 'Datenbankpfad',
	'The physical file path for your SQLite database. ' => 'Physischer Pfad zur SQLite-Datenbank',
	'A default location of \'./db/mt.db\' will store the database file underneath your Movable Type directory.' => 'Mit der  Voreinstellung \'./db/mt.db\' wird die Datenbankdatei unterhalb Ihres Movable Type-Verzeichnisses angelegt.',
	'Database Server' => 'Hostname',
	'This is usually \'localhost\'.' => 'Meistens \'localhost\'',
	'Database Name' => 'Datenbankname',
	'The name of your SQL database (this database must already exist).' => 'Name Ihrer SQL-Datenbank (die Datenbank muss bereits vorhanden sein)',
	'The username to login to your SQL database.' => 'Benutzername Ihrer SQL-Datenbank',
	'Password' => 'Passwort',
	'The password to login to your SQL database.' => 'Passwort Ihrer SQL-Datenbank',
	'Show Advanced Configuration Options' => 'Erweiterte Optionen anzeigen',
	'Database Port' => 'Port',
	'This can usually be left blank.' => 'Braucht normalerweise nicht angegeben zu werden',
	'Database Socket' => 'Socket',
	'Publish Charset' => 'Zeichenkodierung',
	'MS SQL Server driver must use either Shift_JIS or ISO-8859-1.  MS SQL Server driver does not support UTF-8 or any other character set.' => 'Der Microsoft SQL Server-Treiber unterstützt ausschließlich die Zeichenkodierungen Shift_JIS und ISO-8859-1. UTF-8 oder andere Kodierungen können nicht verwendet werden.',
	'Test Connection' => 'Verbindung testen',

## tmpl/wizard/blog.tmpl
	'Setup Your First Blog' => 'Richten Sie Ihr erstes Blog ein',
	'In order to properly publish your blog, you must provide Movable Type with your blog\'s URL and the path on the filesystem where its files should be published.' => 'Damit Ihr Blog veröffentlicht werden kann, geben Sie bitte die Webadresse (URL), unter der der Blog erscheinen soll, und den Pfad im Dateisystem, unter dem Movable Type die Dateien dieses Blog ablegen soll, an.',
	'My First Blog' => 'Mein erstes Blog',
	'Publishing Path' => 'Veröffentlichungspfad',
	'Your \'Publishing Path\' is the path on your web server\'s file system where Movable Type will publish all the files for your blog. Your web server must have write access to this directory.' => 'Der Veröffentlichungspfad ist der Pfad auf Ihrem Webserver, in dem Movable Type die Dateien dieses Blogs ablegt.',

## tmpl/cms/edit_template.tmpl
	'Edit Widget' => 'Widget bearbeiten', # Translate - New # OK
	'Create Widget' => 'Widget anlegen', # Translate - New # OK
	'Create Template' => 'Vorlage anlegen',
	'A saved version of this [_1] was auto-saved [_3]. <a href="[_2]">Recover auto-saved content</a>' => '[_1] automatisch gespeichert [_3]. <a href="[_2]">Automatisch gespeicherte Version wiederherstellen</a>.',
	'You have successfully recovered your saved [_1].' => 'Gespeicherte Fassung erfolgreich wiederhergestellt.',
	'An error occurred while trying to recover your saved [_1].' => 'Bei der Wiederherstellung der gespeicherten Fassung ist ein Fehler aufgetreten.',
	'Your template changes have been saved.' => 'Die Änderungen an der Vorlage wurden gespeichert.',
	'<a href="[_1]" class="rebuild-link">Publish</a> this template.' => 'Vorlage <a href="[_1]" class="rebuild-link">veröffentlichen</a>.',
	'Your [_1] has been published.' => '[_1] wurde veröffentlicht.',
	'Useful Links' => 'Nützliche Links',
	'List [_1] templates' => 'Zeige [_1]-Vorlagen',
	'List all templates' => 'Zeige alle Vorlagen', # Translate - New # OK
	'_external_link_target' => '_new',
	'View Published Template' => 'Veröffentlichte Vorlage ansehen',
	'Included Templates' => 'Eingebundene Vorlagen', # Translate - New # OK
	'create' => 'anlegen', # Translate - Improved (1) # OK
	'Template Tag Docs' => 'Dokumentation der Vorlagenbefehle', # Translate - New # OK
	'Unrecognized Tags' => 'Nicht erkannte Befehle',
	'Save (s)' => 'Sichern (s)',
	'Save' => 'OK',
	'Save and Publish this template (r)' => 'Vorlage speichern und veröffentlichen (r)',
	'Save &amp; Publish' => 'Speichern und veröffentlichen',
	'You have unsaved changes to this template that will be lost.' => 'Es liegen nicht gespeicherte Vorlagenänderungen, die verloren gehen werden.',
	'You must set the Template Name.' => 'Sie müssen einen Vorlagennamen angeben.',
	'You must set the template Output File.' => 'Sie müssen einen Dateinamen angeben.',
	'Processing request...' => 'Verarbeite Anfrage...', # Translate - New # OK
	'Error occurred while updating archive maps.' => 'Bei der Aktualisierung der Archivverknüpfungen ist ein Fehler aufgetreten.',
	'Archive map has been successfully updated.' => 'Archivverknüpfung erfolgreich aktualisiert.',
	'Are you sure you want to remove this template map?' => 'Archivverknüpfung wirklich löschen?',
	'Module Body' => 'Modul-Code',
	'Template Body' => 'Vorlagen-Code',
	'Syntax Highlight On' => 'Syntaxhervorhebung an',
	'Syntax Highlight Off' => 'Syntaxhervorhebung aus',
	'Insert...' => 'Einfügen...',
	'Template Options' => 'Vorlagenoptionen', # Translate - New # OK
	'Output file: <strong>[_1]</strong>' => 'Ausgabedatei: <strong>[_1]</strong>', # Translate - New # OK
	'Enabled Mappings: [_1]' => 'Aktivierte Verknüpfungen: [_1]', # Translate - New # OK
	'Output File' => 'Ausgabedatei',
	'Template Type' => 'Vorlagen-Typ',
	'Custom Index Template' => 'Individuelle Indexvorlage',
	'Link to File' => 'Mit Datei verlinken',
	'Create Archive Mapping' => 'Neue Archivverknüpfung einrichten',
	'Type' => 'Typ',
	'Add' => 'Hinzufügen',
	'Learn more about <a href="http://www.movabletype.org/documentation/administrator/publishing/publishing-profiles-and-strategies.html">publishing profiles</a>' => 'Mehr über <a href="http://www.movabletype.org/documentation/administrator/publishing/publishing-profiles-and-strategies.html">Veröffentlichungsprofile</a> erfahren', # Translate - New # OK
	'Publish Options' => 'Veröffentlichungs- optionen',
	'Statically' => 'Statisch', # Translate - New # OK
	'Dynamically' => 'Dynamisch', # Translate - New # OK
	'Background' => 'Im Hintergrund', # Translate - New # OK
	'On a schedule' => 'Zeitgeplant', # Translate - New # OK
	': every ' => ': alle ', # Translate - New # OK
	'minutes' => 'Minuten', # Translate - New # OK
	'hours' => 'Stunden', # Translate - New # OK
	'days' => 'Tage', # Translate - Improved (1) # OK
	'Manually' => 'Manuell', # Translate - New # OK
	'Disabled' => 'Deaktiviert',
	'Server Side Include' => 'Server Side Include', # Translate - New # OK
	'Process as <strong>[_1]</strong> include' => 'Als <strong>[_1]</strong>-Include verarbeiten', # Translate - New # OK
	'Include cache path' => 'Include Cache-Pfad', # Translate - New # OK
	'Module Caching' => 'Modul-Caching', # Translate - New # OK
	'Disabled (<a href="[_1]">change publishing settings</a>)' => 'Deaktiviert (<a href="[_1]">Veröffentlichungsoptionen ändern</a>)', # Translate - New # OK
	'No caching' => 'Keine Caching', # Translate - New # OK
	'Expire after' => 'Verfallen lassen nach', # Translate - New # OK
	'Expire upon creation or modification of:' => 'Verfallen lassen bei Anlage oder Änderung von:', # Translate - New # OK
	'Auto-saving...' => 'Autospeichern...',
	'Last auto-save at [_1]:[_2]:[_3]' => 'Zuletzt automatisch gespeichert um [_1]:[_2]:[_3]',

## tmpl/cms/edit_role.tmpl
	'Edit Role' => 'Rolle bearbeiten',
	'Your changes have been saved.' => 'Änderungen gespeichert.',
	'List Roles' => 'Rollen auflisten',
	'[quant,_1,User,Users] with this role' => '[quant,_1,Benutzer,Benutzer] mit dieser Rolle',
	'You have changed the privileges for this role. This will alter what it is that the users associated with this role will be able to do. If you prefer, you can save this role with a different name.  Otherwise, be aware of any changes to users with this role.' => 'Sie haben die Berechtigungen dieser Rolle geändert. Dadurch werden auch die Rechte der mit dieser Rolle verknüpften Benutzer beeinflusst. Wenn Sie möchten, können Sie daher die Rolle unter neuem Namen speichern.',
	'Role Details' => 'Rolleneigenschaften',
	'Created by' => 'Angelegt von',
	'System' => 'System',
	'Privileges' => 'Berechtigungen',
	'Check All' => 'Alle wählen',
	'Uncheck All' => 'Alle abwählen',
	'Administration' => 'Verwalten',
	'Authoring and Publishing' => 'Schreiben und veröffentlichen',
	'Designing' => 'Gestalten',
	'Commenting' => 'Kommentieren',
	'Duplicate Roles' => 'Rollen duplizieren',
	'These roles have the same privileges as this role' => 'Folgende Rollen haben die gleichen Berechtigungen wie diese Rolle',
	'Save changes to this role (s)' => 'Rollenänderungen speichern (s)',
	'Save Changes' => 'Änderungen speichern',

## tmpl/cms/cfg_system_general.tmpl
	'System: General Settings' => 'System: Grundeinstellungen',
	'Your settings have been saved.' => 'Die Einstellungen wurden gespeichert.',
	'System Email' => 'System- E-Mail-Adresse',
	'The email address used in the From: header of each email sent from the system.  The address is used in password recovery, commenter registration, comment, trackback notification and a few other minor events.' => 'Geben Sie die E-Mail-Adresse an, die als Absenderadresse der vom System verschickten E-Mails verwendet werden soll. E-Mails werden vom System verschickt bei Passwortanforderungen, Registrierungen von Kommentarautoren, für Benachrichtigungen über neue Kommentare, TrackBacks und einigen weiteren Fällen.',
	'Save changes to these settings (s)' => 'Einstellungsänderungen speichern (s)',

## tmpl/cms/cfg_plugin.tmpl
	'System Plugin Settings' => 'System: Plugin-Einstellungen',
	'Useful links' => 'Nützliche Links',
	'http://plugins.movabletype.org/' => 'http://plugins.movabletype.org/',
	'Find Plugins' => 'Weitere Plugins',
	'Plugin System' => 'Plugin-System',
	'Manually enable or disable plugin-system functionality. Re-enabling plugin-system functionality, will return all plugins to their original state.' => 'Das Plugin-System kann manuell aktiviert oder deaktiviert werden. Reaktivierung der Plugin-Funktion setzt alle Plugins in ihren Ausgangszustand zurück.',
	'Disable plugin functionality' => 'Plugin-Funktion deaktivieren',
	'Disable Plugins' => 'Plugins deaktivieren',
	'Enable plugin functionality' => 'Plugin-Funktion aktivieren',
	'Enable Plugins' => 'Plugins aktivieren',
	'Your plugin settings have been saved.' => 'Plugin-Einstellungen übernommen',
	'Your plugin settings have been reset.' => 'Plugin-Einstellungen zurückgesetzt',
	'Your plugins have been reconfigured. Since you\'re running mod_perl, you will need to restart your web server for these changes to take effect.' => 'Einstellungen übernommen. Da Sie mod_perl verwenden, müssen Sie Ihren Webserver neu starten, damit die Änderungen wirksam werden.',
	'Your plugins have been reconfigured.' => 'Einstellungen übernommen',
	'Are you sure you want to reset the settings for this plugin?' => 'Wollen Sie die Plugin-Einstellungen wirklich zurücksezten?',
	'Are you sure you want to disable plugin functionality?' => 'Plugin-Funktion wirklich deaktivieren?',
	'Disable this plugin?' => 'Plugin deaktivieren?',
	'Are you sure you want to enable plugin functionality? (This will re-enable any plugins that were not individually disabled.)' => 'Plugin-Funktion wirklich aktivieren? (Reaktiviert alle Plugins, die nicht separat deaktiviert worden sind.)',
	'Enable this plugin?' => 'Plugin aktivieren?',
	'Failed to Load' => 'Fehler beim Laden',
	'(Disable)' => '(Deaktivieren)',
	'Enabled' => 'Aktiviert',
	'(Enable)' => '(Aktivieren)',
	'Settings for [_1]' => 'Einstellungen von [_1]',
	'This plugin has not been upgraded to support Movable Type [_1]. As such, it may not be 100% functional. Furthermore, it will require an upgrade once you have upgraded to the next Movable Type major release (when available).' => 'Dieses Plugin wurde noch nicht für Movable Type [_1] portiert. Daher funktioniert es möglicherweise nicht fehlerfrei. Außerdem erfordert es nach Installation der nächsten Movable Type-Version eine zusätzliche Aktualisierung.',
	'Plugin error:' => 'Plugin-Fehler:',
	'Info' => 'Info',
	'Resources' => 'Ressourcen',
	'Run [_1]' => '[_1] ausführen',
	'Documentation for [_1]' => 'Dokumentation zu [_1]',
	'Documentation' => 'Dokumentation',
	'More about [_1]' => 'Mehr über [_1]',
	'Plugin Home' => 'Plugin-Website',
	'Author of [_1]' => 'Autor von [_1]',
	'Tags:' => 'Tags:',
	'Tag Attributes:' => 'Tag-Attribute:',
	'Text Filters' => 'Textfilter',
	'Junk Filters:' => 'Junkfilter',
	'Reset to Defaults' => 'Voreinstellungen',
	'No plugins with blog-level configuration settings are installed.' => 'Es sind keine Plugins installiert, die Einstellungen auf Blogebene erfordern.',
	'No plugins with configuration settings are installed.' => 'Es sind keine Plugins installiert, die Einstellungen erfordern.',

## tmpl/cms/list_blog.tmpl
	'You have successfully deleted the blogs from the Movable Type system.' => 'Blog(s) erfolgreich gelöscht',
	'You have successfully refreshed your templates.' => 'Vorlagen erfolgreich neu aufgebaut.',
	'Create Blog' => 'Blog anlegen',

## tmpl/cms/cfg_trackbacks.tmpl
	'TrackBack Settings' => 'TrackBack-Einstellungen',
	'Your TrackBack preferences have been saved.' => 'TrackBack-Einstellungen gespeichert.',
	'Note: TrackBacks are currently disabled at the system level.' => 'Hinweis: TrackBacks sind derzeit im Gesamtsystem deaktiviert.',
	'Accept TrackBacks' => 'TrackBacks zulassen',
	'If enabled, TrackBacks will be accepted from any source.' => 'Falls aktiviert, werden TrackBacks akzeptiert',
	'TrackBack Policy' => 'TrackBack-Regeln',
	'Moderation' => 'Moderation',
	'Hold all TrackBacks for approval before they\'re published.' => 'Alle TrackBacks moderieren',
	'Apply \'nofollow\' to URLs' => '\'nofollow\' an URLs anhängen',
	'This preference affects both comments and TrackBacks.' => 'Diese Voreinstellung bezieht sich sowohl auf Kommentare als auch auf TrackBacks.',
	'If enabled, all URLs in comments and TrackBacks will be assigned a \'nofollow\' link relation.' => 'Falls aktiviert, wird für alle Links in Kommentaren und TrackBacks das \'nofollow\'-Attribut gesetzt.',
	'E-mail Notification' => 'Benachrichtigungen',
	'Specify when Movable Type should notify you of new TrackBacks if at all.' => 'Legt fest, ob und wann Sie bei neuen TrackBacks benachrichtigt werden',
	'On' => 'Immer',
	'Only when attention is required' => 'Nur wenn eine Entscheidung erforderlich ist',
	'Off' => 'Nie',
	'TrackBack Options' => 'TrackBack-Optionen',
	'TrackBack Auto-Discovery' => 'TrackBack Auto-Discovery',
	'If you turn on auto-discovery, when you write a new entry, any external links will be extracted and the appropriate sites automatically sent TrackBacks.' => 'Falls aktiviert, werden an alle verlinkten externen Seiten, die TrackBack unterstützen, bei Veröffentlichung eines neuen Eintrags automatisch TrackBack-Pings verschickt.',
	'Enable External TrackBack Auto-Discovery' => 'Auto-Discovery für externe TrackBacks aktivieren',
	'Setting Notice' => 'Nutzungshinweise',
	'Note: The above option may be affected since outbound pings are constrained system-wide.' => 'Hinweis: Die Funktion ist möglicherweise nur eingeschränkt wirksam, da ausgehende Pings systemweit eingeschränkt sind.',
	'Setting Ignored' => 'Einstellung ignoriert',
	'Note: The above option is currently ignored since outbound pings are disabled system-wide.' => 'Hinweis: Die Funktion ist derzeit nicht wirksam, da ausgehende Pings systemweit deaktiviert sind.',
	'Enable Internal TrackBack Auto-Discovery' => 'Auto-Discovery für interne TrackBacks aktivieren',

## tmpl/cms/dashboard.tmpl
	'Dashboard' => 'Übersichtsseite',
	'Select a Widget...' => 'Widget wählen...',
	'Your Dashboard has been updated.' => 'Übersichtsseite aktualisiert.',
	'You have attempted to use a feature that you do not have permission to access. If you believe you are seeing this message in error contact your system administrator.' => 'Sie haben für die gewünschte Funktion keine Berechtigung. Bei Fragen wenden Sie sich bitte an Ihren Systemadministrator.',
	'The directory you have configured for uploading userpics is not writable. In order to enable users to upload userpics, please make the following directory writable by your web server: [_1]' => 'Das angegebene Benutzerbilder-Verzeichnis kann nicht beschrieben werden. Damit Mitglieder Benutzerbilder hochladen können, machen Sie folgendes Verzeichnis durch Ihren Webserver beschreibbar: [_1]', # Translate - New
	'Your dashboard is empty!' => 'Ihre Übersichtsseite ist leer!',

## tmpl/cms/edit_commenter.tmpl
	'Commenter Details' => 'Kommentarautor-Details',
	'The commenter has been trusted.' => 'Sie vertrauen diesem Kommentarautoren.',
	'The commenter has been banned.' => 'Dieser Kommentarautor wurde gesperrt.',
	'Comments from [_1]' => 'Kommentare von [_1]',
	'commenter' => 'Kommentarautor',
	'commenters' => 'Kommentarautoren',
	'to act upon' => 'bearbeiten',
	'Trust user (t)' => 'Benutzer vertrauen (t)',
	'Trust' => 'Vertrauen',
	'Untrust user (t)' => 'Benutzer nicht mehr vertrauen (t)',
	'Untrust' => 'Nicht vertrauen',
	'Ban user (b)' => 'Benutzer sperren (b)',
	'Ban' => 'Sperren',
	'Unban user (b)' => 'Benutzer nicht mehr sperren (b)',
	'Unban' => 'Entsperren',
	'The Name of the commenter' => 'Name des Kommentarautors',
	'View all comments with this name' => 'Alle Kommentare mit diesem Autorennamen anzeigen',
	'Identity' => 'Identität',
	'The Identity of the commenter' => 'Identität des Kommentarautors',
	'Email' => 'E-Mail',
	'The Email of the commenter' => 'E-Mail-Adresse des Kommentarautors',
	'Withheld' => 'Zurückgehalten',
	'View all comments with this email address' => 'Alle Kommentare von dieser E-Mail-Adresse anzeigen',
	'The URL of the commenter' => 'Web-Adresse (URL) des Kommentarautors',
	'View all comments with this URL address' => 'Alle Kommentare mit dieser Web-Adresse (URL) anzeigen',
	'Status' => 'Status',
	'The trusted status of the commenter' => 'Vertrauensstatus des Kommentarautors',
	'Trusted' => 'vertraut',
	'Banned' => 'Gesperrt',
	'Authenticated' => 'Authentifiziert',
	'View all commenters' => 'Alle Kommentarautoren anzeigen',

## tmpl/cms/edit_widget.tmpl
	'Edit Widget Set' => 'Widgetgruppe bearbeiten',
	'Create Widget Set' => 'Widgetgruppe anlegen',
	'Please use a unique name for this widget set.' => 'Bitte verwenden Sie für die Widgetgruppe einen eindeutigen Namen.',
	'Set Name' => 'Gruppenname',
	'Drag and drop the widgets you want into the Installed column.' => 'Ziehen Sie die Widgets, die angezeigt werden sollen, in die Spalte \'Installierte Widgets\'. Soll ein Widget nicht mehr angezeigt werden, schieben Sie es zurück in die Spalte \'Verfügbare Widgets\'.',
	'Installed Widgets' => 'Installierte Widgets',
	'edit' => 'Bearbeiten',
	'Available Widgets' => 'Verfügbare Widgets',
	'Save changes to this widget set (s)' => 'Widgetänderungen speichern (s)',

## tmpl/cms/list_entry.tmpl
	'Manage Entries' => 'Einträge verwalten',
	'Entries Feed' => 'Eintragsfeed',
	'Pages Feed' => 'Seitenfeed',
	'The entry has been deleted from the database.' => 'Eintrag aus der Datenbank gelöscht.',
	'The page has been deleted from the database.' => 'Seite aus der Datenbank gelöscht.',
	'Quickfilters' => 'Schnellfilter',
	'[_1] (Disabled)' => '[_1] (deaktiviert)',
	'Set Web Services Password' => 'Passwort für Webdienste wählen',
	'Showing only: [_1]' => 'Zeige nur: [_1]',
	'Remove filter' => 'aufheben',
	'All [_1]' => 'Alle [_1]',
	'change' => 'ändern',
	'[_1] where [_2] is [_3]' => '[_1] mit [_2] [_3]',
	'Show only entries where' => 'Zeige nur Einträge mit',
	'Show only pages where' => 'Zeige nur Seiten mit',
	'status' => 'Status',
	'user' => 'Benutzer',
	'tag (exact match)' => 'Tag (genau)',
	'tag (fuzzy match)' => 'Tag (unscharf)',
	'asset' => 'Asset',
	'is' => ' ',
	'published' => 'veröffentlicht',
	'unpublished' => 'nicht veröffentlicht',
	'scheduled' => 'zeitgeplant',
	'Select A User:' => 'Benutzerkonto wählen: ',
	'User Search...' => 'Benutzer suchen...',
	'Recent Users...' => 'Letzte Benutzer...',
	'Filter' => 'Zeigen',

## tmpl/cms/include/import_start.tmpl
	'Importing...' => 'Importieren...',
	'Importing entries into blog' => 'Importiere Einträge...',
	'Importing entries as user \'[_1]\'' => 'Importiere als Benutzer \'[_1]\'...',
	'Creating new users for each user found in the blog' => 'Lege Benutzerkonten für neu entdeckte Benutzer an...',

## tmpl/cms/include/copyright.tmpl
	'Copyright &copy; 2001-[_1] Six Apart. All Rights Reserved.' => 'Copyright &copy; 2001-[_1] Six Apart. Alle Rechte vorbehalten.',

## tmpl/cms/include/comment_table.tmpl
	'comment' => 'Kommentar',
	'comments' => 'Kommentare',
	'to publish' => 'zu veröffentlichen',
	'Publish selected comments (a)' => 'Gewählte Kommentare veröffentlichen (a)',
	'Delete selected comments (x)' => 'Gewählte Kommentare löschen (x)',
	'Report selected comments as Spam (j)' => 'Gewählte Kommentare als Spam melden (j)',
	'Report selected comments as Not Spam and Publish (j)' => 'Gewählte Kommentare als gültig melden und veröffentlichen (j)',
	'Not Spam' => 'Nicht Spam',
	'Are you sure you want to remove all comments reported as spam?' => 'Wirklich alle als Spam gemeldeten Kommentare löschen?',
	'Delete all comments reported as Spam' => 'Alle als Spam gemeldeten Kommentare löschen',
	'Empty' => 'Leer',
	'Ban This IP' => 'Diese IP-Adresse sperren',
	'Entry/Page' => 'Eintrag/Seite',
	'Date' => 'Datum',
	'IP' => 'IP',
	'Only show published comments' => 'Nur veröffentlichte Kommentare anzeigen',
	'Published' => 'Veröffentlicht',
	'Only show pending comments' => 'Nur nicht veröffentlichte Kommentare anzeigen',
	'Pending' => 'Auf Moderation wartend',
	'Edit this comment' => 'Kommentar bearbeiten',
	'([quant,_1,reply,replies])' => '([quant,_1,Antwort,Antworten])',
	'Blocked' => 'Gesperrt',
	'Edit this [_1] commenter' => '[_1] Kommentarautor bearbeiten',
	'Search for comments by this commenter' => 'Nach Kommentaren von diesem Kommentarautor suchen',
	'View this entry' => 'Diesen Eintrag ansehen',
	'View this page' => 'Diese Seite ansehen',
	'Search for all comments from this IP address' => 'Nach Kommentaren von dieser IP-Adresse suchen',

## tmpl/cms/include/feed_link.tmpl
	'Activity Feed' => 'Aktivitäts-Feed',

## tmpl/cms/include/member_table.tmpl
	'users' => 'Benutzer',
	'Are you sure you want to remove the selected user from this blog?' => 'Gewählte Benutzer wirklich aus diesem Blog entfernen?',
	'Are you sure you want to remove the [_1] selected users from this blog?' => 'Gewählte [_1] Benutzer wirklich aus diesem Blog entfernen?',
	'Remove selected user(s) (r)' => 'Gewählte(n) Benutzer entfernen (r)',
	'Remove' => 'Entfernen',
	'_USER_ENABLED' => 'Aktiviert',
	'Trusted commenter' => 'Vertrauter Kommentarautor',
	'Link' => 'Link',
	'Remove this role' => 'Rolle entfernen',

## tmpl/cms/include/asset_table.tmpl
	'assets' => 'Assets',
	'Delete selected assets (x)' => 'Gewählte Assets löschen (x)',
	'Size' => 'Größe',
	'Created By' => 'Erstellt von',
	'Created On' => 'Angelegt',
	'View' => 'Ansehen',
	'Asset Missing' => 'Asset fehlt',
	'No thumbnail image' => 'Kein Vorschaubild',
	'[_1] is missing' => '[_1] fehlt',

## tmpl/cms/include/overview-left-nav.tmpl
	'List Weblogs' => 'Weblogs anzeigen',
	'Weblogs' => 'Weblogs',
	'List Users and Groups' => 'Benutzer und Gruppen anzeigen',
	'Users &amp; Groups' => 'Benutzer und Gruppen',
	'List Associations and Roles' => 'Verknüpfungen und Rollen',
	'List Plugins' => 'Plugins anzeigen',
	'Aggregate' => 'Übersicht',
	'List Entries' => 'Einträge auflisten',
	'List uploaded files' => 'Hochgeladene Dateien auflisten',
	'List Tags' => 'Tags anzeigen',
	'List Comments' => 'Kommentare auflisten',
	'List TrackBacks' => 'TrackBacks auflisten',
	'Configure' => 'Konfigurieren',
	'Edit System Settings' => 'Systemeinstellungen bearbeiten',
	'Utilities' => 'Werkzeuge',
	'Search &amp; Replace' => 'Suchen &amp; Ersetzen',
	'_SEARCH_SIDEBAR' => 'Suchen',
	'Show Activity Log' => 'Aktivitätsprotokoll anzeigen',

## tmpl/cms/include/comment_detail.tmpl
	'By [_1]' => 'Von [_1]', # Translate - New # OK
	'replied to [_1]' => 'antwortete [_1]', # Translate - New # OK
	'on [_1]' => 'um [_1]', # Translate - New # OK

## tmpl/cms/include/cfg_content_nav.tmpl

## tmpl/cms/include/pagination.tmpl

## tmpl/cms/include/log_table.tmpl
	'No log records could be found.' => 'Keine Protokolleinträge gefunden.',
	'_LOG_TABLE_BY' => 'Von',
	'IP: [_1]' => 'IP: [_1]',

## tmpl/cms/include/backup_end.tmpl
	'All of the data has been backed up successfully!' => 'Alle Daten wurden erfolgreich gesichert!',
	'Download This File' => 'Diese Datei herunterladen',
	'_BACKUP_TEMPDIR_WARNING' => 'Gewünschte Daten erfolgreich im Ordner [_1] gesichert. Bitte laden Sie die angegebenen Dateien <strong>sofort</strong> aus [_1] herunter und <strong>löschen</strong> Sie sie unmittelbar danach aus dem Ordner, da sie sensible Informationen enthalten.',
	'_BACKUP_DOWNLOAD_MESSAGE' => 'Der Download der Sicherungsdatei wird in einigen Sekunden automatisch beginnen. Sollte das nicht der Fall sein, klicken Sie <a href="javascript:(void)" onclick="submit_form()">hier</a> um den Download manuell zu starten. Pro Sitzung kann eine Sicherungsdatei nur einmal heruntergeladen werden.',
	'An error occurred during the backup process: [_1]' => 'Beim Backup ist ein Fehler aufgetreten: [_1]',

## tmpl/cms/include/author_table.tmpl
	'_USER_DISABLED' => 'Deaktiviert',

## tmpl/cms/include/ping_table.tmpl
	'Publish selected [_1] (p)' => 'Markierte [_1] veröffentlichen (p)',
	'Delete selected [_1] (x)' => 'Markierte [_1] löschen (x)',
	'Report selected [_1] as Spam (j)' => 'Markierte [_1] als Spam melden',
	'Report selected [_1] as Not Spam and Publish (j)' => 'Markierte [_1] als gültig melden und veröffentlichen (j)',
	'Are you sure you want to remove all TrackBacks reported as spam?' => 'Wirklich alle als Spam gemeldeten TrackBacks löschen?',
	'Deletes all [_1] reported as Spam' => 'Alle als Spam gemeldeten [_1] löschen',
	'From' => 'Von',
	'Target' => 'Nach',
	'Only show published TrackBacks' => 'Nur veröffentlichte TrackBacks anzeigen',
	'Only show pending TrackBacks' => 'Nur nicht veröffentlichte TrackBacks anzeigen',
	'Edit this TrackBack' => 'TrackBack bearbeiten',
	'Go to the source entry of this TrackBack' => 'Zum Eintrag wechseln, auf den sich das TrackBack bezieht',
	'View the [_1] for this TrackBack' => '[_1] zu dem TrackBack ansehen',

## tmpl/cms/include/footer.tmpl
	'This is a beta version of Movable Type and is not recommended for production use.' => 'Das ist eine Beta-Version von Movable Type. Der Einsatz als Produktivsystem wird nicht empfohlen.', # Translate - New # OK
	'http://www.movabletype.org' => 'http://www.movabletype.org', # Translate - New # OK
	'MovableType.org' => 'MovableType.org', # Translate - New # OK
	'http://wiki.movabletype.org/' => 'http://wiki.movabletype.org/', # Translate - New # OK
	'Wiki' => 'Wiki', # Translate - New # OK
	'http://www.movabletype.com/support/' => 'http://www.movabletype.com/support/', # Translate - New # OK
	'Support' => 'Support', # Translate - New # OK
	'http://www.movabletype.org/feedback.html' => 'http://www.movabletype.org/feedback.html', # Translate - New # OK
	'Send us Feedback' => 'Feedback senden', # Translate - New # OK
	'<a href="[_1]"><mt:var name="mt_product_name"></a> version [_2]' => '<a href="[_1]"><mt:var name="mt_product_name"></a> Version [_2]',
	'with' => 'mit',

## tmpl/cms/include/notification_table.tmpl
	'Date Added' => 'Hinzugefügt am',
	'Click to edit contact' => 'Klicken, um Kontakt zu bearbeiten',
	'Save changes' => 'Änderungen speichern',

## tmpl/cms/include/itemset_action_widget.tmpl
	'More actions...' => 'Weitere Aktionen...',
	'Plugin Actions' => 'Plugin-Aktionen',
	'Go' => 'Ausführen',

## tmpl/cms/include/tools_content_nav.tmpl

## tmpl/cms/include/commenter_table.tmpl
	'Last Commented' => 'Zuletzt kommentiert',
	'Only show trusted commenters' => 'Nur vertrauenswürdige Kommentarautoren anzeigen',
	'Only show banned commenters' => 'Nur gesperrte Kommentarautoren anzeigen',
	'Only show neutral commenters' => 'Nur neutrale Kommentarautoren anzeigen',
	'Edit this commenter' => 'Kommentarautor bearbeiten',
	'View this commenter&rsquo;s profile' => 'Profil des Kommentarautors ansehen',

## tmpl/cms/include/entry_table.tmpl
	'Save these entries (s)' => 'Diese Einträge speichern',
	'Republish selected entries (r)' => 'Markierte Einträge neu veröffentlichen (r)',
	'Delete selected entries (x)' => 'Markierte Einträge löschen (x)',
	'Save these pages (s)' => 'Diese Seiten speichern (s)',
	'Republish selected pages (r)' => 'Markierte Seiten neu veröffentlicchen (r)',
	'Delete selected pages (x)' => 'Markierte Seiten löschen (x)',
	'to republish' => 'zur erneuten Veröffentlichung',
	'Republish' => 'Seite',
	'Last Modified' => 'Zuletzt geändert',
	'Created' => 'Angelegt',
	'Unpublished (Draft)' => 'Unveröffentlicht (Entwurf)',
	'Unpublished (Review)' => 'Unveröffentlicht (Prüfung)',
	'Scheduled' => 'Zu bestimmtem Zeitpunkt',
	'Only show unpublished entries' => 'Nur unveröffentlichte Einträge anzeigen',
	'Only show unpublished pages' => 'Nur unveröffentlichte Seiten anzeigen',
	'Only show published entries' => 'Nur veröffentlichte Einträge anzeigen',
	'Only show published pages' => 'Nur veröffentlichte Seiten anzeigen',
	'Only show entries for review' => 'Nur zu prüfende Einträge anzeigen',
	'Only show pages for review' => 'Nur zu prüfende Seiten anzeigen',
	'Only show scheduled entries' => 'Nur zeitgeplante Einträge anzeigen',
	'Only show scheduled pages' => 'Nur zeitgeplante Seiten anzeigen',
	'Edit Entry' => 'Eintrag bearbeiten',
	'Edit Page' => 'Seite bearbeiten',
	'View entry' => 'Eintrag ansehen',
	'View page' => 'Seite ansehen',
	'No entries could be found. <a href="[_1]">Create an entry</a> now.' => 'Keine Einträge gefunden. Jetzt <a href="[_1]>einen Eintrag anlegen</a>.',
	'No page could be found. <a href="[_1]">Create a page</a> now.' => 'Keine Seiten gefunden. Jetzt <a href="[_1]">eine Seite anlegen</a>.',

## tmpl/cms/include/login_mt.tmpl

## tmpl/cms/include/calendar.tmpl
	'_LOCALE_WEEK_START' => '1',
	'S|M|T|W|T|F|S' => 'S|M|D|M|D|F|S',
	'January' => 'Januar',
	'Febuary' => 'Februar',
	'March' => 'März',
	'April' => 'April',
	'May' => 'Mai',
	'June' => 'Juni',
	'July' => 'Juli',
	'August' => 'August',
	'September' => 'September',
	'October' => 'Oktober',
	'November' => 'November',
	'December' => 'Dezember',
	'Jan' => 'Jan',
	'Feb' => 'Feb',
	'Mar' => 'Mrz',
	'Apr' => 'Apr',
	'_SHORT_MAY' => 'Mai',
	'Jun' => 'Jun',
	'Jul' => 'Jul',
	'Aug' => 'Aug',
	'Sep' => 'Sep',
	'Oct' => 'Okt',
	'Nov' => 'Nov',
	'Dec' => 'Dez',
	'OK' => 'OK',
	'[_1:calMonth] [_2:calYear]' => '[_1:calMonth] [_2:calYear]',

## tmpl/cms/include/list_associations/page_title.tmpl
	'Permissions for [_1]' => 'Berechtigungen für [_1]',
	'Permissions: System-wide' => 'System: Berechtigungen',
	'Users for [_1]' => 'Benutzer für [_1]',

## tmpl/cms/include/anonymous_comment.tmpl
	'Anonymous Comments' => 'Kommentarabgabe ohne Registrierung zulassen',
	'Require E-mail Address for Anonymous Comments' => 'E-Mail-Adresse von nicht registrierten Kommentarautoren verlangen',
	'If enabled, visitors must provide a valid e-mail address when commenting.' => 'Wenn diese Option aktiv ist, müssen Kommentarautoren eine gültige E-Mail-Adresse angeben.',

## tmpl/cms/include/cfg_system_content_nav.tmpl

## tmpl/cms/include/category_selector.tmpl
	'Add sub category' => 'Unterkategorie hinzufügen',
	'Add new' => 'Neue',

## tmpl/cms/include/backup_start.tmpl
	'Backing up Movable Type' => 'Erstelle Sicherung',

## tmpl/cms/include/display_options.tmpl
	'Display Options' => 'Anzeigeoptionen',
	'_DISPLAY_OPTIONS_SHOW' => 'Zeige',
	'[quant,_1,row,rows]' => '[quant,_1,Zeile,Zeilen]',
	'Compact' => 'Kompakt',
	'Expanded' => 'Erweitert',
	'Action Bar' => 'Menü- leiste',
	'Top' => 'Oben',
	'Both' => 'Sowohl als auch',
	'Bottom' => 'Unten',
	'Date Format' => 'Zeit- angaben',
	'Relative' => 'Relativ',
	'Full' => 'Absolut',
	'Save display options' => 'Anzeigeoptionen speichern',
	'Close display options' => 'Anzeigeoptionen schließen',

## tmpl/cms/include/chromeless_footer.tmpl
	'<a href="[_1]">Movable Type</a> version [_2]' => '<a href="[_1]">Movable Type</a> Version [_2]',

## tmpl/cms/include/template_table.tmpl
	'Create Archive Template:' => 'Archiv-Vorlage anlegen:',
	'Entry Listing' => 'Eintragsliste',
	'Create template module' => 'Vorlagenmodul anlegen', # Translate - New # OK
	'Create index template' => 'Indexvorlage anlegen', # Translate - New # OK
	'templates' => 'Vorlagen',
	'Publish selected templates (a)' => 'Ausgewählte Vorlagen veröffentlichen (a)', # Translate - New # OK
	'Archive Path' => 'Archivpfad', # Translate - New # OK
	'Cached' => 'Zwischengespeichert', # Translate - New # OK
	'Linked Template' => 'Verlinkte Vorlage',
	'-' => '-',
	'Manual' => 'Manuell', # Translate - New # OK
	'Dynamic' => 'Dynamisch',
	'Static' => 'Statisch', # Translate - New # OK
	'Yes' => 'Ja',
	'No' => 'Nein',

## tmpl/cms/include/asset_upload.tmpl
	'Before you can upload a file, you need to publish your blog. [_1]Configure your blog\'s publishing paths[_2] and rebuild your blog.' => 'Bevor Sie eine Datei hochladen können, müssen Sie das Blog veröffentlicht haben. Konfigurieren Sie dazu zuerst die [_1]Veröffentlichungspfade[_2] und veröffentlichen Sie dann das Blog.',
	'Your system or blog administrator needs to publish the blog before you can upload files. Please contact your system or blog administrator.' => 'Bevor Sie eine Datei hochladen können, muss Ihr Systemadministrator das Blog veröffentlicht haben. Bitte wenden Sie daher an Ihren Administrator.',
	'Close (x)' => 'Schließen (x)',
	'Select File to Upload' => 'Hochzuladende Datei wählen',
	'_USAGE_UPLOAD' => 'Dateien können auch in Unterverzeichnisse des gewählten Pfads hochgeladen werden. Existiert das Unterverzeichnis noch nicht, wird es automatisch angelegt.',
	'Upload Destination' => 'Zielverzeichnis',
	'Choose Folder' => 'Ordner wählen',
	'Upload (s)' => 'Hochladen (s)',
	'Upload' => 'Hochladen',
	'Back (b)' => 'Zurück (b)',
	'Cancel (x)' => 'Abbrechen (x)',

## tmpl/cms/include/listing_panel.tmpl
	'Step [_1] of [_2]' => 'Schritt [_1] von [_2]',
	'Reset' => 'zurücksetzen',
	'Go to [_1]' => 'Gehe zu [_1]',
	'Sorry, there were no results for your search. Please try searching again.' => 'Keine Treffer. Bitte suchen Sie erneut.',
	'Sorry, there is no data for this object set.' => 'Keine Daten für diese Objekte vorhanden.',
	'Confirm (s)' => 'Bestätigen (s)',
	'Confirm' => 'Bestätigen',
	'Continue (s)' => 'Weiter (s)',

## tmpl/cms/include/header.tmpl
	'Help' => 'Hilfe',
	'Hi [_1],' => 'Hallo [_1]',
	'Logout' => 'Abmelden',
	'Select another blog...' => 'Anderes Blog wählen',
	'Create a new blog' => 'Neues Blog anlegen',
	'Write Entry' => 'Eintrag schreiben',
	'Blog Dashboard' => 'Übersichtsseite',
	'View Site' => 'Ansehen',
	'Search (q)' => 'Suche (q)',

## tmpl/cms/include/archetype_editor.tmpl
	'Decrease Text Size' => 'Textgröße verkleinern',
	'Increase Text Size' => 'Textgröße vergrößern',
	'Bold' => 'Fett',
	'Italic' => 'Kursiv',
	'Underline' => 'Unterstreichen',
	'Strikethrough' => 'Durchstreichen',
	'Text Color' => 'Textfarbe',
	'Email Link' => 'E-Mail-Link',
	'Begin Blockquote' => 'Zitat Anfang',
	'End Blockquote' => 'Zitat Ende',
	'Bulleted List' => 'Aufzählung',
	'Numbered List' => 'Nummerierte Liste',
	'Left Align Item' => 'Linksbündig',
	'Center Item' => 'Zentieren',
	'Right Align Item' => 'Rechtsbündig',
	'Left Align Text' => 'Linksbündiger Text',
	'Center Text' => 'Zentrierter Text',
	'Right Align Text' => 'Rechtsbündiger Text',
	'Insert Image' => 'Bild einfügen',
	'Insert File' => 'Datei einfügen',
	'WYSIWYG Mode' => 'Grafischer Editor',
	'HTML Mode' => 'HTML-Modus',

## tmpl/cms/include/users_content_nav.tmpl
	'Profile' => 'Profil',
	'Details' => 'Details',

## tmpl/cms/include/blog_table.tmpl
	'Delete selected blogs (x)' => 'Gewählte Blogs löschen (x)',

## tmpl/cms/include/blog-left-nav.tmpl
	'Creating' => 'Anlegen',
	'Create Entry' => 'Neuen Eintrag schreiben',
	'Community' => 'Feedback',
	'List Commenters' => 'Kommentarautoren auflisten',
	'Edit Address Book' => 'Adressbuch bearbeiten',
	'List Users &amp; Groups' => 'Benutzer und Gruppen auflisten',
	'List &amp; Edit Templates' => 'Vorlagen auflisten &amp; bearbeiten',
	'Edit Categories' => 'Kategorien bearbeiten',
	'Edit Tags' => 'Tags bearbeiten',
	'Edit Weblog Configuration' => 'Weblog-Konfiguration bearbeiten',
	'Backup this weblog' => 'Dieses Weblog sichern',
	'Import &amp; Export Entries' => 'Einträge importieren &amp; exportieren',
	'Import / Export' => 'Import/Export',
	'Rebuild Site' => 'Neu aufbauen',

## tmpl/cms/include/archive_maps.tmpl
	'Path' => 'Pfad',
	'Custom...' => 'Individuell...',

## tmpl/cms/include/import_end.tmpl
	'All data imported successfully!' => 'Alle Daten erfolgreich importiert!',
	'Make sure that you remove the files that you imported from the \'import\' folder, so that if/when you run the import process again, those files will not be re-imported.' => 'Vergessen Sie nicht, die verwendeten Dateien aus dem \'import\'-Ordner zu entfernen, damit sie bei künftigen Importvorgängen nicht erneut importiert werden.',
	'An error occurred during the import process: [_1]. Please check your import file.' => 'Beim Importieren ist ein Fehler aufgetreten: [_1]. Bitte überprüfen Sie Ihre Import-Datei.',

## tmpl/cms/dialog/asset_replace.tmpl
	'A file named \'[_1]\' already exists. Do you want to overwrite this file?' => 'Eine Datei namens \'[_1]\' ist bereits vorhanden. Möchten Sie sie überschreiben?',
	'Yes (s)' => 'Ja (s)',

## tmpl/cms/dialog/restore_end.tmpl
	'An error occurred during the restore process: [_1] Please check your restore file.' => 'Bei der Wiederherstellung ist ein Fehler aufgetreten: [_1]. Bitte überprüfen Sie die Sicherungsdatei.',
	'View Activity Log (v)' => 'Aktivitätsprotokoll ansehen (v)',
	'All data restored successfully!' => 'Alle Daten erfolgreich wiederhergestellt!',
	'Close (s)' => 'Schließen (s)',
	'Next Page' => 'Nächste Seite',
	'The page will redirect to a new page in 3 seconds. [_1]Stop the redirect.[_2]' => 'Diese Seite leitet in drei Sekunden auf eine neue Seite weiter. [_1]Weiterleitung abbrechen[_2].',

## tmpl/cms/dialog/recover.tmpl
	'Your password has been changed, and the new password has been sent to your email address ([_1]).' => 'Ein neues Passwort wurde erzeugt und an Ihre E-Mail-Adresse gesendet ([_1]).',
	'Sign in to Movable Type (s)' => 'Bei Movable Type anmelden (s)',
	'Sign in to Movable Type' => 'Bei Movable Type anmelden',
	'Password recovery word/phrase' => 'Erinnerungssatz',
	'Recover (s)' => 'Passwort anfordern (s)',
	'Recover' => 'Passwort anfordern',
	'Go Back (x)' => 'Zurück (x)',

## tmpl/cms/dialog/comment_reply.tmpl
	'Reply to comment' => 'Auf Kommentar antworten',
	'On [_1], [_2] commented on [_3]' => '[_2] hat am [_1] [_3] kommentiert',
	'Preview of your comment' => 'Kommentarvorschau',
	'Your reply:' => 'Ihre Antwort:',
	'Submit reply (s)' => 'Abschicken (s)',
	'Preview reply (v)' => 'Vorschau (v)',
	'Re-edit reply (r)' => 'Erneut bearbeiten (r)',
	'Re-edit' => 'Erneut bearbeiten',

## tmpl/cms/dialog/asset_list.tmpl
	'Insert Asset' => 'Asset einfügen',
	'Upload New File' => 'Neue Datei hochladen',
	'Upload New Image' => 'Neues Bild hochladen',
	'Asset Name' => 'Assetname',
	'View Asset' => 'Asset ansehen',
	'Next (s)' => 'Nächstes (s)',
	'Insert (s)' => 'Einfügen (s)',
	'Insert' => 'Einfügen',
	'No assets could be found.' => 'Keine Assets gefunden.',

## tmpl/cms/dialog/refresh_templates.tmpl
	'Refresh Template Set' => 'Vorlagengruppen neu aufbauen',
	'Refresh [_1] template set' => 'Vorlagengruppe [_1] neu aufbauen',
	'Updates current templates while retaining any user-created or user-modified templates.' => 'Aktualisiert die gewählten Vorlagen, ohne von Benutzern angelegte oder bearbeitete Vorlagen zu verändern',
	'Apply a new template set' => 'Neue Vorlagengruppe installieren',
	'Deletes all existing templates and install the selected template set.' => 'Löscht alle vorhandenen Vorlagen und installiert die gewählten Vorlagengruppe.',
	'Reset to factory defaults' => 'Auf Werkseinstellungen zurücksetzen',
	'Deletes all existing templates and installs factory default template set.' => 'Löscht alle vorhandenen Vorlagen und installiert die Movable Type-Standardvorlagen',
	'Make backups of existing templates first' => 'Sichern Sie zuerst Ihre vorhandenen Vorlagen',
	'You have requested to <strong>refresh the current template set</strong>. This action will:' => 'Sie möchten <strong>die vorhandene Vorlagengruppe neu aufbauen</strong>. Das umfasst:',
	'potentially install new templates' => 'ggf. die Installation neuer Vorlagen',
	'overwrite some existing templates with new template code' => 'das Überschreiben vorhandener Vorlagen',
	'backups will be made of your templates and can be accessed through your backup filter' => 'die Anfertigung einer Sicherungskopie der vorhandenen Vorlagen',
	'You have requested to <strong>apply a new template set</strong>. This action will:' => 'Sie möchten <strong>eine neue Vorlagengruppe installieren</a>. Das umfasst:',
	'delete all of the templates in your blog' => 'die Löschung aller vorhandenen Vorlagen Ihres Blogs',
	'install new templates from the selected template set' => 'die Installation der Movable Type-Standardvorlagen',
	'Are you sure you wish to continue?' => 'Möchten Sie wirklich fortsetzen?',

## tmpl/cms/dialog/publishing_profile.tmpl
	'Publishing Profile' => 'Veröffentlichungsprofil', # Translate - New # OK
	'Choose the profile that best matches the requirements for this blog.' => 'Wählen Sie das Profil, das den Anforderungen dieses Blogs am besten entspricht.', # Translate - New # OK
	'Static Publishing' => 'Statische Veröffentlichung', # Translate - New # OK
	'Publish all files statically.' => 'Alle Dateien werden statisch veröffentlicht.', # Translate - New # OK
	'Asynchronous Publishing' => 'Asynchrone Veröffentlichung', # Translate - New # OK
	'Publish all files via the asynchronous job queue.' => 'Alle Dateien werden über automatisch im Hintergrund veröffentlicht.', # Translate - New # OK
	'High Priority Static Publishing' => 'Priorisierte statische Veröffentlichung', # Translate - New # OK
	'Publish main index template and all entry/page archives statically. Publish all other files in the background.' => 'Die Indexvorlage und alle Archivseiten werden statisch, alle anderen Dateien im Hintergrund veröffentlicht.', # Translate - New # OK
	'Dynamic Publishing' => 'Dynamische Veröffentlichung', # Translate - New # OK
	'Publish all files dynamically.' => 'Alle Dateien werden dynamisch veröffentlicht.', # Translate - New # OK
	'Dynamic Archives Only' => 'Nur dynamische Archive', # Translate - New # OK
	'Publish all archives dynamically. Publish all other files statically.' => 'Archive werden dynamisch, alle anderen Dateien statisch veröffentlicht.', # Translate - New # OK
	'This new publishing profile will update all of your templates.' => 'Mit dem neuen Veröffentlichungsprofil werden alle Vorlagen aktualisiert.', # Translate - New # OK

## tmpl/cms/dialog/asset_upload.tmpl
	'You need to configure your blog.' => 'Bitte konfigurieren Sie Ihr Blog.',
	'Your blog has not been published.' => 'Ihr Blog wurde noch nicht veröffentlicht.',

## tmpl/cms/dialog/restore_upload.tmpl
	'Restore: Multiple Files' => 'Wiederherstellung mehrerer Dateien',
	'Canceling the process will create orphaned objects.  Are you sure you want to cancel the restore operation?' => 'Abbrechen führt zu verwaisten Objekten. Wiederherstellung wirklich abbrechen?',
	'Please upload the file [_1]' => 'Bitte laden Sie die Datei [_1] hoch',

## tmpl/cms/dialog/entry_notify.tmpl
	'Send a Notification' => 'Benachrichtigung versenden',
	'You must specify at least one recipient.' => 'Bitte geben Sie mindestens einen Empfänger an.',
	'Your blog\'s name, this entry\'s title and a link to view it will be sent in the notification.  Additionally, you can add a  message, include an excerpt of the entry and/or send the entire entry.' => 'Benachrichtigungen enthalten den Names Ihres Blogs, den Namen des Eintrags und einen Link zum Eintrag. Zusätzlich können Sie eine persönliche Nachricht eingeben und  den Text des Eintrags oder einen Auszug daraus anhängen.',
	'Recipients' => 'Empfänger',
	'Enter email addresses on separate lines, or comma separated.' => 'Geben Sie pro Zeile nur eine E-Mail-Adresse ein oder trennen Sie mehrere Adressen mit Kommata.',
	'All addresses from Address Book' => 'Alle Adressen aus dem Adressbuch',
	'Optional Message' => 'Nachricht (optional)',
	'Optional Content' => 'Inhalt (optional)',
	'(Entry Body will be sent without any text formatting applied)' => '(Der Text des Eintrags wird ohne Formatierung verschickt)',
	'Send notification (s)' => 'Benachrichtigung absenden (s)',
	'Send' => 'Absenden',

## tmpl/cms/dialog/adjust_sitepath.tmpl
	'Confirm Publishing Configuration' => 'Veröffentlichungseinstellungen bestätigen',
	'URL is not valid.' => 'URL ungültig',
	'You can not have spaces in the URL.' => 'Die URL darf keine Leerzeichen enthalten',
	'You can not have spaces in the path.' => 'Der Pfad darf keine Leerzeichen enthalten',
	'Path is not valid.' => 'Pfad ungültig',
	'Archive URL' => 'Archivadresse',

## tmpl/cms/dialog/asset_options.tmpl
	'File Options' => 'Dateioptionen',
	'The file named \'[_1]\' has been uploaded. Size: [quant,_2,byte,bytes].' => 'Datei \'[_1]\' hochgeladen. Größe: [quant,_2,Byte,Bytes].',
	'Create entry using this uploaded file' => 'Eintrag mit hochgeladener Datei anlegen',
	'Create a new entry using this uploaded file.' => 'Neuen Eintrag mit hochgeladener Datei anlegen',
	'Finish (s)' => 'Fertigstellen (s)',
	'Finish' => 'Fertigstellen',

## tmpl/cms/dialog/asset_options_image.tmpl
	'Display image in entry' => 'Bild in Eintrag anzeigen',
	'Alignment' => 'Ausrichtung',
	'Left' => 'Links',
	'Center' => 'Zentriert',
	'Right' => 'Rechts',
	'Use thumbnail' => 'Vorschaubild',
	'width:' => 'Breite:',
	'pixels' => 'Pixel',
	'Link image to full-size version in a popup window.' => 'Mit Großansicht in Popup verlinken',
	'Remember these settings' => 'Einstellungen speichern',

## tmpl/cms/dialog/restore_start.tmpl
	'Restoring...' => 'Wiederherstellung...',

## tmpl/cms/dialog/create_association.tmpl
	'No roles exist in this installation. [_1]Create a role</a>' => 'In dieser MT-Installation ist keine Rolle vorhanden. [_1]Rolle anlegen</a>',
	'No groups exist in this installation. [_1]Create a group</a>' => 'In dieser MT-Installation ist keine Gruppe vorhanden. [_1]Gruppe anlegen</a>',
	'No users exist in this installation. [_1]Create a user</a>' => 'In dieser MT-Installation ist kein Benutzer vorhanden. [_1]Benutzer anlegen</a>',
	'No blogs exist in this installation. [_1]Create a blog</a>' => 'In dieser MT-Installation ist kein Blog vorhanden. [_1]Blog anlegen</a>',

## tmpl/cms/cfg_comments.tmpl
	'Comment Settings' => 'Kommentar-Einstellungen',
	'Your preferences have been saved.' => 'Die Einstellungen wurden gespeichert.',
	'Note: Commenting is currently disabled at the system level.' => 'Hinweise: Die Kommentarfunktion ist derzeit für das Gesamtsystem ausgeschaltet.',
	'Comment authentication is not available because one of the needed modules, MIME::Base64 or LWP::UserAgent is not installed. Talk to your host about getting this module installed.' => 'Kommentarauthentifizierung ist derzeit nicht möglich, da ein erforderliches Modul nicht installiert ist (MIME::Base64 oder LWP::UserAgent). Bitte wenden Sie sich an Ihren Administrator.',
	'Accept Comments' => 'Kommentare zulassen',
	'If enabled, comments will be accepted.' => 'Falls aktiviert, werden Kommentare zugelassen',
	'Commenting Policy' => 'Kommentierungsregeln',
	'Immediately approve comments from' => 'Kommentare automatisch freischalten von',
	'Specify what should happen to comments after submission. Unapproved comments are held for moderation.' => 'Geben Sie an, was mit neuen Kommentaren geschehen soll. Ungeprüfte Kommentare werden zur Moderierung zurückgehalten.',
	'No one' => 'niemandem',
	'Trusted commenters only' => 'von vertrauten Kommentarautoren',
	'Any authenticated commenters' => 'von allen authentifizierten Kommentarautoren',
	'Anyone' => 'jedem',
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
	'Comment Display Options' => 'Anzeigeoptionen',
	'Comment Order' => 'Kommentar- reihenfolge',
	'Select whether you want visitor comments displayed in ascending (oldest at top) or descending (newest at top) order.' => 'Wählen Sie aus, ob Kommentare von Besuchern in aufsteigender (ältester zuerst) oder absteigender (neuester zuerst) Reihenfolge angezeigt werden sollen.',
	'Ascending' => 'Aufsteigend',
	'Descending' => 'Absteigend',
	'Auto-Link URLs' => 'URLs automatisch verlinken',
	'If enabled, all non-linked URLs will be transformed into links to that URL.' => 'Wenn die Option aktiv ist, werden alle URLs automatisch in HTML-Links umgewandelt.',
	'Text Formatting' => 'Textformatierung',
	'Specifies the Text Formatting option to use for formatting visitor comments.' => 'Legt fest, welche Textformatierungsoption standardmäßig für Kommentare verwendet werden soll.',
	'CAPTCHA Provider' => 'CAPTCHA-Quelle',
	'none' => 'Kein(e)',
	'No CAPTCHA provider available' => 'Keine CAPTCHA-Quelle verfügbar',
	'No CAPTCHA provider is available in this system.  Please check to see if Image::Magick is installed, and CaptchaSourceImageBase directive points to captcha-source directory under mt-static/images.' => 'Keine CAPTCHA-Quelle verfügbar. Bitte überprüfen Sie, ob Image::Magick installiert ist und die CaptchaSourceImageBase-Direktive auf das Captcha-Quellverzeichnis im Ordner mt-static/images verweist.',
	'Use Comment Confirmation Page' => 'Bei Abgabe von Kommentaren Bestätigungsseite anzeigen',
	'Use comment confirmation page' => 'Bei Abgabe von Kommentaren Bestätigungsseite anzeigen',

## tmpl/cms/list_member.tmpl
	'Manage Users' => 'Benutzer verwalten',
	'Are you sure you want to remove this role?' => 'Rolle wirklich entfernen?',
	'Add a user to this blog' => 'Benutzer zu diesem Blog hinzufügen',
	'Show only users where' => 'Zeige nur Benutzer mit',
	'role' => 'Rolle',
	'enabled' => 'aktiv',
	'disabled' => 'deaktiviert',
	'pending' => 'auf Moderation wartend',

## tmpl/cms/backup.tmpl
	'What to backup' => 'Umfang der Sicherung',
	'This option will backup Users, Roles, Associations, Blogs, Entries, Categories, Templates and Tags.' => 'Hier können Sie eine Sicherungskopie Ihrer Blogs erstellen. Sicherungen umfassen Benutzerkonten, Rollen, Verknüpfungen, Blogs, Einträge, Kategoriedefinitionen, Vorlagen und Tags.',
	'Everything' => 'Mit allen Blogs',
	'Choose blogs...' => 'Blogs wählen...',
	'Archive Format' => 'Archivformat',
	'The type of archive format to use.' => 'Das zu verwendende Archivformat',
	'Don\'t compress' => 'Nicht komprimieren',
	'Target File Size' => 'Gewünschte Dateigröße ',
	'Approximate file size per backup file.' => 'Ungefähre Größe pro Backupdatei (MB)',
	'Don\'t Divide' => 'Sicherungsdatei nicht aufteilen',
	'Make Backup (b)' => 'Sicherung erstellen (b)',
	'Make Backup' => 'Sicherung erstellen',

## tmpl/cms/setup_initial_blog.tmpl
	'Create Your First Blog' => 'Das erste Blog anlegen',
	'The blog name is required.' => 'Blog-Name erforderlich.',
	'The blog URL is required.' => 'Blog-URL erforderlich.',
	'The publishing path is required.' => 'Pfadangabe erforderlich.',
	'The timezone is required.' => 'Zeitzone erforderlich.',
	'Template Set' => 'Vorlagengruppe',
	'Select the templates you wish to use for this new blog.' => 'Wählen Sie, welche Vorlage für das neue Blog verwendet werden sollen.',
	'Timezone' => 'Zeitzone',
	'Select your timezone from the pulldown menu.' => 'Zeitzone des Weblogs',
	'Time zone not selected' => 'Es wurde keine Zeitzone gewählt',
	'UTC+13 (New Zealand Daylight Savings Time)' => 'UTC+13 (Neuseeland Sommerzeit)',
	'UTC+12 (International Date Line East)' => 'UTC+12 (Internationale Datumslinie Ost)',
	'UTC+11' => 'UTC+11 (Ost-Australische Sommerzeit)',
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
	'Finish install (s)' => 'Installation abschließen (s)',
	'Finish install' => 'Installation abschließen',
	'Back (x)' => 'Zurück (x)',

## tmpl/cms/edit_entry.tmpl
	'Create Page' => 'Seite anlegen',
	'Add folder' => 'Ordner hinzufügen',
	'Add folder name' => 'Ordnername hinzufügen',
	'Add new folder parent' => 'Neuen übergeordneten Ordner hinzufügen',
	'Save this page (s)' => 'Seite speichern (s)',
	'Preview this page (v)' => 'Vorschau (v)',
	'Delete this page (x)' => 'Seite löschen (x)',
	'View Page' => 'Seite ansehen',
	'Add category' => 'Kategorie hinzufügen',
	'Add category name' => 'Kategoriename hinzufügen',
	'Add new category parent' => 'Neue übergeordnete Kateotrie hinzufügen',
	'Save this entry (s)' => 'Eintrag speichern (s)',
	'Preview this entry (v)' => 'Vorschau (v)',
	'Delete this entry (x)' => 'Eintrag löschen (x)',
	'View Entry' => 'Eintrag ansehen',
	'A saved version of this entry was auto-saved [_2]. <a href="[_1]">Recover auto-saved content</a>' => 'Eintrag automatisch gespeichert [_2]. <a href="[_1]>Automatisch gespeicherte Version wiederherstellen</a>',
	'A saved version of this page was auto-saved [_2]. <a href="[_1]">Recover auto-saved content</a>' => 'Seite automatisch gespeichert [_2]. <a href="[_1]>Automatisch gespeicherte Version wiederherstellen</a>',
	'This entry has been saved.' => 'Eintrag gespeichert.',
	'This page has been saved.' => 'Seite gesichert.',
	'One or more errors occurred when sending update pings or TrackBacks.' => 'Es sind ein oder mehrere Fehler beim Senden von TrackBacks aufgetreten.',
	'_USAGE_VIEW_LOG' => 'Nähere Informationen zum aufgetretenen Fehler finden Sie im <a href="[_1]">Aktivitätsprotokoll</a>.',
	'Your customization preferences have been saved, and are visible in the form below.' => 'Einstellungen gespeichert.',
	'Your changes to the comment have been saved.' => 'Kommentaränderungen gespeichert.',
	'Your notification has been sent.' => 'Benachrichtigung gesendet.',
	'You have successfully recovered your saved entry.' => 'Gespeicherten Eintrag erfolgreich wiederhergestellt.',
	'You have successfully recovered your saved page.' => 'Gespeicherte Seite erfolgreich wiederhergestellt.',
	'An error occurred while trying to recover your saved entry.' => 'Bei der Wiederherstellung des gespeicherten Eintrags ist ein Fehler aufgetreten.',
	'An error occurred while trying to recover your saved page.' => 'Bei der Wiederherstellung der gespeicherten Seite ist ein Fehler aufgetreten.',
	'You have successfully deleted the checked comment(s).' => 'Die markierten Kommentare wurden erfolgreich gelöscht.',
	'You have successfully deleted the checked TrackBack(s).' => 'Die markierten TrackBacks wurden erfolgreich gelöscht.',
	'Change Folder' => 'Ordner wechseln',
	'Stats' => 'Statistik',
	'Share' => 'Teilen',
	'<a href="[_2]">[quant,_1,comment,comments]</a>' => '<a href="[_2]">[quant,_1,Kommentar,Kommentare]</a>',
	'<a href="[_2]">[quant,_1,trackback,trackbacks]</a>' => '<a href="[_2]">[quant,_1,TrackBack,TrackBacks]</a>',
	'Unpublished' => 'Nicht veröffentlicht',
	'You must configure this blog before you can publish this entry.' => 'Bitte konfigurieren Sie das Blog, bevor Sie einen Eintrag veröffentlichen.',
	'You must configure this blog before you can publish this page.' => 'Bitte konfigurieren Sie das Blog, bevor Sie eine Seite veröffentlichen.',
	'[_1] - Created by [_2]' => 'Angelegt von [_2] [_1]',
	'[_1] - Published by [_2]' => 'Veröffentlicht von [_2] [_1]',
	'[_1] - Edited by [_2]' => 'Bearbeitet von [_2] [_1]',
	'Publish On' => 'Veröffentlichen um',
	'Publish Date' => 'Veröffent- lichungs- zeitpunkt',
	'Select entry date' => 'Eintragsdatum wählen',
	'Unlock this entry&rsquo;s output filename for editing' => 'Dateinamen manuell bearbeiten',
	'Warning: If you set the basename manually, it may conflict with another entry.' => 'Warnung: Wenn Sie den Basisnamen manuell einstellen, ist es nicht auszuschließen, daß der gewählte Name bereits existiert.',
	'Warning: Changing this entry\'s basename may break inbound links.' => 'Warnung: Wenn Sie den Basisnamen nachträglich ändern, können externe Links zu diesem Eintrag ungültig werden.',
	'close' => 'schließen',
	'Accept' => 'Annehmen',
	'Outbound TrackBack URLs' => 'TrackBack- URLs',
	'View Previously Sent TrackBacks' => 'TrackBacks anzeigen',
	'You have unsaved changes to this entry that will be lost.' => 'Es liegen nicht gespeicherte Eintragsänderungen vor, die verloren gehen werden.',
	'You have unsaved changes to this page that will be lost.' => 'Es liegen nicht gespeicherte Seitenänderungen vor, die verloren gehen werden.',
	'Enter the link address:' => 'Link-Adresse eingeben:',
	'Enter the text to link to:' => 'Link-Text eingeben:',
	'Your entry screen preferences have been saved.' => 'Einstellungen gespeichert.',
	'Your entry screen preferences have been saved. Please refresh the page to reorder the custom fields.' => 'Einstellungen gespeichert. Bitte laden Sie die Seite neu um die Felder anzuordnen.',
	'Are you sure you want to use the Rich Text editor?' => 'Grafischen Editor wirklich verwenden?',
	'Make primary' => 'Als Hauptkategorie',
	'Fields' => 'Felder',
	'Body' => 'Text',
	'Reset display options' => 'Anzeigeoptionen zurücksetzen',
	'Reset display options to blog defaults' => 'Anzeigeoptionen auf Standardeinstellungen zurücksetzen',
	'Reset defaults' => 'Auf Standardeinstellungen zurücksetzen',
	'Extended' => 'Erweiterter Text',
	'Format:' => 'Formatierung:',
	'(comma-delimited list)' => '(Liste mit Kommatrennung)',
	'(space-delimited list)' => '(Liste mit Leerzeichentrennung)',
	'(delimited by \'[_1]\')' => '(Trennung durch \'[_1]\')',
	'None selected' => 'Keine',

## tmpl/cms/refresh_results.tmpl
	'Template Refresh' => 'Vorlagen neu aufbauen',
	'No templates were selected to process.' => 'Keine Vorlagen gewählt.',
	'Return to templates' => 'Zurück zu den Vorlagen',

## tmpl/cms/view_log.tmpl
	'The activity log has been reset.' => 'Aktivitätsprotokoll zurückgesetzt',
	'All times are displayed in GMT[_1].' => 'Alle Zeiten in GMT[_1]',
	'All times are displayed in GMT.' => 'Alle Zeiten in GMT',
	'Show only errors' => 'Nur Fehlermeldungen anzeigen',
	'System Activity Log' => 'System-Aktivitätsprotokoll',
	'Filtered' => 'Gefilterte',
	'Filtered Activity Feed' => 'Gefilterter Aktivitätsfeed',
	'Download Filtered Log (CSV)' => 'Gefiltertes Protokoll herunterladen (CSV)',
	'Download Log (CSV)' => 'Protokoll herunterladen (CSV)',
	'Clear Activity Log' => 'Aktivitätsprotokoll zurücksetzen',
	'Are you sure you want to reset the activity log?' => 'Aktivitätsprotokoll wirklich zurücksetzen?',
	'Showing all log records' => 'Alle Einträge',
	'Showing log records where' => 'Einträge mit',
	'Show log records where' => 'Zeige Einträge mit',
	'level' => 'Art',
	'classification' => 'Thema',
	'Security' => 'Sicherheit',
	'Error' => 'Fehler',
	'Information' => 'Information',
	'Debug' => 'Debug',
	'Security or error' => 'Sicherheit oder Fehler',
	'Security/error/warning' => 'Sicherheit/Fehler/Warnung',
	'Not debug' => 'Kein Debug',
	'Debug/error' => 'Debug/Fehler',

## tmpl/cms/edit_category.tmpl
	'Edit Category' => 'Kategorie bearbeiten',
	'Your category changes have been made.' => 'Die Einstellungen wurden übernommen.',
	'You must specify a label for the category.' => 'Geben Sie einen Namen für die Kategorie an.',
	'_CATEGORY_BASENAME' => 'Basisname',
	'This is the basename assigned to your category.' => 'Der dieser Kategorie zugewiesene Basisname',
	'Unlock this category&rsquo;s output filename for editing' => 'Dateinamen manuell bearbeiten',
	'Warning: Changing this category\'s basename may break inbound links.' => 'Achtung: Änderungen des Basisnamens können bestehende externe Links auf diese Kategorieseite ungültig machen',
	'Inbound TrackBacks' => 'TrackBack-Empfang',
	'Accept Trackbacks' => 'TrackBacks zulassen',
	'If enabled, TrackBacks will be accepted for this category from any source.' => 'Wenn die Option aktiv ist, sind Kategorie-TrackBacks aus allen Quellen zugelassen',
	'View TrackBacks' => 'TrackBacks ansehen',
	'TrackBack URL for this category' => 'TrackBack-URL für diese Kategorie',
	'_USAGE_CATEGORY_PING_URL' => 'Das ist die Adresse für TrackBacks für diese Kategorie. Wenn Sie sie öffentlich machen, kann jeder, der in seinem Blog einen für diese Kategorie relevanten Eintrag geschrieben hat, einen TrackBack-Ping senden. Mittels TrackBack-Tags können Sie diese TrackBacks dann auf Ihrer Seite anzeigen. Näheres dazu finden Sie in der Dokumentation.',
	'Passphrase Protection' => 'Passphrasenschutz',
	'Optional' => 'Optional',
	'Outbound TrackBacks' => 'TrackBack-Versand',
	'Trackback URLs' => 'TrackBack-URLs',
	'Enter the URL(s) of the websites that you would like to send a TrackBack to each time you create an entry in this category. (Separate URLs with a carriage return.)' => 'Geben Sie die Adressen der Websites ein, an die Sie automatisch einen TrackBack-Ping schicken möchten, wenn ein neuer Eintrag in dieser Kategorie veröffentlicht wurde. Verwenden Sie für jede Adresse eine neue Zeile.',
	'Save changes to this category (s)' => 'Kategorieänderungen speichern (s)',

## tmpl/cms/cfg_spam.tmpl
	'Spam Settings' => 'Spam-Einstellungen',
	'Your spam preferences have been saved.' => 'Spam-Einstellungen gespeichert.',
	'Auto-Delete Spam' => 'Spam automatisch löschen',
	'If enabled, feedback reported as spam will be automatically erased after a number of days.' => 'Falls aktiviert, wird als Spam markiertes Feedback nach einer wählbaren Anzahl von Tagen automatisch gelöscht.',
	'Delete Spam After' => 'Spam löschen nach',
	'When an item has been reported as spam for this many days, it is automatically deleted.' => 'Wenn ein Feedback für länger als angegeben als Spam markiert war, wird es automatisch gelöscht.',
	'Spam Score Threshold' => 'Spam-Schwellenwert',
	'Comments and TrackBacks receive a spam score between -10 (complete spam) and +10 (not spam). Feedback with a score which is lower than the threshold shown above will be reported as spam.' => 'Kommentare und TrackBacks bekommen eine Spam-Bewertung zwischen -10 (sicher Spam) und +10 (kein Spam) zugewiesen. Feedback mit einer geringeren Bewertung als eingestellt werden automatisch als Spam markiert.',
	'Less Aggressive' => 'konservativ',
	'Decrease' => 'Abschwächen',
	'Increase' => 'Verstärken',
	'More Aggressive' => 'aggressiv',

## tmpl/cms/list_notification.tmpl
	'You have added [_1] to your address book.' => '[_1] zum Adressbuch hinzugefügt.',
	'You have successfully deleted the selected contacts from your address book.' => 'Gewählte Kontakte erfolgreich aus dem Adressbuch gelöscht.',
	'Download Address Book (CSV)' => 'Adressbuch herunterladen (CSV)',
	'contact' => 'Kontakt',
	'contacts' => 'Kontakte',
	'Create Contact' => 'Kontakt anlegen',
	'Website URL' => 'Website',
	'Add Contact' => 'Kontakt hinzufügen',

## tmpl/cms/edit_folder.tmpl
	'Edit Folder' => 'Ordner bearbeiten',
	'Your folder changes have been made.' => 'Änderungen gespeichert',
	'You must specify a label for the folder.' => 'Sie müssen diesem Ordner eine Bezeichnung geben',
	'Save changes to this folder (s)' => 'Ordneränderungen speichern (s)',

## tmpl/cms/export.tmpl
	'You must select a blog to export.' => 'Sie müssen wählen, welches Blog exportiert werden soll.',
	'_USAGE_EXPORT_1' => 'Hier können Sie die Einträge, Kommentare und TrackBacks eines Blogs exportieren. Ein Export stellt <em>keine</em> komplette Sicherung eines Blogs dar. Verwenden Sie dafür die Funktion Sichern/Wiederherstellen.',
	'Blog to Export' => 'Zu exportierendes Blog',
	'Select a blog for exporting.' => 'Zu exportierendes Blog',
	'Change blog' => 'Anderes Blog wählen',
	'Select blog' => 'Blog wählen',
	'Export Blog (s)' => 'Blog exportieren (s)',
	'Export Blog' => 'Blog exportieren',

## tmpl/cms/edit_comment.tmpl
	'The comment has been approved.' => 'Kommentar freigeschaltet.',
	'Save changes to this comment (s)' => 'Kommentaränderungen speichern (s)',
	'Delete this comment (x)' => 'Diesen Kommentar löschen (x)',
	'Previous Comment' => 'Vorheriger Kommentar',
	'Next Comment' => 'Nächster Kommentar',
	'Manage Comments' => 'Kommentare verwalten',
	'View entry comment was left on' => 'Eintrag zum Kommentar anzeigen',
	'Reply to this comment' => 'Kommentar beantworten',
	'Update the status of this comment' => 'Kommentarstatus aktualisieren',
	'Approved' => 'Freigeschaltet',
	'Unapproved' => 'Nicht freigeschaltet',
	'Reported as Spam' => 'Als Spam gemeldet',
	'View all comments with this status' => 'Alle Kommentare mit diesem Status anzeigen',
	'Spam Details' => 'Spam-Details',
	'Total Feedback Rating: [_1]' => 'Gesamtbewertung: [_1]',
	'Score' => 'Bewertung',
	'Results' => 'Treffer',
	'The name of the person who posted the comment' => 'Name des Kommentarautors',
	'(Trusted)' => '(vertraut)',
	'Ban Commenter' => 'Kommentarautor sperren',
	'Untrust Commenter' => 'Kommentarautor nicht mehr vertrauen',
	'(Banned)' => '(gesperrt)',
	'Trust Commenter' => 'Kommentarautor vertrauen',
	'Unban Commenter' => 'Kommentarautor nicht mehr sperren',
	'View all comments by this commenter' => 'Alle Kommentare von diesem Kommentarautor anzeigen',
	'Email address of commenter' => 'E-Mail-Adresse des Kommentarautors',
	'None given' => 'Nicht angegeben',
	'URL of commenter' => 'URL des Kommentarautors',
	'View all comments with this URL' => 'Alle Kommentare mit dieser URL anzeigen',
	'[_1] this comment was made on' => '[_1] zum Kommentar',
	'[_1] no longer exists' => '[_1] existiert nicht mehr',
	'View all comments on this [_1]' => 'Alle Kommentare zu diesem Eintrag oder dieser Seite',
	'Date this comment was made' => 'Datum, an dem dieser Kommentar abgegeben wurde',
	'View all comments created on this day' => 'Alle Kommentare dieses Tages anzeigen',
	'IP Address of the commenter' => 'IP-Adresse des Kommentarautors',
	'View all comments from this IP address' => 'Alle Kommentare von dieser IP-Adresse anzeigen',
	'Fulltext of the comment entry' => 'Vollständiger Kommentartext',
	'Responses to this comment' => 'Reaktionen auf diesen Kommentar',

## tmpl/cms/edit_author.tmpl
	'Edit Profile' => 'Profil bearbeiten',
	'This profile has been updated.' => 'Profil aktualisiert',
	'A new password has been generated and sent to the email address [_1].' => 'Ein neues Passwort wurde erzeugt und an [_1] verschickt.',
	'Your Web services password is currently' => 'Ihr Passwort für Webdienste lautet derzeit',
	'_WARNING_PASSWORD_RESET_SINGLE' => 'Sie sind dabei, das Passwort von [_1] zurückzusetzen. Dazu wird ein zufällig erzeugtes neues Passwort per E-Mail an [_2] verschickt werden.\n\nForsetzen?',
	'Error occurred while removing userpic.' => 'Beim Entfernen des Benutzerbildes ist ein Fehler aufgetreten',
	'_USER_STATUS_CAPTION' => 'Status',
	'Status of user in the system. Disabling a user removes their access to the system but preserves their content and history.' => 'Globaler Benutzerstatus. Deaktivierung eines Benutzerkontos führt zum Ausschluß des Benutzers. Seine Inhalte und Protokolleinträge bleiben erhalten.',
	'_USER_PENDING' => 'Schwebend',
	'The username used to login.' => 'Benutzername (für Anmeldung)',
	'External user ID' => 'Externe Benutzer-ID',
	'The name used when published.' => 'Anzeigename (für Veröffentlichung)',
	'The email address associated with this user.' => 'Mit diesem Benutzer verknüpfte E-Mail-Adresse',
	'The URL of the site associated with this user. eg. http://www.movabletype.com/' => 'Mit diesem Benutzer verknüpfte Web-Adresse (z.B. http://movabletype.de/)',
	'Userpic' => 'Benutzerbild',
	'The image associated with this user.' => 'Ein diesem Benutzer zugeordnetes Bild',
	'Select Userpic' => 'Benutzerbild wählen',
	'Remove Userpic' => 'Benutzerbild entfernen',
	'Change Password' => 'Passwort ändern',
	'Current Password' => 'Derzeitiges Passwort',
	'Existing password required to create a new password.' => 'Derzeitiges Passwort zur Passwortänderung erforderlich',
	'Initial Password' => 'Passwort',
	'Enter preferred password.' => 'Bevorzugtes Passwort eingeben',
	'New Password' => 'Neues Passwort',
	'Enter the new password.' => 'Neues Passwort eingeben',
	'Confirm Password' => 'Passwort bestätigen',
	'Repeat the password for confirmation.' => 'Passwort zur Bestätigung wiederholen',
	'This word or phrase will be required to recover a forgotten password.' => 'Dieser Ausdruck wird abgefragt, wenn das Passwort vergessen und daher ein neues Passwort angefordert wurde.',
	'Language' => 'Sprache',
	'Preferred language of this user.' => 'Bevorzugte Sprache des Benutzers',
	'Text Format' => 'Textformatierung',
	'Preferred text format option.' => 'Bevorzugte Formatierungsoption',
	'(Use Blog Default)' => '(Standard verwenden)',
	'Tag Delimiter' => 'Tag-Trennzeichen',
	'Preferred method of separating tags.' => 'Bevorzugtes Trennzeichen für Tags',
	'Comma' => 'Komma',
	'Space' => 'Leerzeichen',
	'Web Services Password' => 'Passwort für Webdienste',
	'For use by Activity feeds and with XML-RPC and Atom-enabled clients.' => 'Erforderlich für Aktivitätsfeeds und für externe Software, die über XML-RPC oder ATOM-API auf das Weblog zugreift',
	'Reveal' => 'Anzeigen',
	'System Permissions' => 'Berechtigungen',
	'Options' => 'Optionen',
	'Create personal blog for user' => 'Persönliches Blog für den Benutzer anlegen',
	'Create User (s)' => 'Benutzerkonto anlegen (s)',
	'Save changes to this author (s)' => 'Kontoänderungen speichern (s)',
	'_USAGE_PASSWORD_RESET' => 'Hier können Sie das Passwort dieses Benutzers zurücksetzen. Dazu wird ein zufälliges neues Passwort erzeugt und an <strong>[_1]</strong> verschickt werden.',
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
	'Show only [_1] where' => 'Zeige nur [_1] mit',
	'approved' => 'Freigeschaltet',
	'unapproved' => 'Nicht freigeschaltet',

## tmpl/cms/list_banlist.tmpl
	'IP Banning Settings' => 'IP-Sperren-Einstellungen',
	'IP addresses' => 'IP-Adressen',
	'Delete selected IP Address (x)' => 'Gewählte IP-Adressen löschen (x)',
	'You have added [_1] to your list of banned IP addresses.' => 'Sie haben [_1] zur Liste mit gesperrten IP-Adressen hinzugefügt.',
	'You have successfully deleted the selected IP addresses from the list.' => 'Sie haben die ausgewählten IP-Adressen erfolgreich aus der Liste entfernt.',
	'Ban IP Address' => 'IP-Adresse sperren',
	'Date Banned' => 'gesperrt am',

## tmpl/cms/error.tmpl
	'An error occurred' => 'Es ist ein Fehler aufgetreten',

## tmpl/cms/list_role.tmpl
	'Roles: System-wide' => 'System: Rollen',
	'You have successfully deleted the role(s).' => 'Rolle(n) erfolgreich gelöscht.',
	'roles' => 'Rollen',
	'Members' => 'Mitglieder',
	'Role Is Active' => 'Rolle ist aktiv',
	'Role Not Being Used' => 'Rolle wird derzeit nicht verwendet',

## tmpl/cms/widget/new_version.tmpl
	'What\'s new in Movable Type [_1]' => 'Neu in Movable Type [_1]',
	'Congratulations, you have successfully installed Movable Type [_1]. Listed below is an overview of the new features found in this release.' => 'Herzlichen Glückwunsch, Sie haben Movable Type [_1] erfolgreich installiert! Die wichtigsten Neuerungen dieser Version:',

## tmpl/cms/widget/new_user.tmpl
	'Welcome to Movable Type, the world\'s most powerful blogging, publishing and social media platform. To help you get started we have provided you with links to some of the more common tasks new users like to perform:' => 'Willkommen zu Movable Type, der leistungsfähigsten Blogging-, Publishing- und Social Media-Plattfom! Um Ihnen den Einstieg zu erleichtern, haben wir Ihnen einige Links zu den Funktionen zusammengestellt, die für neue Benutzer besonders interessant sind:',
	'Write your first post' => 'Den ersten Eintrag schreiben',
	'What would a blog be without content? Start your Movable Type experience by creating your very first post.' => 'Was ist ein Blog ohne Inhalt? Schreiben Sie jetzt Ihren ersten Eintrag!',
	'Design your blog' => 'Das Blog gestalten',
	'Customize the look and feel of your blog quickly by selecting a design from one of our professionally designed themes.' => 'Mit unseren professionellen Designvorlagen gestalten Sie Ihr Blog unkompliziert nach Ihren Vorstellungen.',
	'Explore what\'s new in Movable Type 4' => 'Neu in Movable Type 4',
	'Whether you\'re new to Movable Type or using it for the first time, learn more about what this tool can do for you.' => 'Für Neueinsteiger wie für erfahrende Movable Type-Anwender: Erfahren Sie, was Movable Type für Sie leisten kann!',

## tmpl/cms/widget/mt_news.tmpl
	'News' => 'Neuigkeiten',
	'MT News' => 'Neues von MT',
	'Learning MT' => 'MT lernen',
	'Hacking MT' => 'MT hacken',
	'Pronet' => 'Pronet',
	'No Movable Type news available.' => 'Es liegen keine Movable Type-Nachrichten vor.',
	'No Learning Movable Type news available.' => 'Es liegen keine Movable Type lernen-Nachrichten vor',

## tmpl/cms/widget/this_is_you.tmpl
	'This is you' => 'Das sind Sie',
	'Your <a href="[_1]">last entry</a> was [_2] in <a href="[_3]">[_4]</a>.' => 'Ihr <a href="[_1]">letzter Eintrag</a> war [_2] in <a href="[_3]">[_4]</a>',
	'You have <a href="[_1]">[quant,_2,draft,drafts]</a>.' => 'Sie haben <a href="[_1]>[quant,_2,Entwurf,Entwürfe]</a>.',
	'You\'ve written <a href="[_1]">[quant,_2,entry,entries]</a> with <a href="[_3]">[quant,_4,comment,comments]</a>.' => 'Sie haben <a href="[_1]">[quant,_2,Eintrag,Einträge]</a> mit <a href="[_3]">[quant,_4,Kommentar,Kommentaren]</a> geschrieben.',
	'You\'ve written <a href="[_1]">[quant,_2,entry,entries]</a>.' => 'Sie haben <a href="[_1]">[quant,_2,Eintrag,Einträge]</a> geschrieben.',
	'Edit your profile' => 'Profil bearbeiten',

## tmpl/cms/widget/blog_stats_recent_entries.tmpl
	'[quant,_1,entry,entries] tagged &ldquo;[_2]&rdquo;' => '[quant,_1,Eintrag,Einträge] getaggt mit &#8222;[_2]&#8221;', # Translate - Improved (3) # OK
	'...' => '...',
	'Posted by [_1] [_2] in [_3]' => 'Von [_1] [_2] in [_3]',
	'Posted by [_1] [_2]' => 'Von [_1] [_2]',
	'Tagged: [_1]' => 'Getaggt: [_1]',
	'View all entries tagged &ldquo;[_1]&rdquo;' => 'Zeige alle mit &#8222;[_1]&#8221; getaggten Einträge', # Translate - Improved (3) # OK
	'No entries available.' => 'Keine Einträge vorhanden.',

## tmpl/cms/widget/blog_stats_tag_cloud.tmpl

## tmpl/cms/widget/custom_message.tmpl
	'Welcome to [_1].' => 'Willkommen zu [_1].',
	'You can manage your blog by selecting an option from the menu located to the left of this message.' => 'Sie können Ihr Blog von dem links befindlichen Menü aus verwalten.',
	'If you need assistance, try:' => 'Falls Sie Hilfe benötigen, stehen folgende Möglichkeiten zur Verfügung:',
	'Movable Type User Manual' => 'Movable Type Benutzerhandbuch',
	'http://www.sixapart.com/movabletype/support' => 'http://www.sixapart.com/movabletype/support',
	'Movable Type Technical Support' => 'Movable Type Technischer Support',
	'Movable Type Community Forums' => 'Movable Type Community-Foren',
	'Save Changes (s)' => 'Änderungen speichern (s)',
	'Change this message.' => 'Diese Nachricht ändern.',
	'Edit this message.' => 'Diese Nachricht ändern.',

## tmpl/cms/widget/mt_shortcuts.tmpl
	'Import Content' => 'Importieren',
	'Blog Preferences' => 'Blog-Einstellungen',

## tmpl/cms/widget/new_install.tmpl
	'Thank you for installing Movable Type' => 'Vielen Dank, daß Sie sich für Movable Type entschieden haben',
	'Congratulations on installing Movable Type, the world\'s most powerful blogging, publishing and social media platform. To help you get started we have provided you with links to some of the more common tasks new users like to perform:' => 'Herzlichen Glückwunsch zur Installation von Movable Type, der leistungsfähigsten Blogging-, Publizierungs- und Social Media-Plattfom. Um Ihnen den Einstieg zu erleichtern, haben wir Ihnen einige Links zu den Funktionen, die für neue Benutzer besonders interessant sind, zusammengestellt:',
	'Add more users to your blog' => 'Weitere Benutzer einladen',
	'Start building your network of blogs and your community now. Invite users to join your blog and promote them to authors.' => 'Bauen Sie ein Netzwerk auf und laden Sie weitere Personen ein, Mitautoren Ihres Blogs zu werden!',

## tmpl/cms/widget/blog_stats.tmpl
	'Error retrieving recent entries.' => 'Fehler beim Einlesen der aktuellen Einträge.',
	'Loading recent entries...' => 'Lade aktuelle Einträge...',
	'Jan.' => 'Januar',
	'Feb.' => 'Februar',
	'July.' => 'Juli',
	'Aug.' => 'August',
	'Sept.' => 'September',
	'Oct.' => 'Oktober',
	'Nov.' => 'November',
	'Dec.' => 'Dezember',
	'Movable Type was unable to locate your \'mt-static\' directory. Please configure the \'StaticFilePath\' configuration setting in your mt-config.cgi file, and create a writable \'support\' directory underneath your \'mt-static\' directory.' => 'Movable Type konnte Ihr \'mt-static\'-Verzeichnis nicht finden. Bitte überprüfen Sie die \'StaticFilePath\'-Direktive in der Konfigurationsdatei mt-config.cgi und legen Sie ein vom Webserver beschreibbares Verzeichnis \'support\' im \'mt-static\'-Verzeichnis an.',
	'Movable Type was unable to write to its \'support\' directory. Please create a directory at this location: [_1], and assign permissions that will allow the web server write access to it.' => 'Movable Type kann auf den Ordner \'support\' nicht schreibend zugreifen. Legen Sie hier: [_1] ein solches Verzeichnis an und stellen Sie sicher, daß der Webserver Schreibrechte für diesen Ordner besitzt.',
	'[_1] [_2] - [_3] [_4]' => '[_1] [_2] - [_3] [_4]',
	'You have <a href=\'[_3]\'>[quant,_1,comment,comments] from [_2]</a>' => 'Sie haben <a href=\'[_3]\'>[quant,_1,Kommentar,Kommentare] von [_2]</a>',
	'You have <a href=\'[_3]\'>[quant,_1,entry,entries] from [_2]</a>' => 'Sie haben <a href=\'[_3]\'>[quant,_1,Eintrag,Einträge] von [_2]</a>',

## tmpl/cms/widget/blog_stats_entry.tmpl
	'Most Recent Entries' => 'Aktuelle Einträge',
	'View all entries' => 'Alle Einträge',

## tmpl/cms/widget/blog_stats_comment.tmpl
	'Most Recent Comments' => 'Aktuelle Kommentare',
	'[_1] [_2], [_3] on [_4]' => '[_1] [_2], [_3] zu [_4]',
	'View all comments' => 'Alle Kommentare',
	'No comments available.' => 'Keine Kommentare vorhanden.',

## tmpl/cms/preview_template_strip.tmpl
	'You are previewing the template named &ldquo;[_1]&rdquo;' => 'Sie sehen eine Vorschau auf die Vorlage &#8222;[_1]&#8221;', # Translate - New # OK
	'(Publish time: [_1] seconds)' => '(Veröffentlicht in [_1] Sekunden)', # Translate - New # OK
	'Save this template (s)' => 'Vorlage speichern (s)', # Translate - New # OK
	'Save this template' => 'Vorlage speichern', # Translate - New # OK
	'Re-Edit this template (e)' => 'Vorlage erneut bearbeiten (e)', # Translate - New # OK
	'Re-Edit this template' => 'Vorlage erneut bearbeiten', # Translate - New # OK

## tmpl/cms/cfg_web_services.tmpl
	'Web Services Settings' => 'Webdienste-Einstellungen',
	'Your blog preferences have been saved.' => 'Einstellungen übernommen.',
	'Six Apart Services' => 'Six Apart-Dienste',
	'Your TypeKey token is used to access Six Apart services like its free Authentication service.' => 'Ihr TypeKey-Token ermöglicht Ihnen Zugriff auf von Six Apart angebotene Webdienste. Dazu gehören der kostenlose Authentifierzungsdienst TypeKey.',
	'TypeKey is enabled.' => 'TypeKey wird verwendet.',
	'TypeKey token:' => 'TypeKey-Token:',
	'Clear TypeKey Token' => 'TypeKey-Token löschen',
	'Please click the Save Changes button below to disable authentication.' => 'Bitte klicken Sie auf "Änderungen speichern", um die Authentifizierung abzuschalten.',
	'TypeKey is not enabled.' => 'TypeKey wird nicht verwendet',
	'or' => 'oder',
	'Obtain TypeKey token' => 'TypeKey-Token anfordern',
	'Please click the Save Changes button below to enable TypeKey.' => 'Bitte klicken Sie auf "Änderungen speichern", um TypeKey zu aktivieren.',
	'External Notifications' => 'Externe Benachrichtigungen',
	'Notify of blog updates' => 'Über Aktualisierungen benachrichtigen',
	'When this blog is updated, Movable Type will automatically notify the selected sites.' => 'Movable Type benachrichtigt die gewählten Sites automatisch, wenn dieses Blog aktualisiert wurde.',
	'Note: This option is currently ignored since outbound notification pings are disabled system-wide.' => 'Hinweis: Diese Einstellung zeigt momentan keine Wirkung, da ausgehende Pings systemweit deaktiviert sind.',
	'Others:' => 'Andere:',
	'(Separate URLs with a carriage return.)' => '(Pro Zeile eine URL)',
	'Recently Updated Key' => '"Kürzlich aktualisiert"- Schlüssel',
	'If you have received a recently updated key (by virtue of your purchase), enter it here.' => 'Wenn Sie einen "Kürzlich aktualisiert"-Schlüssel erhalten haben, tragen Sie ihn hier ein.',

## tmpl/cms/list_comment.tmpl
	'The selected comment(s) has been approved.' => 'Die gewählten Kommentare wurden freigeschaltet.',
	'All comments reported as spam have been removed.' => 'Alle als Spam markierten Kommentare wurden entfernt.',
	'The selected comment(s) has been unapproved.' => 'Die gewählten Kommentare sind nicht mehr freigeschaltet',
	'The selected comment(s) has been reported as spam.' => 'Die gewählten Kommentare wurden als Spam gemeldet',
	'The selected comment(s) has been recovered from spam.' => 'Die gewählten Kommentare wurden aus dem Spam wiederhergestellt',
	'The selected comment(s) has been deleted from the database.' => 'Die gewählten Kommentar(e) wurden aus der Datenbank gelöscht.',
	'One or more comments you selected were submitted by an unauthenticated commenter. These commenters cannot be Banned or Trusted.' => 'Nicht authentifizierten Kommentarautoren können weder gesperrt werden noch das Vertrauen ausgesprochen bekommen.',
	'No comments appeared to be spam.' => 'Kein Kommentar scheint Spam zu sein.',
	'[_1] on entries created within the last [_2] days' => '[_1] zu Einträgen, die in den letzten [_2] Tagen angelegt wurden',
	'[_1] on entries created more than [_2] days ago' => '[_1] zu Einträgen, die vor mehr als [_2] Tagen angelegt wurden',
	'spam' => 'Spam', # Translate - Case # OK

## tmpl/cms/list_tag.tmpl
	'Your tag changes and additions have been made.' => 'Tag-Änderungen übernommen',
	'You have successfully deleted the selected tags.' => 'Markierte Tags erfolgreich gelöscht',
	'tag' => 'Tag',
	'tags' => 'Tags',
	'Specify new name of the tag.' => 'Geben Sie den neuen Tagnamen an',
	'Tag Name' => 'Name des Tags',
	'Click to edit tag name' => 'Klicken, um Tagname zu bearbeiten',
	'Rename [_1]' => '[_1] umbenennen',
	'Rename' => 'Umbenennen',
	'Show all [_1] with this tag' => 'Alle [_1] mit diesem Tag zeigen',
	'[quant,_1,_2,_3]' => '[quant,_1,_2,_3]',
	'[quant,_1,entry,entries]' => '[quant,_1,Eintrag,Einträge]',
	'The tag \'[_2]\' already exists. Are you sure you want to merge \'[_1]\' with \'[_2]\' across all blogs?' => 'Das Tag \'[_2]\' ist schon vorhanden. \'[_1]\' wirklich in allen Blogs mit \'[_2]\' zusammenführen?',
	'An error occurred while testing for the new tag name.' => 'Bei der Überprüfung des neuen Tag-Namens ist ein Fehler aufgetreten.',

## tmpl/cms/list_template.tmpl
	'Blog Templates' => 'Blog-Vorlagen',
	'Show All' => 'Alle zeigen', # Translate - New # OK
	'Blog Publishing Settings' => 'Veröffentlichtungs-Einstellungen',
	'You have successfully deleted the checked template(s).' => 'Vorlage(n) erfolgreich gelöscht.',
	'Your templates have been published.' => 'Die Vorlagen wurden veröffentlicht.',
	'Selected template(s) has been copied.' => 'Die gewählte(n) Vorlage(n) wurden kopiert.', # Translate - New # OK

## tmpl/cms/install.tmpl
	'Create Your Account' => 'Legen Sie Ihr Benutzerkonto an',
	'The initial account name is required.' => 'Benutzername erforderlich',
	'The display name is required.' => 'Anzeigename erforderlich', # Translate - New # OK
	'Password recovery word/phrase is required.' => 'Passwort-Erinnerungsfrage erforderlich',
	'The version of Perl installed on your server ([_1]) is lower than the minimum supported version ([_2]).' => 'Die vorhandene Perl-Version ([_1]) ist nicht aktuell genug ([_2] oder höher erforderlich).',
	'While Movable Type may run, it is an <strong>untested and unsupported environment</strong>.  We strongly recommend upgrading to at least Perl [_1].' => 'Wir empfehlen dringend, die Perl-Installation mindestens auf Version [_1] zu aktualisieren. Movable Type läuft zwar möglicherweise auch mit der vorhandenen Perl-Version, es handelt sich aber um eine <strong>nicht getestete und nicht unterstützte Umgebung</strong>.',
	'Do you want to proceed with the installation anyway?' => 'Möchten Sie die Installation dennoch fortsetzen?',
	'View MT-Check (x)' => 'MT-Check anzeigen (x)',
	'Before you can begin blogging, you must create an administrator account for your system. When you are done, Movable Type will then initialize your database.' => 'Bevor Sie bloggen können, müssen Sie einen Systemadministrator bestimmen. Movable Type wird daraufhin Ihre Datenbank einrichten.',
	'To proceed, you must authenticate properly with your LDAP server.' => 'Um fortfahren zu können, müssen Sie sich gegenüber Ihrem LDAP-Server authentifizieren',
	'The name used by this user to login.' => 'Anmeldename dieses Benutzerkontos',
	'The user&rsquo;s email address.' => 'E-Mail-Adresse dieses Benutzers',
	'The user&rsquo;s preferred language.' => 'Gewünschte Spracheinstellung',
	'Select a password for your account.' => 'Passwort dieses Benutzerkontos',
	'Password Confirm' => 'Passwortbestätigung',
	'This word or phrase will be required to recover your password if you forget it.' => 'Dieser Satz wird abgefragt, wenn Sie Ihr Passwort vergesen haben und daher ein neues Passwort anfordern möchten.',
	'Your LDAP username.' => 'Ihr LDAP-Benutzername.',
	'Enter your LDAP password.' => 'Geben Sie Ihr LDAP-Passwort ein.',

## tmpl/cms/popup/rebuild_confirm.tmpl
	'Publish [_1]' => 'Veröffentliche [_1]',
	'Publish <em>[_1]</em>' => '<em>[_1]</em> veröffentlichen',
	'_REBUILD_PUBLISH' => 'Veröffentlichen',
	'All Files' => 'Alle Dateien',
	'Index Template: [_1]' => 'Index-Vorlagen: [_1]',
	'Only Indexes' => 'Nur Indizes',
	'Only [_1] Archives' => 'Nur Archive: [_1]',
	'Publish (s)' => 'Veröffentlichen (s)',

## tmpl/cms/popup/pinged_urls.tmpl
	'Successful Trackbacks' => 'Erfolgreiche TrackBacks',
	'Failed Trackbacks' => 'Fehlgeschlagene TrackBacks',
	'To retry, include these TrackBacks in the Outbound TrackBack URLs list for your entry.' => 'Kopieren Sie diese Adressen im Eintragseditor in das Formularfeld für die zu verschickenden TrackBacks, um es erneut zu versuchen.',

## tmpl/cms/popup/rebuilt.tmpl
	'Success' => 'Erfolg',
	'All of your files have been published.' => 'Alle Dateien veröffentlicht.',
	'Your [_1] archives have been published.' => '[_1] veröffentlicht',
	'Your [_1] templates have been published.' => '[_1]-Vorlagen veröffentlicht',
	'Publish time: [_1].' => 'Zeitpunkt der Veröffentlichung: [_1]', # Translate - New # OK
	'View your site.' => 'Site ansehen',
	'View this page.' => 'Seite ansehen',
	'Publish Again (s)' => 'Erneut veröffentlichen (s)',
	'Publish Again' => 'Erneut veröffentlichen',

## tmpl/cms/list_author.tmpl
	'Users: System-wide' => 'System: Benutzerkonten',
	'You have successfully disabled the selected user(s).' => 'Gewählte Benutzerkonten erfolgreich deaktiviert',
	'You have successfully enabled the selected user(s).' => 'Gewählte Benutzerkonten erfolgreich aktiviert',
	'You have successfully deleted the user(s) from the Movable Type system.' => 'Gewählte Benutzerkonten erfolgreich aus Movable Type gelöscht',
	'The deleted user(s) still exist in the external directory. As such, they will still be able to login to Movable Type Enterprise.' => 'Die gelöschten Benutzerkonten sind im externen Verzeichnis weiterhin vorhanden. Die Benutzer können sich daher weiterhin an Movable Type Enterprise anmelden.',
	'You have successfully synchronized users\' information with the external directory.' => 'Benutzerinformationen erfolgreich mit externem Verzeichnis synchronisiert.',
	'Some ([_1]) of the selected user(s) could not be re-enabled because they were no longer found in the external directory.' => 'Einige ([_1]) der gewählten Benutzerkonten konnten nicht reaktiviert werden, da sie im externen Verzeichnis nicht mehr vorhanden sind.',
	'An error occured during synchronization.  See the <a href=\'[_1]\'>activity log</a> for detailed information.' => 'Bei der Synchronisation ist ein Fehler aufgetreten. Das  <a href=\'[_1]\'>Aktivitätsprotokoll</a> enthält nähere Informationen.',
	'Enable selected users (e)' => 'Gewählte Benutzerkonten aktivieren (e)',
	'_USER_ENABLE' => 'Aktivieren',
	'_NO_SUPERUSER_DISABLE' => 'Sie können Ihr eigenes Benutzerkonto nicht deaktivieren, da Sie Verwalter dieser Movable Type-Installation sind.',
	'Disable selected users (d)' => 'Gewählte Benutzerkonten deaktivieren (d)',
	'_USER_DISABLE' => 'Deaktivieren',
	'Showing All Users' => 'Zeige alle Benutzer',

## tmpl/cms/cfg_system_feedback.tmpl
	'System: Feedback Settings' => 'System: Feedback-Einstellungen',
	'Your feedback preferences have been saved.' => 'Ihre Feedback-Einstellungen wurden gespeichert.',
	'Feedback: Master Switch' => 'Feedback-Hauptschalter',
	'This will override all individual blog settings.' => 'Dieser Schalter überragt alle auf Blog-Ebene getätigten Einstellungen.',
	'Disable comments for all blogs' => 'Kommentare für alle Blogs deaktivieren',
	'Disable TrackBacks for all blogs' => 'TrackBacks für alle Blogs deaktivieren',
	'Outbound Notifications' => 'Benachrichtigungen',
	'Notification pings' => 'Benachrichtigungs- Pings',
	'This feature allows you to disable sending notification pings when a new entry is created.' => 'Mit dieser Funktion können Sie die automatische Versendung von Benachrichtigungs-Pings bei Veröffentlichung eines neuen Eintrags unterbinden.',
	'Disable notification pings for all blogs' => 'Versendung von Benachrichtigungs-Pings für alle Blogs deaktivieren',
	'Limit outbound TrackBacks and TrackBack auto-discovery for the purposes of keeping your installation private.' => 'Schränken Sie den Versand von TrackBacks und TrackBack Auto-Discovery auf bestimmte Sites ein, um diese Movable Type-Installation nichtöffentlich zu halten.',
	'Allow to any site' => 'Zu allen Sites',
	'(No outbound TrackBacks)' => '(Kein TrackBack-Versand)',
	'Only allow to blogs on this installation' => 'Nur zu Blogs dieser Installation',
	'Only allow the sites on the following domains:' => 'Nur zu Sites auf folgenden Domains:',

## tmpl/cms/restore_end.tmpl
	'Make sure that you remove the files that you restored from the \'import\' folder, so that if/when you run the restore process again, those files will not be re-restored.' => 'Vergessen Sie nicht, die verwendeten Dateien aus dem \'import\'-Ordner zu entfernen, damit sie bei künftigen Wiederherstellungen nicht erneut wiederhergestellt werden.',
	'An error occurred during the restore process: [_1] Please check activity log for more details.' => 'Bei der Wiederherstellung ist ein Fehler aufgetreten: [_1]. Bitte überprüfen Sie das Aktivitätsprotokoll.',

## tmpl/cms/list_asset.tmpl
	'You have successfully deleted the asset(s).' => 'Assets erfolgreich gelöscht.',
	'Show only assets where' => 'Zeige nur Assets mit',
	'type' => 'Typ',

## tmpl/cms/import.tmpl
	'You must select a blog to import.' => 'Wählen Sie, in welches Blog importiert werden soll',
	'Transfer weblog entries into Movable Type from other Movable Type installations or even other blogging tools or export your entries to create a backup or copy.' => 'Mit der Import/Export-Funktion können Sie Einträge aus anderen Movable Type-Installationen oder aus anderen Weblog-Systemen übernehmen. Bestehende Einträge können in einem Austauschformat gesichert werden.',
	'Import data into' => 'Daten importieren in',
	'Select a blog to import.' => 'Wählen Sie, in welches Blog importiert werden soll',
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
	'Import File Encoding' => 'Zeichenkodierung der Importdatei',
	'By default, Movable Type will attempt to automatically detect the character encoding of your import file.  However, if you experience difficulties, you can set it explicitly.' => 'Movable Type versucht automatisch die korrekte Zeichenkodierung auszuwählen. Sollte das fehlschlagen, können Sie sie auch explizit angeben.',
	'<mt:var name="display_name">' => '<mt:var name="display_name">',
	'Default category for entries (optional)' => 'Standard-Kategorie für Einträge (optional)',
	'You can specify a default category for imported entries which have none assigned.' => 'Standardkdategorie für importierte Einträge ohne Kategorie',
	'Select a category' => 'Kategorie auswählen...',
	'Import Entries (s)' => 'Einträge importieren (s)',
	'Import Entries' => 'Einträge importieren',

## tmpl/cms/upgrade_runner.tmpl
	'Initializing database...' => 'Initialisiere Datenbank...',
	'Upgrading database...' => 'Aktualisiere Datenbank...',
	'Installation complete!' => 'Installation abgeschlossen!',
	'Upgrade complete!' => 'Upgrade abgeschlossen!',
	'Starting installation...' => 'Starte Installation...',
	'Starting upgrade...' => 'Starte Upgrade...',
	'Error during installation:' => 'Fehler während Installation:',
	'Error during upgrade:' => 'Fehler während Upgrade:',
	'Return to Movable Type (s)' => 'Zurück zu Movable Type (s)',
	'Return to Movable Type' => 'Zurück zu Movable Type',
	'Your database is already current.' => 'Ihre Datenbank ist bereits auf dem aktuellen Stand.',

## tmpl/cms/list_widget.tmpl
	'Widget Sets' => 'Widgetgruppen',
	'Delete selected Widget Sets (x)' => 'Gewählte Widget-Gruppen löschen',
	'Helpful Tips' => 'Nützliche Hinweise',
	'To add a widget set to your templates, use the following syntax:' => 'Um eine Widgetgruppe in eine Vorlage einzubinden, verwenden Sie folgenden Code:',
	'<strong>&lt;$MTWidgetSet name=&quot;Name of the Widget Set&quot;$&gt;</strong>' => '<strong>&lt;$MTWidgetSet name=&quot;Name der Widgetgruppe&quot;$&gt;</strong>',
	'Your changes to the widget set have been saved.' => 'Änderungen gespeichert.',
	'You have successfully deleted the selected widget set(s) from your blog.' => 'Widget-Gruppe(n) erfolgreich gelöscht.',
	'No Widget Sets could be found.' => 'Keine Widgetgruppen gefunden.',
	'Create widget template' => 'Widgetvorlage anlegen', # Translate - New # OK
	'Widget Template' => 'Widgetvorlage', # Translate - New # OK
	'Widget Templates' => 'Widgetvorlagen', # Translate - New # OK

## tmpl/cms/restore.tmpl
	'Restore from a Backup' => 'System aus Sicherheitskopie wiederherstellen',
	'Perl module XML::SAX and/or its dependencies are missing - Movable Type can not restore the system without it.' => 'Das Per-Modul XML::SAX und/oder seine Abhängigkeiten fehlen. Ohne kann Movable Type das System nicht wiederherstellen.',
	'Backup file' => 'Sicherungsdatei',
	'If your backup file is located on your computer, you can upload it here.  Otherwise, Movable Type will automatically look in the \'import\' folder of your Movable Type directory.' => 'Wenn Sie eine auf Ihrem Computer gespeicherte Sicherungsdatei verwenden wollen, laden Sie diese hier hoch. Alternativ verwendet Movable Type automatisch die Sicherungsdatei, die es im \'import\'-Unterordner Ihres Movable Type-Verzeichnis findet.',
	'Check this and files backed up from newer versions can be restored to this system.  NOTE: Ignoring Schema Version can damage Movable Type permanently.' => 'Anwählen, um auch Dateien mit einer neueren Schemaversionen wiederherstellen zu können. HINWEIS: Nichtbeachtung der Schemaverion kann Ihre Movable Type-Installation dauerhaft beschädigen.',
	'Ignore schema version conflicts' => 'Versionskonflikte ignorieren',
	'Check this and existing global templates will be overwritten from the backup file.' => 'Wenn diese Option aktiv ist, werden globale Vorlagen mit der gesicherten Fassung überschrieben',
	'Overwrite global templates.' => 'Globale Vorlagen überschreiben',
	'Restore (r)' => 'Wiederherstellen (r)',

## tmpl/cms/system_check.tmpl
	'User Counts' => 'Benutzerzahl',
	'Number of users in this system.' => 'Anzahl der Benutzer dieses Systems',
	'Total Users' => 'Benutzer insgesamt',
	'Active Users' => 'Aktive Benutzer',
	'Users who have logged in within 90 days are considered <strong>active</strong> in Movable Type license agreement.' => 'Benutzer, die sich innerhalb der letzten 90 Tage eingeloggt haben, gelten nach den Movable Type-Lizenzbedingungen als <strong>aktiv</strong>.',
	'Movable Type could not find the script named \'mt-check.cgi\'. To resolve this issue, please ensure that the mt-check.cgi script exists and/or the CheckScript configuration parameter references it properly.' => 'Movable Type konnte die Datei \'mt-check.cgi\' nicht finden. Stellen Sie sicher, daß die Datei vorhanden ist und MTCheckScript die richtigen Pfadangaben enthält.',

## tmpl/cms/restore_start.tmpl
	'Restoring Movable Type' => 'Movable Type wiederherstellen',

## tmpl/cms/cfg_archives.tmpl
	'Error: Movable Type was not able to create a directory for publishing your blog. If you create this directory yourself, assign sufficient permissions that allow Movable Type to create files within it.' => 'Fehler: Movable Type konnte kein Verzeichnis zur Veröffentlichung Ihres Blogs anlegen. Wenn Sie das Verzeichnis manuell angelegt haben, stellen Sie bitte sicher, daß der Webserver Schreibrechte für das Verzeichnis hat.',
	'Your blog\'s archive configuration has been saved.' => 'Einstellungen übernommen',
	'You have successfully added a new archive-template association.' => 'Sie haben erfolgreich eine neue Verknüpfung zwischen Archiven und Vorlagen hinzugefügt.',
	'You may need to update your \'Master Archive Index\' template to account for your new archive configuration.' => 'Eventuell müssen Sie Ihre Vorlage für das Archiv-Index aktualisieren, um die neue Archiv-Konfiguration zu übernehmen.',
	'The selected archive-template associations have been deleted.' => 'Die gewählten Verknüpfungen zwischen Archiven und Vorlagen wurden gelöscht.',
	'Warning: one or more of your templates is set to publish dynamically using PHP, however your server side include method may not be compatible with dynamic publishing.' => 'Achtung: Mindestens eine ihrer Vorlagen wird dynamisch per PHP veröffentlicht. Die gewählte Server Side Include-Methode ist möglicherweise aber nicht für dynamisches Veröffentlichen geeignet.', # Translate - New # OK
	'You must set your Local Site Path.' => 'Bitte wählen Sie ein Wurzelverzeichnis',
	'You must set a valid Site URL.' => 'Bitte geben Sie eine gültige Adresse (URL) an',
	'You must set a valid Local Site Path.' => 'Bitte geben Sie ein gültiges lokales Verzeichnis an',
	'Publishing Paths' => 'System-Pfade',
	'The URL of your website. Do not include a filename (i.e. exclude index.html). Example: http://www.example.com/blog/' => 'Die URL Ihrer Website. Bitte geben Sie die Adresse ohne Dateinamen ein, beispielsweise so: http://www.beispiel.de/blog/',
	'Unlock this blog&rsquo;s site URL for editing' => 'Blog-URL manuell bearbeiten',
	'Warning: Changing the site URL can result in breaking all the links in your blog.' => 'Hinweis: Eine Änderung der Webadresse kann alle Link zu Ihrem Blog ungültig machen.',
	'The path where your index files will be published. An absolute path (starting with \'/\') is preferred, but you can also use a path relative to the Movable Type directory. Example: /home/melody/public_html/blog' => 'Der Pfad, in dem die Indexdateien abgelegt werden. Eine absolute (mit \'/\' beginnende) Pfadangabe wird bevorzugt, Sie können den Pfad aber auch relativ Sie zu Ihrem Movable Type-Verzeichnis angeben. Beispiel: /home/melanie/public_html/blog',
	'Unlock this blog&rsquo;s site path for editing' => 'Pfad manuell bearbeiten',
	'Note: Changing your site root requires a complete publish of your site.' => 'Hinweis: Im Anschluss an eine Änderung des Wurzelverzeichnisses muss die gesamte Site neu veröffentlicht werden.',
	'Advanced Archive Publishing' => 'Erweiterte Archivoptionen',
	'Select this option only if you need to publish your archives outside of your Site Root.' => 'Wählen Sie diese Option nur, wenn Sie Ihre Archive außerhalb des Wurzelverzeichnisses Ihres Blog veröffentlichen müssen.',
	'Publish archives outside of Site Root' => 'Archive außerhalb Wurzelverzeichnis ablegen',
	'Enter the URL of the archives section of your website. Example: http://archives.example.com/' => 'Geben Sie die Adresse der Archivsektion Ihrer Website ein, beispielsweise http://archiv.beispiel.de/',
	'Unlock this blog&rsquo;s archive url for editing' => 'Archivadresse manuell bearbeiten',
	'Warning: Changing the archive URL can result in breaking all the links in your blog.' => 'Hinweis: Eine Änderung der Archivadresse kann alle Links zu Ihrem Blog ungültig machen.',
	'Enter the path where your archive files will be published. Example: /home/melody/public_html/archives' => 'Geben Sie den lokalen Pfad zu Ihrem Archiv ein, beispielsweise /home/melanie/public_html/archiv',
	'Warning: Changing the archive path can result in breaking all the links in your blog.' => 'Warnung: Eine Änderung des Archivpfads kann sämtliche Links zu Ihrem Blog ungültig machen.',
	'Asynchronous Job Queue' => 'Asynchronous Job Queue', # Translate - New # OK
	'Use Publishing Queue' => 'Warteschlange benutzen',
	'Requires the use of a cron job to publish pages in the background.' => 'Zur Veröffentlichung im Hintergrund muss der Server Cronjobs ausführen können.',
	'Use background publishing queue for publishing static pages for this blog' => 'Für die Veröffentlichung der statischen Seiten dieses Blogs Hintergrund-Warteschleife verwenden',
	'Dynamic Publishing Options' => 'Dynamikoptionen', # Translate - New # OK
	'Enable dynamic cache' => 'Dynamischen Cache aktivieren', # Translate - Case # OK
	'Enable conditional retrieval' => 'Conditional Retrieval aktivieren',
	'Archive Options' => 'Archivierungsoptionen', # Translate - New # OK
	'File Extension' => 'Dateierweiterung', # Translate - New # OK
	'Enter the archive file extension. This can take the form of \'html\', \'shtml\', \'php\', etc. Note: Do not enter the leading period (\'.\').' => 'Geben Sie die gewünschte Erweiterung der Archivdateien an. Möglich sind \'html\', \'shtml\', \'php\' usw. Hinweis: Geben Sie nicht den führenden Punkt (\'.\') ein.',
	'Preferred Archive' => 'Bevorzugte Archive', # Translate - New # OK
	'Used for creating links to an archived entry (permalink). Select from the archive types used in this blogs archive templates.' => 'Bestimmt, mit welcher Art Archivseite Permalinks verlinkt werden. Welche Archivarten zur Verfügung stehen, hängt von den verwendeten Vorlagen ab.',
	'No archives are active' => 'Archive nicht aktiviert',
	'Module Options' => 'Moduloptionen', # Translate - New # OK
	'Enable template module caching' => 'Vorlagenmodul-Caching aktivieren', # Translate - New # OK
	'Server Side Includes' => 'Server Side Includes', # Translate - New # OK
	'None (disabled)' => 'Keine (deaktiviert)', # Translate - New # OK
	'PHP Includes' => 'PHP-Includes', # Translate - New # OK
	'Apache Server-Side Includes' => 'Apache Server-Side-Includes', # Translate - New # OK
	'Active Server Page Includes' => 'Active Server Page-Includes', # Translate - New # OK
	'Java Server Page Includes' => 'Java Server Page-Includes', # Translate - New # OK

## tmpl/cms/rebuilding.tmpl
	'Publishing...' => 'Veröffentliche...',
	'Publishing [_1]...' => 'Veröffentliche [_1]...',
	'Publishing [_1] [_2]...' => 'Veröffentliche [_1] [_2]',
	'Publishing [_1] dynamic links...' => 'Veröffentliche [_1] (dynamisch)',
	'Publishing [_1] archives...' => 'Veröffentliche [_1]...',
	'Publishing [_1] templates...' => 'Veröffentliche [_1]...',

## tmpl/cms/edit_asset.tmpl
	'Edit Asset' => 'Asset bearbeiten',
	'Your asset changes have been made.' => 'Assetänderungen gespeichert.',
	'[_1] - Modified by [_2]' => '[_1] - Bearbeitet von [_2]',
	'Appears in...' => 'Erscheint in...',
	'Published on [_1]' => 'Veröffentlicht am [_1]',
	'Show all entries' => 'Alle Einträge anzeigen',
	'Show all pages' => 'Alle Seiten anzeigen',
	'This asset has not been used.' => 'Dieses Asset wurde noch nicht verwendet.',
	'Related Assets' => 'Verwandte Assets',
	'You must specify a label for the asset.' => 'Bitte geben Sie einen Namen für das Asset an.',
	'Embed Asset' => 'Asset einbetten',
	'Save changes to this asset (s)' => 'Assetänderungen speichern (s)',

## tmpl/cms/upgrade.tmpl
	'Time to Upgrade!' => 'Zeit für ein Upgrade!',
	'Upgrade Check' => 'Upgrade-Überprüfung',
	'Do you want to proceed with the upgrade anyway?' => 'Upgrade dennoch fortsetzen?',
	'A new version of Movable Type has been installed.  We\'ll need to complete a few tasks to update your database.' => 'Es wurde eine neue Version von Movable Type installiert. Ihre Datenbank wird nun auf den aktuellen Stand gebracht.',
	'Information about this upgrade can be found <a href=\'[_1]\' target=\'_blank\'>here</a>.' => 'Informationen über dieses Upgrade finden Sie <a href=\'[_1]\' target=\'_blank\'>hier</a>.',
	'In addition, the following Movable Type components require upgrading or installation:' => 'Zusätzlich müssen folgende Movable Type-Komponenten installiert oder aktualisiert werden:',
	'The following Movable Type components require upgrading or installation:' => 'Die folgenden Movable Type-Komponenten müssen installiert oder aktualisiert werden:',
	'Begin Upgrade' => 'Upgrade durchführen',
	'Congratulations, you have successfully upgraded to Movable Type [_1].' => 'Herzlichen Glückwunsch, Sie haben Ihre Installation erfolgreich auf Movable Type [_1] aktualisiert!',
	'Your Movable Type installation is already up to date.' => 'Ihre Movable Type-Installation ist bereits auf dem neuesten Stand.',

## tmpl/cms/edit_blog.tmpl
	'Your blog configuration has been saved.' => 'Ihre Blog-Konfiguration wurde gespeichert.',
	'You must set your Blog Name.' => 'Bitte geben Sie einen Blognamen an',
	'You did not select a timezone.' => 'Bitte wählen Sie einen Zeitzone',
	'You must set your Site URL.' => 'Bitte wählen Sie einen Webadresse (URL)',
	'Your Site URL is not valid.' => 'Die gewählte Webadresse (URL) ist ungültig.',
	'You can not have spaces in your Site URL.' => 'Die Adresse (URL) darf keine Leerzeichen enthalten.',
	'You can not have spaces in your Local Site Path.' => 'Der lokale Pfad darf keine Leerzeichen enthalten.',
	'Your Local Site Path is not valid.' => 'Das gewählte lokale Verzeichnis ist ungültig.',
	'Blog Details' => 'Blog-Details',
	'Name your blog. The blog name can be changed at any time.' => 'Geben Sie Ihrem Blog einen Namen. Der Name kann jederzeit geändert werden.',
	'Enter the URL of your public website. Do not include a filename (i.e. exclude index.html). Example: http://www.example.com/weblog/' => 'Geben Sie die Webadresse Ihrer Site ein. Geben Sie die Adresse ohne Dateinamen ein beispielsweise so: http://www.beispiel.de/weblog/',
	'Enter the path where your main index file will be located. An absolute path (starting with \'/\') is preferred, but you can also use a path relative to the Movable Type directory. Example: /home/melody/public_html/weblog' => 'Der Pfad, in dem Startseite Ihres Blog abgelegt werden soll. Eine absolute (mit \'/\' beginnende) Pfadangabe wird bevorzugt, Sie können den Pfad aber auch relativ Sie zu Ihrem Movable Type-Verzeichnis angeben. Beispiel: /home/melanie/public_html/blog',
	'Create Blog (s)' => 'Blog anlegen (s)',

## tmpl/cms/pinging.tmpl
	'Trackback' => 'TrackBack',
	'Pinging sites...' => 'Sende Pings...',

## tmpl/cms/cfg_prefs.tmpl
	'Blog Settings' => 'Blog',
	'Enter a description for your blog.' => 'Geben Sie eine Beschreibung Ihres Blogs ein.',
	'License' => 'Lizenz',
	'Your blog is currently licensed under:' => 'Ihr Blog ist derzeit lizenziert unter:',
	'Change license' => 'Lizenz ändern',
	'Remove license' => 'Lizenz entfernen',
	'Your blog does not have an explicit Creative Commons license.' => 'Für dieses Blog liegt keine Creative Commons-Lizenz vor.',
	'Select a license' => 'Creative Commons-Lizenz wählen',

## tmpl/cms/list_association.tmpl
	'permission' => 'Berechtigung',
	'permissions' => 'Berechtigungen',
	'Remove selected permissions (x)' => 'Gewählte Berechtigungen entziehen (x)',
	'Revoke Permission' => 'Berechtigung entziehen',
	'[_1] <em>[_2]</em> is currently disabled.' => '[_1] <em>[_2]</em> ist derzeit deaktiviert.',
	'Grant Permission' => 'Berechtigungen vergeben',
	'You can not create permissions for disabled users.' => 'Deaktivierten Benutzern können keine Berechtigungen zugewiesen werden.',
	'Assign Role to User' => 'Rolle an Benutzer zuweisen',
	'Grant permission to a user' => 'Berechtigung an Benutzer vergeben',
	'You have successfully revoked the given permission(s).' => 'Berechtigungen erfolgreich entzogen',
	'You have successfully granted the given permission(s).' => 'Berechtigungen erfolgreich vergeben',
	'No permissions could be found.' => 'Keine Berechtigungen gefunden.',

## tmpl/cms/preview_entry.tmpl
	'Preview [_1]' => 'Vorschau auf [_1]',
	'Re-Edit this [_1]' => '[_1] erneut bearbeiten',
	'Re-Edit this [_1] (e)' => '[_1] erneut bearbeiten (e)',
	'Save this [_1]' => '[_1] speichern',
	'Save this [_1] (s)' => '[_1] speihern (s)',
	'Cancel (c)' => 'Abbrechen (c)',

## tmpl/cms/list_folder.tmpl
	'Manage Folders' => 'Ordner verwalten',
	'Your folder changes and additions have been made.' => 'Ordneränderungen gespeichert.',
	'You have successfully deleted the selected folder.' => 'Gewählte Ordner erfolgreich gelöscht.',
	'Delete selected folders (x)' => 'Gewählte Ordner löschen (x)',
	'Create top level folder' => 'Neuen Hauptordner anlegen',
	'New Parent [_1]' => 'Neuen Haupt[_1]',
	'Create Folder' => 'Ordner anlegen',
	'Top Level' => 'Hauptebene',
	'Create Subfolder' => 'Unterordner anlegen',
	'Move Folder' => 'Ordner verschieben',
	'Move' => 'Verschieben',
	'[quant,_1,page,pages]' => '[quant,_1,Seite,Seiten]',
	'No folders could be found.' => 'Keine Ordner gefunden.',

## tmpl/cms/cfg_entry.tmpl
	'Entry Settings' => 'Eintragsanezeige',
	'Display Settings' => 'Anzeige-Einstellungen',
	'Entry Listing Default' => 'Anzahl',
	'Select the number of days of entries or the exact number of entries you would like displayed on your blog.' => 'Geben Sie entweder die größte Zahl Einträge an, die auf der Startseite höchstens angezeigt werden sollen, oder die größte Zahl Tage, aus denen dort Einträge erscheinen sollen.',
	'Days' => 'Tage',
	'Entry Order' => 'Rreihenfolge',
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
	'Basename Length' => 'Basisnamenlänge',
	'Specifies the default length of an auto-generated basename. The range for this setting is 15 to 250.' => 'Setzt den Wert für den automatisch generierten Basisname des Eintrags. Mögliche Länge: 15 bis 250.',
	'New Entry Defaults' => 'Standardwerte',
	'Specifies the default Entry Status when creating a new entry.' => 'Gibt an, welcher Eintragsstatus neue Einträge standardmäßig zugewiesen werden soll.',
	'Specifies the default Text Formatting option when creating a new entry.' => 'Gibt an, welche Textformatierungsoption standardmäßig beim Erstellen eines neuen Eintrags verwendet werden soll',
	'Specifies the default Accept Comments setting when creating a new entry.' => 'Legt fest, ob bei neuen Einträgen Kommentare standardmässig zugelassen werden.',
	'Note: This option is currently ignored since comments are disabled either blog or system-wide.' => 'Hinweis: Diese Einstellung zeigt momentan keine Wirkung, da Kommentare blog- oder systemweit deaktiviert sind.',
	'Specifies the default Accept TrackBacks setting when creating a new entry.' => 'Legt fest, ob bei neuen Einträgen TrackBack standardmässig zugelassen werden.',
	'Note: This option is currently ignored since TrackBacks are disabled either blog or system-wide.' => 'Hinweis: Diese Einstellungen zeigen momentan keine Wirkung, da TrackBacks blog- oder systemweit deaktiviert sind.',
	'Replace Word Chars' => 'Word-Zeichen ersetzen',
	'Smart Replace' => 'Smart Replace',
	'Replace UTF-8 characters frequently used by word processors with their more common web equivalents.' => 'Mit dieser Option können von Textverarbeitungen erzeugte UTF-8-Sonderzeichen automatisch durch gebräuchlichere Äquivalente ersetzt werden.',
	'No substitution' => 'Keine Zeichen ersetzen',
	'Character entities (&amp#8221;, &amp#8220;, etc.)' => 'Entitäten (&amp#8221;, &amp#8220; usw.)',
	'ASCII equivalents (&quot;, \', ..., -, --)' => 'ASCII-Äquivalente  (&quot;, \', ..., -, --)',
	'Replace Fields' => 'Felder ersetzen',
	'Extended entry' => 'Erweiterter Eintrag',
	'Default Editor Fields' => 'Standard-Eingabefelder',
	'Editor Fields' => 'Eingabefelder',
	'_USAGE_ENTRYPREFS' => 'Wählen Sie aus, welche Formularfelder in der Eingabemaske angezeigt werden sollen.',
	'Action Bars' => 'Menüleisten',
	'Select the location of the entry editor&rsquo;s action bar.' => 'Gewünschte Position der Menüleiste',

## tmpl/cms/login.tmpl
	'Your Movable Type session has ended.' => 'Ihre Movable Type-Sitzung ist abgelaufen oder Sie haben sich abgemeldet.',
	'Your Movable Type session has ended. If you wish to sign in again, you can do so below.' => 'Ihre Movable Type-Sitzung ist abgelaufen. Unten können Sie sich erneut anmelden.',
	'Your Movable Type session has ended. Please sign in again to continue this action.' => 'Ihre Movable Type-Sitzung ist abgelaufen. Bitte melden Sie sich erneut an, um den Vorgang fortzusetzen.',
	'Forgot your password?' => 'Passwort vergessen?',
	'Sign In (s)' => 'Anmelden (s)',

## tmpl/cms/cfg_system_users.tmpl
	'System: User Settings' => 'System: Benutzereinstellungen',
	'(No blog selected)' => '(Kein Blog gewählt)',
	'You must set a valid Default Site URL.' => 'Standard-Site URL erforderlich.',
	'You must set a valid Default Site Root.' => 'Standard-Site Root erforderlich.',
	'(None selected)' => '(Kein Blog gewählt)',
	'User Registration' => 'Benutzerregistrierung',
	'Allow Registration' => 'Registrierung erlauben',
	'Select a system administrator you wish to notify when commenters successfully registered themselves.' => 'Bestimmen Sie, welcher Systemadministrator benachrichtigt werden soll, wenn ein Kommentarautor sich erfolgreich selbst registriert hat.',
	'Allow commenters to register to Movable Type' => 'Falls aktiv, können sich Benutzer bei dieser Movable Type-Installation als Kommentarautor selbst registrieren',
	'Notify the following administrators upon registration:' => 'Bei Registrierungen folgende Administratoren benachrichtigen:',
	'Select Administrators' => 'Administratoren wählen',
	'Clear' => 'zurücksetzen',
	'Note: System Email Address is not set. Emails will not be sent.' => 'Hinweis: System-E-Mail-Adresse nicht konfiguriert. E-Mails können daher nicht verschickt werden.',
	'New User Defaults' => 'Voreinstellungen für neue Benutzer',
	'Personal blog' => 'Persönliches Blog',
	'Check to have the system automatically create a new personal blog when a user is created in the system. The user will be granted a blog administrator role on the blog.' => 'Wenn diese Option aktiv ist, wird für jeden neu angelegten Benutzer automatisch ein persönliches Weblog angelegt. Der Benutzer wird für dieses Blog als Blog-Administrator eingetragen.',
	'Automatically create a new blog for each new user' => 'Für neue Benutzer automatisch eigenes Blog anlegen',
	'Personal blog clone source' => 'Klonvorlage für persönliche Blogs',
	'Select a blog you wish to use as the source for new personal blogs. The new blog will be identical to the source except for the name, publishing paths and permissions.' => 'Wählen Sie, welches Blog Vorlage für persönliche Blogs sein soll. Neue Blogs sind mit den Ausnahmen Name, Pfade und Berechtigungen mit der Vorlage identisch.',
	'Default Site URL' => 'Standard- Webadresse (URL)',
	'Define the default site URL for new blogs. This URL will be appended with a unique identifier for the blog.' => 'Wählen Sie die Standard-URL für neue Weblogs. Dieser URL wird ein individueller Bezeichner für jedes Weblog angehängt.',
	'Default Site Root' => 'Standard- Wurzelverzeichnis',
	'Define the default site root for new blogs. This path will be appended with a unique identifier for the blog.' => 'Wählen Sie das Standard-Wurzelverzeichnis für neue Weblogs. Dem Pfad wird ein individueller Bezeichner für jedes Weblog angehängt.',
	'Default User Language' => 'Standard-Sprache',
	'Define the default language to apply to all new users.' => 'Wählen Sie die Standard-Sprache aller neuer Benutzerkonten ',
	'Default Timezone' => 'Standard-Zeitzone',
	'Default Tag Delimiter' => 'Standard- Tag-Trennzeichen',
	'Define the default delimiter for entering tags.' => 'Wählen Sie das Standard-Trennzeichen für die Eingabe von Tags',

## tmpl/cms/list_category.tmpl
	'Your category changes and additions have been made.' => 'Kategorieänderungen gespeichert.',
	'You have successfully deleted the selected category.' => 'Gewählte Kategorie erfolgreich gelöscht.',
	'categories' => 'Kategorien',
	'Delete selected category (x)' => 'Gewählte Kategorie löschen (x)',
	'Create top level category' => 'Hauptkategorie anlegen',
	'Create Category' => 'Kategorie anlegen',
	'Collapse' => 'Einklappen',
	'Expand' => 'Ausklappen',
	'Create Subcategory' => 'Unterkategorie anlegen',
	'Move Category' => 'Kategorie verschieben',
	'[quant,_1,TrackBack,TrackBacks]' => '[quant,_1,TrackBack,TrackBacks]',
	'No categories could be found.' => 'Keine Kategorien gefunden.',

## tmpl/cms/recover_password_result.tmpl
	'Recover Passwords' => 'Passwörter wiederherstellen',
	'No users were selected to process.' => 'Keine Benutzer zur Bearbeitung ausgewählt.',
	'Return' => 'Zurück',

## tmpl/cms/cfg_registration.tmpl
	'Registration Settings' => 'Registrierungs-Einstellungen',
	'Allow registration for Movable Type.' => 'Registrierungen bei Movable Type erlauben',
	'Registration Not Enabled' => 'Registierungen nicht erlauben',
	'Note: Registration is currently disabled at the system level.' => 'Hinweis: Registrierung derzeit systemweit deaktiviert.',
	'Authentication Methods' => 'Authentifizierungs- methoden',
	'Note: You have selected to accept comments from authenticated commenters only but authentication is not enabled. In order to receive authenticated comments, you must enable authentication.' => 'Hinweis: Sie möchten Kommentare nur von authentifizierten Kommentarautoren zulassen. Allerdings haben Sie die Authentifizierung nicht aktiviert.',
	'Native' => 'nativ',
	'Require E-mail Address for Comments via TypeKey' => 'E-Mail-Adresse für Kommentare via TypeKey erfordern',
	'If enabled, visitors must allow their TypeKey account to share e-mail address when commenting.' => 'Falls aktiviert, müssen Leser, die sich zum Kommentieren mit TypeKey anmelden, von TypeKey ihre E-Mail-Adresse übermitteln lassen. ',
	'Setup TypeKey' => 'TypeKey konfigurieren',
	'OpenID providers disabled' => 'OpenID-Provider deaktiviert',
	'Required module (Digest::SHA1) for OpenID commenter authentication is missing.' => 'Für OpenID-Authentifizierung von Kommentarautoren erforderliches Modul (Digest::SHA1) nicht vorhanden.',

## tmpl/cms/import_others.tmpl
	'Start title HTML (optional)' => 'HTML-Code am Überschriftenanfang (optional)',
	'End title HTML (optional)' => 'HTML-Code am Überschriftenende (optional)',
	'If the software you are importing from does not have title field, you can use this setting to identify a title inside the body of the entry.' => 'Wenn Sie aus einem Weblog-System importieren, das kein eigenes Feld für Überschriften hat, können Sie hier angeben, welche HTML-Ausdrücke den Anfang und das Ende von Überschriften markieren.',
	'Default entry status (optional)' => 'Standard-Eintragsstatus (optional)',
	'If the software you are importing from does not specify an entry status in its export file, you can set this as the status to use when importing entries.' => 'Wenn Sie aus einem Weblog-System importieren, das in seiner Exportdatei den Eintragsstatus nicht vermerkt, können Sie hier angeben, welcher Status den importierten Einträgen zugewiesen werden soll.',
	'Select an entry status' => 'Eintragsstatus wählen',

## tmpl/cms/search_replace.tmpl
	'You must select one or more item to replace.' => 'Wählen Sie mindestens ein Element aus, das ersetzt werden soll.',
	'Search Again' => 'Erneut suchen',
	'Submit search (s)' => 'Suchen (s)',
	'Replace' => 'Ersetzen',
	'Replace Checked' => 'Gewählte ersetzen',
	'Case Sensitive' => 'Groß/Kleinschreibung beachten',
	'Regex Match' => 'Reguläre Ausdrücke verwenden',
	'Limited Fields' => 'Felder eingrenzen',
	'Date Range' => 'Zeitraum eingrenzen',
	'Reported as Spam?' => 'Als Spam gemeldet?',
	'Search Fields:' => 'Felder eingrenzen:',
	'_DATE_FROM' => 'Von',
	'_DATE_TO' => 'Bis',
	'Successfully replaced [quant,_1,record,records].' => '[quant,_1,Element,Elemente] erfolgreich ersetzt.',
	'Showing first [_1] results.' => 'Zeige die ersten [_1] Treffer.',
	'Show all matches' => 'Zeige alle Treffer',
	'[quant,_1,result,results] found' => '[quant,_1,Treffer,Treffer] gefunden',

## tmpl/cms/preview_strip.tmpl
	'Save this entry' => 'Eintrag speichern',
	'Re-Edit this entry' => 'Eintrag erneut bearbeiten',
	'Re-Edit this entry (e)' => 'Eintrag erneut bearbeiten (e)',
	'Save this page' => 'Seite speichern',
	'Re-Edit this page' => 'Seite erneut bearbeiten',
	'Re-Edit this page (e)' => 'Seite erneut bearbeiten (e)',
	'You are previewing the entry titled &ldquo;[_1]&rdquo;' => 'Sie sehen eine Vorschau auf den Eintrag &#8222;[_1]&#8221;', # Translate - Improved (3) # OK
	'You are previewing the page titled &ldquo;[_1]&rdquo;' => 'Sie sehen eine Vorschau auf die Seite &#8222;[_1]&#8221;', # Translate - Improved (3) # OK

## tmpl/cms/edit_ping.tmpl
	'Edit Trackback' => 'TrackBack bearbeiten',
	'The TrackBack has been approved.' => 'TrackBack wurde freigeschaltet.',
	'List &amp; Edit TrackBacks' => 'TrackBacks anzeigen &amp; bearbeiten',
	'Save changes to this TrackBack (s)' => 'TrackBack-Änderungen speichern (s)',
	'Delete this TrackBack (x)' => 'Diesen TrackBack löschen (x)',
	'Update the status of this TrackBack' => 'TrackBack-Status aktualisieren',
	'Junk' => 'Spam',
	'View all TrackBacks with this status' => 'Alle TrackBacks mit diesem Status ansehen',
	'Source Site' => 'Quelle',
	'Search for other TrackBacks from this site' => 'Weitere TrackBacks von dieser Site suchen',
	'Source Title' => 'Quellname',
	'Search for other TrackBacks with this title' => 'Weitere TrackBacks mit diesem Namen suchen',
	'Search for other TrackBacks with this status' => 'Weitere TrackBacks mit diesem Status suchen',
	'Target Entry' => 'Zieleintrag',
	'Entry no longer exists' => 'Eintrag nicht mehr vorhanden',
	'No title' => 'Kein Name',
	'View all TrackBacks on this entry' => 'Alle TrackBacks bei diesem Eintrag anzeigen',
	'Target Category' => 'Zielkategorie',
	'Category no longer exists' => 'Kategorie nicht mehr vorhanden',
	'View all TrackBacks on this category' => 'Alle TrackBacks in dieser Kategorie anzeigen',
	'View all TrackBacks created on this day' => 'Alle TrackBacks dieses Tages anzeigen',
	'View all TrackBacks from this IP address' => 'Alle TrackBacks von dieser IP-Adrese anzeigen',
	'TrackBack Text' => 'TrackBack-Text',
	'Excerpt of the TrackBack entry' => 'TrackBack-Auszug',

## tmpl/comment/error.tmpl
	'Go Back (s)' => 'Zurück (s)',

## tmpl/comment/register.tmpl
	'Create an account' => 'Konto anlegen',
	'Your email address.' => 'Ihre E-Mail-Adresse',
	'Your login name.' => 'Ihr Benutzername',
	'The name appears on your comment.' => 'Dieser Name wird unter Ihren Kommentaren angezeigt.',
	'Select a password for yourself.' => 'Eigenes Passwort',
	'This word or phrase will be required to recover the password if you forget it.' => 'Dieser Begriff oder Satz wird abgefragt, wenn Sie Ihr Passwort vergessen haben und daher ein neues Passwort anfordern möchten.',
	'The URL of your website. (Optional)' => 'URL Ihrer Website (optional)',
	'Register' => 'Registrieren',

## tmpl/comment/signup.tmpl

## tmpl/comment/login.tmpl
	'Sign in to comment' => 'Anmelden zum Kommentieren',
	'Sign in using' => 'Anmelden mit',
	'Remember me?' => 'Benutzername speichern?',
	'Not a member?&nbsp;&nbsp;<a href="[_1]">Sign Up</a>!' => 'Noch nicht registriert?&nbsp;&nbsp;<a href="[_1]">Einfach jetzt registrieren</a>!',

## tmpl/comment/profile.tmpl
	'Your Profile' => 'Ihr Profil',
	'Password recovery' => 'Passwort anfordern',
	'Return to the <a href="[_1]">original page</a>.' => 'Zurück zur <a href="[_1]">Ausgangsseite</a>.',

## tmpl/comment/signup_thanks.tmpl
	'Thanks for signing up' => 'Vielen Dank für Ihre Anmeldung',
	'Before you can leave a comment you must first complete the registration process by confirming your account. An email has been sent to [_1].' => 'Bevor Sie kommentieren können, müssen Sie noch Ihre Registrierung bestätigen. Dazu haben wir Ihnen eine E-Mail an [_1] geschickt.',
	'To complete the registration process you must first confirm your account. An email has been sent to [_1].' => 'Um die Registrierung abzuschließen, bestätigen Sie bitte Ihre Anmeldung. Dazu haben wir Ihnen eine E-Mail an [_1] geschickt.',
	'To confirm and activate your account please check your inbox and click on the link found in the email we just sent you.' => 'Um Ihre Registrierung zu bestätigen und Ihr Konto zu aktivieren, klicken Sie bitte auf den Link in dieser E-Mail.',
	'Return to the original entry.' => 'Zurück zum ursprünglichen Eintrag',
	'Return to the original page.' => 'Zurück zur ursprünglichen Seite',

## tmpl/feeds/feed_comment.tmpl
	'Unpublish' => 'Nicht mehr veröffentlichen',
	'More like this' => 'Ähnliche Einträge',
	'From this blog' => 'Aus diesem Blog',
	'On this entry' => 'Zu diesem Eintrag',
	'By commenter identity' => 'Nach Identität des Kommentarautoren',
	'By commenter name' => 'Nach Namen des Kommentarautoren',
	'By commenter email' => 'Nach E-Mail-Adresse des Kommentarautoren',
	'By commenter URL' => 'Nach Web-Adresse (URL) des Kommentarautoren',
	'On this day' => 'An diesem Tag',

## tmpl/feeds/feed_entry.tmpl
	'From this author' => 'Von diesem Autoren',

## tmpl/feeds/feed_page.tmpl

## tmpl/feeds/login.tmpl
	'Movable Type Activity Log' => 'Movable Type-Aktivitätsprotokoll',
	'This link is invalid. Please resubscribe to your activity feed.' => 'Dieser Link ist ungültig. Bitte abonnieren Sie Ihren Aktivitäts-Feed erneut.',

## tmpl/feeds/error.tmpl

## tmpl/feeds/feed_ping.tmpl
	'Source blog' => 'Quelle',
	'By source blog' => 'Nach Quelle',
	'By source title' => 'Nach Name der Quelle',
	'By source URL' => 'By URL der Quelle',

## tmpl/error.tmpl
	'Missing Configuration File' => 'Fehlende Konfigurationsdatei',
	'_ERROR_CONFIG_FILE' => 'Ihre Movable Type-Konfigurationsdatei fehlt, ist fehlerhaft oder kann nicht gelesen werden. Anweisungen zur Konfigurierung finden Sie im Abschnitt <a href="javascript:void(0)">Installation and Configuration</a> der Movable Type-Dokumentation.',
	'Database Connection Error' => 'Verbindung mit Datenbank fehlgeschlagen',
	'_ERROR_DATABASE_CONNECTION' => 'Die Datenbankeinstellungen in Ihrer Konfigurationsdatei fehlen oder sind fehlerhaft. Anweisungen zur Konfigurierung finden Sie im Abschnitt <a href="javascript:void(0)">Installation and Configuration</a> der Movable Type-Dokumentation.',
	'CGI Path Configuration Required' => 'CGI-Pfad muß eingestellt sein',
	'_ERROR_CGI_PATH' => 'Die CGIPath-Angabe in Ihrer Konfigurationsdatei fehlt oder ist fehlerhaft. Anweisungen zur Konfigurierung finden Sie im Abschnitt <a href="javascript:void(0)">Installation and Configuration</a> der Movable Type-Dokumentation.',

## addons/Community.pack/lib/MT/App/Community.pm
	'No login form template defined' => 'Keine Vorlage für das Anmeldeformular definiert',
	'Before you can sign in, you must authenticate your email address. <a href="[_1]">Click here</a> to resend the verification email.' => 'Bevor Sie sich anmelden können, bestätigen Sie bitte Ihre E-Mail-Adresse. <a href="[_1]>Bestätigungsmail erneut senden</a>.',
	'Your confirmation have expired. Please register again.' => 'Ihre Anmeldung ist abgelaufen. Bitte registrieren Sie sich erneut.',
	'User \'[_1]\' (ID:[_2]) has been successfully registered.' => 'Benutzer \'[_1]\' (ID:[_2]) erfolgreich registriert.',
	'Thanks for the confirmation.  Please sign in.' => 'Danke für die Bestätigung. Bitte melden Sie sich an.',
	'Login required' => 'Anmeldung erforderlich',
	'System template entry_response not found in blog: [_1]' => 'Systemvorlage entry_response für Blog [_1] nicht gefunden',
	'Posting a new entry failed.' => 'Veröffentlichtung eines neuen Eintrags fehlgeschlagen.',
	'New entry \'[_1]\' added to the blog \'[_2]\'' => 'Neuer Eintrag \'[_1]\' zu Blog \'[_2]\' hinzugefügt.',
	'Id or Username is required' => 'ID oder Benutzername erforderlich',
	'Unknown user' => 'Unbekannter Benutzer',
	'Cannot edit profile.' => 'Kann Profil nicht editieren',
	'Recent Entries from [_1]' => 'Aktuelle Eintrage von [_1]',
	'Responses to Comments from [_1]' => 'Reaktionen auf Kommentare von  [_1]',
	'Actions from [_1]' => 'Aktionen von [_1]',

## addons/Community.pack/lib/MT/Community/Tags.pm
	'You used an \'[_1]\' tag outside of the block of MTIfEntryRecommended; perhaps you mistakenly placed it outside of an \'MTIfEntryRecommended\' container?' => '\'[_1]\'-Befehl außerhalb eines MtIfEntryRecommended-Blocks verwendet - \'MTIfEntryRecommended\'-Block erforderlich',
	'Click here to recommend' => 'Empfehlen',
	'Click here to follow' => 'Klicken, um zu folgen', # Translate - New # OK
	'Click here to leave' => 'Klicken, um nicht mehr zu folgen', # Translate - New # OK

## addons/Community.pack/lib/MT/Community/CMS.pm
	'Users followed by [_1]' => 'Benutzer, denen [_1] folgt',
	'Users following [_1]' => 'Benutzer, die [_1] folgt',
	'Friends' => 'Freunde', # Translate - New # OK
	'Friends Of' => 'Freunde von', # Translate - New # OK
	'Welcome to the Movable Type Community Solution' => 'Willkommen zur Movable Type Community Solution',
	'The Community Solution gives you to the tools to build a successful community with active, engaged conversations. Some key features to explore:' => 'Mit der Community Solution erhalten Sie alle Werkzeuge, die zum Aufbau erfolgreicher Communities mit aktiven, engagierten Mitgliedern erforderlich sind. Zu den Schlüsselfunktionen gehören:',
	'Friends and Followers' => 'Freundesliste',
	'Allow registered members to maintain a list of friends across your community' => 'Registrierten Mitgliedern ermöglichen, den Aktivitäten ihrer Freunde in Ihrer Community zu folgen.',

## addons/Community.pack/php/function.mtentryrecommendvotelink.php

## addons/Community.pack/tmpl/widget/blog_stats_registration.mtml
	'Registrations' => 'Registrierungen',
	'Recent Registrations' => 'Aktuelle Registrierungen',
	'default userpic' => 'Standard-Benutzerbild',
	'You have [quant,_1,registration,registrations] from [_2]' => 'Sie haben [quant,_1,Registrierung,Registrierungen] von [_2]',

## addons/Community.pack/tmpl/widget/most_popular_entries.mtml
	'Most Popular Entries' => 'Beliebteste Einträge',
	'There are no popular entries.' => 'Keine beliebten Einträge.',

## addons/Community.pack/tmpl/widget/recent_submissions.mtml
	'Recent Submissions' => 'Aktuelle Beiträge',

## addons/Community.pack/tmpl/widget/recent_favorites.mtml
	'Recent Favorites' => 'Aktuelle Favoriten',
	'There are no recently favorited entries.' => 'Keine kürzlich als Favoriten gespeicherte Einträge.',

## addons/Community.pack/tmpl/cfg_community_prefs.tmpl
	'Community Settings' => 'Community',
	'Anonymous Recommendation' => 'Anonyme Empfehlungen',
	'Check to allow anonymous users (users not logged in) to recommend discussion.  IP address is recorded and used to identify each user.' => 'Anonymen (nicht angemeldeten) Benutzern erlauben, Diskussionen zu empfehlen. Die IP-Adressen nicht angemeldeter Benutzer werden gespeichert.',
	'Allow anonymous user to recommend' => 'Anonymen Benutzern erlauben Empfehlen auszusprechen',
	'Save changes to blog (s)' => 'Blog-?nderungen speichern (s)',

## addons/Community.pack/config.yaml
	'Many Friends' => 'Viele Freunde', # Translate - New # OK
	'Many Friends Of' => 'Viele Freunde von', # Translate - New # OK
	'Login Form' => 'Anmeldeformular',
	'Password Reset Form' => 'Passwortanforderungsformular',
	'Registration Form' => 'Registrierungsformular',
	'Registration Confirmation' => 'Registrierungsbestätigung',
	'Profile Error' => 'Profilfehler',
	'Profile View' => 'Profilansicht',
	'Profile Edit Form' => 'Profilbearbeitungsformular',
	'Profile Feed (Atom)' => 'Profilfeed (ATOM)',
	'Profile Feed (RSS)' => 'Profilfeed (RSS)',
	'Form Field' => 'Formularfeld',
	'Status Message' => 'Statusnachricht',
	'Simple Header' => 'Einfache Kopfzeile',
	'Simple Footer' => 'Einfache Fußzeile',
	'Navigation' => 'Navigation',
	'Header' => 'Kopf',
	'Footer' => 'Fußzeile',
	'User Navigation' => 'Benutzernavigation',
	'GlobalJavaScript' => 'GlobalJavaScript',
	'Email verification' => 'E-Mail-Bestätigung',
	'Registration notification' => 'Registrierungsbenachrichtigung',
	'New entry notification' => 'Eintragsbenachrichtigung',
	'Community Blog' => 'Community-Blog',
	'Atom' => 'ATOM',
	'RSS' => 'RSS',
	'Entry Response' => 'Eintragsantworten',
	'Displays error, pending or confirmation message when submitting an entry.' => 'Zeigt Bestätigungs-, Moderations- und Fehlermeldungen zu neuen Beiträgen an.',
	'Comment Detail' => 'Kommentardetails',
	'Entry Detail' => 'Eintragsdetails',
	'Entry Metadata' => 'Eintrags-Metadaten',
	'Sidebar - 2 Column Layout' => 'Seitenleiste - zweispaltiges Layout',
	'Sidebar - 3 Column Layout' => 'Seitenleiste - dreispaltiges Layout',
	'Page Detail' => 'Seiteninformationen',
	'Entry Form' => 'Eintragsformular',
	'Content Navigation' => 'Inhaltsnavigation',
	'Community Forum' => 'Community-Forum',
	'Entry Feed (Atom)' => 'Eintragsfeed (ATOM)',
	'Entry Feed (RSS)' => 'Eintragsfeed (RSS)',
	'Displays error, pending or confirmation message when submitting a entry.' => 'Zeigt Bestätigungs-, Moderations- und Fehlermeldungen zu neuen Beiträgen an.',
	'Category Groups' => 'Kategoriegruppen',
	'Popular Entry' => 'Beliebter Eintrag',
	'Entry Table' => 'Eintragstabelle',
	'Content Header' => 'Inhaltskopf',

## addons/Community.pack/templates/global/login_form.mtml

## addons/Community.pack/templates/global/header.mtml
	'Blog Description' => 'Blogbeschreibung',

## addons/Community.pack/templates/global/register_form.mtml
	'Sign up' => 'Registrieren',

## addons/Community.pack/templates/global/simple_footer.mtml

## addons/Community.pack/templates/global/profile_error.mtml
	'ERROR MSG HERE' => 'ERROR MSG HERE',

## addons/Community.pack/templates/global/register_confirmation.mtml
	'Authentication Email Sent' => 'Authentifizierungsmail verschickt',
	'Profile Created' => 'Profil angelegt',
	'<a href="[_1]">Return to the original page.</a>' => '<a href="[_1]">Zurück zur Ausgangsseite</a>',

## addons/Community.pack/templates/global/profile_feed_rss.mtml
	'Copyright [_1]' => 'Copyright [_1]',

## addons/Community.pack/templates/global/new_entry_email.mtml
	'A new entry \'[_1]([_2])\' has been posted on your blog [_3].' => 'In Ihrem Blog [_3] wurde ein neuer Eintrag \'[_1]([_2])\' veröffentlicht.',
	'Author name: [_1]' => 'Name des Autors: [_1]',
	'Author nickname: [_1]' => 'Nickname des Autors: [_1]',
	'Title: [_1]' => 'Titel: [_1]',
	'Edit entry:' => 'Eintrag bearbeiten:',

## addons/Community.pack/templates/global/password_reset_form.mtml
	'Reset Password' => 'Passwort zurücksetzen',
	'Back to the original page' => 'Zurück zur Ausgangsseite',

## addons/Community.pack/templates/global/profile_edit_form.mtml
	'Go <a href="[_1]">back to the previous page</a> or <a href="[_2]">view your profile</a>.' => '<a href="[_1]>Zurück zur Ausgangsseite</a> oder <a href="[_2]>Profil ansehen</a>.',
	'User Name' => 'Benutzername',
	'Upload New Userpic' => 'Neues Benutzerbild hochladen',

## addons/Community.pack/templates/global/profile_view.mtml
	'User Profile' => 'Benutzerprofil',
	'Recent Actions from [_1]' => 'Aktuelle Aktionen von [_1]',
	'You are following [_1].' => 'Sie folgen [_1]',
	'Unfollow' => 'Nicht mehr folgen',
	'Follow' => 'Folgen',
	'You are followed by [_1].' => '[_1] folgt Ihnen.',
	'You are not followed by [_1].' => '[_1] folgt Ihnen nicht.',
	'Website:' => 'Website:',
	'Recent Actions' => 'Aktuelle Aktionen',
	'Comment Threads' => 'Kommentar-Threads',
	'Posted [_1] to [_2]' => '[_1] in [_2] veröffentlicht',
	'Commented on [_1]' => '[_1] kommentiert',
	'Favorited [_1] on [_2]' => '[_1] in [_2] zum Favoriten gemacht',
	'No recent actions.' => 'Keine aktuellen Aktionen',
	'[_1] commented on ' => '[_1] kommentierte',
	'No responses to comments.' => 'Keine Kommentarantworten',
	'Following' => 'Benutzer, denen Sie folgen',
	'Not following anyone' => 'Sie folgen niemandem',
	'Followers' => 'Benutzer, die Ihnen folgen',
	'Not being followed' => 'Niemand folgt Ihnen',

## addons/Community.pack/templates/global/user_navigation.mtml
	'Logged in as <a href="[_1]">[_2]</a>' => 'Als <a href="[_1]">[_2]</a> angemeldet',
	'Sign out' => 'Abmelden',
	'Not a member? <a href="[_1]">Register</a>' => 'Noch kein Mitglied? <a href="[_1]>Registieren</a>',

## addons/Community.pack/templates/global/footer.mtml

## addons/Community.pack/templates/global/navigation.mtml
	'Home' => 'Startseite',

## addons/Community.pack/templates/global/login_form_module.mtml
	'Hello [_1]' => 'Hallo [_1]',
	'Forgot Password' => 'Passwort vergessen',

## addons/Community.pack/templates/global/search.mtml

## addons/Community.pack/templates/global/register_notification_email.mtml

## addons/Community.pack/templates/global/email_verification_email.mtml
	'Thank you registering for an account to [_1].' => 'Danke, daß Sie sich ein [_1]-Konto angelegt haben.',
	'For your own security and to prevent fraud, we ask that you please confirm your account and email address before continuing. Once confirmed you will immediately be allowed to sign in to [_1].' => 'Zur Ihren eigenen Sicherheit und um Mißbrauch vorzubeugen bestätigen Sie nun bitte Ihre Angaben. Daraufhin können Sie sich sofort bei [_1] anmelden.',
	'If you did not make this request, or you don\'t want to register for an account to [_1], then no further action is required.' => 'Sollten Sie sich nicht angemeldet haben oder sollten Sie sich doch nicht registrieren wollen, brauchen Sie nichts weiter zu tun.',

## addons/Community.pack/templates/blog/page.mtml

## addons/Community.pack/templates/blog/rss.mtml

## addons/Community.pack/templates/blog/comment_response.mtml
	'Comment Submitted' => 'Kommentar abgeschickt',

## addons/Community.pack/templates/blog/archive_index.mtml

## addons/Community.pack/templates/blog/trackbacks.mtml
	'[_1] TrackBacks' => '[_1] TrackBacks',
	'Listed below are links to blogs that reference this entry: <a href="[_1]">[_2]</a>.' => 'Folgende Einträge anderer Blogs beziehen sich auf den Eintrag <a href="[_1]">[_2]</a>',
	'TrackBack URL for this entry: <span id="trackbacks-link">[_1]</span>' => 'TrackBack-URL dieses Eintrags: <span id="trackbacks-link">[_1]</span>',
	'&raquo; <a href="[_1]">[_2]</a> from [_3]' => '&raquo; <a href="[_1]">[_2]</a> von [_3]',
	'Tracked on <a href="[_1]">[_2]</a>' => 'Gesehen auf <a href="[_1]">[_2]</a>',

## addons/Community.pack/templates/blog/main_index.mtml

## addons/Community.pack/templates/blog/content_nav.mtml
	'Blog Home' => 'Startseite',

## addons/Community.pack/templates/blog/entry_summary.mtml
	'A favorite' => 'Ein Favorit',
	'Favorite' => 'Favorit',
	'Continue reading <a rel="bookmark" href="[_1]">[_2]</a>.' => '<a rel="bookmark" href="[_1]">[_2]</a> weiterlesen',

## addons/Community.pack/templates/blog/tags.mtml

## addons/Community.pack/templates/blog/entry_response.mtml
	'Thank you for posting an entry.' => 'Danke, daß Sie einen Eintrag geschrieben haben.',
	'Entry Pending' => 'Eintrag noch nicht freigegeben',
	'Your entry has been received and held for approval by the blog owner.' => 'Ihr Eintrag ist eingegangen und muss nun vom Blogbetreiber freigeschaltet werden.',
	'Entry Posted' => 'Eintrag veröffentlicht',
	'Your entry has been posted.' => 'Ihr Eintrag wurde veröffentlicht.',
	'Your entry has been received.' => 'Ihr Eintrag ist eingegangen.',
	'Return to the <a href="[_1]">blog\'s main index</a>.' => 'Zurück zur <a href="[_1]">Startseite</a>.',

## addons/Community.pack/templates/blog/entry_detail.mtml

## addons/Community.pack/templates/blog/entry_create.mtml

## addons/Community.pack/templates/blog/entry_form.mtml
	'You don\'t have permission to post.' => 'Sie haben nicht genügend Benutzerrechte um zu veröffentlichen.',
	'<a href="[_1]">Sign in</a> to create an entry.' => '<a href="[_1]">Anmelden</a> um einen Eintrag zu schreiben.',
	'Select Category...' => 'Kategorie wählen...',

## addons/Community.pack/templates/blog/comment_detail.mtml

## addons/Community.pack/templates/blog/comments.mtml
	'[_1] Comments' => '[_1] Kommentare',

## addons/Community.pack/templates/blog/comment_form.mtml

## addons/Community.pack/templates/blog/categories.mtml

## addons/Community.pack/templates/blog/search_results.mtml
	'Results matching &ldquo;[_1]&rdquo; from [_2]' => 'Suchergebnisse für &#8222;[_1]&#8221; aus [_2]', # Translate - Improved (3) # OK
	'Results tagged &ldquo;[_1]&rdquo; from [_2]' => 'Mit &#8222;[_1]&#8221; getaggte auf [_2]:', # Translate - Improved (3) # OK

## addons/Community.pack/templates/blog/sidebar_2col.mtml
	'Photos' => 'Fotos',
	'Subscribe icon' => 'Abonnieren-Icon',
	'Search results matching &ldquo;<$MTSearchString$>&rdquo;' => 'Suchergebnisse für &#8222;<$MTSearchString$>&#8221;', # Translate - Improved (3) # OK

## addons/Community.pack/templates/blog/sidebar_3col.mtml

## addons/Community.pack/templates/blog/entry_listing.mtml
	'Recently by <em>[_1]</em>' => 'Neues von <em>[_1]</em>',

## addons/Community.pack/templates/blog/dynamic_error.mtml

## addons/Community.pack/templates/blog/entry_metadata.mtml

## addons/Community.pack/templates/blog/entry.mtml

## addons/Community.pack/templates/blog/comment_preview.mtml
	'Comment on [_1]' => 'Kommentar zu [_1]',

## addons/Community.pack/templates/blog/javascript.mtml
	'Thanks for signing in,' => 'Danke für Ihre Anmeldung, ',
	'. Now you can comment.' => '. Sie können jetzt Ihren Kommentar verfassen.',
	'You do not have permission to comment on this blog.' => 'Sie haben nicht die notwendige Berechtigung, um in diesem Blog Kommentare zu schreiben.',
	' to comment on this entry.' => ' um diesen Eintrag zu kommentieren.',
	' to comment on this entry,' => ' um diesen Eintrag zu kommentieren,',
	'or ' => 'oder ',
	'comment anonymously.' => 'ohne Anmeldung kommentieren',

## addons/Community.pack/templates/forum/entry_summary.mtml

## addons/Community.pack/templates/forum/main_index.mtml
	'Forum Home' => 'Startseite',

## addons/Community.pack/templates/forum/page.mtml

## addons/Community.pack/templates/forum/entry_response.mtml
	'Thank you for posting a new topic to the forums.' => 'Danke, daß Sie ein neues Thema eröffnet haben!',
	'Topic Pending' => 'Thema noch nicht freigegeben',
	'The topic you posted has been received and held for approval by the forum administrators.' => 'Ihr Thema  ist eingegangen und muss nun vom Forenadministrator freigeschaltet werden.',
	'Topic Posted' => 'Thema veröffentlicht',
	'The topic you posted has been received and published. Thank you for your submission.' => 'Ihr Thema ist eingegangen und wurde veröffentlicht. Vielen Dank!',
	'Return to the <a href="[_1]">forum\'s homepage</a>.' => 'Zurück zur <a href="[_1]">Startseite</a> des Forums.',

## addons/Community.pack/templates/forum/content_nav.mtml
	'Start Topic' => 'Thema eröffnen',

## addons/Community.pack/templates/forum/sidebar.mtml
	'All Forums' => 'Alle Foren',
	'[_1] Forum' => '[_1]-Forum',

## addons/Community.pack/templates/forum/rss.mtml

## addons/Community.pack/templates/forum/comment_response.mtml
	'Reply Submitted' => 'Antwort eingegangen',
	'Your reply has been accepted' => 'Ihre Antwort ist eingegangen.',
	'Thank you for your reply. It has been accepted and should appear momentarily.' => 'Vielen Dank für Ihre Antwort. Sie erscheint sofort ohne weitere Moderation.',
	'Reply Pending' => 'Moderation',
	'Your reply has been received' => 'Ihre Antwort ist eingegangen.',
	'Thank you for your reply. However, your reply is currently being held for approval by the forum\'s administrator.' => 'Vielen Dank für Ihre Antwort. Sie muss noch vom Forenadministrator freigeschaltet werden.',
	'Reply Submission Error' => 'Es ist ein Fehler aufgetreten',
	'Your reply submission failed for the following reasons:' => 'Die Einsendung Ihrer Antwort schlug aus folgendem Grund fehl:',
	'Return to the <a href="[_1]">original topic</a>.' => 'Zurück zum <a href="[_1]">Ausgangsthema</a>.',

## addons/Community.pack/templates/forum/content_header.mtml

## addons/Community.pack/templates/forum/entry_detail.mtml

## addons/Community.pack/templates/forum/entry_form.mtml
	'<a href="[_1]">Sign in</a> to create a topic.' => '<a href="[_1]">Anmelden</a> um ein Thema zu eröffnen',
	'Topic' => 'Thema',
	'Select Forum...' => 'Forum wählen...',
	'Forum' => 'Forum',

## addons/Community.pack/templates/forum/comment_detail.mtml

## addons/Community.pack/templates/forum/entry_create.mtml
	'Start a Topic' => 'Neues Thema eröffnen',

## addons/Community.pack/templates/forum/comment_form.mtml

## addons/Community.pack/templates/forum/entry_listing.mtml

## addons/Community.pack/templates/forum/entry_metadata.mtml
	'Permalink' => 'Permalink',
	'Replies ([_1])' => 'Antworten ([_1])',

## addons/Community.pack/templates/forum/entry.mtml

## addons/Community.pack/templates/forum/javascript.mtml
	'. Now you can reply to this topic.' => '. Sie können nun Ihre Antwort schreiben.',
	' to comment on this topic.' => 'um dieses Thema zu kommentieren.',
	' to comment on this topic,' => 'um dieses Thema zu kommentieren,',

## addons/Community.pack/templates/forum/archive_index.mtml

## addons/Community.pack/templates/forum/entry_table.mtml
	'Recent Topics' => 'Aktuelle Themen',
	'Replies' => 'Antworten',
	'Last Reply' => 'Letzte Antwort',
	'Permalink to this Reply' => 'Peramanenter Link zu dieser Antwort',
	'Closed' => 'Geschlossen',
	'Post the first topic in this forum.' => 'Eröffnen Sie das erste Thema in diesem Forum',

## addons/Community.pack/templates/forum/category_groups.mtml
	'Forum Groups' => 'Forengruppen',
	'Last Topic: [_1] by [_2] on [_3]' => 'Letztes Thema: [_1] von [_2] um [_3]',

## addons/Community.pack/templates/forum/comments.mtml
	'[_1] Replies' => '[_1] Antworten',
	'_NUM_FAVORITES' => 'Favorit',
	'Favorite This' => 'Zum Favoriten machen',

## addons/Community.pack/templates/forum/search_results.mtml

## addons/Community.pack/templates/forum/dynamic_error.mtml

## addons/Community.pack/templates/forum/entry_popular.mtml
	'Popular topics' => 'Beliebte Themen',
	'No Reply' => 'Keine Antworten',

## addons/Community.pack/templates/forum/comment_preview.mtml
	'Reply on [_1]' => 'Auf [_1] antworten',
	'Previewing your Reply' => 'Vorschau Ihrer Antwort',

## addons/Commercial.pack/lib/MT/Commercial/Util.pm
	'About' => 'Über',
	'_UTS_REPLACE_THIS' => '<p><strong>Ersetzen Sie diesen Text durch Ihre eigenen Informationen.</strong></p>',
	'_UTS_SAMPLE_ABOUT' => '
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In nec tellus sed turpis varius sagittis. Nullam pulvinar. Fusce dapibus neque pellentesque nulla. Maecenas condimentum quam. Vestibulum pretium fringilla quam. Nam elementum. Suspendisse odio magna, aliquam vitae, vulputate et, dignissim at, pede. Integer pellentesque orci at nibh. Morbi ante.</p>

<p>Maecenas convallis mattis justo. Ut mauris sapien, consequat a, bibendum vitae, sagittis ac, nisi. Nulla et sapien. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Ut condimentum turpis ut elit. Quisque ultricies sollicitudin justo. Duis vitae magna nec risus pulvinar ultricies.</p>
',
	'_UTS_EDIT_LINK' => '
<!-- Entfernen Sie diesen Link nach der Bearbeitung -->
<p class="admin-edit-link">
<script type="text/javascript">document.write(\'<a href="\' + adminurl + \'?__mode=view&_type=page&id=\' + page_id + \'&blog_id=\' + blog_id + \'" target="_blank">Diesen Text anpassen</a>\')</script>
</p>
',
	'_UTS_CONTACT' => 'Kontakt',
	'_UTS_SAMPLE_CONTACT' => '
<p>Wir freuen uns darauf, von Ihnen zu hören. Senden Sie Ihre E-Mail an email (at) domainname.de</p>
',
	'Welcome to our new website!' => 'Willkommen auf unserer neuen Website!',
	'_UTS_SAMPLE_WELCOME' => '
<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In nec tellus sed turpis varius sagittis. Nullam pulvinar. Fusce dapibus neque pellentesque nulla. Maecenas condimentum quam. Aliquam erat volutpat. Ut placerat porta nibh. Donec vitae nulla. Pellentesque nisi leo, pretium a, gravida quis, sollicitudin non, eros. Vestibulum pretium fringilla quam. Nam elementum. Suspendisse odio magna, aliquam vitae, vulputate et, dignissim at, pede. Integer pellentesque orci at nibh. Morbi ante.</p>

<p>Maecenas convallis mattis justo. Ut mauris sapien, consequat a, bibendum vitae, sagittis ac, nisi. Nulla et sapien. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Ut condimentum turpis ut elit. Quisque ultricies sollicitudin justo. Duis vitae magna nec risus pulvinar ultricies. Aliquam sagittis volutpat metus.</p>

<p>Sed enim. Integer hendrerit, arcu ac pretium nonummy, velit turpis faucibus risus, pulvinar egestas enim elit sed ante. Curabitur orci diam, placerat a, faucibus id, condimentum vitae, magna. Etiam enim massa, convallis quis, rutrum vitae, porta quis, turpis.</p>
',
	'New design launched using Movable Type' => 'Neue Website auf Basis von Movable Type',
	'_UTS_SAMPLE_NEWDESIGN' => ' 
<p>Unsere Website hat ein neues Aussehen - dank <a href="http://www.movabletype.com/">Movable Type</a> und der Universellen Vorlagengruppe. Mit der Universellen Vorlagengruppe kann so gut wie jeder eine neue Website mit Movable Type anlegen. Neue Vorlagengruppe anlegen, "Universelle Vorlagengruppe" auswählen, "Veröffentlichen" klicken - fertig! So einfach war es noch nie. Danke, Movable Type!</p>
',

## addons/Commercial.pack/lib/CustomFields/App/CMS.pm
	'Show' => 'Zeige',
	'Date & Time' => 'Datum- und Uhrzeit',
	'Date Only' => 'Nur Datum',
	'Time Only' => 'Nur Uhrzeit',
	'Please enter all allowable options for this field as a comma delimited list' => 'Bitte geben Sie alle für dieses Feld zulässigen Optionen als kommagetrennte Liste ein.',
	'Custom Fields' => 'Eigene Felder',
	'[_1] Fields' => '[_1]-Felder',
	'Edit Field' => 'Feld bearbeiten',
	'Invalid date \'[_1]\'; dates must be in the format YYYY-MM-DD HH:MM:SS.' => 'Ungültige Datumsangabe \'[_1]\' - Datumsangaben müssen das Format JJJJ-MM-TT HH:MM:SS haben.',
	'Invalid date \'[_1]\'; dates should be real dates.' => 'Ungültige Datumsangabe \'[_1]\' - Datumsangaben sollten tatsächliche Daten sein',
	'Please enter valid URL for the URL field: [_1]' => 'Bitte geben Sie eine gültige Web-Adresse in das Feld [_1] ein.',
	'Please enter some value for required \'[_1]\' field.' => 'Bitte füllen Sie das erforderliche Feld \'[_1]\' aus.',
	'Please ensure all required fields have been filled in.' => 'Bitte füllen Sie alle erforderlichen Felder aus.',
	'The template tag \'[_1]\' is an invalid tag name.' => '\'[_1]\' ist ein ungültiger Befehlsname.',
	'The template tag \'[_1]\' is already in use.' => 'Vorlagenbefehl \'[_1]\' bereits vorhanden',
	'The basename \'[_1]\' is already in use.' => 'Basisname \'[_1]\' bereits vorhanden',
	'Default value must be valid URL.' => 'Der Standardwert muss eine gültige Web-Adresse sein.',
	'Customize the forms and fields for entries, pages, folders, categories, and users, storing exactly the information you need.' => 'Speichern Sie genau die Informationen, die Sie möchten, indem Sie die Formulare und Felder von Einträgen, Seiten, Ordnern, Kategorien und Benutzerkonten frei anpassen.',
	' ' => ' ', # Translate - New # OK
	'Single-Line Text' => 'Einzeiliger Text',
	'Multi-Line Text' => 'Mehrzeiliger Text', # Translate - New # OK
	'Checkbox' => 'Auswahlkästchen',
	'Date and Time' => 'Datum und Uhrzeit',
	'Drop Down Menu' => 'Drop-Down-Menü',
	'Radio Buttons' => 'Auswahlknöpfe',

## addons/Commercial.pack/lib/CustomFields/BackupRestore.pm
	'Restoring custom fields data stored in MT::PluginData...' => 'Stelle eigene Felder aus MT::PluginData wieder her...',
	'Restoring asset associations found in custom fields ( [_1] ) ...' => 'Stelle Assetverknüpfungen aus eigenen Feldern wieder her...',
	'Restoring url of the assets associated in custom fields ( [_1] )...' => 'Stelle die Adressen der in eigenen Feldern verwendeten Assets wieder her...',

## addons/Commercial.pack/lib/CustomFields/Upgrade.pm
	'Moving metadata storage for pages...' => 'Verschiebe Metadatenspeicher für Seiten...',

## addons/Commercial.pack/lib/CustomFields/Template/ContextHandlers.pm
	'Are you sure you have used a \'[_1]\' tag in the correct context? We could not find the [_2]' => 'Wird der \'[_1]\'-Befehl im richtigen Kontext verwendet? Kann [_2] nicht finden',
	'You used an \'[_1]\' tag outside of the context of the correct content; ' => '\'[_1]\'-Befehl außerhalb des passenden Kontexts verwendet.',

## addons/Commercial.pack/lib/CustomFields/Util.pm
	'Failed to find [_1]::[_2]' => 'Konnte [_1]::[_2] nicht finden',

## addons/Commercial.pack/lib/CustomFields/Field.pm
	'Field' => 'Feld',

## addons/Commercial.pack/config.yaml
	'Universal Website' => 'Universelle Website',
	'Themes that are compatible with the Universal Website template set.' => 'Mit der Universellen Vorlagengruppe kompatible Designvorlagen',
	'Blog Index' => 'Blog-Index',
	'Blog Entry Listing' => 'Blog-Eintragsverzeichnis',
	'Header' => 'Kopf',
	'Footer' => 'Fußzeile',
	'Navigation' => 'Navigation',
	'Comment Detail' => 'Kommentardetails',
	'Entry Detail' => 'Eintragsdetails',
	'Entry Metadata' => 'Eintrags-Metadaten',
	'Page Detail' => 'Seiteninformationen',
	'Powered By (Footer)' => 'Powered by (Fußzeile)',
	'Sign In (In Header)' => 'Anmelden (in Kopfzeile)',
	'Search (In Navigation)' => 'Suche (in Navigation)',
	'Recent Entries Expanded' => 'Neueste Einträge (erweitert)',
	'Footer Links' => 'Fußzeilen-Links',
	'Blog Activity' => 'Blog-Aktivität', # Translate - New # OK
	'Blog Archives' => 'Blog-Archive', # Translate - New # OK
	'Main Sidebar' => 'Haupt-Seitenspalte', # Translate - New # OK

## addons/Commercial.pack/tmpl/reorder_fields.tmpl
	'Your field order has been saved. Please refresh this page to see the new order.' => 'Felder gespeichert. Bitte laden Sie die Seite neu, um die Felder in ihrer neuen Reihenfolge angezeigt zu bekommen.',
	'Reorder Fields' => 'Felder anordnen',
	'Save field order' => 'Reihenfolge speichern',
	'Close field order widget' => 'Reihenfolgenwidget schließen',
	'open' => 'öffnen',
	'click-down and drag to move this field' => 'bei gedrückter Maustaste ziehen, um das Feld zu verschieben',
	'click to %toggle% this box' => 'klicken um das Feld an- oder abzuwählen',
	'use the arrow keys to move this box' => 'mit den Pfeiltasten verschieben',
	', or press the enter key to %toggle% it' => 'oder Enter drücken zum An- oder Abwählen',

## addons/Commercial.pack/tmpl/date-picker.tmpl
	'Select date' => 'Datum wählen',

## addons/Commercial.pack/tmpl/edit_field.tmpl
	'New Field' => 'Neues Feld',
	'The selected fields(s) has been deleted from the database.' => 'Gewählten Felder aus Datenbank gelöscht.',
	'Please ensure all required fields (highlighted) have been filled in.' => 'Bitte füllen Sie alle erforderlichen (hervorgehobenen) Felder aus.',
	'System Object' => 'Systemobjekt',
	'Select the system object this field is for' => 'Wählen Sie aus, auf welches Systemobjekt sich dieses Feld bezieht',
	'Select...' => 'Wählen...',
	'Required?' => 'Erforderlich?',
	'Should a value be chosen or entered into this field?' => 'Ist diese Option aktiv, muss das Formularfeld ausgefüllt werden.',
	'Default' => 'Standardwert',
	'You will need to first save this field in order to set a default value' => 'Um den Standardwert festlegen zu können, speichern Sie das Feld bitte vorher.',
	'_CF_BASENAME' => 'Basisname',
	'The basename is used for entering custom field data through a 3rd party client. It must be unique.' => 'Der Basisname wird für das Befüllen eigener Felder durch externe Software verwendet. Basisnamen müssen eindeutig sein.',
	'Unlock this for editing' => 'Zur Bearbeitung freischalten',
	'Warning: Changing this field\'s basename may require changes to existing templates.' => 'Hinweis: Eine Änderung des Basisnamens eines Feldes kann die Bearbeitung vorhandener Vorlagen notwendig machen.', # Translate - New # OK
	'Template Tag' => 'Vorlagenbefehl',
	'Create a custom template tag for this field.' => 'Einen eigenen Vorlagenbefehl für dieses Feld anlegen.',
	'Example Template Code' => 'Beispiel-Vorlagencode',
	'Save this field (s)' => 'Dieses Feld speichern (s)',
	'field' => 'Feld',
	'fields' => 'Felder',
	'Delete this field (x)' => 'Dieses Feld löschen (x)',

## addons/Commercial.pack/tmpl/asset-chooser.tmpl
	'Choose [_1]' => '[_1] wählen',
	'Remove [_1]' => '[_1] löschen',

## addons/Commercial.pack/tmpl/list_field.tmpl
	'New [_1] Field' => 'Neues [_1] Feld',
	'Delete selected fields (x)' => 'Gewählte Felder löschen (x)',
	'No fields could be found.' => 'Keine Felder gefunden.',
	'System-Wide' => 'Systemweit',

## addons/Commercial.pack/templates/comment_response.mtml

## addons/Commercial.pack/templates/notify-entry.mtml

## addons/Commercial.pack/templates/blog_index.mtml

## addons/Commercial.pack/templates/category_archive_list.mtml

## addons/Commercial.pack/templates/main_index.mtml

## addons/Commercial.pack/templates/page.mtml

## addons/Commercial.pack/templates/entry_summary.mtml

## addons/Commercial.pack/templates/recent_entries_expanded.mtml
	'By [_1] | Comments ([_2])' => 'Von [_1] | Kommentare ([_2])',

## addons/Commercial.pack/templates/commenter_notify.mtml

## addons/Commercial.pack/templates/verify-subscribe.mtml

## addons/Commercial.pack/templates/footer-email.mtml

## addons/Commercial.pack/templates/entry_detail.mtml

## addons/Commercial.pack/templates/comment_detail.mtml

## addons/Commercial.pack/templates/new-ping.mtml

## addons/Commercial.pack/templates/comment_throttle.mtml

## addons/Commercial.pack/templates/comment_form.mtml

## addons/Commercial.pack/templates/recent_comments.mtml

## addons/Commercial.pack/templates/monthly_archive_list.mtml

## addons/Commercial.pack/templates/new-comment.mtml

## addons/Commercial.pack/templates/entry_listing.mtml
	'Recently by <em>[_1]</em>' => 'Neues von <em>[_1]</em>',

## addons/Commercial.pack/templates/footer.mtml

## addons/Commercial.pack/templates/tags.mtml

## addons/Commercial.pack/templates/navigation.mtml
	'Home' => 'Startseite',

## addons/Commercial.pack/templates/entry_metadata.mtml

## addons/Commercial.pack/templates/entry.mtml

## addons/Commercial.pack/templates/recover-password.mtml

## addons/Commercial.pack/templates/javascript.mtml
	'Posting...' => 'Veröffentlichen...', # Translate - New # OK
	'[_1]Sign in[_2] to comment, or [_3]comment anonymously[_2].' => 'Zum Kommentieren [_1]anmelden[_2] oder [_3]anonym kommentieren[_2]', # Translate - New # OK

## addons/Commercial.pack/templates/archive_index.mtml

## addons/Commercial.pack/templates/sign_in_top.mtml
	'You are signed in as' => 'Sie sind angemeldet als',
	'.  <a href="[_1]">Sign Out</a>' => '. <a href="[_1]">Abmelden</a>',
	'Sign Out' => 'Abmelden',

## addons/Commercial.pack/templates/trackbacks.mtml
	'TrackBack URL: <a href="[_1]" id="trackbacks-link">[_1]</a>' => 'TrackBack-URL: <a href="[_1]" id="trackback-link">[_1]</a>', # Translate - New # OK

## addons/Commercial.pack/templates/sidebar.mtml

## addons/Commercial.pack/templates/powered_by_footer.mtml

## addons/Commercial.pack/templates/categories.mtml

## addons/Commercial.pack/templates/comments.mtml

## addons/Commercial.pack/templates/search_results.mtml

## addons/Commercial.pack/templates/search_top.mtml

## addons/Commercial.pack/templates/header.mtml

## addons/Commercial.pack/templates/dynamic_error.mtml

## addons/Commercial.pack/templates/footer_links.mtml
	'Links' => 'Links',

## addons/Commercial.pack/templates/tag_cloud.mtml

## addons/Commercial.pack/templates/recent_assets.mtml

## addons/Commercial.pack/templates/comment_preview.mtml

## addons/Commercial.pack/templates/commenter_confirm.mtml

## addons/Enterprise.pack/lib/MT/Enterprise/CMS.pm
	'Add [_1] to a blog' => '[_1] zu Blog hinzufügen',
	'You can not create associations for disabled groups.' => 'Deaktivierte Gruppen können nicht zugewiesen werden.',
	'Assign Role to Group' => 'Rolle an Gruppe zuweisen',
	'Add a group to this blog' => 'Diesem Blog Gruppe hinzufügen',
	'Grant permission to a group' => 'Berechtigung an Gruppe vergeben',
	'Movable Type Enterprise has just attempted to disable your account during synchronization with the external directory. Some of the external user management settings must be wrong. Please correct your configuration before proceeding.' => 'Movable Type Enterprise hat während der Synchronisation versucht, Ihr Benutzerkonto zu deaktivieren. Das deutet auf einen Fehler in der externen Benutzerverwaltung hin. Überprüfen Sie daher die dortigen Einstellungen, bevor Sie Ihre Arbeit in Movable Type forsetzen.',
	'Group requires name' => 'Gruppenname erforderlich',
	'Invalid group' => 'Ungültige Gruppe',
	'Add Users to Group [_1]' => 'Benutzer zu Gruppe [_1] hinzufügen',
	'Users & Groups' => 'Benutzer und Gruppen',
	'Group Members' => 'Gruppenmitglieder',
	'Groups' => 'Gruppen',
	'User Groups' => 'Benutzergruppen',
	'Group load failed: [_1]' => 'Fehler beim Laden einer Gruppe:',
	'User load failed: [_1]' => 'Fehler beim Laden eines Benutzers:',
	'User \'[_1]\' (ID:[_2]) removed from group \'[_3]\' (ID:[_4]) by \'[_5]\'' => 'Benutzer \'[_1]\' (ID:[_2]) von \'[_5]\' aus Gruppe \'[_3]\' (ID:[_4]) entfernt',
	'User \'[_1]\' (ID:[_2]) was added to group \'[_3]\' (ID:[_4]) by \'[_5]\'' => 'Benutzer \'[_1]\' (ID:[_2]) von \'[_5]\' zu Gruppe \'[_3]\' (ID:[_4]) hinzugefügt',
	'Group Profile' => 'Gruppenprofile',
	'Author load failed: [_1]' => 'Fehler beim Laden eines Autoren: [_1]',
	'Invalid user' => 'Ungültiger Benutzer',
	'Assign User [_1] to Groups' => 'Gruppen an Benutzer [_1] zuweisen',
	'Select Groups' => 'Gruppen auswählen',
	'Group' => 'Gruppe',
	'Groups Selected' => 'Gewählte Gruppen',
	'Type a group name to filter the choices below.' => 'Geben Sie einen Gruppennamen ein, um die Auswahl einzuschränken.',
	'Group Name' => 'Gruppenname',
	'Search Groups' => 'Gruppen suchen',
	'Bulk import cannot be used under external user management.' => 'Stapelimport ist bei externer Benutzerverwaltung nicht möglich.',
	'Bulk management' => 'Stapelverwaltung',
	'No record found in the file.  Make sure the file uses CRLF as the line ending character.' => 'Keine Eintr?ge in der Datei gefunden. Stellen Sie sicher, da? CRLF f?r den Zeilenwechsel verwendet wird.',
	'Registered [quant,_1,user,users], updated [quant,_2,user,users], deleted [quant,_3,user,users].' => '[quant,_1,Benutzer] registiert, [quant,_2,Benutzerkonto,Benutzerkonten] aktualisiert, [quant,_3,Benutzerkonto,Benutzerkonten] gel?scht.',
	'The group' => 'Die Gruppe',
	'User/Group' => 'Benutzer/Gruppe',
	'A user can\'t change his/her own username in this environment.' => 'Benutzer können ihre eigenen Benutzernamen in diesem Kontext nicht ändern.',
	'An error occurred when enabling this user.' => 'Bei der Aktivierung dieses Benutzerkontos ist ein Fehler aufgetreten',

## addons/Enterprise.pack/lib/MT/Enterprise/Upgrade.pm
	'Fixing binary data for Microsoft SQL Server storage...' => 'Bereite Binärdaten zur Speicherung in Microsoft SQL Server vor...',

## addons/Enterprise.pack/lib/MT/Enterprise/BulkCreation.pm
	'Format error at line [_1]: [_2]' => 'Fehlerhaftes Format in Zeile [_1]: [_2]',
	'Invalid command: [_1]' => 'Unbekannter Befehl: [_1]',
	'Invalid number of columns for [_1]' => 'Ungültige Spaltenzahl für [_1]',
	'Invalid user name: [_1]' => 'Ungültiger Benutzername: [_1]',
	'Invalid display name: [_1]' => 'Ungültiger Anzeigename: [_1]',
	'Invalid email address: [_1]' => 'Ungültige E-Mail-Adresse: [_1]',
	'Invalid language: [_1]' => 'Ungültige Sprache: [_1]',
	'Invalid password: [_1]' => 'Ungültiges Passwort: [_1]',
	'Invalid password recovery phrase: [_1]' => 'Ungültiger Passwort-Erinnerungssatz: [_1]',
	'Invalid weblog name: [_1]' => 'Ungültiger Weblogname: [_1]',
	'Invalid weblog description: [_1]' => 'Ungültige Weblogbeschreibung: [_1]',
	'Invalid site url: [_1]' => 'Ungültige Webadresse: [_1]',
	'Invalid site root: [_1]' => 'Ungültiges Wurzelverzeichnis: [_1]',
	'Invalid timezone: [_1]' => 'Ungültige Zeitzone: [_1]',
	'Invalid new user name: [_1]' => 'Ungültiger neuer Benutzername: [_1]',
	'A user with the same name was found.  Register was not processed: [_1]' => 'Benutzer mit gleichem Namen gefunden, Registrierung daher nicht durchgeführt: [_1]',
	'Blog for user \'[_1]\' can not be created.' => 'Blog für Benutzer \'[_1]\' kann nicht angelegt werden.',
	'Blog \'[_1]\' for user \'[_2]\' has been created.' => 'Blog \'[_1]\' für Benutzer \'[_2]\' angelegt.',
	'Error assigning weblog administration rights to user \'[_1] (ID: [_2])\' for weblog \'[_3] (ID: [_4])\'. No suitable weblog administrator role was found.' => 'Fehler bei der Zuweisung von Blog-Administrationsrechten für Blog \'[_3] (ID: [_4])\' an Benutzer \'[_1] (ID: [_2])\'. Keine geeignete Administratorenrolle gefunden.',
	'Permission granted to user \'[_1]\'' => 'Berechtigungenga an Benutzer \'[_1]\' vergeben',
	'User \'[_1]\' already exists. Update was not processed: [_2]' => 'Benutzerkonto \'[_1]\' bereits vorhanden, Aktualisierung daher nicht durchgeführt: [_2] ',
	'User cannot be updated: [_1].' => 'Benutzerkonto kann nicht aktualisiert werden: [_1].',
	'User \'[_1]\' not found.  Update was not processed.' => 'Benutzerkonto \'[_1]\' nicht gefunden, Aktualisierung daher nicht durchgeführt. ',
	'User \'[_1]\' has been updated.' => 'Benutzerkonto \'[_1]\' aktualisiert.',
	'User \'[_1]\' was found, but delete was not processed' => 'Benutzerkonto \'[_1]\' gefunden, aber Löschung nicht durchgeführt.',
	'User \'[_1]\' not found.  Delete was not processed.' => 'Benutzerkonto \'[_1]\' nicht gefunden, Löschung daher nicht durchgeführt.',
	'User \'[_1]\' has been deleted.' => 'Benutzerkonto \'[_1]\' gelöscht.',

## addons/Enterprise.pack/lib/MT/Enterprise/Wizard.pm
	'PLAIN' => 'PLAIN',
	'CRAM-MD5' => 'CRAM-MD5',
	'Digest-MD5' => 'Digest-MD5',
	'Login' => 'Login',
	'Found' => 'Gefunden',
	'Not Found' => 'Nicht gefunden',

## addons/Enterprise.pack/lib/MT/Auth/LDAP.pm
	'User [_1]([_2]) not found.' => 'Benutzerkonto [_1]([_2]) nicht gefunden.',
	'User \'[_1]\' cannot be updated.' => 'Benutzerkonto \'[_1]\' kann nicht aktualisiert werden.',
	'User \'[_1]\' updated with LDAP login ID.' => 'Benutzerkonto \'[_1]\' mit LDAP-Login-ID aktualisiert.',
	'LDAP user [_1] not found.' => 'LDAP-Benutzerkonto [_1] nicht gefunden.',
	'User [_1] cannot be updated.' => 'Benutzerkonto [_1] kann nicht aktualisiert werden.',
	'Failed login attempt by user \'[_1]\' deleted from LDAP.' => 'Fehlgeschlagener Anmeldeversuch durch Benutzer \'[_1]\'. Der Benutzer ist aus dem LDAP-Verzeichnis gelöscht', # Translate - Improved (9) # OK
	'User \'[_1]\' updated with LDAP login name \'[_2]\'.' => 'Benutzerkonto \'[_1]\' mit LDAP-Login-Name \'[_2]\'aktualisiert.', # Translate - Improved (1) # OK
	"Failed login attempt by user \'[_1]\'. A user with that\nusername already exists in the system with a different UUID." => "Fehlgeschlagener Anmeldeversuch durch Benutzer \'[_1]\'. Im System ist bereits ein Benutzer\nmit diesem Benutzernamen, aber anderer UUID vorhanden.", # Translate - New # OK
	'User \'[_1]\' account is disabled.' => 'Benutzerkonto \'[_1]\' ist deaktiviert.',
	'LDAP users synchronization interrupted.' => 'LDAP-Benutzersynchronisierung unterbrochen.',
	'Loading MT::LDAP failed: [_1]' => 'Beim Laden von MT::LDAP ist ein Fehler aufgetreten: [_1]',
	'External user synchronization failed.' => 'Synchronisierung externer Benutzer fehlgeschlagen.',
	'An attempt to disable all system administrators in the system was made.  Synchronization of users was interrupted.' => 'Es wurde versucht, alle Administratorenkonten zu deaktivieren. Synchronisation unterbrochen.',
	'The following users\' information were modified:' => 'Die Daten folgender Benutzer wurden geändert:',
	'The following users were disabled:' => 'Die folgenden Benutzer wurden deaktiviert:',
	'LDAP users synchronized.' => 'LDAP-Benutzer synchronisiert.',
	'Synchronization of groups can not be performed without LDAPGroupIdAttribute and/or LDAPGroupNameAttribute is set.' => 'Gruppen können nur synchronisiert werden, wenn LDAPGroupIdAttribute und/oder LDAPGroupNameAttribute gesetzt ist.',
	'LDAP groups synchronized with existing groups.' => 'LDAP-Gruppen mit vorhandenen Gruppen sychnronisiert.',
	'The following groups\' information were modified:' => 'Die Daten folgender Gruppen wurden geändert:',
	'No LDAP group was found using given filter.' => 'Keine entsprechenden LDAP-Gruppen gefunden.',
	"Filter used to search for groups: [_1]\nSearch base: [_2]" => "Verwendeter Suchfilter: [_1]\nSuchbasis: [_2]", # Translate - New # OK
	'(none)' => '(Keine)',
	'The following groups were deleted:' => 'Die folgenden Gruppen wurden gelöscht:',
	'Failed to create a new group: [_1]' => 'Fehler beim Anlegen einer neuen Gruppe: [_1]',
	'[_1] directive must be set to synchronize members of LDAP groups to Movable Type Enterprise.' => '[_1]-Direktive muss gesetzt sein, um LDAP-Gruppenmitgliedschaften mit Movable Type Enterprise zu synchronisieren.',
	'Members removed: ' => 'Entfernte Mitglieder:',
	'Members added: ' => 'Hinzugefügte Mitglieder:',
	'Memberships of the group \'[_2]\' (#[_3]) has been changed in synchronizing with external directory.' => 'Die Mitgliedschaften der Gruppe \'[_2]\' (#[_3]) wurden bei der Sychronisierung mit dem externen Verzeichnis verändert.',
	'LDAPUserGroupMemberAttribute must be set to enable synchronize members of groups.' => 'Zur Synchronisierung von Gruppen muss LDAPUserGroupMemberAttribute gesetzt sein.',

## addons/Enterprise.pack/lib/MT/ObjectDriver/Driver/DBD/UMSSQLServer.pm
	'This version of UMSSQLServer driver requires DBD::ODBC version 1.14.' => 'Diese Version des UMSSQLServer-Treibers erfordert DBD::ODBC in der Version 1.14.',
	'This version of UMSSQLServer driver requires DBD::ODBC compiled with Unicode support.' => 'Diese Version des UMSSQLServer-Treiber erfodert ein mit Unicode-Unterstützung compiliertes DBD::ODBC.',

## addons/Enterprise.pack/lib/MT/ObjectDriver/Driver/DBD/MSSQLServer.pm
	'PublishCharset [_1] is not supported in this version of MS SQL Server Driver.' => 'PublishCharset [_1] wird von dieser Version des Microsoft SQL Server-Treibers nicht unterstützt.',

## addons/Enterprise.pack/lib/MT/Group.pm

## addons/Enterprise.pack/lib/MT/LDAP.pm
	'Invalid LDAPAuthURL scheme: [_1].' => 'Ungültiges LDAPAuthURL-Schema: [_1].',
	'Error connecting to LDAP server [_1]: [_2]' => 'Verbindung zu LDAP-Server [_1] fehlgeschlagen: [_2]',
	'User not found on LDAP: [_1]' => 'Benutzer nicht im LDAP-Verzeichnis gefunden:',
	'Binding to LDAP server failed: [_1]' => 'Bindung an LDAP-Server fehlgeschlagen: [_1]',
	'More than one user with the same name found on LDAP: [_1]' => 'Mehrere Benutzer mit identischem Namen im LDAP-Verzeichnis gefunden: [_1]',

## addons/Enterprise.pack/tmpl/dialog/select_groups.tmpl
	'You need to create some groups.' => 'Bitte legen Sie einige Gruppen an.',
	'Before you can do this, you need to create some groups. <a href="javascript:void(0);" onclick="closeDialog(\'[_1]\');">Click here</a> to create a group.' => 'Bitte legen Sie zuerst einige Gruppen an. <a href="javascript:void(0);" onclick="closeDialog(\'[_1]\');">Klicken Sie hier </a> um Gruppen anzulegen.',

## addons/Enterprise.pack/tmpl/include/list_associations/page_title.group.tmpl
	'Users &amp; Groups for [_1]' => 'Benutzer und Gruppen für [_1]',
	'Group Associations for [_1]' => 'Gruppenzuweisungen für [_1]',

## addons/Enterprise.pack/tmpl/include/users_content_nav.tmpl

## addons/Enterprise.pack/tmpl/include/group_table.tmpl
	'group' => 'Gruppe',
	'groups' => 'Gruppen',
	'Enable selected group (e)' => 'Gew?hlte Gruppe aktivieren (e)',
	'Disable selected group (d)' => 'Gew?hlte Gruppe deaktivieren (d)',
	'Remove selected group (d)' => 'Gew?hlte Gruppe entfernen (d)',
	'Only show enabled groups' => 'Nur aktivierte Gruppen zeigen',
	'Only show disabled groups' => 'Nur deaktivierte Gruppen zeigen',

## addons/Enterprise.pack/tmpl/list_group.tmpl
	'[_1]: User&rsquo;s Groups' => '[_1]: Zugewiesene Gruppen',
	'Groups: System Wide' => 'Systemweite Gruppen',
	'You have successfully disabled the selected group(s).' => 'Gewählte Gruppe(n) erfolgreich deaktiviert.',
	'You have successfully enabled the selected group(s).' => 'Gewählte Gruppe(n) erfolgreich aktiviert.',
	'You have successfully deleted the groups from the Movable Type system.' => 'Gruppen erfolgreich aus dem System gelöscht.',
	'You have successfully synchronized groups\' information with the external directory.' => 'Gruppeninformationen erfolgreich mit externem Verzeichnis synchronisiert.',
	'The user <em>[_1]</em> is currently disabled.' => 'Das Benutzerkonto von <em>[_1]</em> ist derzeit deaktiviert.',
	'You can not add disabled users to groups.' => 'Deaktivierte Benutzer können nicht zu Gruppen hinzugefügt werden.',
	'Add [_1] to another group' => '[_1] zu weiterer Gruppe hinzufügen',
	'Create Group' => 'Gruppe anlegen',
	'You did not select any [_1] to remove.' => 'Keine zu entfernende [_1] gewählt.',
	'Are you sure you want to remove this [_1]?' => '[_1] wirklich entfernen?',
	'Are you sure you want to remove the [_1] selected [_2]?' => '[_1] gewählte [_2] wirklich entfernen?',
	'to remove' => 'zu entfernen',

## addons/Enterprise.pack/tmpl/create_author_bulk_end.tmpl
	'All users updated successfully!' => 'Alle Benutzerkonten erfolgreich aktualisiert!',
	'An error occurred during the updating process. Please check your CSV file.' => 'Während der Aktualisierung ist ein Fehler aufgetreten. Bitte überprüfen Sie Ihre CSV-Datei.',

## addons/Enterprise.pack/tmpl/author_bulk.tmpl
	'Manage Users in bulk' => 'Benutzerverwaltung im Stapel',
	'_USAGE_AUTHORS_2' => 'Sie können Benutzerkonto im Stapel anlegen, bearbeiten und löschen, indem Sie CSV-formatierte Steuerungsdatei mit den entsprechenden Daten und Befehlen hochladen.',
	'Upload source file' => 'Quelldatei hochladen',
	'Specify the CSV-formatted source file for upload' => 'Geben Sie die hochzuladende CSV-Quelldatei an',
	'Source File Encoding' => 'Zeichenkodierung der Quelldatei',
	'Upload (u)' => 'Hochladen (u)',

## addons/Enterprise.pack/tmpl/list_group_member.tmpl
	'[_1]: Group Members' => '[_1]: Gruppenmitglieder',
	'<em>[_1]</em>: Group Members' => '<em>[_1]</em>: Gruppenmitglieder',
	'You have successfully deleted the users.' => 'Benutzer erfolgreich gelöscht.',
	'You have successfully added new users to this group.' => 'Benutzer erfolgreich zur Gruppe hinzugefügt.',
	'You have successfully synchronized users\' information with external directory.' => 'Benutzerinformationen erfolgreich mit externem Verzeichnis synchronisiert.',
	'Some ([_1]) of the selected users could not be re-enabled because they were no longer found in LDAP.' => 'Einige ([_1]) der gewählten Benutzerkonten konnten nicht reaktiviert werden, da sie nicht mehr im LDAP-Verzeichnis vorhanden sind.',
	'You have successfully removed the users from this group.' => 'Benutzer erfolgreich aus Gruppe entfernt.',
	'Group Disabled' => 'Gruppe deaktiviert',
	'You can not add users to a disabled group.' => 'Zu deaktivierten Gruppen können keine Benutzer hinzugefügt werden.',
	'Add user to [_1]' => 'Benutzer zu [_1] hinzufügen',
	'member' => 'Mitglied',
	'Show Enabled Members' => 'Aktivierte Mitglieder zeigen',
	'Show Disabled Members' => 'Deaktivierte Mitglieder zeigen',
	'Show All Members' => 'Alle Mitglieder zeigen',
	'None.' => 'Keine.',
	'(Showing all users.)' => '(Zeige alle Benutzer)',
	'Showing only users whose [_1] is [_2].' => 'Zeige nur Benutzer mit [_2].',
	'Show' => 'Zeige',
	'all' => 'alle',
	'only' => 'nur',
	'users where' => 'Benutzer mit',
	'No members in group' => 'Gruppe ohne Mitglieder',
	'Only show enabled users' => 'Nur aktivierte Benutzer zeigen',
	'Only show disabled users' => 'Nur deaktivierte Benutzer zeigen',
	'Are you sure you want to remove this [_1] from this group?' => '[_1] wirklich aus dieser Gruppe entfernen?',
	'Are you sure you want to remove the [_1] selected [_2] from this group?' => '[_1] gewählten [_2] wirklich aus dieser Gruppe entfernen?',

## addons/Enterprise.pack/tmpl/edit_group.tmpl
	'Edit Group' => 'Gruppe bearbeiten',
	'Group profile has been updated.' => 'Gruppenprofil aktualisiert.',
	'LDAP Group ID' => 'LDAP-Gruppen-ID',
	'The LDAP directory ID for this group.' => 'Die ID dieser Gruppe im LDAP-Verzeichnis',
	'Status of group in the system. Disabling a group removes its members&rsquo; access to the system but preserves their content and history.' => 'Globaler Gruppenstatus. Deaktivierung einer Gruppe entzieht ihren Mitgliedern den Zugang zum System. Inhalte und Nutzungsverläufe der Mitglieder bleiben jedoch erhalten.',
	'The name used for identifying this group.' => 'Der zur Idenfifizierung diesser Gruppe verwendete Name',
	'The display name for this group.' => 'Der Anzeigename dieser Gruppe',
	'Enter a description for your group.' => 'Geben Sie eine Gruppenbeschreibung ein.',
	'Created on' => 'Angelegt',
	'Save changes to this field (s)' => 'Feld-?nderungen speichern (s)',

## addons/Enterprise.pack/tmpl/cfg_ldap.tmpl
	'Authentication Configuration' => 'Authentifizierungs- Einstellungen',
	'You must set your Authentication URL.' => 'Authentifizierungs-URL erforderlich',
	'You must set your Group search base.' => 'Groupsearchbase-Attribut erforderlich',
	'You must set your UserID attribute.' => 'UserID-Attribut erforderlich',
	'You must set your email attribute.' => 'Email-Attribut erforderlich',
	'You must set your user fullname attribute.' => 'Userfullname-Attribut erforderlich',
	'You must set your user member attribute.' => 'Usermember-Attribut erforderlich',
	'You must set your GroupID attribute.' => 'GroupID-Attribut erforderlich',
	'You must set your group name attribute.' => 'Groupname-Attribut erforderlich',
	'You must set your group fullname attribute.' => 'Groupfullname-Attribut erforderlich',
	'You must set your group member attribute.' => 'Groupmember-Attribut erforderlich',
	'You can configure your LDAP settings from here if you would like to use LDAP-based authentication.' => 'Wenn Sie LDAP-Authentifizierung verwenden möchten, können Sie hier die entsprechenden Einstellungen vornehmen.',
	'Your configuration was successful.' => 'Konfigurierung erfolgreich.',
	'Click \'Continue\' below to configure the External User Management settings.' => 'Klicken Sie auf \'Weiter\', um die externe Benutzerverwaltung zu konfigurieren.',
	'Click \'Continue\' below to configure your LDAP attribute mappings.' => 'Klicken Sie auf \'Weiter\', um die LDAP-Attribute zuzuweisen.',
	'Your LDAP configuration is complete.' => 'Ihre LDAP-Konfigurierung ist abgeschlossen.',
	'To finish with the configuration wizard, press \'Continue\' below.' => 'Mit einem Klick auf \'Weiter\' schließen Sie die Konfigurierung ab.',
	'An error occurred while attempting to connect to the LDAP server: ' => 'Es konnte keine Verbindung zum LDAP-Server aufgebaut werden: ',
	'Use LDAP' => 'LDAP verwenden',
	'Authentication URL' => 'Authentifizierungs-URL',
	'The URL to access for LDAP authentication.' => 'Adresse (URL) zur LDAP-Authentifizierung',
	'Authentication DN' => 'Authentifizierungs-DN',
	'An optional DN used to bind to the LDAP directory when searching for a user.' => 'Optionaler DN zur LDAP-Bindung bei der Benutzersuche',
	'Authentication password' => 'Authentifizierungs- Passwort',
	'Used for setting the password of the LDAP DN.' => 'Wird zur Einstellung des LDAP DN-Passworts verwendet',
	'SASL Mechanism' => 'SASL-Mechanismus',
	'The name of SASL Mechanism to use for both binding and authentication.' => 'Name des für Bindung und Authentifizierung verwendeten SASL-Mechanismus',
	'Test Username' => 'Test-Benutzername',
	'Test Password' => 'Test-Passwort',
	'Enable External User Management' => 'Externe Benutzerverwaltung aktivieren',
	'Synchronization Frequency' => 'Aktualisierungsintervall',
	'Frequency of synchronization in minutes. (Default is 60 minutes)' => 'Aktualisierungsintervall in Minuten (Standard: 60 Minuten)',
	'15 Minutes' => '15 Minuten',
	'30 Minutes' => '30 Minuten',
	'60 Minutes' => '60 Minuten',
	'90 Minutes' => '90 Minuten',
	'Group search base attribute' => 'Groupsearchbase-Attribut',
	'Group filter attribute' => 'Groupfilter-Attribut',
	'Search Results (max 10 entries)' => 'Suchergebnis (ersten 10 Treffer)',
	'CN' => 'CN (Common Name)',
	'No groups were found with these settings.' => 'Keine Gruppe mit diesen Einstellungen gefunden.',
	'Attribute mapping' => 'Attributzuordnung',
	'LDAP Server' => 'LDAP-Server',
	'Other' => 'Anderer',
	'User ID attribute' => 'UserID-Attribut',
	'Email Attribute' => 'Email-Attribut',
	'User fullname attribute' => 'Userfullname-Attribut',
	'User member attribute' => 'Usermember-Attribut',
	'GroupID attribute' => 'GroupID-Attribut',
	'Group name attribute' => 'Groupname-Attribut',
	'Group fullname attribute' => 'Groupfullname-Attribut',
	'Group member attribute' => 'Groupmember-Attribut',
	'Search result (max 10 entries)' => 'Suchergebnis (ersten 10 Treffer)',
	'Group Fullname' => 'Groupfullname',
	'Group Member' => 'Groupmember',
	'No groups could be found.' => 'Keine Gruppen gefunden.',
	'User Fullname' => 'Userfullname',
	'No users could be found.' => 'Keine Benutzer gefunden.',
	'Test connection to LDAP' => 'LDAP-Verbindung testen',
	'Test search' => 'Testsuche',

## addons/Enterprise.pack/tmpl/create_author_bulk_start.tmpl
	'Bulk Author Import' => 'Stapelimport von Autoren',

## addons/Enterprise.pack/app-wizard.yaml
	'This module is required in order to use the LDAP Authentication.' => 'Dieses Modul ist zur Nutzung der LDAP-Authentifizierung erforderlich.',
	'This module is required in order to use SSL/TLS connection with the LDAP Authentication.' => 'Dieses Modul ist zur Nutzung von SSL/TLS-Verbindungen bei der LDAP-Authentifizierung erforderlich.',

## addons/Enterprise.pack/app-cms.yaml
	'Are you sure you want to delete the selected group(s)?' => 'Gewählte Gruppe(n) wirklich löschen?',
	'Bulk Author Export' => 'Stapelexport von Autoren',
	'Synchronize Users' => 'Benutzer synchronisieren',
	'Synchronize Groups' => 'Gruppen synchronisieren',

## addons/Enterprise.pack/config.yaml
	'Enterprise Pack' => 'Enterprise-Pack',
	'Oracle Database' => 'Oracle-Datenbank',
	'Microsoft SQL Server Database' => 'Microsoft SQL Server-Datenbank',
	'Microsoft SQL Server Database (UTF-8 support)' => 'Microsoft SQL Server-Datenbank (mit UTF-8-Unterstüzung)',
	'External Directory Synchronization' => 'Synchronisierung mit externem Verzeichnis',
	'Populating author\'s external ID to have lower case user name...' => 'Setze externe Benutzerkennung für kleingeschriebene Benutzernamen...', # Translate - New # OK

## plugins/Cloner/cloner.pl
	'Clones a blog and all of its contents.' => 'Klont Blogs mit allen Inhalten',
	'Cloning blog \'[_1]\'...' => 'Klone Blog \'[_1]\'...',
	'Finished! You can <a href="javascript:void(0);" onclick="closeDialog(\'[_1]\');">return to the blog listing</a> or <a href="javascript:void(0);" onclick="closeDialog(\'[_2]\');">configure the Site root and URL of the new blog</a>.' => 'Fertig! Zurück zur <a href="javascript:void(0);" onclick="closeDialog(\'[_1]\');">Liste aller Blogs</a> oder <a href="javascript:void(0);" onclick="closeDialog(\'[_2]\');">Pfade und Adressen des neuen Blogs konfigurieren</a>.',
	'No blog was selected to clone.' => 'Kein Blog zum Klonen ausgewählt.',
	'This action can only be run for a single blog at a time.' => 'Diese Aktion kann nur für jeweils ein Blog gleichzeitig ausgeführt werden.',
	'Invalid blog_id' => 'Ungültige blog_id',
	'Clone Blog' => 'Blog klonen',

## plugins/Markdown/SmartyPants.pl
	'Easily translates plain punctuation characters into \'smart\' typographic punctuation.' => 'Wandelt einfache Interpunktionszeichen in typographisch korrekte Zecichen um.',
	'Markdown With SmartyPants' => 'Markdown mit SmartyPants',

## plugins/Markdown/Markdown.pl
	'A plain-text-to-HTML formatting plugin.' => 'Ein Plugin, mit dem HTML wie normaler Text eingegeben werden kann.',
	'Markdown' => 'Markdown',

## plugins/WXRImporter/lib/WXRImporter/Import.pm

## plugins/WXRImporter/lib/WXRImporter/WXRHandler.pm
	'File is not in WXR format.' => 'Datei ist nicht im WXR-Format.',
	'Duplicate asset (\'[_1]\') found.  Skipping.' => 'Doppeltes Asset (\'[_1]\') gefunden. Überspringe...',
	'Saving asset (\'[_1]\')...' => 'Speichere Asset (\'[_1]\')...',
	' and asset will be tagged (\'[_1]\')...' => ' und tagge Asset (\'[_1]\')...',
	'Duplicate entry (\'[_1]\') found.  Skipping.' => 'Doppelter Eintrag gefunden. Überspringe...',
	'Saving page (\'[_1]\')...' => 'Speichere Seite (\'[_1]\')...',

## plugins/WXRImporter/tmpl/options.tmpl
	'Before you import WordPress posts to Movable Type, we recommend that you <a href=\'[_1]\'>configure your blog\'s publishing paths</a> first.' => 'Bevor Sie WordPress-Einträge in Movable Type importieren, sollten Sie zuerst die <a href=\'[_1]\'>Veröffentlichungspfade Ihres Weblogs einstellen</a>.',
	'Upload path for this WordPress blog' => 'Uploadpfad für dieses WordPress-Blog',
	'Replace with' => 'Ersetzen durch',
	'Download attachments' => 'Anhänge herunterladen',
	'Requires the use of a cron job to download attachments from WordPress powered blog in the background.' => 'Lädt Anhänge von Wordpress-Blogs im Hintergrund herunter. Cronjob erforderlich.',
	'Download attachments (images and files) from the imported WordPress powered blog.' => 'Anhänge (Bilder und Dateien) des importierten Wordpress-Blogs herunterladen.',

## plugins/WXRImporter/WXRImporter.pl
	'Import WordPress exported RSS into MT.' => 'Aus WordPress exportiertes RSS in Movable Type importieren',
	'WordPress eXtended RSS (WXR)' => 'WordPress eXtended RSS (WXR)',
	'Download WP attachments via HTTP.' => 'WP-Anhänge per HTTP herunterladen',

## plugins/StyleCatcher/lib/StyleCatcher/CMS.pm
	'Your mt-static directory could not be found. Please configure \'StaticFilePath\' to continue.' => 'Ihr mt-static-Ordner konnte nicht gefunden werden. Bitte konfigurieren Sie \'StaticFilePath\' um fortzufahren.',
	'Could not create [_1] folder - Check that your \'themes\' folder is webserver-writable.' => 'Konnte den Ordner [_1] nicht anlegen. Stellen Sie sicher, daß der Webserver Schreibrechte auf dem \'themes\'-Ordner hat.',
	'Error downloading image: [_1]' => 'Fehler beim Herunterladen einer Bilddatei: [_1]',
	'Successfully applied new theme selection.' => 'Neue Themenauswahl erfolgreich angewendet.',
	'Invalid URL: [_1]' => 'Ungültige URL: [_1]',

## plugins/StyleCatcher/tmpl/view.tmpl
	'Select a Style' => 'Design wählen',
	'3-Columns, Wide, Thin, Thin' => 'Dreispaltig: breit - schmal - schmal',
	'3-Columns, Thin, Wide, Thin' => 'Dreispaltig: schmal - breit - schmal',
	'2-Columns, Thin, Wide' => 'Zweispaltig: schmal - breit',
	'2-Columns, Wide, Thin' => 'Zweispaltig: breit - schmal',
	'2-Columns, Wide, Medium' => 'Zweispaltig: breit - mittel',
	'2-Columns, Medium, Wide' => 'Zweispaltig: mittel - breit', # Translate - New # OK
	'None available' => 'Keine verfügbar',
	'Applying...' => 'Wende an...',
	'Apply Design' => 'Design übernehmen',
	'Error applying theme: ' => 'Fehler bei der Übernahme des Themas:',
	'The selected theme has been applied, but as you have changed the layout, you will need to republish your blog to apply the new layout.' => 'Das gewählte Thema wurde übernommen. Da das Layout geändert wurde, veröffentlichen Sie das Blog bitte erneut, um die Änderungen wirksam werden zu lassen.',
	'The selected theme has been applied!' => 'Das Thema wurde übernommen!',
	'Error loading themes! -- [_1]' => 'Fehler beim Laden der Themen -- [_1]',
	'Stylesheet or Repository URL' => 'URL des Stylesheets oder der Sammlung',
	'Stylesheet or Repository URL:' => 'URL des Stylesheets oder der Sammlung:',
	'Download Styles' => 'Designs herunterladen',
	'Current theme for your weblog' => 'Aktuelles Theme Ihres Weblogs',
	'Current Style' => 'Derzeitige Design',
	'Locally saved themes' => 'Lokal gespeicherte Themes',
	'Saved Styles' => 'Gespeicherte Designs',
	'Default Styles' => 'Standarddesigns',
	'Single themes from the web' => 'Einzelne Themes aus dem Web',
	'More Styles' => 'Weitere Designs',
	'Selected Design' => 'Gewähltes Design',
	'Layout' => 'Layout',

## plugins/StyleCatcher/stylecatcher.pl
	'StyleCatcher lets you easily browse through styles and then apply them to your blog in just a few clicks. To find out more about Movable Type styles, or for new sources for styles, visit the <a href=\'http://www.sixapart.com/movabletype/styles\'>Movable Type styles</a> page.' => 'Mit StyleCatchter können Sie spielend leicht neue Designvorlagen für Ihre Blogs finden und mit wenigen Klicks direkt aus dem Internet installieren. Mehr dazu auf der <a href=\'http://www.sixapart.com/movabletype/styles\'>Movable Type Styles</a>-Seite.',
	'MT 4 Style Library' => 'MT 4-Designs',
	'A collection of styles compatible with Movable Type 4 default templates.' => 'Mit den Standardvorlagen von MT 3.3+  kompatible Designvorlagen',
	'MT 3 Style Library' => 'MT 3-Design',
	'A collection of styles compatible with Movable Type 3.3+ default templates.' => 'Mit den Standardvorlagen von MT 3.3+  kompatible Designvorlagen',
	'Styles' => 'Designs',

## plugins/spamlookup/lib/spamlookup.pm
	'Failed to resolve IP address for source URL [_1]' => 'Kann IP-Adresse der Quelladresse [_1] nicht auflösen',
	'Moderating: Domain IP does not match ping IP for source URL [_1]; domain IP: [_2]; ping IP: [_3]' => 'Moderation: Die IP-Adresse der Domain ([_2]) stimmt nicht mit der Ping-IP-Adresse ([_3]) überein. URL: [_1]',
	'Domain IP does not match ping IP for source URL [_1]; domain IP: [_2]; ping IP: [_3]' => 'Die IP-Adresse der Domain ([_2]) stimmt nicht mit der Ping-IP-Adresse ([_3]) überein. URL: [_1]',
	'No links are present in feedback' => 'Keine Links enthalten',
	'Number of links exceed junk limit ([_1])' => 'Anzahl der Links übersteigt Spam-Schwellenwert ([_1] Links)',
	'Number of links exceed moderation limit ([_1])' => 'Anzahl der Links übersteigt Moderations-Schwellenwert ([_1] Links)',
	'Link was previously published (comment id [_1]).' => 'Link wurde bereits veröffentlicht (Kommentar [_1])',
	'Link was previously published (TrackBack id [_1]).' => 'Link wurde bereits veröffentlicht (TrackBack [_1])',
	'E-mail was previously published (comment id [_1]).' => 'E-Mail-Adresse wurde bereits veröffentlicht (Kommentar [_1])',
	'Word Filter match on \'[_1]\': \'[_2]\'.' => 'Schlüsselwortfilter angesprochen bei \'[_1]\': \'[_2]\'.',
	'Moderating for Word Filter match on \'[_1]\': \'[_2]\'.' => 'Moderierung: Schlüsselwortfilter angesprochen bei \'[_1]\': \'[_2]\'.',
	'domain \'[_1]\' found on service [_2]' => 'Domain \'[_1]\'gefunden bei [_2]',
	'[_1] found on service [_2]' => '[_1] gefunden bei [_2]',

## plugins/spamlookup/tmpl/lookup_config.tmpl
	'Lookups monitor the source IP addresses and hyperlinks of all incoming feedback. If a comment or TrackBack comes from a blacklisted IP address or contains a blacklisted domain, it can be held for moderation or scored as junk and placed into the blog\'s Junk folder. Additionally, advanced lookups on TrackBack source data can be performed.' => 'Von eingehendem Feedback können die IP-Adressen und die enthaltenen Hyperlinks  in Schwarzlisten nachgeschlagen werden. Stammt ein eingehender Kommentar oder TrackBack von einer dort gelisteten IP-Adresse oder enthält er Links zu einer dort gelisteten Domain, kann er  automatisch zur Moderation zurückgehalten oder als Spam angesehen werden. Für TrackBacks sind zusätzliche Prüfungen möglich.',
	'IP Address Lookups' => 'Nachschlagen von IP-Adressen',
	'Moderate feedback from blacklisted IP addresses' => 'Feedback von schwarzgelisteten IP-Adressen moderieren',
	'Junk feedback from blacklisted IP addresses' => 'Feedback von schwarzgelisteten IP-Adressen als Spam ansehen',
	'Adjust scoring' => 'Gewichtung anpassen',
	'Score weight:' => 'Gewichtung',
	'Less' => 'kleiner',
	'More' => 'größer',
	'block' => 'sperren',
	'IP Blacklist Services' => 'IP-Schwarzlisten',
	'Domain Name Lookups' => 'Nachschlagen von Domain-Namen',
	'Moderate feedback containing blacklisted domains' => 'Feedback von schwarzgelisteten Domains moderieren',
	'Junk feedback containing blacklisted domains' => 'Feedback von schwarzgelisteten Domains als Spam ansehen',
	'Domain Blacklist Services' => 'Domain-Schwarzlisten',
	'Advanced TrackBack Lookups' => 'Zusätzliche TrackBack-Prüfungen',
	'Moderate TrackBacks from suspicious sources' => 'TrackBacks aus dubiosen Quellen moderieren',
	'Junk TrackBacks from suspicious sources' => 'TrackBacks aus dubiosen Quellen als Spam ansehen',
	'Lookup Whitelist' => 'Weißliste',
	'To prevent lookups for some IP addresses or domains, list them below. Place each entry on a line by itself.' => 'Hier können Sie IP-Adressen und Domains eintragen, die nicht nachgeschlagen werden sollen. Verwenden Sie für jeden Eintrag eine neue Zeile.',

## plugins/spamlookup/tmpl/url_config.tmpl
	'Link filters monitor the number of hyperlinks in incoming feedback. Feedback with many links can be held for moderation or scored as junk. Conversely, feedback that does not contain links or only refers to previously published URLs can be positively rated. (Only enable this option if you are sure your site is already spam-free.)' => 'Die Anzahl der in eingehendem Feedback enthaltenen Hyperlinks kann kontrolliert werden. Feedback mit sehr vielen Links kann automatisch zur Moderation zurückgehalten oder als Spam angesehen werden. Umgekehrt kann Feedback, das gar keine Links enthält oder nur solche, die zuvor bereits freigegeben wurden, automatisch positiv bewertet werden.',
	'Link Limits' => 'Link-Schwellenwert',
	'Credit feedback rating when no hyperlinks are present' => 'Feedback ohne Hyperlinks positiv bewerten',
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

## plugins/spamlookup/tmpl/word_config.tmpl
	'Incomming feedback can be monitored for specific keywords, domain names, and patterns. Matches can be held for moderation or scored as junk. Additionally, junk scores for these matches can be customized.' => 'Eingehendes Feedback kann auf wählbare Schlüsselbegriffe, Domainnamen und Muster durchsucht werden. Feedback mit Treffern kann automatisch zur Moderation zurückgehalten oder als Spam angesehen werden.',
	'Keywords to Moderate' => 'Bei Auftreten dieser Schlüsselwörter Feedback moderieren',
	'Keywords to Junk' => 'Bei Auftreten dieser Schlüsselwörter Feedback als Spam ansehen',

## plugins/spamlookup/spamlookup_words.pl
	'SpamLookup module for moderating and junking feedback using keyword filters.' => 'SpamLookup-Modul zur automatischen Einordnung von Feedback nach Schlüsselbegriffen zur Moderation oder als Spam.',
	'SpamLookup Keyword Filter' => 'SpamLookup Schlüsselbegriff-Filter',

## plugins/spamlookup/spamlookup.pl
	'SpamLookup module for using blacklist lookup services to filter feedback.' => 'SpamLookup-Modul zur Nutzung von Sperrlisten zur Feedback-Überprüfung',
	'SpamLookup IP Lookup' => 'SpamLookup für IP-Adressen',
	'SpamLookup Domain Lookup' => 'SpamLookup für Domains',
	'SpamLookup TrackBack Origin' => 'SpamLookup für TrackBack-Herkunft',
	'Despam Comments' => 'Spam aus Kommentaren entfernen',
	'Despam TrackBacks' => 'Spam aus TrackBacks entfernen',
	'Despam' => 'Spam entfernen',

## plugins/spamlookup/spamlookup_urls.pl
	'SpamLookup - Link' => 'SpamLookup für Links',
	'SpamLookup module for junking and moderating feedback based on link filters.' => 'SpamLookup-Modul zur Überprüfung von Links in Feedback',
	'SpamLookup Link Filter' => 'SpamLookup zur Linkfilterung',
	'SpamLookup Link Memory' => 'SpamLookup zur Betrachtung bereits veröffentlichter Links',
	'SpamLookup Email Memory' => 'SpamLookup zur Betrachtung bereits veröffentlichter E-Mail-Adressen',

## plugins/MultiBlog/lib/MultiBlog/Tags.pm
	'MTMultiBlog tags cannot be nested.' => 'MTMultiBlog-Tags können nicht veschachtelt werden.',
	'Unknown "mode" attribute value: [_1]. Valid values are "loop" and "context".' => 'Ungültiges "mode"-Attribut [_1]. Gültige Werte sind "loop" und "context".',

## plugins/MultiBlog/lib/MultiBlog.pm
	'The include_blogs, exclude_blogs, blog_ids and blog_id attributes cannot be used together.' => 'Die Attribute include_blogs, exclude_blog, blog_ids und blog_id können nicht gemeinsam verwendet werden.',
	'The attribute exclude_blogs cannot take "all" for a value.' => '"All" ist kein gültiger Wert für exclude_blogs.',
	'The value of the blog_id attribute must be a single blog ID.' => 'blog_id erfordert genau eine Blog-ID als Wert.',
	'The value for the include_blogs/exclude_blogs attributes must be one or more blog IDs, separated by commas.' => 'include_blogs und exclude_blogs erfordern mindestens eine Blog-ID als Wert. Mehrere IDs sind per Kommata zu trennen.',

## plugins/MultiBlog/tmpl/system_config.tmpl
	'Default system aggregation policy' => 'Systemwite Aggregations- Voreinstellung',
	'Allow' => 'Aggregation zulassen',
	'Disallow' => 'Aggregation nicht zulassen',
	'Cross-blog aggregation will be allowed by default.  Individual blogs can be configured through the blog-level MultiBlog settings to restrict access to their content by other blogs.' => 'Verwendung von Bloginhalten in anderen Blogs dieser Installation systemweit erlauben. Auf Blog-Ebene gemachte Einstellungen sind vorranging, so daß diese Voreinstellung für einzelne Blogs außer Kraft gesetzt werden kann.',
	'Cross-blog aggregation will be disallowed by default.  Individual blogs can be configured through the blog-level MultiBlog settings to allow access to their content by other blogs.' => 'Verwendung von Bloginhalten in anderen Blogs dieser Installation systemweit nicht erlauben. Auf Blog-Ebene gemachte Einstellungen sind vorranging, so daß diese Voreinstellung für einzelne Blogs außer Kraft gesetzt werden kann.',

## plugins/MultiBlog/tmpl/blog_config.tmpl
	'When' => 'Wenn in',
	'Any Weblog' => 'einem beliebigen Blog',
	'Weblog' => 'Weblog',
	'Trigger' => 'Auslöser',
	'Action' => 'Aktion',
	'Content Privacy' => 'Externer Zugriff auf Inhalte',
	'Specify whether other blogs in the installation may publish content from this blog. This setting takes precedence over the default system aggregation policy found in the system-level MultiBlog configuration.' => 'Hier können Sie festlegen, ob andere Blogs dieser Movable Type-Installation die Inhalte dieses Blogs verwenden dürfen oder nicht. Diese Einstellung hat Vorrang vor der globalen MultiBlog-Konfiguration.',
	'Use system default' => 'System-Voreinstellung verwenden',
	'MTMultiBlog tag default arguments' => 'MultiBlog- Standardargumente',
	'Enables use of the MTMultiBlog tag without include_blogs/exclude_blogs attributes. Comma-separated BlogIDs or \'all\' (include_blogs only) are acceptable values.' => 'Ermöglicht die Verwendung von MTMultiBlog ohne include_blogs- und exclude_blogs-Attribute. Erlaubte Werte sind \'all\' oder per Kommata getrennte BlogIDs.',
	'Include blogs' => 'Einzuschließende Blogs',
	'Exclude blogs' => 'Auszuschließende Blogs',
	'Rebuild Triggers' => 'Auslöser für Neuaufbau',
	'Create Rebuild Trigger' => 'Auslöser für Neuaufbau definieren',
	'You have not defined any rebuild triggers.' => 'Es sind keine Auslöser definiert.',

## plugins/MultiBlog/tmpl/dialog_create_trigger.tmpl
	'Create MultiBlog Trigger' => 'MultiBlog-Auslöser definieren',

## plugins/MultiBlog/multiblog.pl
	'MultiBlog allows you to publish content from other blogs and define publishing rules and access controls between them.' => 'Mit MultiBlog können Sie Inhalte anderer Blogs übernehmen und die dazu erforderlichen Veröffentlichungsregeln definieren.',
	'MultiBlog' => 'MultiBlog',
	'Create Trigger' => 'Neuen Auslöser anlegen',
	'Weblog Name' => 'Name des Blogs',
	'Search Weblogs' => 'Weblogs suchen',
	'When this' => 'Wenn',
	'* All Weblogs' => '* Alle Weblogs',
	'Select to apply this trigger to all weblogs' => 'Auslöser auf alle Weblogs anwenden',
	'saves an entry' => 'ein Eintrag gespeichert wird',
	'publishes an entry' => 'ein Eintrag veröffentlicht wird',
	'publishes a comment' => 'ein Kommentar veröffentlicht wird',
	'publishes a TrackBack' => 'ein TrackBack veröffentlicht wird',
	'rebuild indexes.' => 'Indizes neu aufbauen.',
	'rebuild indexes and send pings.' => 'Indizes neu aufbauen und Pings senden.',

## plugins/Textile/textile2.pl
	'A humane web text generator.' => 'Korrekt formatierter Text leicht gemacht',
	'Textile 2' => 'Textile 2',

## plugins/WidgetManager/WidgetManager.pl
	'Widget Manager version 1.1; This version of the plugin is to upgrade data from older version of Widget Manager that has been shipped with Movable Type to the Movable Type core schema.  No other features are included.  You can safely remove this plugin after installing/upgrading Movable Type.' => 'Widget Manager 1.1 - Diese Version des Plugins dient ausschließlich dazu, Daten älterer Versionen auf das Movable Type Core-Schema zu aktualisieren. Sie können diese Plugin daher nach Installation bzw. Aktualisierung von Movable Type gefahrlos löschen.', # Translate - New # OK
	'Moving storage of Widget Manager [_1]...' => 'Verschiebe den Speicherort von Widget Manager [_1]...', # Translate - New # OK

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
	'You may now <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">edit &ldquo;[_1]&rdquo;</a> or include the widget in your blog using <a href="javascript:void(0)" onclick="closeDialog(\'[_3]\')">WidgetManager</a> or the following MTInclude tag:' => 'Sie können &#8222;[_1]&#8221; jetzt <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">bearbeiten</a> oder in Ihr Blog <a href="javascript:void(0)" onclick="closeDialog(\'[_3]\')">einbinden</a>. Alternativ können Sie dazu auch diesen MTInclude-Befehl verwenden:', # Translate - Improved (3) # OK
	'You may now <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">edit &ldquo;[_1]&rdquo;</a> or include the widget in your blog using the following MTInclude tag:' => 'Sie können &#8222;[_1]&#8221; jetzt <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">bearbeiten</a> oder mit diesem MTInclude-Befehl in Ihr Blog einbinden:', # Translate - Improved (3) # OK
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
	'Feeds.App Lite helps you republish feeds on your blogs. Want to do more with feeds in Movable Type?' => 'Mit Feeds.App Lite können Sie Feedinhalte in Ihre Blogs integrieren. Noch mehr Möglichkeiten erhalten Sie durch ein',
	'Upgrade to Feeds.App' => 'Upgrade auf Feeds.App',
	'Create a Feed Widget' => 'Feed-Widget anlegen',

);

## New words: 1127
## Case words: -
## Improved words: 58
## Previous words: - 
## Total: 1185

1;
