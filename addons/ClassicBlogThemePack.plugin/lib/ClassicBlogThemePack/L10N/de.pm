package ClassicBlogThemePack::L10N::de;
use strict;
use ClassicBlogThemePack::L10N;
use ClassicBlogThemePack::L10N::en_us;
use vars qw( @ISA %Lexicon );
@ISA = qw( ClassicBlogThemePack::L10N::en_us );

## The following is the translation table.

%Lexicon = (

## default_templates/comments.mtml
	'1 Comment' => '1 Kommentar',
	'# Comments' => '# Kommentare',
	'No Comments' => 'Keine Kommentare',
	'Comment Detail' => 'Kommentardetails',
	'The data is modified by the paginate script' => 'Diese Daten werden durch das Paginierungs-Skript ge√§ndert', # Translate - New # OK
	'Older Comments' => '√Ñltere Kommentare', # Translate - New # OK
	'Newer Comments' => 'Neuere Kommentare', # Translate - New # OK
	'Leave a comment' => 'Jetzt kommentieren',
	'Name' => 'Name',
	'Email Address' => 'E-Mail-Adresse',
	'URL' => 'URL',
	'Remember personal info?' => 'Pers√∂nliche Angaben speichern?',
	'Comments' => 'Kommentare',
	'(You may use HTML tags for style)' => '(HTML-Tags zur Textformatierung erlaubt)',
	'Preview' => 'Vorschau',
	'Submit' => 'Abschicken',

## default_templates/search.mtml
	'Search' => 'Suchen:',
	'Case sensitive' => 'Gro√ü/Kleinschreibung beachten',
	'Regex search' => 'Regul√§re Ausdr√ºcke verwenden',
	'Tags' => 'Tags',
	'[_1] ([_2])' => '[_1] ([_2])',

## default_templates/monthly_archive_dropdown.mtml
	'Archives' => 'Archiv',
	'Select a Month...' => 'Monat w√§hlen...',

## default_templates/notify-entry.mtml
	'A new [lc,_3] entitled \'[_1]\' has been published to [_2].' => 'Ein neuer [_3] namens \'[_1]\' wurde auf [_2] ver√∂ffentlicht.',
	'View entry:' => 'Eintrag ansehen:',
	'View page:' => 'Seite ansehen:',
	'[_1] Title: [_2]' => 'Titel: [_2]',
	'Publish Date: [_1]' => 'Ver√∂ffentlichungsdatum:',
	'Message from Sender:' => 'Nachricht des Absenders:',
	'You are receiving this email either because you have elected to receive notifications about new content on [_1], or the author of the post thought you would be interested. If you no longer wish to receive these emails, please contact the following person:' => 'Sie erhalten diese E-Mail, da Sie entweder Nachrichten √ºber Aktualisierungen von [_1] bestellt haben oder da der Autor dachte, da√ü dieser Eintrag f√ºr Sie von Interesse sein k√∂nnte. Wenn Sie solche Mitteilungen nicht l√§nger erhalten wollen, wenden Sie sich bitte an ',

## default_templates/category_archive_list.mtml
	'Categories' => 'Kategorien',

## default_templates/date_based_author_archives.mtml
	'Author Yearly Archives' => 'J√§hrliche Autorenarchive',
	'Author Monthly Archives' => 'Monatliche Autorenarchive',
	'Author Weekly Archives' => 'W√∂chentliche Autorenarchive',
	'Author Daily Archives' => 'T√§gliche Autorenarchive',

## default_templates/current_author_monthly_archive_list.mtml
	'[_1]: Monthly Archives' => '[_1]: Monatsarchive',

## default_templates/main_index.mtml
	'HTML Head' => 'HTML-Kopf',
	'Banner Header' => 'Banner-Kopf',
	'Entry Summary' => 'Zusammenfassung',
	'Sidebar' => 'Seitenleiste',
	'Banner Footer' => 'Banner-Fu√ü',

## default_templates/page.mtml
	'Trackbacks' => 'TrackBacks',

## default_templates/comment_preview.mtml
	'Previewing your Comment' => 'Vorschau Ihres Kommentars',
	'[_1] replied to <a href="[_2]">comment from [_3]</a>' => '[_1] hat auf den <a href="[_2]">Kommentar von [_3]</a> geantwortet</a>',
	'Replying to comment from [_1]' => 'Antwort auf den Kommentar von [_1]',
	'Cancel' => 'Abbrechen',

## default_templates/main_index_widgets_group.mtml
	'This is a custom set of widgets that are conditioned to only appear on the homepage (or "main_index"). More info: [_1]' => 'Dies ist eine spezielle Widgetgrupe, die nur auf der Startseite angezeigt wird.',
	'Recent Comments' => 'Aktuelle Kommentare',
	'Recent Entries' => 'Aktuelle Eintr√§ge',
	'Recent Assets' => 'Aktuelle Assets',
	'Tag Cloud' => 'Tag-Wolke',

## default_templates/entry_summary.mtml
	'By [_1] on [_2]' => 'Von [_1] am [_2]',
	'1 TrackBack' => '1 TrackBack',
	'# TrackBacks' => '# TrackBacks',
	'No TrackBacks' => 'Keine TrackBacks',
	'Continue reading <a href="[_1]" rel="bookmark">[_2]</a>.' => '<a rel="bookmark" href="[_1]">[_2]</a> weiterlesen',

## default_templates/comment_response.mtml
	'Confirmation...' => 'Best√§tigung',
	'Your comment has been submitted!' => 'Ihr Kommentar ist eingegangen!',
	'Thank you for commenting.' => 'Vielen Dank f√ºr Ihren Kommentar.',
	'Your comment has been received and held for approval by the blog owner.' => 'Ihr Kommentar wurde abgeschickt. Er erscheint, sobald der Blogbetreiber ihn freigeschaltet hat.',
	'Comment Submission Error' => 'Fehler beim Kommentieren',
	'Your comment submission failed for the following reasons: [_1]' => 'Ihr Kommentar konnte aus folgenden Gr√ºnden nicht abgeschickt werden: [_1]',
	'Return to the <a href="[_1]">original entry</a>.' => '<a href="[_1]">Zur√ºck zum Eintrag</a>',

## default_templates/commenter_notify.mtml
	'This email is to notify you that a new user has successfully registered on the blog \'[_1]\'. Listed below you will find some useful information about this new user.' => 'Ein neuer Benutzer hat sich erfolgreich f√ºr das Blog \'[_1]\' registriert. Unten finden Sie n√§here Informationen √ºber diesen Benutzer.',
	'New User Information:' => 'Informationen √ºber den neuen Benutzer:',
	'Username: [_1]' => 'Benutzername: [_1]',
	'Full Name: [_1]' => 'Voller Name: [_1]',
	'Email: [_1]' => 'E-Mail-Adresse:',
	'To view or edit this user, please click on or cut and paste the following URL into a web browser:' => 'Um alle Benutzerdaten zu sehen oder zu bearbeiten, klicken Sie bitte auf folgende Adresse (oder kopieren Sie sie und f√ºgen Sie sie in Adresszeile Ihres Web-Browsers ein):',

## default_templates/footer-email.mtml
	'Powered by Melody [_1]' => 'Powered by Melody [_1]',

## default_templates/comment_listing_dynamic.mtml

## default_templates/archive_widgets_group.mtml
	'This is a custom set of widgets that are conditioned to serve different content based upon what type of archive it is included. More info: [_1]' => 'Dies ist eine spezielle Widgetgruppe, die vom jeweiligen Archivtyp abh√§ngige Inhalte ausgibt.',
	'Current Category Monthly Archives' => 'Monatsarchive der aktuellen Kategorie',
	'Category Archives' => 'Kategoriearchive',
	'Monthly Archives' => 'Monatsarchive',

## default_templates/verify-subscribe.mtml
	'Thanks for subscribing to notifications about updates to [_1]. Follow the link below to confirm your subscription:' => 'Vielen Dank, da√ü Sie die die Benachrichtungen √ºber Aktualisierungen von [_1] abonniert haben. Bitte klicken Sie zur Best√§tigung auf folgenden Link:',
	'If the link is not clickable, just copy and paste it into your browser.' => 'Wenn der Link nicht anklickbar ist, kopieren Sie ihn einfach und f√ºgen ihn in der Adresszeile Ihres Browers ein.',

## default_templates/new-ping.mtml
	'An unapproved TrackBack has been posted on your blog [_1], for entry #[_2] ([_3]). You need to approve this TrackBack before it will appear on your site.' => 'In Ihrem Weblog [_1] ist ein noch nicht freigeschaltetes TrackBack zum Eintrag [_3] (#[_2]) eingegangen. Schalten Sie das TrackBack frei, damit es auf Ihrem Weblog erscheint.',
	'An unapproved TrackBack has been posted on your blog [_1], for category #[_2], ([_3]). You need to approve this TrackBack before it will appear on your site.' => 'In Ihrem Weblog [_1] ist ein noch nicht freigeschaltetes TrackBack f√ºr die Kategorie [_3] (#[_2]) eingegangen. Schalten Sie das TrackBack frei, damit es auf Ihrem Weblog erscheint.',
	'A new TrackBack has been posted on your blog [_1], on entry #[_2] ([_3]).' => 'In Ihrem Weblog [_1] ist ein neuer TrackBack zum Eintrag [_3] (#[_2]) eingegangen.',
	'A new TrackBack has been posted on your blog [_1], on category #[_2] ([_3]).' => 'In Ihrem Weblog [_1] ist ein neuer TrackBack f√ºr die Kategorie [_3] (#[_2]) eingegangen.',
	'Excerpt' => 'Zusammenfassung',
	'Title' => 'Titel',
	'Blog' => 'Blog',
	'IP address' => 'IP-Adresse',
	'Approve TrackBack' => 'TrackBack annehmen',
	'View TrackBack' => 'TrackBack ansehen',
	'Report TrackBack as spam' => 'TrackBack als Spam melden',
	'Edit TrackBack' => 'TrackBack bearbeiten',

## default_templates/syndication.mtml
	'Subscribe to feed' => 'Feed abonnieren',
	'Subscribe to this blog\'s feed' => 'Feed dieses Blogs abonnieren',
	'Subscribe to a feed of all future entries tagged &ldquo;[_1]&ldquo;' => 'Feed aller k√ºnftigen mit &#8222;[_1]&#8220; getaggten Eintr√§ge abonnieren',
	'Subscribe to a feed of all future entries matching &ldquo;[_1]&ldquo;' => 'Feed aller k√ºnftigen Eintr√§ge mit &#8222;[_1]&#8220; abonnieren',
	'Feed of results tagged &ldquo;[_1]&ldquo;' => 'Feed aller mit &#8222;[_1]&#8220; getaggten Ergebnisse abonnieren',
	'Feed of results matching &ldquo;[_1]&ldquo;' => 'Feeds aller Ergebnisse zu &#8222;[_1]&#8220; abonnieren',

## default_templates/comment_detail.mtml

## default_templates/banner_footer.mtml
	'_POWERED_BY' => 'Powered by<br /><a href="http://www.movabletype.org/sitede/"><MTProductName></a>',
	'This blog is licensed under a <a href="[_1]">Creative Commons License</a>.' => 'Dieses Blog steht unter einer <a href="[_1]">Creative Commons-Lizenz</a>.',

## default_templates/search_results.mtml
	'Search Results' => 'Suchergebnisse',
	'Results matching &ldquo;[_1]&rdquo;' => 'Suchergebnisse f√ºr &#8222;[_1]&#8221;',
	'Results tagged &ldquo;[_1]&rdquo;' => 'Mit &#8222;[_1]&#8221; getaggt',
	'Previous' => 'Zur√ºck',
	'Next' => 'Vor',
	'No results found for &ldquo;[_1]&rdquo;.' => 'Keine Suchergebnisse f√ºr &#8222;[_1]&#8221; gefunden',
	'Instructions' => 'Anleitung',
	'By default, this search engine looks for all words in any order. To search for an exact phrase, enclose the phrase in quotes:' => 'Die Suchfunktion sucht nach allen angebenen Begriffen in beliebiger Reihenfolge. Um nach einem exakten Ausdruck zu suchen, setzen Sie diesen bitte in Anf√ºhrungszeichen:',
	'movable type' => 'Melody',
	'The search engine also supports AND, OR, and NOT keywords to specify boolean expressions:' => 'Die boolschen Operatoren AND, OR und NOT werden unterst√ºtzt:',
	'personal OR publishing' => 'Schrank OR Schublade',
	'publishing NOT personal' => 'Regal NOT Schrank',

## default_templates/current_category_monthly_archive_list.mtml
	'[_1]' => '[_1]',

## default_templates/date_based_category_archives.mtml
	'Category Yearly Archives' => 'J√§hrliche Kategoriearchive',
	'Category Monthly Archives' => 'Monatliche Kategoriearchive',
	'Category Weekly Archives' => 'W√∂chentliche Kategoriearchive',
	'Category Daily Archives' => 'T√§gliche Kategoriearchive',

## default_templates/recent_comments.mtml
	'<strong>[_1]:</strong> [_2] <a href="[_3]" title="full comment on: [_4]">read more</a>' => '<strong>[_1]:</strong> [_2] <a href="[_3]" title="Vollst√§ndiger Kommentar zu: [_4]">weiter lesen</a>',

## default_templates/dynamic_error.mtml
	'Page Not Found' => 'Seite nicht gefunden',

## default_templates/technorati_search.mtml
	'Technorati' => 'Technorati',
	'<a href=\'http://www.technorati.com/\'>Technorati</a> search' => '<a href=\'http://www.technorati.com/\'>Technorati</a>-Suche',
	'this blog' => 'in diesem Blog',
	'all blogs' => 'in allen Blogs',
	'Blogs that link here' => 'Blogs, die Links auf diese Seite enthalte',

## default_templates/monthly_archive_list.mtml
	'[_1] <a href="[_2]">Archives</a>' => '<a href="[_2]">[_1]</a>',

## default_templates/category_entry_listing.mtml
	'[_1] Archives' => '[_1] Archive',
	'Recently in <em>[_1]</em> Category' => 'Neues in der Kategorie <em>[_1]</em>',
	'Main Index' => '√úbersicht',

## default_templates/comment_throttle.mtml
	'If this was a mistake, you can unblock the IP address and allow the visitor to add it again by logging in to your Melody installation, going to Blog Config - IP Banning, and deleting the IP address [_1] from the list of banned addresses.' => 'Sie k√∂nnen die Sperrung dieser Adresse aufheben, indem Sie den Eintrag [_1] aus der Sperrliste unter Konfigurieren > Blog > IP-Sperren entfernen.',
	'A visitor to your blog [_1] has automatically been banned by adding more than the allowed number of comments in the last [_2] seconds.' => 'Die IP-Adrese eines Besuchers Ihres Weblogs [_1] wurde automatisch gesperrt, da er in den letzten [_2] Sekunden mehr Kommentare als zul√§ssig zu ver√∂ffentlichen versucht hat.',
	'This has been done to prevent a malicious script from overwhelming your weblog with comments. The banned IP address is' => 'Dadurch wird verhindert, da√ü bos√§rtige Skripte Ihr Blog mit Spam-Kommentaren fluten k√∂nnen. Die gesperrte IP-Adresse lautet',

## default_templates/signin.mtml
	'Sign In' => 'Anmelden',
	'You are signed in as ' => 'Sie sind angemeldet als ',
	'sign out' => 'abmelden',
	'You do not have permission to sign in to this blog.' => 'Sie haben keine Berechtigung zur Anmeldung an diesem Blog.',

## default_templates/new-comment.mtml
	'An unapproved comment has been posted on your blog [_1], for entry #[_2] ([_3]). You need to approve this comment before it will appear on your site.' => 'In Ihrem Weblog [_1] ist ein noch nicht freigeschalteter Kommentar zum Eintrag "[_3]" (#[_2]) eingegangen. Schalten Sie den Kommentar frei, damit er auf Ihrem Weblog erscheint.',
	'A new comment has been posted on your blog [_1], on entry #[_2] ([_3]).' => 'In Ihrem Weblog [_1] ist ein neuer Kommentar zum Eintrag "[_3]" (#[_2]) eingegangen:',
	'Commenter name: [_1]' => 'Name des Kommentarautors: [_1]',
	'Commenter email address: [_1]' => 'E-Mail-Adresse des Kommentarautors: [_1]',
	'Commenter URL: [_1]' => 'Web-Adresse (URL) des Kommentarautors: [_1]',
	'Commenter IP address: [_1]' => 'IP-Adresse des Kommentarautors: [_1]',
	'Approve comment:' => 'Kommentar freischalten:',
	'View comment:' => 'Kommentar ansehen:',
	'Edit comment:' => 'Kommentar bearbeiten:',
	'Report comment as spam:' => 'Kommentar als Spam melden:',

## default_templates/pages_list.mtml
	'Pages' => 'Seiten',

## default_templates/creative_commons.mtml

## default_templates/about_this_page.mtml
	'About this Entry' => '√úber diese Seite',
	'About this Archive' => '√úber dieses Archiv',
	'About Archives' => '√úber die Archive',
	'This page contains links to all the archived content.' => 'Diese Seite enth√§lt Links zu allen archivierten Eintr√§gen.',
	'This page contains a single entry by [_1] published on <em>[_2]</em>.' => 'Diese Seite enth√§lt einen einen einzelnen Eintrag von [_1] vom <em>[_2]</em>.',
	'<a href="[_1]">[_2]</a> was the previous entry in this blog.' => '<a href="[_1]">[_2]</a> ist der vorherige Eintrag in diesem Blog.',
	'<a href="[_1]">[_2]</a> is the next entry in this blog.' => '<a href="[_1]">[_2]</a> ist der n√§chste Eintrag in diesem Blog.',
	'This page is an archive of entries in the <strong>[_1]</strong> category from <strong>[_2]</strong>.' => 'Diese Archivseite enth√§lt alle Eintr√§ge der Kategorie <strong>[_1]</strong> aus <strong>[_2]</strong>.',
	'<a href="[_1]">[_2]</a> is the previous archive.' => '<a href="[_1]">[_2]</a> ist das vorherige Archiv.',
	'<a href="[_1]">[_2]</a> is the next archive.' => '<a href="[_1]">[_2]</a> ist das n√§chste Archiv.',
	'This page is an archive of recent entries in the <strong>[_1]</strong> category.' => 'Diese Seite enth√§lt aktuelle Eintr√§ge der Kategorie <strong>[_1]</strong>.',
	'<a href="[_1]">[_2]</a> is the previous category.' => '<a href="[_1]">[_2]</a> ist die vorherige Kategorie.',
	'<a href="[_1]">[_2]</a> is the next category.' => '<a href="[_1]">[_2]</a> ist die n√§chste Kategorie.',
	'This page is an archive of recent entries written by <strong>[_1]</strong> in <strong>[_2]</strong>.' => 'Diese Seite enth√§lt aktuelle Eintr√§ge von <strong>[_1]</strong> aus <strong>[_2]</strong>.',
	'This page is an archive of recent entries written by <strong>[_1]</strong>.' => 'Diese Seite enth√§lt aktuelle Eintr√§ge von <strong>[_1]</strong>.',
	'This page is an archive of entries from <strong>[_2]</strong> listed from newest to oldest.' => 'Diese Seite enth√§lt alle Eintr√§ge von <strong>[_1]</strong> von neu nach alt.',
	'Find recent content on the <a href="[_1]">main index</a>.' => 'Aktuelle Eintr√§ge finden Sie auf der <a href="[_1]">Startseite</a>.',
	'Find recent content on the <a href="[_1]">main index</a> or look in the <a href="[_2]">archives</a> to find all content.' => 'Aktuelle Eintr√§ge finden Sie auf der <a href="[_1]">Startseite</a>, alle Eintr√§ge in den <a href="[_2]">Archiven</a>.',

## default_templates/entry.mtml

## default_templates/recover-password.mtml
	'A request has been made to change your password in Melody. To complete this process click on the link below to select a new password.' => 'Es wurde eine Anfrage zur √Ñnderung Ihres Passwortes in Melody gestellt. Bitte klicken Sie auf untenstehenden Link und w√§hlen Sie ein neues Passwort aus um diesen Prozess abzuschlie√üen.',
	'If you did not request this change, you can safely ignore this email.' => 'Wenn Sie diese √Ñnderung nicht w√ºnschen k√∂nnen Sie diese E-Mail bedenkenlos ignorieren.',

## default_templates/javascript.mtml
	'moments ago' => 'vor einem Augenblick',
	'[quant,_1,hour,hours] ago' => 'vor [quant,_1,Stunde,Stunden]',
	'[quant,_1,minute,minutes] ago' => 'vor [quant,_1,Minute,Minuten]',
	'[quant,_1,day,days] ago' => 'vor [quant,_1,Tag,Tagen]',
	'Edit' => 'Bearbeiten',
	'Your session has expired. Please sign in again to comment.' => 'Ihre Sitzung ist abgelaufen. Bitte melden Sie sich erneut an.',
	'Signing in...' => 'Anmelden...',
	'You do not have permission to comment on this blog. ([_1]sign out[_2])' => 'Sie haben nicht die notwendige Berechtigung, um in diesem Blog Kommentare zu schreiben. ([_1]Abmelden[_2])',
	'Thanks for signing in, __NAME__. ([_1]sign out[_2])' => 'Danke f√ºr Ihre Anmeldung, __NAME__. ([_1]Abmelden[_2])',
	'[_1]Sign in[_2] to comment.' => '[_1]Anmelden[_2] um zu kommentieren',
	'[_1]Sign in[_2] to comment, or comment anonymously.' => '[_1]Anmelden[_2] um zu kommentieren oder anonym kommentieren',
	'Replying to <a href="[_1]" onclick="[_2]">comment from [_3]</a>' => 'Antwort auf den <a href="[_1]" onclick="[_2]">Kommentar von [_3]</a>',

## default_templates/author_archive_list.mtml
	'Authors' => 'Autoren',

## default_templates/archive_index.mtml
	'Author Archives' => 'Autorenarchive',

## default_templates/trackbacks.mtml
	'TrackBack URL: [_1]' => 'TrackBack-URL: [_1]',
	'<a href="[_1]">[_2]</a> from [_3] on <a href="[_4]">[_5]</a>' => '<a href="[_1]">[_2]</a> von [_3] zu <a href="[_4]">[_5]</a>',
	'[_1] <a href="[_2]">Read More</a>' => '[_1] <a href="[_2]">Mehr</a>',

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

## default_templates/recent_entries.mtml

## default_templates/sidebar.mtml
	'2-column layout - Sidebar' => '2-spaltiges Layout - Seitenleiste',
	'3-column layout - Primary Sidebar' => '3-spaltiges Layout - Prim√§r-Seitenleiste',
	'3-column layout - Secondary Sidebar' => '3-spaltiges Layout - Sekund√§r-Seitenleiste',

## default_templates/openid.mtml
	'[_1] accepted here' => 'Hier wird [_1] akzeptiert',
	'http://www.sixapart.com/labs/openid/' => 'http://www.sixapart.com/labs/openid/',
	'Learn more about OpenID' => 'Mehr √ºber OpenID erfahren',

## default_templates/powered_by.mtml
	'_MTCOM_URL' => 'http://www.movabletype.com/',

## default_templates/tag_cloud.mtml

## default_templates/commenter_confirm.mtml
	'Thank you registering for an account to comment on [_1].' => 'Danke, da√ü Sie sich zum Kommentieren von [_1] registriert haben.',
	'For your own security and to prevent fraud, we ask that you please confirm your account and email address before continuing. Once confirmed you will immediately be allowed to comment on [_1].' => 'Zu Ihrer eigenen Sicherheit und zur Vermeidung von Mi√übrauch best√§tigen Sie bitte Ihre Anmeldung und Ihre E-Mail-Adresse.',
	'To confirm your account, please click on or cut and paste the following URL into a web browser:' => 'Klicken Sie dazu auf folgenden Link (oder kopieren Sie Adresse und f√ºgen Sie sie in Adresszeile Ihres Web-Browsers ein):',
	'If you did not make this request, or you don\'t want to register for an account to comment on [_1], then no further action is required.' => 'Sollten Sie sich nicht angemeldet haben oder sollten Sie sich doch nicht registrieren wollen, brauchen Sie nichts weiter zu tun.',
	'Thank you very much for your understanding.' => 'Vielen Dank',
	'Sincerely,' => ' ',

## default_templates/recent_assets.mtml

## default_templates/monthly_entry_listing.mtml

);

1;
