# Copyright 2003-2008 Six Apart. This code cannot be redistributed without
# permission from www.sixapart.com.
#
# $Id:$

package MT::L10N::nl;
use strict;
use MT::L10N;
use MT::L10N::en_us;
use vars qw( @ISA %Lexicon );
@ISA = qw( MT::L10N::en_us );

## The following is the translation table.

%Lexicon = (

## php/lib/function.mtvar.php
	'You used a [_1] tag without a valid name attribute.' => 'U gebruikte een [_1] tag zonder geldig name attribuut',
	'\'[_1]\' is not a valid function for a hash.' => '\'[_1]\' is geen geldige functie voor een hash.',
	'\'[_1]\' is not a valid function for an array.' => '\'[_1]\' is geen geldige functie voor een array.',
	'[_1] [_2] [_3] is illegal.' => '[_1] [_2] [_3] is illegaal.',

## php/lib/archive_lib.php
	'Page' => 'Pagina',
	'Individual' => 'per bericht',
	'Yearly' => 'per jaar',
	'Monthly' => 'per maand',
	'Daily' => 'per dag',
	'Weekly' => 'per week',
	'Author' => 'Auteur',
	'(Display Name not set)' => '(Getoonde naam niet ingesteld)',
	'Author Yearly' => 'per auteur per jaar',
	'Author Monthly' => 'per auteur per maand',
	'Author Daily' => 'per auteur per dag',
	'Author Weekly' => 'per auteur per week',
	'Category Yearly' => 'per categorie per jaar',
	'Category Monthly' => 'per categorie per maand',
	'Category Daily' => 'per categorie per dag',
	'Category Weekly' => 'per categorie per week',

## php/lib/block.mtsethashvar.php

## php/lib/block.mtif.php

## php/lib/function.mtremotesigninlink.php
	'TypeKey authentication is not enabled in this blog.  MTRemoteSignInLink can\'t be used.' => 'TypeKey authenticatie is niet ingeschakeld op deze blog.  MTRemoteSignInLink kan niet worden gebruikt.',

## php/lib/block.mtauthorhaspage.php
	'No author available' => 'Geen auteur beschikbaar',

## php/lib/block.mtauthorhasentry.php

## php/lib/function.mtproductname.php
	'[_1] [_2]' => '[_1] [_2]',

## php/lib/captcha_lib.php
	'Captcha' => 'Captcha',
	'Type the characters you see in the picture above.' => 'Tik te tekens in die u ziet in de afbeelding hierboven.',

## php/lib/function.mtsetvar.php
	'\'[_1]\' is not a hash.' => '\'[_1]\' is geen hash.',
	'Invalid index.' => 'Ongeldige index.',
	'\'[_1]\' is not an array.' => '\'[_1]\' is geen array.',
	'\'[_1]\' is not a valid function.' => '\'[_1]\' is geen geldige functie.',

## php/lib/block.mtassets.php
	'sort_by="score" must be used in combination with namespace.' => 'sort_by="score" moet gebruikt worden in combinatie met een namespace.',

## php/lib/block.mtsetvarblock.php

## php/lib/block.mtentries.php

## php/lib/MTUtil.php
	'userpic-[_1]-%wx%h%x' => 'gebruikersafbeelding-[_1]-%wx%h%x',

## php/lib/function.mtauthordisplayname.php

## php/lib/function.mtentryclasslabel.php
	'page' => 'pagina',
	'entry' => 'bericht',
	'Entry' => 'Bericht',

## default_templates/notify-entry.mtml
	'A new [lc,_3] entitled \'[_1]\' has been published to [_2].' => 'Een [lc,_3] getiteld \'[_1]\' is gepubliceerd op [_2].',
	'View entry:' => 'Bekijk bericht:',
	'View page:' => 'Bekijk pagina:',
	'[_1] Title: [_2]' => '[_1] titel: [_2]',
	'Publish Date: [_1]' => 'Publicatiedatum: [_1]',
	'Message from Sender:' => 'Boodschap van afzender:',
	'You are receiving this email either because you have elected to receive notifications about new content on [_1], or the author of the post thought you would be interested. If you no longer wish to receive these emails, please contact the following person:' => 'U ontvangt dit bericht omdat u ofwel gekozen hebt om notificaties over nieuw inhoud op [_1] te ontvangen, of de auteur van het bericht dacht dat u misschien wel geïnteresseerd zou zijn.  Als u deze berichten niet langer wenst te ontvangen, gelieve deze persoon te contacteren:',

## default_templates/main_index.mtml
	'Header' => 'Hoofding',
	'Entry Summary' => 'Samenvatting bericht',
	'Archives' => 'Archieven',

## default_templates/page.mtml
	'Page Detail' => 'Pagina detail',
	'TrackBacks' => 'TrackBacks',
	'Comments' => 'Reacties',

## default_templates/entry_summary.mtml
	'Entry Metadata' => 'Metadata bericht',
	'Tags' => 'Tags',
	'Continue reading <a rel="bookmark" href="[_1]">[_2]</a>.' => '<a rel="bookmark" href="[_1]">[_2]</a> verder lezen.',

## default_templates/comment_response.mtml
	'Comment Submitted' => 'Reactie achtergelaten',
	'Confirmation...' => 'Bevestiging...',
	'Your comment has been submitted!' => 'Uw reactie werd ontvangen!',
	'Comment Pending' => 'Reactie wordt behandeld',
	'Thank you for commenting.' => 'Bedankt voor uw reactie.',
	'Your comment has been received and held for approval by the blog owner.' => 'Uw reactie is ontvangen en zal worden opgeslagen tot de eigenaar van deze weblog goedkeuring geeft voor publicatie.',
	'Comment Submission Error' => 'Fout bij indienen reactie',
	'Your comment submission failed for the following reasons:' => 'Het indienen van uw reactie mislukte omwille van volgende redenen:',
	'Return to the <a href="[_1]">original entry</a>.' => 'Ga terug naar het <a href="[_1]">oorspronkelijke bericht</a>.',

## default_templates/commenter_notify.mtml
	'This email is to notify you that a new user has successfully registered on the blog \'[_1]\'. Listed below you will find some useful information about this new user.' => 'Deze e-mail dient om u te melden dat een nieuwe gebruiker zich met succes registreerde op blog \'[_1]\'.  Hieronder leest u nuttige informatie over deze gebruiker.',
	'New User Information:' => 'Info nieuwe gebruiker:',
	'Username: [_1]' => 'Gebruikersnaam: [_1]',
	'Full Name: [_1]' => 'Volledige naam: [_1]',
	'Email: [_1]' => 'E-mail: [_1]',
	'To view or edit this user, please click on or cut and paste the following URL into a web browser:' => 'Om deze gebruiker te bekijken of te bewerken, klik op deze link of plak de URL in een webbrowser:',

## default_templates/footer-email.mtml
	'Powered by Movable Type [_1]' => 'Aangedreven door Movable Type [_1]',

## default_templates/entry_detail.mtml
	'Categories' => 'Categorieën',

## default_templates/verify-subscribe.mtml
	'Thanks for subscribing to notifications about updates to [_1]. Follow the link below to confirm your subscription:' => 'Bedankt om u in te schrijven voor notificaties over updates van [_1].  Volg onderstaande link om uw inschrijving te bevestigen:',
	'If the link is not clickable, just copy and paste it into your browser.' => 'Indien de link niet klikbaar is, kopiëer en plak hem dan gewoon in uw browser.',

## default_templates/new-ping.mtml
	'An unapproved TrackBack has been posted on your blog [_1], for entry #[_2] ([_3]). You need to approve this TrackBack before it will appear on your site.' => 'Er is een niet-gekeurde TrackBack binnengekomen op uw blog [_1], op bericht #[_2] ([_3]).  U moet deze TrackBack goedkeuren voor hij op uw site zal verschijnen.',
	'An unapproved TrackBack has been posted on your blog [_1], for category #[_2], ([_3]). You need to approve this TrackBack before it will appear on your site.' => 'Er is een niet-gekeurde TrackBack binnengekomen op uw blog [_1], op categorie #[_2] ([_3]).  U moet deze TrackBack goedkeuren voor hij op uw site zal verschijnen.',
	'A new TrackBack has been posted on your blog [_1], on entry #[_2] ([_3]).' => 'Een nieuw TrackBack is gepubliceerd op uw blog [_1], op bericht #[_2] ([_3]).',
	'A new TrackBack has been posted on your blog [_1], on category #[_2] ([_3]).' => 'Een nieuw TrackBack is gepubliceerd op uw blog [_1], op categorie #[_2] ([_3]).',
	'Excerpt' => 'Uittreksel',
	'URL' => 'URL',
	'Title' => 'Titel',
	'Blog' => 'Blog',
	'IP address' => 'IP adres',
	'Approve TrackBack' => 'TrackBack goedkeuren',
	'View TrackBack' => 'TrackBack bekijken',
	'Report TrackBack as spam' => 'TrackBack melden als spam',
	'Edit TrackBack' => 'TrackBack bewerken',

## default_templates/comment_detail.mtml
	'[_1] [_2] said:' => '[_1] [_2] zei:',
	'<a href="[_1]" title="Permalink to this comment">[_2]</a>' => '<a href="[_1]" title="Permalink naar deze reactie">[_2]</a>',

## default_templates/comment_form.mtml
	'Leave a comment' => 'Laat een reactie achter',
	'Name' => 'Naam',
	'Email Address' => 'E-mailadres',
	'Remember personal info?' => 'Persoonijke gegevens onthouden?',
	'(You may use HTML tags for style)' => '(u kunt HTML tags gebruiken voor de lay-out)',
	'Preview' => 'Voorbeeld',
	'Submit' => 'Invoeren',
	'Cancel' => 'Annuleren',

## default_templates/comment_throttle.mtml
	'If this was a mistake, you can unblock the IP address and allow the visitor to add it again by logging in to your Movable Type installation, going to Blog Config - IP Banning, and deleting the IP address [_1] from the list of banned addresses.' => 'Indien dit een vergissing was, kunt hu het IP adres deblokkeren en de bezoeker toestaan om het opnieuw toe te voegen door u aan te melden op uw Movable Type installatie, dan naar Blog Config te gaan en het IP adres [_1] te verwijderen uit de lijst van verbannen adressen.',
	'A visitor to your blog [_1] has automatically been banned by adding more than the allowed number of comments in the last [_2] seconds.' => 'Een bezoeker van uw weblog [_1] is automatisch uitgesloten omdat dez meer dan het toegestane aantal reacties heeft gepubliceerd in de laatste [_2] seconden.',
	'This has been done to prevent a malicious script from overwhelming your weblog with comments. The banned IP address is' => 'Dit wordt gedaan om te voorkomen dat kwaadwillige scripts uw weblog met reacties overstelpen. Het uitgesloten IP-adres is',

## default_templates/new-comment.mtml
	'An unapproved comment has been posted on your blog [_1], for entry #[_2] ([_3]). You need to approve this comment before it will appear on your site.' => 'Een niet gekeurde reactie is binnengekomen op uw weblog [_1], op bericht #[_2] ([_3]). U moet deze reactie eerst goedkeuren voor ze op uw site verschijnt.',
	'A new comment has been posted on your blog [_1], on entry #[_2] ([_3]).' => 'Een nieuwe reactie is gepubliceerd op uw blog [_1], op bericht #[_2] ([_3]).',
	'Commenter name: [_1]' => 'Naam reageerder: [_1]',
	'Commenter email address: [_1]' => 'E-mail adres reageerder: [_1]',
	'Commenter URL: [_1]' => 'URL reageerder: [_1]',
	'Commenter IP address: [_1]' => 'IP adres reageerder: [_1]',
	'Approve comment:' => 'Reactie goedkeuren',
	'View comment:' => 'Reactie bekijken:',
	'Edit comment:' => 'Reactie bewerken:',
	'Report comment as spam:' => 'Reactie als spam rapporteren:',

## default_templates/entry_listing.mtml
	'[_1] Archives' => 'Archieven van [_1]',
	'Recently in <em>[_1]</em> Category' => 'Recent in de categorie <em>[_1]</em>',
	'Recently by <em>[_1]</em>' => 'Recent door <em>[_1]</em>',
	'Main Index' => 'Hoofdindex',

## default_templates/footer.mtml
	'Sidebar' => 'Zijkolom',
	'_POWERED_BY' => 'Aangedreven  door<br /><a href=\"http://www.sixapart.com/movabletype/\"><$MTProductName$></a>',
	'This blog is licensed under a <a href="[_1]">Creative Commons License</a>.' => 'Deze weblog valt onder een <a href="[_1]">Creative Commons Licentie</a>.',

## default_templates/tags.mtml

## default_templates/entry_metadata.mtml
	'By [_1] on [_2]' => 'Door [_1] op [_2]',
	'Permalink' => 'Permalink',
	'Comments ([_1])' => 'Reacties ([_1])',
	'TrackBacks ([_1])' => 'TrackBacks ([_1])',

## default_templates/entry.mtml
	'Entry Detail' => 'Berichtdetails',

## default_templates/recover-password.mtml
	'_USAGE_FORGOT_PASSWORD_1' => 'U hebt een nieuw Movable Type-wachtwoord aangevraagd. Uw wachtwoord is in het systeem gewijzigd; hier is het nieuwe wachtwoord:',
	'_USAGE_FORGOT_PASSWORD_2' => 'Met dit nieuwe wachtwoord moet u zich op Movable Type kunnen aanmelden. Zodra u zich hebt aangemeld, kunt u uw wachtwoord veranderen in iets dat u makkelijker kunt onthouden.',
	'Mail Footer' => 'Footer voor e-mail',

## default_templates/javascript.mtml
	'Thanks for signing in,' => 'Bedankt om u aan te melden,',
	'. Now you can comment.' => '. U kunt hieronder reageren.',
	'sign out' => 'afmelden',
	'You do not have permission to comment on this blog.' => 'U heeft geen toestemming om reacties achter te laten op deze weblog',
	'Sign in' => 'Aanmelden',
	' to comment on this entry.' => ' om te reageren op dit bericht.',
	' to comment on this entry,' => ' om te reageren op dit bericht,',
	'or ' => 'of ',
	'comment anonymously.' => 'reageer anoniem',

## default_templates/rss.mtml
	'Copyright [_1]' => 'Copyright [_1]',

## default_templates/archive_index.mtml
	'Monthly Archives' => 'Archief per maand',
	'Author Archives' => 'Archief per auteur',
	'Category Monthly Archives' => 'Archief per categorie per maand',
	'Author Monthly Archives' => 'Archief per auteur per maand',

## default_templates/trackbacks.mtml
	'[_1] TrackBacks' => '[_1] TrackBacks',
	'Listed below are links to blogs that reference this entry: <a href="[_1]">[_2]</a>.' => 'Hieronder ziet u links naar blogs die verwijzen naar het bericht: <a href="[_1]">[_2]</a>.',
	'TrackBack URL for this entry: <span id="trackbacks-link">[_1]</span>' => 'TrackBack URL voor dit bericht: <span id="trackbacks-link">[_1]</span>',
	'&raquo; <a href="[_1]">[_2]</a> from [_3]' => '&raquo; <a href="[_1]">[_2]</a> van [_3]',
	'[_1] <a href="[_2]">Read More</a>' => '[_1] <a href="[_2]">Meer lezen</a>',
	'Tracked on <a href="[_1]">[_2]</a>' => 'Getracked op <a href="[_1]">[_2]</a>',

## default_templates/sidebar.mtml
	'2-column layout - Sidebar' => 'layout twee kolommen - Zijkolom',
	'3-column layout - Primary Sidebar' => 'layout drie kolommen - Primaire zijkolom',
	'3-column layout - Secondary Sidebar' => 'layout drie kolommen - Secundaire zijkolom',

## default_templates/categories.mtml

## default_templates/comments.mtml
	'Comment Form' => 'Reactieformulier',
	'[_1] Comments' => '[_1] reacties',
	'Comment Detail' => 'Details reactie',

## default_templates/search_results.mtml
	'Search Results' => 'Zoekresultaten',
	'Results matching &ldquo;[_1]&rdquo; from [_2]' => 'Resultaten die overeenkomen met &ldquo;[_1]&rdquo; uit [_2]',
	'Results tagged &ldquo;[_1]&rdquo; from [_2]' => 'Resultaten getagd als &ldquo;[_1]&rdquo; uit [_2]',
	'Results matching &ldquo;[_1]&rdquo;' => 'Resultaten die overeenkomen met &ldquo;[_1]&rdquo;',
	'Results tagged &ldquo;[_1]&rdquo;' => 'Resultaten getagd als &ldquo;[_1]&rdquo;',
	'No results found for &ldquo;[_1]&rdquo;.' => 'Geen resultaten gevonden met &ldquo;[_1]&rdquo;',
	'Instructions' => 'Gebruiksaanwijzing',
	'By default, this search engine looks for all words in any order. To search for an exact phrase, enclose the phrase in quotes:' => 'Standaard zoekt deze zoekmachine naar alle woorden in eender welke volgorde.  Om een exacte uitdrukking te zoeken, gelieve aanhalingstekens rond uw zoekopdracht te zetten.',
	'movable type' => 'movable type',
	'The search engine also supports AND, OR, and NOT keywords to specify boolean expressions:' => 'De zoekfunctie ondersteunt eveneens de sleutelwoorden AND, OR en NOT om booleaanse expressies mee op te stellen:',
	'personal OR publishing' => 'persoonlijk OR publicatie',
	'publishing NOT personal' => 'publiceren NOT persoonlijk',

## default_templates/sidebar_2col.mtml
	'Search' => 'Zoek',
	'Case sensitive' => 'Hoofdlettergevoelig',
	'Regex search' => 'Zoeken met reguliere expressies',
	'[_1] ([_2])' => '[_1] ([_2])',
	'About this Entry' => 'Over dit bericht',
	'About this Archive' => 'Over dit archief',
	'About Archives' => 'Over archieven',
	'This page contains links to all the archived content.' => 'Deze pagina bevat links naar alle gearchiveerde inhoud.',
	'This page contains a single entry by [_1] published on <em>[_2]</em>.' => 'Deze pagina bevat één bericht door [_1] gepubliceerd op <em>[_2]</em>.',
	'<a href="[_1]">[_2]</a> was the previous entry in this blog.' => '<a href="[_1]">[_2]</a> was het vorige bericht op deze weblog.',
	'<a href="[_1]">[_2]</a> is the next entry in this blog.' => '<a href="[_1]">[_2]</a> is het volgende bericht op deze weblog.',
	'This page is a archive of entries in the <strong>[_1]</strong> category from <strong>[_2]</strong>.' => 'Deze pagina is een archief met berichten in de categorie <strong>[_1]</strong> op <strong>[_2]</strong>.',
	'<a href="[_1]">[_2]</a> is the previous archive.' => '<a href="[_1]">[_2]</a> is het vorige archief.',
	'<a href="[_1]">[_2]</a> is the next archive.' => '<a href="[_1]">[_2]</a> is het volgende archief.',
	'This page is a archive of recent entries in the <strong>[_1]</strong> category.' => 'Deze pagina is een archief van recente berichten in de categorie <strong>[_1]</strong>.',
	'<a href="[_1]">[_2]</a> is the previous category.' => '<a href="[_1]">[_2]</a> is de vorige categorie.',
	'<a href="[_1]">[_2]</a> is the next category.' => '<a href="[_1]">[_2]</a> is de volgende categorie.',
	'This page is a archive of recent entries written by <strong>[_1]</strong> in <strong>[_2]</strong>.' => 'Deze pagina is een archief van recente berichten geschreven door <strong>[_1]</strong> op <strong>[_2]</strong>',
	'This page is a archive of recent entries written by <strong>[_1]</strong>.' => 'Deze pagina is een archief van recente berichten geschreven door <strong>[_1]</strong>.',
	'This page is an archive of entries from <strong>[_2]</strong> listed from newest to oldest.' => 'Deze pagina is een archief van berichten op <strong>[_2]</strong> gerangschikt van nieuw naar oud',
	'Find recent content on the <a href="[_1]">main index</a>.' => 'De nieuwste berichten zijn te vinden op de <a href="[_1]">hoofdpagina</a>.',
	'Find recent content on the <a href="[_1]">main index</a> or look in the <a href="[_2]">archives</a> to find all content.' => 'De nieuwste berichten zijn te vinden op de <a href="[_1]">hoofdpagina</a> of kijk in de <a href="[_2]">archieven</a> om alle berichten te zien.',
	'Recent Entries' => 'Recente berichten',
	'Photos' => 'Foto\'s',
	'Tag Cloud' => 'Tagwolk',
	'[_1] <a href="[_2]">Archives</a>' => '<a href="[_2]">Archieven</a> [_1]',
	'[_1]: Monthly Archives' => '[_1]: Maandelijkse archieven',
	'Subscribe to feed' => 'Inschrijven op feed',
	'Subscribe to this blog\'s feed' => 'Inschrijven op de feed van deze weblog',
	'Search results matching &ldquo;<$MTSearchString$>&rdquo;' => 'Zoekresultaten die overeen komen met &ldquo;<$MTSearchString$>&rdquo;',
	'_MTCOM_URL' => 'http://www.movabletype.com/',

## default_templates/sidebar_3col.mtml

## default_templates/dynamic_error.mtml
	'Page Not Found' => 'Pagina niet gevonden',

## default_templates/comment_preview.mtml
	'Comment on [_1]' => 'Reactie op [_1]',
	'Previewing your Comment' => 'U ziet een voorbeeld van uw reactie',

## default_templates/commenter_confirm.mtml
	'Thank you registering for an account to comment on [_1].' => 'Bedankt om een account aan te maken om te kunnen reageren op [_1].',
	'For your own security and to prevent fraud, we ask that you please confirm your account and email address before continuing. Once confirmed you will immediately be allowed to comment on [_1].' => 'Voor uw eigen veiligheid en om fraude te vermijden vragen we dat u deze account eerst bevestigt samen met uw e-mail adres.  Eens bevestigd kunt u meteen reageren op [_1].',
	'To confirm your account, please click on or cut and paste the following URL into a web browser:' => 'Om uw account te bevestigen moet u op deze link klikken of de URL in uw webbrowser plakken:',
	'If you did not make this request, or you don\'t want to register for an account to comment on [_1], then no further action is required.' => 'Als u deze account niet heeft aangevraagd, of als u niet de bedoeling had te registreren om te kunnen reageren op [_1] dan hoeft u verder niets te doen.',
	'Thank you very much for your understanding.' => 'Wij danken u voor uw begrip.',
	'Sincerely,' => 'Hoogachtend,',

## lib/MT/Asset/Video.pm
	'Video' => 'Video',
	'Videos' => 'Video\'s',
	'video' => 'video',

## lib/MT/Asset/Audio.pm
	'Audio' => 'Audio',
	'audio' => 'audio',

## lib/MT/Asset/Image.pm
	'Image' => 'Afbeelding',
	'Images' => 'Afbeeldingen',
	'Actual Dimensions' => 'Echte afmetingen',
	'[_1] x [_2] pixels' => '[_1] x [_2] pixels',
	'Error cropping image: [_1]' => 'Fout bij het bijsnijden van de afbeelding: [_1]',
	'Error scaling image: [_1]' => 'Fout bij het schalen van de afbeelding: [_1]',
	'Error converting image: [_1]' => 'Fout bij conversie afbeelding: [_1]',
	'Error creating thumbnail file: [_1]' => 'Fout bij het aanmaken van een thumbnail-bestand: [_1]',
	'%f-thumb-%wx%h%x' => '%f-thumb-%wx%h%x',
	'Can\'t load image #[_1]' => 'Kan afbeelding niet laden #[_1]',
	'View image' => 'Afbeelding bekijken',
	'Permission denied setting image defaults for blog #[_1]' => 'Permissie geweigerd om de standaardinstellingen voor afbeeldingen te wijzigen voor blog #[_1]',
	'Thumbnail image for [_1]' => 'Miniatuurweergave voor [_1]',
	'Invalid basename \'[_1]\'' => 'Ongeldige basisnaam \'[_1]\'',
	'Error writing to \'[_1]\': [_2]' => 'Fout bij schrijven naar \'[_1]\': [_2]',
	'Popup Page for [_1]' => 'Popup pagina voor [_1]',

## lib/MT/Util/Archive/Tgz.pm
	'Type must be tgz.' => 'Type moet tgz zijn.',
	'Could not read from filehandle.' => 'Kon filehandle niet lezen.',
	'File [_1] is not a tgz file.' => 'Bestand [_1] is geen tgz bestand.',
	'File [_1] exists; could not overwrite.' => 'Bestand [_1] bestaat; kon niet worden overschreven.',
	'Can\'t extract from the object' => 'Kan extractie uit object niet uitvoeren',
	'Can\'t write to the object' => 'Kan niet schrijven naar het object',
	'Both data and file name must be specified.' => 'Zowel data gen bestandsnaam moeten worden opgegeven.',

## lib/MT/Util/Archive/Zip.pm
	'Type must be zip' => 'Type moet zip zijn.',
	'File [_1] is not a zip file.' => 'Bestand [_1] is geen zip bestand.',

## lib/MT/Util/Archive.pm
	'Type must be specified' => 'Type moet worden opgegeven',
	'Registry could not be loaded' => 'Registry kon niet worden geladen',

## lib/MT/Util/Captcha.pm
	'Movable Type default CAPTCHA provider requires Image::Magick.' => 'Standaard CAPTCHA provider van Movable Type vereist Image::Magick.',
	'You need to configure CaptchaSourceImageBase.' => 'U moet CaptchaSourceImageBase nog configureren.',
	'Image creation failed.' => 'Afbeelding aanmaken mislukt.',
	'Image error: [_1]' => 'Afbeelding fout: [_1]',

## lib/MT/Plugin/JunkFilter.pm
	'[_1]: [_2][_3] from rule [_4][_5]' => '[_1]: [_2][_3] vanwege regel [_4][_5]',
	'[_1]: [_2][_3] from test [_4]' => '[_1]: [_2][_3] vanwege test [_4]',

## lib/MT/Auth/TypeKey.pm
	'Sign in requires a secure signature.' => 'Aanmelden vereist een beveiligde handtekening.',
	'The sign-in validation failed.' => 'Validatie van het aanmelden mislukt.',
	'This weblog requires commenters to pass an email address. If you\'d like to do so you may log in again, and give the authentication service permission to pass your email address.' => 'Deze weblog vereist dat reageerders een e-mail adres opgeven.  Als u dat wenst kunt u zich opnieuw aanmelden en de authenticatiedienst toestemming verlenen om uw e-mail adres door te geven.',
	'Couldn\'t save the session' => 'Kon de sessie niet opslaan',
	'This blog requires commenters to provide an email address' => 'Deze blog vereist een e-mail adres van reageerders',
	'Couldn\'t get public key from url provided' => 'Kon geen publieke sleutel vinden via de opgegeven url',
	'No public key could be found to validate registration.' => 'Er kon geen publieke sleutel gevonden worden om de registratie te valideren.',
	'TypeKey signature verif\'n returned [_1] in [_2] seconds verifying [_3] with [_4]' => 'TypeKey signatuurverificatie gaf [_1] terug in [_2] seconden bij het verifiëren van [_3] met [_4]',
	'The TypeKey signature is out of date ([_1] seconds old). Ensure that your server\'s clock is correct' => 'De TypeKey signatuur is vervallen ([_1] seconden oud). Controleer of de klok van uw server juist staat',

## lib/MT/Auth/OpenID.pm
	'Invalid request.' => 'Ongeldig verzoek.',
	'The address entered does not appear to be an OpenID' => 'Het ingevulde adres lijkt geen OpenID te zijn',
	'The text entered does not appear to be a web address' => 'De ingevulde tekst lijkt geen webadres te zijn',
	'Unable to connect to [_1]: [_2]' => 'Verbinden met [_1] mislukt: [_2]',
	'Could not verify the OpenID provided: [_1]' => 'Kon de OpenID provider niet verifiëren: [_1]',

## lib/MT/Auth/MT.pm
	'Passwords do not match.' => 'Wachtwoorden komen niet overeen.',
	'Failed to verify current password.' => 'Verificatie huidig wachtwoord mislukt.',
	'Password hint is required.' => 'Wachtwoordhint is vereist.',

## lib/MT/TheSchwartz/Error.pm
	'Job Error' => 'Jobfout',

## lib/MT/TheSchwartz/FuncMap.pm
	'Job Function' => 'Jobfunctie',

## lib/MT/TheSchwartz/Job.pm
	'Job' => 'Job',

## lib/MT/TheSchwartz/ExitStatus.pm
	'Job Exit Status' => 'Job exitstatus',

## lib/MT/ObjectDriver/Driver/DBD/SQLite.pm
	'Can\'t open \'[_1]\': [_2]' => 'Kan \'[_1]\' niet openen: [_2]',

## lib/MT/Compat/v3.pm
	'uses: [_1], should use: [_2]' => 'gebruikt: [_1], zou moeten gebruiken: [_2]',
	'uses [_1]' => 'gebruikt [_1]',
	'No executable code' => 'Geen uitvoerbare code',
	'Publish-option name must not contain special characters' => 'Naam voor publicatie-optie mag geen speciale karakters bevatten',

## lib/MT/FileMgr/FTP.pm
	'Creating path \'[_1]\' failed: [_2]' => 'Aanmaken van pad \'[_1]\' mislukt: [_2]',
	'Renaming \'[_1]\' to \'[_2]\' failed: [_3]' => 'Herbenoemen van \'[_1]\' naar \'[_2]\' mislukt: [_3]',
	'Deleting \'[_1]\' failed: [_2]' => 'Verwijderen van \'[_1]\' mislukt: [_2]',

## lib/MT/FileMgr/DAV.pm
	'DAV connection failed: [_1]' => 'DAV verbinding mislukt: [_1]',
	'DAV open failed: [_1]' => 'DAV open mislukt: [_1]',
	'DAV get failed: [_1]' => 'DAV get mislukt: [_1]',
	'DAV put failed: [_1]' => 'DAV put mislukt: [_1]',

## lib/MT/FileMgr/Local.pm
	'Opening local file \'[_1]\' failed: [_2]' => 'Lokaal bestand \'[_1]\' openen mislukt: [_2]',

## lib/MT/FileMgr/SFTP.pm
	'SFTP connection failed: [_1]' => 'SFTP verbinding mislukt: [_1]',
	'SFTP get failed: [_1]' => 'SFTP get mislukt: [_1]',
	'SFTP put failed: [_1]' => 'SFTP put mislukt: [_1]',

## lib/MT/BackupRestore/ManifestFileHandler.pm
	'Uploaded file was not a valid Movable Type backup manifest file.' => 'Het opgeladen bestand was geen geldig Movable Type backup manifest bestand.',

## lib/MT/BackupRestore/BackupFileHandler.pm
	'Uploaded file was backed up from Movable Type with the newer schema version ([_1]) than the one in this system ([_2]).  It is not safe to restore the file to this version of Movable Type.' => 'Het opgeladen bestand werd gebackupt vanuit Movable Type met een nieuwere schemaversie ([_1]) dan die van dit systeem ([_2]).  Het is niet veilig dit bestand terug te zetten op deze versie van Movable Type.',
	'[_1] is not a subject to be restored by Movable Type.' => '[_1] is geen item dat door Movable Type teruggezet moet worden.',
	'[_1] records restored.' => '[_1] records teruggezet.',
	'Restoring [_1] records:' => '[_1] records aan het terugzetten:',
	'User with the same name as the name of the currently logged in ([_1]) found.  Skipped the record.' => 'Gebruiker met dezelfde naam gevonden als die van de momenteel ingelogde ([_1]).  Record overgeslagen.',
	'User with the same name \'[_1]\' found (ID:[_2]).  Restore replaced this user with the data backed up.' => 'Een gebruiker met dezelfde naam \'[_1]\' werd gevonden (ID:[_2]).  Restore verving deze gebruiker door de data uit de backup.',
	'Tag \'[_1]\' exists in the system.' => 'Tag \'[_1]\' bestaat in het systeem.',
	'[_1] records restored...' => '[_1] records teruggezet...',

## lib/MT/Template/Context.pm
	'The attribute exclude_blogs cannot take \'all\' for a value.' => 'Het attribuut exclude_blogs kan niet \'all\' hebben als waarde.',

## lib/MT/Template/ContextHandlers.pm
	'Remove this widget' => 'Verwijder dit widget',
	'[_1]Publish[_2] your site to see these changes take effect.' => '[_1]Publiceer[_2] uw site om deze wijzigingen zichtbaar te maken.',
	'Actions' => 'Acties',
	'Warning' => 'Waarschuwing',
	'http://www.movabletype.org/documentation/appendices/tags/%t.html' => 'http://www.movabletype.org/documentation/appendices/tags/%t.html',
	'No [_1] could be found.' => '[_1] werden niet gevonden',
	'Invalid tag [_1] specified.' => 'Ongeldige tag [_1] opgegeven.',
	'Recursion attempt on [_1]: [_2]' => 'Recursiepoging op [_1]: [_2]',
	'Can\'t find included template [_1] \'[_2]\'' => 'Kan geincludeerd sjabloon niet vinden: [_1] \'[_2]\'',
	'Can\'t find blog for id \'[_1]' => 'Kan geen blog vinden met id \'[_1]',
	'Can\'t find included file \'[_1]\'' => 'Kan geïncludeerd bestand \'[_1]\' niet vinden',
	'Error opening included file \'[_1]\': [_2]' => 'Fout bij het openen van geïncludeerd bestand \'[_1]\': [_2]',
	'Recursion attempt on file: [_1]' => 'Recursiepoging op bestand: [_1]',
	'Unspecified archive template' => 'Niet gespecifiëerd archiefsjabloon',
	'Error in file template: [_1]' => 'Fout in bestandssjabloon: [_1]',
	'Can\'t load template' => 'Kan sjabloon niet laden',
	'Can\'t find template \'[_1]\'' => 'Kan sjabloon \'[_1]\' niet vinden',
	'Can\'t find entry \'[_1]\'' => 'Kan bericht \'[_1]\' niet vinden',
	'[_1] is not a hash.' => '[_1] is geen hash.',
	'You used an \'[_1]\' tag outside of the context of a author; perhaps you mistakenly placed it outside of an \'MTAuthors\' container?' => 'U gebruikten een \'[_1]\' tag buiten de context van een auteur; misschien plaatste u de tag per ongeluk buiten een \'MTAuthors\' container?',
	'You have an error in your \'[_2]\' attribute: [_1]' => 'Er staat een fout in uw \'[_2]\' attribuut: [_1]',
	'You have an error in your \'tag\' attribute: [_1]' => 'Er zit een fout in uw \'tag\' attribuut: [_1]',
	'No such user \'[_1]\'' => 'Geen gebruiker \'[_1]\'',
	'You used an \'[_1]\' tag outside of the context of an entry; perhaps you mistakenly placed it outside of an \'MTEntries\' container?' => 'U gebruikte een \'[_1]\' tag buiten de context van een bericht; misschien plaatste u die tag per ongeluk buiten een \'MTEntries\' container?',
	'You used <$MTEntryFlag$> without a flag.' => 'U gebruikte <$MTEntryFlag$> zonder een vlag.',
	'You used an [_1] tag for linking into \'[_2]\' archives, but that archive type is not published.' => 'U gebruikte een [_1] tag om te linken naar \'[_2]\' archieven, maar dat type archieven wordt niet gepubliceerd.',
	'Could not create atom id for entry [_1]' => 'Kon geen atom id aanmaken voor bericht [_1]',
	'To enable comment registration, you need to add a TypeKey token in your weblog config or user profile.' => 'Om registratie van reacties in te schakelen, moet u een TypeKey token toevoegen in de configuratie van uw weblog of in uw gebruikersprofiel.',
	'The MTCommentFields tag is no longer available; please include the [_1] template module instead.' => 'De MTCommentFields tag is niet meer beschikbaar; gelieve de [_1] sjabloonmodule te includeren ter vervanging.',
	'You used an [_1] tag without a date context set up.' => 'U gebruikte een [_1] tag zonder dat er een datumcontext ingesteld was.',
	'You used an \'[_1]\' tag outside of the context of a comment; perhaps you mistakenly placed it outside of an \'MTComments\' container?' => 'U gebruikte een \'[_1]\' tag buiten de context van een reactie; misschien plaatste u die tag per ongeluik buiten een \'MTComments\' container?',
	'[_1] can be used only with Daily, Weekly, or Monthly archives.' => '[_1] kan enkel worden gebruikt met dagelijkse, wekelijkse of maandelijkse archieven.',
	'Group iterator failed.' => 'Group iterator mislukt.',
	'You used an [_1] tag outside of the proper context.' => 'U gebruikte een [_1] tag buiten de juiste context.',
	'Could not determine entry' => 'Kon bericht niet bepalen',
	'Invalid month format: must be YYYYMM' => 'Ongeldig maandformaat: moet JJJJMM zijn',
	'No such category \'[_1]\'' => 'Geen categorie \'[_1]\'',
	'[_1] cannot be used without publishing Category archive.' => '[_1] kan niet gebruikt worden zonder dat er archieven per categorie worden gepubliceerd.',
	'<\$MTCategoryTrackbackLink\$> must be used in the context of a category, or with the \'category\' attribute to the tag.' => '<\$MTCategoryTrackbackLink\$> moet gebruikt worden in een categorie, of met het \'category\' attribuute van de tag.',
	'You failed to specify the label attribute for the [_1] tag.' => 'U gaf geen label attribuut op voor de [_1] tag.',
	'You used an \'[_1]\' tag outside of the context of a ping; perhaps you mistakenly placed it outside of an \'MTPings\' container?' => 'U gebruikte een \'[_1]\' tag buiten de context van een ping;  mogelijk plaatste u die per ongeluk buiten een \'MTPings\' container?',
	'[_1] used outside of [_2]' => '[_1] gebruikt buiten [_2]',
	'MT[_1] must be used in a [_2] context' => 'MT[_1] moet gebruikt worden in een [_2] context',
	'Cannot find package [_1]: [_2]' => 'Kan package [_1] niet vinden: [_2]',
	'Error sorting [_2]: [_1]' => 'Fout bij sorteren [_2]: [_1]',
	'Edit' => 'Bewerken',
	'You used an \'[_1]\' tag outside of the context of an asset; perhaps you mistakenly placed it outside of an \'MTAssets\' container?' => 'U gebruikte een \'[_1]\' tag buiten de context van een mediabestand; misschien plaatste u dit per ongeluk buiten een \'MTAssets\' container?',
	'You used an \'[_1]\' tag outside of the context of an page; perhaps you mistakenly placed it outside of an \'MTPages\' container?' => 'U gebruikte een \'[_1]\' tag buiten de context van een pagina; misschien plaatste u dit per ongeluk buiten een \'MTPages\' container?',
	'You used an [_1] without a author context set up.' => 'U gebruikte een [_1] zonder een auteurscontext op te zetten.',
	'Can\'t load user.' => 'Kan gebruiker niet laden.',
	'Division by zero.' => 'Deling door nul.',

## lib/MT/App/NotifyList.pm
	'Please enter a valid email address.' => 'Gelieve een geldig e-mail adres op te geven.',
	'Missing required parameter: blog_id. Please consult the user manual to configure notifications.' => 'Ontbrekende parameter: blog_id. Gelieve de handleiding te raadplegen om waarschuwingen te configureren.',
	'An invalid redirect parameter was provided. The weblog owner needs to specify a path that matches with the domain of the weblog.' => 'Er werd een ongeldige redirect parameter opgegeven. De eigenaar van de weblog moet een pad opgeven dat overeenkomt met het domein van de weblog.',
	'The email address \'[_1]\' is already in the notification list for this weblog.' => 'Het e-mail adres \'[_1]\' zit reeds in de notificatielijst voor deze weblog.',
	'Please verify your email to subscribe' => 'Gelieve uw e-mail adres te verifiëren voor inschrijving',
	'_NOTIFY_REQUIRE_CONFIRMATION' => 'Er is een e-mail verstuurd naar [_1].  Om uw inschrijving te voltooien, \n    gelieve de link te volgen die in die e-mail staat.  Dit om te bevestigen dat\n    het opgegeven e-mail adres correct is en aan u toebehoort.',
	'The address [_1] was not subscribed.' => 'Het adres [_1] werd niet ingeschreven.',
	'The address [_1] has been unsubscribed.' => 'Het adres [_1] werd uitgeschreven.',

## lib/MT/App/Comments.pm
	'Error assigning commenting rights to user \'[_1] (ID: [_2])\' for weblog \'[_3] (ID: [_4])\'. No suitable commenting role was found.' => 'Fout bij het toekennen van reactierechten aan gebruiker \'[_1] (ID: [_2])\' op weblog \'[_3] (ID: [_4])\'.  Er werd geen geschikte reageerder-rol gevonden.',
	'Invalid commenter login attempt from [_1] to blog [_2](ID: [_3]) which does not allow Movable Type native authentication.' => 'Ongeldige aanmeldpoging van een reageerder [_1] op blog [_2](ID: [_3]) waar geenMovable Type native authenticatie is toegelaten.',
	'Invalid login.' => 'Ongeldige gebruikersnaam.',
	'Invalid login' => 'Ongeldige gebruikersnaam',
	'Successfully authenticated but signing up is not allowed.  Please contact system administrator.' => 'Authenticatie is geslaagd, maar nieuwe registraties zijn niet toegestaan.  Neem contact op met de systeembeheerder.',
	'You need to sign up first.' => 'U moet zich eerst registreren',
	'Permission denied.' => 'Toestemming geweigerd.',
	'Login failed: permission denied for user \'[_1]\'' => 'Aanmelden mislukt: permissie geweigerd aan gebruiker \'[_1]\'',
	'Login failed: password was wrong for user \'[_1]\'' => 'Aanmelden mislukt: fout in wachtwoord van gebruiker \'[_1]\'',
	'Failed login attempt by disabled user \'[_1]\'' => 'Mislukte poging tot aanmelden door uitgeschakelde gebruiker \'[_1]\'',
	'Failed login attempt by unknown user \'[_1]\'' => 'Mislukte poging tot aanmelden door onbekende gebruiker \'[_1]\'',
	'Signing up is not allowed.' => 'Registreren is niet toegestaan.',
	'Movable Type Account Confirmation' => 'Movable Type accountbevestiging',
	'System Email Address is not configured.' => 'Systeem e-mail adres is niet ingesteld.',
	'Commenter \'[_1]\' (ID:[_2]) has been successfully registered.' => 'Reageerder \'[_1]\' (ID:[_2]) heeft zich met succes geregistreerd.',
	'Thanks for the confirmation.  Please sign in to comment.' => 'Bedankt voor de bevestiging.  Gelieve u aan te melden om te reageren.',
	'[_1] registered to the blog \'[_2]\'' => '[_1] registreerde zich op blog \'[_2]\'',
	'No id' => 'Geen id',
	'No such comment' => 'Reactie niet gevonden',
	'IP [_1] banned because comment rate exceeded 8 comments in [_2] seconds.' => 'IP [_1] verbannen omdat aantal reacties hoger was dan 8 in [_2] seconden.',
	'IP Banned Due to Excessive Comments' => 'IP verbannen wegens excessief achterlaten van reacties',
	'Invalid request' => 'Ongeldig verzoek',
	'No entry_id' => 'Geen entry_id',
	'No such entry \'[_1]\'.' => 'Geen bericht \'[_1]\'.',
	'You are not allowed to add comments.' => 'U heeft geen toestemming om reacties toe te voegen.',
	'_THROTTLED_COMMENT' => 'U heeft in een korte periode te veel reacties achtergelaten.  Gelieve over enige tijd opnieuw te proberen.',
	'Comments are not allowed on this entry.' => 'Reacties op dit bericht zijn niet toegelaten.',
	'Comment text is required.' => 'Tekst van de reactie is verplicht.',
	'An error occurred: [_1]' => 'Er deed zich een probleem voor: [_1]',
	'Registration is required.' => 'Registratie is verplicht.',
	'Name and email address are required.' => 'Naam en e-mail adres zijn verplicht.',
	'Invalid email address \'[_1]\'' => 'Ongeldig e-mail adres \'[_1]\'',
	'Invalid URL \'[_1]\'' => 'Ongeldige URL \'[_1]\'',
	'Text entered was wrong.  Try again.' => 'De ingevoerde tekst was verkeerd.  Probeer opnieuw.',
	'Comment save failed with [_1]' => 'Opslaan van reactie mislukt met [_1]',
	'Comment on "[_1]" by [_2].' => 'Reactie op "[_1]" door [_2].',
	'Commenter save failed with [_1]' => 'Opslaan reageerder mislukt met [_1]',
	'Publish failed: [_1]' => 'Publicatie mislukt: [_1]',
	'Failed comment attempt by pending registrant \'[_1]\'' => 'Mislukte poging om een reactie achter te laten van op registratie wachtende gebruiker \'[_1]\'',
	'Registered User' => 'Geregistreerde gebruiker',
	'The sign-in attempt was not successful; please try again.' => 'Aanmeldingspoging mislukt; gelieve opnieuw te proberen.',
	'No entry was specified; perhaps there is a template problem?' => 'Geen bericht opgegeven; misschien is er een sjabloonprobleem?',
	'Somehow, the entry you tried to comment on does not exist' => 'Het bericht waar u een reactie op probeerde achter te laten, bestaat niet',
	'Invalid commenter ID' => 'Ongeldig reageerder-ID',
	'No entry ID provided' => 'Geen bericht-ID opgegeven',
	'Permission denied' => 'Permissie geweigerd',
	'All required fields must have valid values.' => 'Alle vereiste velden moeten geldige waarden bevatten.',
	'Email Address is invalid.' => 'E-mail adres is ongeldig.',
	'URL is invalid.' => 'URL is ongeldig.',
	'Commenter profile has successfully been updated.' => 'Reageerdersprofiel is met succes bijgewerkt.',
	'Commenter profile could not be updated: [_1]' => 'Reageerdersprofiel kon niet worden bijgewerkt: [_1]',

## lib/MT/App/Search.pm
	'You are currently performing a search. Please wait until your search is completed.' => 'U bent momenteel al een zoekactie aan het uitvoeren.  Gelieve te wachten tot uw zoekopdracht voltooid is.',
	'Search failed. Invalid pattern given: [_1]' => 'Zoeken mislukt. Ongeldig patroon opgegeven: [_1]',
	'Search failed: [_1]' => 'Zoeken mislukt: [_1]',
	'No alternate template is specified for the Template \'[_1]\'' => 'Er is geen alternatief sjabloon opgegeven voor sjabloon \'[_1]\'',
	'Publishing results failed: [_1]' => 'Publicatie van resultaten mislukt: [_1]',
	'Search: query for \'[_1]\'' => 'Zoeken: zoekopdracht voor \'[_1]\'',
	'Search: new comment search' => 'Zoeken: opnieuw zoeken in de reacties',

## lib/MT/App/Trackback.pm
	'Invalid entry ID \'[_1]\'' => 'Ongeldig bericht-ID \'[_1]\'',
	'You must define a Ping template in order to display pings.' => 'U moet een pingsjabloon definiëren om pings te kunnen tonen.',
	'Trackback pings must use HTTP POST' => 'Trackback pings moeten HTTP POST gebruiken',
	'Need a TrackBack ID (tb_id).' => 'TrackBack ID vereist (tb_id).',
	'Invalid TrackBack ID \'[_1]\'' => 'Ongeldig TrackBack-ID \'[_1]\'',
	'You are not allowed to send TrackBack pings.' => 'U heeft geen toestemming om TrackBack pings te versturen.',
	'You are pinging trackbacks too quickly. Please try again later.' => 'U bent te snel TrackBacks aan het pingen. Probeer het later opnieuw.',
	'Need a Source URL (url).' => 'Bron-URL vereist (url).',
	'This TrackBack item is disabled.' => 'Dit TrackBack item is uitgeschakeld.',
	'This TrackBack item is protected by a passphrase.' => 'Dit TrackBack item is beschermd door een wachtwoord.',
	'TrackBack on "[_1]" from "[_2]".' => 'TrackBack op "[_1]" van "[_2]".',
	'TrackBack on category \'[_1]\' (ID:[_2]).' => 'TrackBack op categorie \'[_1]\' (ID:[_2]).',
	'Can\'t create RSS feed \'[_1]\': ' => 'Kan RSS feed \'[_1]\' niet aanmaken: ',
	'New TrackBack Ping to Entry [_1] ([_2])' => 'Nieuwe TrackBack ping naar bericht [_1] ([_2])',
	'New TrackBack Ping to Category [_1] ([_2])' => 'Nieuwe TrackBack ping naar categorie [_1] ([_2])',

## lib/MT/App/Upgrader.pm
	'Failed to authenticate using given credentials: [_1].' => 'Authenticatie met de opgegeven aanmeldgegevens mislukt: [_1].',
	'You failed to validate your password.' => 'Het valideren van uw wachtwoord is mislukt.',
	'You failed to supply a password.' => 'U gaf geen wachtwoord op.',
	'The e-mail address is required.' => 'Het e-mail adres is vereist.',
	'The path provided below is not writable.' => 'Het pad dat hieronder werd opgegeven is niet beschrijfbaar.',
	'Invalid session.' => 'Ongeldige sessie.',
	'No permissions. Please contact your administrator for upgrading Movable Type.' => 'Geen permissies.  Gelieve uw administrator te contacteren om Movable Type te upgraden.',
	'Movable Type has been upgraded to version [_1].' => 'Movable Type is bijgewerkt tot versie [_1]',

## lib/MT/App/Wizard.pm
	'The [_1] database driver is required to use [_2].' => 'De [_1] databasedriver is vereist om [_2] te kunnen gebruiken.',
	'The [_1] driver is required to use [_2].' => 'De [_1] driver is vereist om [_2] te kunnen gebruiken.',
	'An error occurred while attempting to connect to the database.  Check the settings and try again.' => 'Er deed zich een fout voor bij het verbinen met de database.  Controleer de instellingen en probeer opnieuw.',
	'SMTP Server' => 'SMTP server',
	'Sendmail' => 'Sendmail',
	'Test email from Movable Type Configuration Wizard' => 'Test e-mail van de Movable Type Configuratiewizard',
	'This is the test email sent by your new installation of Movable Type.' => 'Dit is de test e-mail verstuurd door uw nieuwe installatie van Movable Type.',
	'This module is needed to encode special characters, but this feature can be turned off using the NoHTMLEntities option in mt-config.cgi.' => 'Deze module is vereist als u speciale karacters wenst te encoderen, maar deze optie kan worden uitgeschakeld door de NoHTMLEntities optie te gebruiken in mt-config.cgi',
	'This module is needed if you wish to use the TrackBack system, the weblogs.com ping, or the MT Recently Updated ping.' => 'Deze module is vereist als u het TrackBack systeem, de ping naar weblogs.com of de MT Recent Bijgewerkt ping wenst te gebruiken.',
	'This module is needed if you wish to use the MT XML-RPC server implementation.' => 'Deze module is vereist als u de MT XML-RPC serverimplementatie wenst te gebruiken.',
	'This module is needed if you would like to be able to overwrite existing files when you upload.' => 'Deze module is vereist als u bestaande bestanden wenst te kunnen overschrijven bij het opladen.',
	'List::Util is optional; It is needed if you want to use the Publish Queue feature.' => 'List::Util is optioneel; Het is vereist als u de publicatiewachtrij-functie wenst te gebruiken.',
	'This module is needed if you would like to be able to create thumbnails of uploaded images.' => 'Deze module is vereist als u graag thumbnailveries van opgeladen bestanden wenst te kunnen aanmaken.',
	'This module is required by certain MT plugins available from third parties.' => 'Deze module is vereist door bepaalde MT plugins beschikbaar bij derden.',
	'This module accelerates comment registration sign-ins.' => 'Deze module versnelt aanmeldingen om te kunnen reageren.',
	'This module is needed to enable comment registration.' => 'Deze module is vereist om registraties bij reacties mogelijk te maken.',
	'This module enables the use of the Atom API.' => 'Deze module maakt het mogelijk de Atom API te gebruiken.',
	'This module is required in order to archive files in backup/restore operation.' => 'Deze module is vereist om bestanden te archiveren bij backup/restore operaties.',
	'This module is required in order to compress files in backup/restore operation.' => 'Deze module is vereist om bestanden te comprimeren bij backup/restore operaties.',
	'This module is required in order to decompress files in backup/restore operation.' => 'Deze module is vereist om bestanden te decomprimeren bij backup/restore operaties.',
	'This module and its dependencies are required in order to restore from a backup.' => 'Deze module en de modules waar ze van afhangt zijn vereisten om te kunen restoren uit een backup.',
	'This module and its dependencies are required in order to allow commenters to be authenticated by OpenID providers including Vox and LiveJournal.' => 'Deze module en de modules waar ze van afhangt zijn nodig om reageerders zichzelf te laten authenticeren via OpenID providers zoals o.a. Vox en LiveJournal.',
	'This module is required for sending mail via SMTP Server.' => 'Deze module is vereist om mail te versturen via een SMTP server.',
	'This module is used in test attribute of MTIf conditional tag.' => 'Deze module wordt gebruikt in een testattribuut van de MTIf conditionele tag.',
	'This module is required for file uploads (to determine the size of uploaded images in many different formats).' => 'Deze module is vereist om bestande te kunnen opladen (om het formaat van afbeeldingen in vele verschillende formaten te kunnen bepalen).',
	'This module is required for cookie authentication.' => 'Deze module is vereist voor cookie-authenticatie.',
	'DBI is required to store data in database.' => 'DBI is vereist om gegevens te kunnen opslaan in een database',
	'CGI is required for all Movable Type application functionality.' => 'CGI is vereist voor alle functionaliteit van Movable Type.',
	'File::Spec is required for path manipulation across operating systems.' => 'File::Spec is vereist om paden te kunnen manipuleren op verschillende operating systemen.',

## lib/MT/App/Viewer.pm
	'Loading blog with ID [_1] failed' => 'Laden van blog met ID [_1] mislukt',
	'Template publishing failed: [_1]' => 'Publicatie van sjabloon mislukt: [_1]',
	'Invalid date spec' => 'Ongeldige date spec',
	'Can\'t load template [_1]' => 'Kan sjabloon [_1] niet laden',
	'Archive publishing failed: [_1]' => 'Publicatie van archief mislukt: [_1]',
	'Invalid entry ID [_1]' => 'Ongeldige entry ID [_1]',
	'Entry [_1] is not published' => 'Bericht [_1] is ongepubliceerd',
	'Invalid category ID \'[_1]\'' => 'Ongeldig categorie-ID \'[_1]\'',

## lib/MT/App/CMS.pm
	'No [_1] were found that match the given criteria.' => 'Er werden geen [_1] gevonden die overeenkomen met de opgegeven criteria.',
	'This action will restore your global templates to factory settings without creating a backup. Click OK to continue or Cancel to abort.' => 'Deze actie zal de globale sjablonen terugzetten naar de fabrieksinstellingen zonder een backup aan te maken.  Klik OK om verder te gaan of Annuleren om af te breken.',
	'_WARNING_PASSWORD_RESET_MULTI' => 'U staat op het punt het wachtwoord opnieuw in te stellen voor de geselecteerde gebruikers.  Nieuwe wachtwoorden zullen willekeurig worden gegenereerd en rechtstreeks naar hun e-mail adres worden verzonden.\n\nWenst u verder te gaan?',
	'_WARNING_DELETE_USER_EUM' => 'Een gebruiker verwijderen is een actie die niet ongedaan gemaakt kan worden en die alle berichten van de gebruiker tot \'wees\' maakt.  Als u een gebruiker wenst weg te halen of zijn toegang tot het systeem wenst te blokkeren, is het aanbevolen alternatief al zijn permissies verwijderen.  Bent u zeker dat u deze gebruiker(s) wenst te verwijderen?\nGebruikers die nog bestaan in de externe directory zullen zichzelf weer kunnen aanmaken.',
	'_WARNING_DELETE_USER' => 'Een gebruiker verwijderen is een actie die niet ongedaan gemaakt kan worden en die alle berichten van de gebruiker in \'wezen\' verandert.  Als u een gebruiker wenst weg te halen of zijn toegang tot het systeem wenst te blokkeren, is het aanbevolen alternatief al zijn permissies te verwijderen.  Bent u zeker dat u deze gebruiker wenst te verwijderen?',
	'All Assets' => 'Alle mediabestanden',
	'Published [_1]' => 'Gepubliceerde [_1]',
	'Unpublished [_1]' => 'Ongepubliceerde [_1]',
	'Scheduled [_1]' => 'Geplande [_1]',
	'My [_1]' => 'Mijn  [_1]',
	'[_1] with comments in the last 7 days' => '[_1] met reacties in de laatste 7 dagen',
	'[_1] posted between [_2] and [_3]' => '[_1] gepubliceerd tussen [_2] en [_3]',
	'[_1] posted since [_2]' => '[_1] gepubliceerd sinds [_2]',
	'[_1] posted on or before [_2]' => '[_1] gepubliceerd op of voor [_2]',
	'All comments by [_1] \'[_2]\'' => 'Alle reacties van [_1] \'[_2]\'',
	'Commenter' => 'Reageerder',
	'All comments for [_1] \'[_2]\'' => 'Alle reacties op [_1] \'[_2]\'',
	'Comments posted between [_1] and [_2]' => 'Reacties gepubliceerd tussen [_1] en [_2]',
	'Comments posted since [_1]' => 'Reacties gepubliceerd sinds [_1]',
	'Comments posted on or before [_1]' => 'Reacties gepubliceerd op of voor [_1]',
	'Invalid blog' => 'Ongeldige blog',
	'Password Recovery' => 'Wachtwoord terugvinden',
	'Invalid password recovery attempt; can\'t recover password in this configuration' => 'Ongeldige poging het wachtwoord terug te vinden; kan geen wachtwoorden terugvinden in deze configuratie',
	'Invalid author_id' => 'Ongeldig author_id',
	'Can\'t recover password in this configuration' => 'Kan geen wachtwoorden terugvinden in deze configuratie',
	'Invalid user name \'[_1]\' in password recovery attempt' => 'Ongeldige gebruikersnaam \'[_1]\' bij poging tot terugvinden wachtwoord',
	'User name or password hint is incorrect.' => 'Gebruikersnaam of wachtwoordhint niet correct.',
	'User has not set pasword hint; cannot recover password' => 'Gebruiker heeft geen wachtwoordhint ingesteld; kan wachtwoord niet recupereren',
	'Invalid attempt to recover password (used hint \'[_1]\')' => 'Ongeldige poging om wachtwoord te recupereren (gebruikte hint \'[_1]\')',
	'User does not have email address' => 'Gebruiker heeft geen e-mail adres',
	'Password was reset for user \'[_1]\' (user #[_2]). Password was sent to the following address: [_3]' => 'Wachtwoord werd opnieuw ingesteld voor gebruiker \'[_1]\' (gebruiker #[_2]). Wachtwoord werd naar dit e-mail adres verstuurd: [_3]',
	'Error sending mail ([_1]); please fix the problem, then try again to recover your password.' => 'Fout bij verzenden van e-mail ([_1]);  gelieve het probleem op te lossen en probeer dan opnieuw om uw wachtwoord terug te vinden.',
	'(newly created user)' => '(nieuw aangemaakte gebruiker)',
	'Untitled' => 'Zonder titel',
	'Files' => 'Bestanden',
	'Roles' => 'Rollen',
	'Users' => 'Gebruikers',
	'User Associations' => 'Gebruikersassociaties',
	'Role Users & Groups' => 'Gebruikers & Groepen met deze rol',
	'Associations' => 'Associaties',
	'(Custom)' => '(Gepersonaliseerd)',
	'(user deleted)' => '(gebruiker verwijderd)',
	'The user' => 'De gebruiker',
	'User' => 'Gebruiker',
	'Invalid type' => 'Ongeldig type',
	'New name of the tag must be specified.' => 'Nieuwe naam van de tag moet opgegeven worden',
	'No such tag' => 'Onbekende tag',
	'None' => 'Geen',
	'You are not authorized to log in to this blog.' => 'U hebt geen toestemming op u aan te melden op deze weblog.',
	'No such blog [_1]' => 'Geen blog [_1]',
	'Shared Template Modules' => 'Gedeelde sjabloonmodules.',
	'Reuse elements of your site design or layout across all the blogs and sites managed within Movable Type.' => 'Hergebruik elementen van het design of de lay-out van uw site op alle blogs en sites die u beheert in Movable Type.',
	'Userpics' => 'Gebruikersfoto\'s',
	'Allow authors and commenters to upload a photo of themselves to be displayed alongside their comments.' => 'Laat auteurs en reageerders toe om een foto van zichzelf te uploaden die naast hun reacties getoond wordt.',
	'Template Sets' => 'Sjabloonsets',
	'Template sets provide an easy way to bundle an entire design and install it into Movable Type.' => 'Sjabloonsets zijn een handige manier om een volledig design samen te bundelen en op Movable Type te installeren.',
	'Blogs' => 'Blogs',
	'Blog Activity Feed' => 'Blogactiviteitsfeed',
	'*User deleted*' => '*Gebruiker verwijderd*',
	'All Feedback' => 'Alle feedback',
	'Publishing' => 'Publicatie',
	'Activity Log' => 'Activiteitenlog',
	'System Activity Feed' => 'Systeemactiviteit-feed',
	'Activity log for blog \'[_1]\' (ID:[_2]) reset by \'[_3]\'' => 'Activiteitenlog van blog \'[_1]\' (ID:[_2]) leeggemaakt door \'[_3]\'',
	'Activity log reset by \'[_1]\'' => 'Activiteitenlog leeggemaakt door \'[_1]\'',
	'Please select a blog.' => 'Gelieve een blog te selecteren.',
	'Edit Template' => 'Sjabloon bewerken',
	'Go Back' => 'Ga terug',
	'Import/Export' => 'Importeren/exporteren',
	'Invalid parameter' => 'Ongeldige parameter',
	'Permission denied: [_1]' => 'Toestemming geweigerd: [_1]',
	'Load failed: [_1]' => 'Laden mislukt: [_1]',
	'(no reason given)' => '(geen reden vermeld)',
	'Entries' => 'Berichten',
	'Pages' => 'Pagina\'s',
	'(untitled)' => '(geen titel)',
	'index' => 'index',
	'archive' => 'archief',
	'module' => 'module',
	'widget' => 'widget',
	'email' => 'e-mail',
	'system' => 'systeem',
	'Templates' => 'Sjablonen',
	'One or more errors were found in this template.' => 'Er werden één of meer fouten gevonden in dit sjabloon.',
	'General Settings' => 'Algemene instellingen',
	'Publishing Settings' => 'Publicatie-instellingen',
	'Plugin Settings' => 'Instellingen plugins',
	'Settings' => 'Instellingen',
	'Edit Comment' => 'Reactie bewerken',
	'Authenticated Commenters' => 'Geauthenticeerde reageerders',
	'Commenter Details' => 'Details reageerder',
	'Assets' => 'Mediabestanden',
	'New Entry' => 'Nieuw bericht',
	'New Page' => 'Nieuwe pagina',
	'Create template requires type' => 'Sjabloon aanmaken vereist type',
	'Archive' => 'Archief',
	'Entry or Page' => 'Bericht of pagina',
	'New Template' => 'Nieuwe sjabloon',
	'New Blog' => 'Nieuwe blog',
	'pages' => 'pagina\'s',
	'Create User' => 'Gebruiker aanmaken',
	'User requires username' => 'Gebruiker vereist gebruikersnaam',
	'A user with the same name already exists.' => 'Er bestaat al een gebruiker met die naam.',
	'User requires password' => 'Gebruiker vereist wachtwoord',
	'User requires password recovery word/phrase' => 'Gebruiker heeft een woord/uitdrukking nodig om het wachtwoord te kunnen terugvinden',
	'Email Address is required for password recovery' => 'E-mail adres is vereist voor het terugvinden van een wachtwoord',
	'Website URL is imperfect' => 'Website URL is imperfect',
	'The value you entered was not a valid email address' => 'Wat u invulde was geen geldig e-mail adres',
	'The e-mail address you entered is already on the Notification List for this blog.' => 'Het e-mail adres dat u opgaf staat al op de notificatielijst van deze weblog.',
	'You did not enter an IP address to ban.' => 'U vulde geen IP adres in om te verbannen.',
	'The IP you entered is already banned for this blog.' => 'Het IP adres dat u opgaf is al verbannen van deze weblog.',
	'You did not specify a blog name.' => 'U gaf geen weblognaam op.',
	'Site URL must be an absolute URL.' => 'Site URL moet eenn absolute URL zijn.',
	'Archive URL must be an absolute URL.' => 'Archief URL moet een absolute URL zijn.',
	'You did not specify an Archive Root.' => 'U gaf geen archiefroot op.',
	'The name \'[_1]\' is too long!' => 'De naam \'[_1]\' is te lang!',
	'Folder \'[_1]\' created by \'[_2]\'' => 'Map \'[_1]\' aangemaakt door \'[_2]\'',
	'Category \'[_1]\' created by \'[_2]\'' => 'Categorie \'[_1]\' aangemaakt door \'[_2]\'',
	'The folder \'[_1]\' conflicts with another folder. Folders with the same parent must have unique basenames.' => 'De map \'[_1]\' conflicteert met een andere map. Mappen met dezelfde ouder moeten een unieke basisnaam hebben.',
	'The category name \'[_1]\' conflicts with another category. Top-level categories and sub-categories with the same parent must have unique names.' => 'Categorienaam \'[_1]\' conflicteert met een andere categorie. Hoofdcategorieën en subcategorieën met dezelfde ouder moeten een unieke naam hebben.',
	'The category basename \'[_1]\' conflicts with another category. Top-level categories and sub-categories with the same parent must have unique basenames.' => 'Categoriebasisnaam \'[_1]\' conflicteert met een andere categoriewith another category. Hoofdcategorieën en subcategorieën met dezelfde ouder moeten een unieke basisnaam hebben.',
	'Saving permissions failed: [_1]' => 'Permissies opslaan mislukt: [_1]',
	'Blog \'[_1]\' (ID:[_2]) created by \'[_3]\'' => 'Blog \'[_1]\' (ID:[_2]) aangemaakt door \'[_3]\'',
	'User \'[_1]\' (ID:[_2]) created by \'[_3]\'' => 'Gebruiker \'[_1]\' (ID:[_2]) aangemaakt door \'[_3]\'',
	'Template \'[_1]\' (ID:[_2]) created by \'[_3]\'' => 'Sjabloon \'[_1]\' (ID:[_2]) aangemaakt door \'[_3]\'',
	'You cannot delete your own association.' => 'U kunt uw eigen associatie niet verwijderen.',
	'You cannot delete your own user record.' => 'U kunt uw eigen gebruikersgegevens niet verwijderen.',
	'You have no permission to delete the user [_1].' => 'U heeft geen rechten om gebruiker [_1] te verwijderen.',
	'Blog \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Blog \'[_1]\' (ID:[_2]) verwijderd door \'[_3]\'',
	'Subscriber \'[_1]\' (ID:[_2]) deleted from address book by \'[_3]\'' => 'Abonnee \'[_1]\' (ID:[_2]) verwijderd uit adresboek door \'[_3]\'',
	'User \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Gebruiker \'[_1]\' (ID:[_2]) verwijderd door \'[_3]\'',
	'Folder \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Map \'[_1]\' (ID:[_2]) verwijderd door \'[_3]\'',
	'Category \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Categorie \'[_1]\' (ID:[_2]) verwijderd door \'[_3]\'',
	'Comment (ID:[_1]) by \'[_2]\' deleted by \'[_3]\' from entry \'[_4]\'' => 'Reactie (ID:[_1]) door \'[_2]\' verwijderd door \'[_3]\' van bericht \'[_4]\'',
	'Page \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Pagina \'[_1]\' (ID:[_2]) verwijderd door \'[_3]\'',
	'Entry \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Bericht \'[_1]\' (ID:[_2]) verwijderd door \'[_3]\'',
	'(Unlabeled category)' => '(Categorie zonder label)',
	'Ping (ID:[_1]) from \'[_2]\' deleted by \'[_3]\' from category \'[_4]\'' => 'Ping (ID:[_1]) van \'[_2]\' verwijderd door \'[_3]\' van categorie \'[_4]\'',
	'(Untitled entry)' => '(Bericht zonder titel)',
	'Ping (ID:[_1]) from \'[_2]\' deleted by \'[_3]\' from entry \'[_4]\'' => 'Ping (ID:[_1]) van \'[_2]\' verwijderd door \'[_3]\' van bericht \'[_4]\'',
	'Template \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Sjabloon \'[_1]\' (ID:[_2]) verwijderd door \'[_3]\'',
	'Tag \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Tag \'[_1]\' (ID:[_2]) verwijderd door \'[_3]\'',
	'File \'[_1]\' uploaded by \'[_2]\'' => 'Bestand \'[_1]\' opgeladen door \'[_2]\'',
	'File \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' => 'Bestand \'[_1]\' (ID:[_2]) verwijderd door \'[_3]\'',
	'Permisison denied.' => 'Toestemming geweigerd.',
	'The Template Name and Output File fields are required.' => 'De velden sjabloonnaam en uitvoerbestand zijn verplicht.',
	'Invalid type [_1]' => 'Ongeldig type [_1]',
	'Save failed: [_1]' => 'Opslaan mislukt: [_1]',
	'Saving object failed: [_1]' => 'Object opslaan mislukt: [_1]',
	'No Name' => 'Geen naam',
	'Notification List' => 'Notificatie-lijst',
	'IP Banning' => 'IP-verbanning',
	'Removing tag failed: [_1]' => 'Tag verwijderen mislukt: [_1]',
	'You can\'t delete that category because it has sub-categories. Move or delete the sub-categories first if you want to delete this one.' => 'U kunt deze categorie niet verwijderen want ze heeft subcategorieën.  Verplaats of verwijder eerst de subcategorieën als u deze wenst te verwijderen.',
	'Loading MT::LDAP failed: [_1].' => 'Laden van MT::LDAP mislukt: [_1]',
	'Removing [_1] failed: [_2]' => 'Verwijderen van [_1] mislukt: [_2]',
	'System templates can not be deleted.' => 'Systeemsjablonen kunnen niet worden verwijderd.',
	'Unknown object type [_1]' => 'Onbekend objecttype [_1]',
	'Can\'t load file #[_1].' => 'Kan bestand niet laden #[_1].',
	'No such commenter [_1].' => 'Geen reageerder [_1].',
	'User \'[_1]\' trusted commenter \'[_2]\'.' => 'Gebruiker \'[_1]\' gaf reageerder \'[_2]\' de status VERTROUWD.',
	'User \'[_1]\' banned commenter \'[_2]\'.' => 'Gebruiker \'[_1]\' verbande reageerder \'[_2]\'.',
	'User \'[_1]\' unbanned commenter \'[_2]\'.' => 'Gebruiker \'[_1]\' maakte de verbanning van reageerder \'[_2]\' ongedaan.',
	'User \'[_1]\' untrusted commenter \'[_2]\'.' => 'Gebruiker \'[_1]\' gaf reageerder \'[_2]\' de status NIET VERTROUWD.',
	'Need a status to update entries' => 'Status vereist om berichten bij te werken',
	'Need entries to update status' => 'Berichten nodig om status bij te werken',
	'One of the entries ([_1]) did not actually exist' => 'Een van de berichten ([_1]) bestond niet',
	'[_1] \'[_2]\' (ID:[_3]) status changed from [_4] to [_5]' => '[_1] \'[_2]\' (ID:[_3]) status veranderd van [_4] naar [_5]',
	'You don\'t have permission to approve this comment.' => 'U heeft geen toestemming om deze reactie goed te keuren.',
	'Comment on missing entry!' => 'Reactie op ontbrekend bericht!',
	'Commenters' => 'Reageerders',
	'Orphaned comment' => 'Verweesde reactie',
	'Comments Activity Feed' => 'Activiteitenfeed reacties',
	'Orphaned' => 'Verweesd',
	'Global Templates' => 'Globale sjablonen',
	'Plugin Set: [_1]' => 'Pluginset: [_1]',
	'Individual Plugins' => 'Individuele plugins',
	'Junk TrackBacks' => 'TrackBacks als spam markeren',
	'TrackBacks where <strong>[_1]</strong> is &quot;[_2]&quot;.' => 'TrackBacks waar <strong>[_1]</strong> gelijk is aan &quot;[_2]&quot;.',
	'TrackBack Activity Feed' => 'TrackBackactiviteit-feed',
	'No Excerpt' => 'Geen uittreksel',
	'No Title' => 'Geen titel',
	'Orphaned TrackBack' => 'Verweesde TrackBack',
	'category' => 'categorie',
	'Category' => 'Categorie',
	'Asset' => 'Mediabestand',
	'Tag' => 'Tag',
	'Entry Status' => 'Status bericht',
	'[_1] Feed' => '[_1] Feed',
	'(user deleted - ID:[_1])' => '(gebruiker verwijderd - ID:[_1])',
	'Invalid date \'[_1]\'; authored on dates must be in the format YYYY-MM-DD HH:MM:SS.' => 'Ongeldige datum \'[_1]\'; publicatiedatums moeten in het formaat JJJJ-MM-DD UU:MM:SS staan.',
	'Invalid date \'[_1]\'; authored on dates should be real dates.' => 'Ongeldige datum \'[_1]\'; berichtdatums moeten echte datums zijn.',
	'Saving [_1] failed: [_2]' => 'Opslaan van [_1] mislukt: [_2]',
	'Saving entry \'[_1]\' failed: [_2]' => 'Bericht \'[_1]\' opslaan mislukt: [_2]',
	'Removing placement failed: [_1]' => 'Plaatsing verwijderen mislukt: [_1]',
	'Saving placement failed: [_1]' => 'Plaatsing opslaan mislukt: [_1]',
	'[_1] \'[_2]\' (ID:[_3]) edited and its status changed from [_4] to [_5] by user \'[_6]\'' => '[_1] \'[_2]\' (ID:[_3]) bewerkt en status aangepast van [_4] naar [_5] door gebruiker \'[_6]\'',
	'[_1] \'[_2]\' (ID:[_3]) edited by user \'[_4]\'' => '[_1] \'[_2]\' (ID:[_3]) bewerkt door gebruiker \'[_4]\'',
	'No such [_1].' => 'Geen [_1].',
	'Same Basename has already been used. You should use an unique basename.' => 'Dezelfde basisnaam is al in gebruik.  U gebruikt best een unieke basisnaam.',
	'Your blog has not been configured with a site path and URL. You cannot publish entries until these are defined.' => 'Er is nog geen sitepad en URL ingesteld voor uw weblog.  U kunt geen berichten publiceren voor deze zijn ingesteld.',
	'[_1] \'[_2]\' (ID:[_3]) added by user \'[_4]\'' => '[_1] \'[_2]\' (ID:[_3]) toegevoegd door gebruiker \'[_4]\'',
	'Error during publishing: [_1]' => 'Fout tijdens publiceren: [_1]',
	'Subfolder' => 'Submap',
	'Subcategory' => 'Subcategorie',
	'Saving category failed: [_1]' => 'Categorie opslaan mislukt: [_1]',
	'The [_1] must be given a name!' => 'De [_1] moet nog een naam krijgen!',
	'Saving blog failed: [_1]' => 'Blog opslaan mislukt: [_1]',
	'Invalid ID given for personal blog clone source ID.' => 'Ongeldig ID opgegeven als kloonbron voor een persoonlijke weblog.',
	'If personal blog is set, the default site URL and root are required.' => 'Als persoonlijke weblog is ingesteld, dan zijn de standaard URL en hoofdmap van de site vereist.',
	'Feedback Settings' => 'Feedback instellingen',
	'Publish error: [_1]' => 'Publicatiefout: [_1]',
	'Unable to create preview file in this location: [_1]' => 'Kon geen voorbeeldbestand maken op deze locatie: [_1]',
	'New [_1]' => 'Nieuwe [_1]',
	'Publish Site' => 'Site publiceren',
	'index template \'[_1]\'' => 'indexsjabloon \'[_1]\'',
	'[_1] \'[_2]\'' => '[_1] \'[_2]\'',
	'No permissions' => 'Geen permissies',
	'Ping \'[_1]\' failed: [_2]' => 'Ping \'[_1]\' mislukt: [_2]',
	'Create Role' => 'Rol aanmaken',
	'Role name cannot be blank.' => 'Naam van de rol mag niet leeg zijn.',
	'Another role already exists by that name.' => 'Er bestaat al een rol met die naam.',
	'You cannot define a role without permissions.' => 'U kunt geen rol definiëren zonder permissies.',
	'No permissions.' => 'Geen permissies.',
	'No such entry \'[_1]\'' => 'Geen bericht \'[_1]\'',
	'No email address for user \'[_1]\'' => 'Geen e-mail adres voor gebruiker \'[_1]\'',
	'No valid recipients found for the entry notification.' => 'Geen geldige ontvangers gevonden om op de hoogte te brengen van dit bericht.',
	'[_1] Update: [_2]' => '[_1] update: [_2]',
	'Error sending mail ([_1]); try another MailTransfer setting?' => 'Fout bij verzenden mail ([_1]); een andere MailTransfer instelling proberen?',
	'Archive Root' => 'Archiefroot',
	'Site Root' => 'Siteroot',
	'Upload File' => 'Opladen',
	'Can\'t load blog #[_1].' => 'Kan blog niet laden #[_1].',
	'Please select a file to upload.' => 'Gelieve een bestand te selecteren om te uploaden.',
	'Invalid filename \'[_1]\'' => 'Ongeldige bestandsnaam \'[_1]\'',
	'Please select an audio file to upload.' => 'Gelieve een audiobestand te selecteren om te uploaden.',
	'Please select an image to upload.' => 'Gelieve een afbeelding te selecteren om te uploaden.',
	'Please select a video to upload.' => 'Gelieve een videobestand te selecteren om te uploaden.',
	'Before you can upload a file, you need to publish your blog.' => 'Voor u een bestand kunt opladen, moet u eerst uw weblog publiceren.',
	'Invalid extra path \'[_1]\'' => 'Ongeldig extra pad \'[_1]\'',
	'Can\'t make path \'[_1]\': [_2]' => 'Kan pad \'[_1]\' niet aanmaken: [_2]',
	'Invalid temp file name \'[_1]\'' => 'Ongeldige naam voor temp bestand \'[_1]\'',
	'Error opening \'[_1]\': [_2]' => 'Fout bij openen van \'[_1]\': [_2]',
	'Error deleting \'[_1]\': [_2]' => 'Fout bij wissen van \'[_1]\': [_2]',
	'File with name \'[_1]\' already exists. (Install File::Temp if you\'d like to be able to overwrite existing uploaded files.)' => 'Bestand met de naam \'[_1]\' bestaat al. (Installeer File::Temp als u bestaande bestanden wenst te kunnen overschrijven.)',
	'Error creating temporary file; please check your TempDir setting in your coniguration file (currently \'[_1]\') this location should be writable.' => 'Fout bij het aanmaken van een tijdelijk bestand; controleer de TempDir instelling in uw configuratiebestand (momenteel \'[_1]\'), deze locatie zou beschrijfbaar moeten zijn door de webserver.',
	'unassigned' => 'niet toegewezen',
	'File with name \'[_1]\' already exists; Tried to write to tempfile, but open failed: [_2]' => 'Bestand met de naam \'[_1]\' bestaat al; Poging tot schrijven naar tijdelijk bestand ondernomen, openen mislukt: [_2]',
	'Could not create upload path \'[_1]\': [_2]' => 'Kon geen upload pad \'[_1]\' aanmaken: [_2]',
	'Error writing upload to \'[_1]\': [_2]' => 'Fout bij schrijven van upload naar \'[_1]\': [_2]',
	'Search & Replace' => 'Zoeken & vervangen',
	'Entry Body' => 'Berichttekst',
	'Extended Entry' => 'Uitgebreid bericht',
	'Keywords' => 'Trefwoorden',
	'Basename' => 'Basisnaam',
	'Comment Text' => 'Tekst reactie',
	'IP Address' => 'IP adres',
	'Source URL' => 'Bron URL',
	'Blog Name' => 'Blognaam',
	'Page Body' => 'Romp van de pagina',
	'Extended Page' => 'Uitgebreide pagina',
	'Template Name' => 'Sjabloonnaam',
	'Text' => 'Tekst',
	'Linked Filename' => 'Naam gelinkt bestand',
	'Output Filename' => 'Naam uitvoerbestand',
	'Filename' => 'Bestandsnaam',
	'Description' => 'Beschrijving',
	'Label' => 'Naam',
	'Log Message' => 'Logbericht',
	'Username' => 'Gebruikersnaam',
	'Display Name' => 'Getoonde naam',
	'Site URL' => 'URL van de site',
	'Invalid date(s) specified for date range.' => 'Ongeldige datum(s) opgegeven in datumbereik.',
	'Error in search expression: [_1]' => 'Fout in zoekexpressie: [_1]',
	'Saving object failed: [_2]' => 'Object opslaan mislukt: [_2]',
	'Load of blog \'[_1]\' failed: [_2]' => 'Laden van blog \'[_1]\' mislukt: [_2]',
	'You do not have export permissions' => 'U heeft geen exportpermissies',
	'You do not have import permissions' => 'U heeft geen importpermissies',
	'You do not have permission to create users' => 'U heeft geen permissie om gebruikers aan te maken',
	'You need to provide a password if you are going to create new users for each user listed in your blog.' => 'U moet een wachtwoord opgeven als u nieuwe gebruikers gaat aanmaken voor elke gebruiker die in uw weblog voorkomt.',
	'Importer type [_1] was not found.' => 'Importeertype [_1] niet gevonden.',
	'Saving map failed: [_1]' => 'Map opslaan mislukt: [_1]',
	'Add a [_1]' => 'Voeg een [_1] toe',
	'No label' => 'Geen label',
	'Category name cannot be blank.' => 'Categorienaam kan niet leeg zijn.',
	'Populating blog with default templates failed: [_1]' => 'Inrichten van blog met standaard sjablonen mislukt: [_1]',
	'Setting up mappings failed: [_1]' => 'Doorverwijzingen opzetten mislukt: [_1]',
	'Error: Movable Type cannot write to the template cache directory. Please check the permissions for the directory called <code>[_1]</code> underneath your blog directory.' => 'Fout: Movable Type kan niet schrijven in de sjablooncache map. Gelieve de permissies na te kijken van de map met de naam <code>[_1]</code> onder de map van uw weblog.',
	'Error: Movable Type was not able to create a directory to cache your dynamic templates. You should create a directory called <code>[_1]</code> underneath your blog directory.' => 'Fout: Movable Type kon geen map maken om uw dynamische sjablonen in te cachen. U moet een map aanmaken met de naam <code>[_1]</code> onder de map van uw weblog.',
	'That action ([_1]) is apparently not implemented!' => 'Die handeling ([_1]) is blijkbaar niet geïmplementeerd!',
	'Error saving entry: [_1]' => 'Fout bij opslaan bericht: [_1]',
	'Select Blog' => 'Selecteer blog',
	'Selected Blog' => 'Geselecteerde blog',
	'Type a blog name to filter the choices below.' => 'Typ de naam van een weblog in om de onderstaande keuzes te filteren.',
	'Select a System Administrator' => 'Selecteer een systeembeheerder',
	'Selected System Administrator' => 'Geselecteerde systeembeheerder',
	'Type a username to filter the choices below.' => 'Tik een gebruikersnaam in om de keuzes hieronder te filteren.',
	'System Administrator' => 'Systeembeheerder',
	'Error saving file: [_1]' => 'Fout bij opslaan bestand: [_1]',
	'represents a user who will be created afterwards' => 'stelt een gebruiker voor die later zal worden aangemaakt',
	'Select Blogs' => 'Selecteer blogs',
	'Blogs Selected' => 'Geselecteerde blogs',
	'Search Blogs' => 'Blogs zoeken',
	'Select Users' => 'Gebruikers selecteren',
	'Users Selected' => 'Gebruikers geselecteerd',
	'Search Users' => 'Gebruikers zoeken',
	'Select Roles' => 'Selecteer rollen',
	'Role Name' => 'Naam rol',
	'Roles Selected' => 'Geselecteerde rollen',
	'' => '', # Translate - New
	'Grant Permissions' => 'Permissies toekennen',
	'Backup' => 'Backup',
	'Backup & Restore' => 'Backup & Restore',
	'Temporary directory needs to be writable for backup to work correctly.  Please check TempDir configuration directive.' => 'De tijdelijke map moet beschrijfbaar zijn om backups te kunnen doen.  Gelieve de TempDir configuratiedirectief na te kijken.',
	'Temporary directory needs to be writable for restore to work correctly.  Please check TempDir configuration directive.' => 'De tijdelijke map moet beschrijfbaar zijn om restore-operaties te kunnen doen.  Gelieve de TempDir configuratiedirectief na te kijken',
	'Blog(s) (ID:[_1]) was/were successfully backed up by user \'[_2]\'' => 'Blog(s) (ID:[_1]) werden met succes gebackupt door gebruiker \'[_2]\'',
	'Movable Type system was successfully backed up by user \'[_1]\'' => 'Movable Type systeem werd met succes gebackupt door gebruiker \'[_1]\'',
	'[_1] is not a number.' => '[_1] is geen getal.',
	'Copying file [_1] to [_2] failed: [_3]' => 'Bestand [_1] copiëren naar [_2] mislukt: [_3]',
	'Specified file was not found.' => 'Het opgegeven bestand werd niet gevonden.',
	'[_1] successfully downloaded backup file ([_2])' => '[_1] downloadde met succes backupbestand ([_2])',
	'Restore' => 'Restore',
	'Please use xml, tar.gz, zip, or manifest as a file extension.' => 'Gelieve xml, tar.gz, zip, of manifest te gebruiken als bestandsextensies.',
	'Unknown file format' => 'Onbekend bestandsformaat',
	'Some [_1] were not restored because their parent objects were not restored.' => 'Een aantal [_1] werden niet teruggezet omdat hun ouderobjecten niet werden teruggezet.',
	'Some objects were not restored because their parent objects were not restored.  Detailed information is in the <a href="javascript:void(0);" onclick="closeDialog(\'[_1]\');">activity log</a>.' => 'Sommige objecten werden niet gerecupereerd omdat hun ouder-objecten niet werden teruggezet.  Gedetailleerde informatie is te vinden in het <a href="javascript:void(0);" onclick="closeDialog(\'[_1]\');">activiteitenlog</a>.',
	'Successfully restored objects to Movable Type system by user \'[_1]\'' => 'Objecten werden met succes teruggezet in het Movable Type systeem door gebruiker \'[_1]\'',
	'[_1] is not a directory.' => '[_1] is geen map.',
	'Error occured during restore process.' => 'Er deed zich een fout voor tijdens het restore-proces.',
	'MT::Asset#[_1]: ' => 'MT::Asset#[_1]: ',
	'Some of files could not be restored.' => 'Een aantal bestanden konden niet worden teruggezet.',
	'Please upload [_1] in this page.' => 'Gelieve [_1] te uploaden op deze pagina.',
	'File was not uploaded.' => 'Bestand werd niet opgeladen.',
	'Restoring a file failed: ' => 'Terugzetten van een bestand mislukt: ',
	'Some objects were not restored because their parent objects were not restored.' => 'Sommige objecten werden niet teruggezet omdat hun ouder-objecten niet werden teruggezet.',
	'Some of the files were not restored correctly.' => 'Een aantal bestanden werden niet correct teruggezet.',
	'Detailed information is in the <a href=\'javascript:void(0)\' onclick=\'closeDialog(\"[_1]\")\'>activity log</a>.' => 'Gedetailleerde informatie is terug te vinden in het <a href=\'javascript:void(0)\' onclick=\'closeDialog(\"[_1]\")\'>activiteitenlog</a>.',
	'[_1] has canceled the multiple files restore operation prematurely.' => '[_1] heeft de terugzet-operatie van meerdere bestanden voortijdig afgebroken.',
	'Changing Site Path for the blog \'[_1]\' (ID:[_2])...' => 'Sitepad voor blog \'[_1]\' (ID:[_2]) aan het aanpassen...',
	'Removing Site Path for the blog \'[_1]\' (ID:[_2])...' => 'Sitepad voor blog \'[_1]\' (ID:[_2]) aan het verwijderen...',
	'Changing Archive Path for the blog \'[_1]\' (ID:[_2])...' => 'Archiefpad aan het aanpassen voor blog \'[_1]\' (ID:[_2])...',
	'Removing Archive Path for the blog \'[_1]\' (ID:[_2])...' => 'Archiefpad aan het verwijderen voor blog \'[_1]\' (ID:[_2])...',
	'failed' => 'mislukt',
	'ok' => 'ok',
	'Changing file path for the asset \'[_1]\' (ID:[_2])...' => 'Bestandslocatie voor mediabestand \'[_1]\' (ID:[_2]) wordt aangepast...',
	'Some of the actual files for assets could not be restored.' => 'Een aantal van de mediabestanden konden niet teruggezet worden.',
	'Parent comment id was not specified.' => 'ID van ouder-reactie werd niet opgegeven.',
	'Parent comment was not found.' => 'Ouder-reactie werd niet gevonden.',
	'You can\'t reply to unapproved comment.' => 'U kunt niet antwoorden op een niet-gekeurde reactie.',
	'You can\'t reply to unpublished comment.' => 'U kunt niet reageren op een niet gepubliceerde reactie.',
	' (Backup from [_1])' => ' (Backup van [_1])', # Translate - New
	'Error creating new template: ' => 'Fout bij aanmaken nieuw sjabloon: ',
	'Skipping template \'[_1]\' since it appears to be a custom template.' => 'Sjabloon \'[_1]\' wordt overgeslagen, omdat het blijkbaar een gepersonaliseerd sjabloon is.',
	'Refreshing template <strong>[_3]</strong> with <a href="?__mode=view&amp;blog_id=[_1]&amp;_type=template&amp;id=[_2]">backup</a>' => 'Bezig sjabloon <strong>[_3]</strong> te verversen met <a href="?__mode=view&amp;blog_id=[_1]&amp;_type=template&amp;id=[_2]">backup</a>',
	'Skipping template \'[_1]\' since it has not been changed.' => 'Sjabloon \'[_1]\' wordt overgeslagen omdat het niet is veranderd.',
	'entries' => 'berichten',
	'This is You' => 'Dit bent u',
	'Handy Shortcuts' => 'Handige snelkoppelingen',
	'Movable Type News' => 'Movable Type-nieuws',
	'Blog Stats' => 'Blogstatistieken',
	'Refresh Blog Templates' => 'Blogsjablonen verversen',
	'Refresh Global Templates' => 'Globale sjablonen verversen',
	'Publish Entries' => 'Berichten publiceren',
	'Unpublish Entries' => 'Publicatie ongedaan maken',
	'Add Tags...' => 'Tags toevoegen',
	'Tags to add to selected entries' => 'Tags toe te voegen aan geselecteerde berichten',
	'Remove Tags...' => 'Tags verwijderen',
	'Tags to remove from selected entries' => 'Tags te verwijderen van geselecteerde berichten',
	'Batch Edit Entries' => 'Berichten bewerken in bulk',
	'Publish Pages' => 'Pagina\'s publiceren',
	'Unpublish Pages' => 'Pagina\'s off-line halen',
	'Tags to add to selected pages' => 'Tags om toe te voegen aan geselecteerde pagina\'s',
	'Tags to remove from selected pages' => 'Tags om te verwijderen van geselecteerde pagina\'s',
	'Batch Edit Pages' => 'Pagina\'s bewerken in bulk',
	'Tags to add to selected assets' => 'Tags om toe te voegen aan de geselecteerde mediabestanden',
	'Tags to remove from selected assets' => 'Tags om te verwijderen van de geselecteerde mediabestanden',
	'Unpublish TrackBack(s)' => 'Publicatie ongedaan maken',
	'Unpublish Comment(s)' => 'Publicatie ongedaan maken',
	'Trust Commenter(s)' => 'Reageerder(s) vertrouwen',
	'Untrust Commenter(s)' => 'Reageerder(s) niet meer vertrouwen',
	'Ban Commenter(s)' => 'Reageerder(s) verbannen',
	'Unban Commenter(s)' => 'Verbanning opheffen',
	'Recover Password(s)' => 'Wachtwoord(en) terugvinden',
	'Delete' => 'Verwijderen',
	'Refresh Template(s)' => 'Sjablo(o)n(en) verversen',
	'Publish Template(s)' => 'Sjablo(o)n(en) publiceren',
	'Non-spam TrackBacks' => 'Non-spam TrackBacks',
	'TrackBacks on my entries' => 'TrackBacks op mijn berichten',
	'Published TrackBacks' => 'Gepubliceerde TrackBacks',
	'Unpublished TrackBacks' => 'Niet gepubliceerde TrackBacks',
	'TrackBacks marked as Spam' => 'TrackBacks gemarkeerd als spam',
	'All TrackBacks in the last 7 days' => 'Alle TrackBacks in de afgelopen 7 dagen',
	'Non-spam Comments' => 'Non-spam reacties',
	'Comments on my entries' => 'Reacties op mijn berichten',
	'Pending comments' => 'Te modereren reacties',
	'Spam Comments' => 'Spamreacties',
	'Published comments' => 'Gepubliceerde reacties',
	'My comments' => 'Mijn reacties',
	'Comments in the last 7 days' => 'Reacties in de afgelopen 7 dagen',
	'All comments in the last 24 hours' => 'Alle reacties in de laatste 24 uur',
	'Index Templates' => 'Indexsjablonen',
	'Archive Templates' => 'Archiefsjablonen',
	'Template Modules' => 'Sjabloonmodules',
	'E-mail Templates' => 'E-mailsjablonen',
	'Backup Templates' => 'Sjabloonbackup',
	'System Templates' => 'Systeemsjablonen',
	'Tags with entries' => 'Tags met berichten',
	'Tags with pages' => 'Tags met pagina\'s',
	'Tags with assets' => 'Tags met mediabestanden',
	'Enabled Users' => 'Ingeschakelde gebruikers',
	'Disabled Users' => 'Uitgeschakelde gebruikers',
	'Pending Users' => 'Te keuren gebruikers',
	'Authors' => 'Auteurs',
	'Create' => 'Nieuw',
	'Manage' => 'Beheren',
	'Design' => 'Design',
	'Preferences' => 'Voorkeuren',
	'Tools' => 'Gereedschappen',
	'Folders' => 'Mappen',
	'General' => 'Algemeen',
	'Feedback' => 'Feedback',
	'Plugins' => 'Plugins',
	'Blog Settings' => 'Bloginstellingen',
	'Address Book' => 'Adresboek',
	'System Information' => 'Systeeminformatie',
	'Import' => 'Import',
	'Export' => 'Export',
	'System Overview' => 'Systeemoverzicht',
	'/' => '/',
	'<' => '<',

## lib/MT/App/ActivityFeeds.pm
	'Error loading [_1]: [_2]' => 'Fout bij het laden van [_1]: [_2]',
	'An error occurred while generating the activity feed: [_1].' => 'Er deed zich een fout voor bij het aanmaken van de activiteitenfeed: [_1].',
	'[_1] Weblog TrackBacks' => '[_1] Weblog TrackBacks',
	'All Weblog TrackBacks' => 'Alle Weblog TrackBacks',
	'[_1] Weblog Comments' => '[_1] Weblogreacties',
	'All Weblog Comments' => 'Alle Weblogreacties',
	'[_1] Weblog Entries' => '[_1] Weblogberichten',
	'All Weblog Entries' => 'Alle weblogberichten',
	'[_1] Weblog Activity' => '[_1] Weblogactiviteit',
	'All Weblog Activity' => 'Alle weblogactiviteit',
	'Movable Type System Activity' => 'Movable Type systeemactiviteit',
	'Movable Type Debug Activity' => 'Movable Type debugactiviteit',
	'[_1] Weblog Pages' => '[_1] weblogpagina\'s',
	'All Weblog Pages' => 'Alle weblogpagina\'s',

## lib/MT/Worker/Publish.pm
	'Publishing: [quant,_1,file,files]...' => 'Bezig te publiceren: [quant,_1,bestand,bestanden]...',
	'-- set complete ([quant,_1,file,files] in [_2] seconds)' => '-- set afgerond ([quant,_1,bestand,bestanden] in [_2] seconden)',

## lib/MT/BasicAuthor.pm
	'authors' => 'auteurs',

## lib/MT/Placement.pm
	'Category Placement' => 'Categorieplaatsing',

## lib/MT/TaskMgr.pm
	'Unable to secure lock for executing system tasks. Make sure your TempDir location ([_1]) is writable.' => 'Aanmaken van een lockfile mislukt om systeemtaken uit te kunnen voeren. Kijk naof uw TempDir locatie ([_1]) beschrijfbaar is.',
	'Error during task \'[_1]\': [_2]' => 'Fout tijdens taak \'[_1]\': [_2]',
	'Scheduled Tasks Update' => 'Update van geplande taken',
	'The following tasks were run:' => 'Volgende taken moesten uitgevoerd worden:',

## lib/MT/Page.pm
	'Folder' => 'Map',
	'Load of blog failed: [_1]' => 'Laden van blog mislukt: [_1]',

## lib/MT/Bootstrap.pm
	'Got an error: [_1]' => 'Er deed zich een fout voor: [_1]',

## lib/MT/Category.pm
	'Categories must exist within the same blog' => 'Categorieën moeten bestaan binnen dezelfde blog',
	'Category loop detected' => 'Categorielus gedetecteerd',

## lib/MT/Asset.pm
	'Location' => 'Locatie',

## lib/MT/Image.pm
	'Perl module Image::Size is required to determine width and height of uploaded images.' => 'Perl module Image::Size is nodig om de breedte en hoogte van opgeladen afbeeldingen te bepalen.',
	'File size exceeds maximum allowed: [_1] > [_2]' => 'Bestandsgroote is groter dan maximum toegestaan: [_1] > [_2]',
	'Can\'t load Image::Magick: [_1]' => 'Kan Image::Magick niet laden: [_1]',
	'Reading file \'[_1]\' failed: [_2]' => 'Bestand \'[_1]\' lezen mislukt: [_2]',
	'Reading image failed: [_1]' => 'Afbeelding lezen mislukt: [_1]',
	'Scaling to [_1]x[_2] failed: [_3]' => 'Dimensies aanpassen naar [_1]x[_2] mislukt: [_3]',
	'Cropping a [_1]x[_1] square at [_2],[_3] failed: [_4]' => 'Bijsnijden van een vierkant van [_1]x[_1] op [_2],[_3] mislukt: [_4]',
	'Converting image to [_1] failed: [_2]' => 'Converteren van afbeelding naar [_1] mislukt: [_2]',
	'Can\'t load IPC::Run: [_1]' => 'Kan IPC::Run niet laden: [_1]',
	'Cropping to [_1]x[_1] failed: [_2]' => 'Bijsnijden naar [_1]x[_1] mislukt: [_2]',
	'Converting to [_1] failed: [_2]' => 'Converteren naar [_1] mislukt: [_2]',
	'You do not have a valid path to the NetPBM tools on your machine.' => 'U hebt geen geldig pad naar de NetPBM tools op uw machine.',

## lib/MT/Session.pm
	'Session' => 'Sessie',

## lib/MT/Trackback.pm
	'TrackBack' => 'TrackBack',

## lib/MT/Notification.pm
	'Contact' => 'Contact',
	'Contacts' => 'Contacten',

## lib/MT/Upgrade.pm
	'Comment Posted' => 'Reactie geplaatst',
	'Your comment has been posted!' => 'Uw reactie is geplaatst!',
	'[_1]: [_2]' => '[_1]: [_2]',
	'Migrating Nofollow plugin settings...' => 'Nofollow plugin instellingen worden gemigreerd',
	'Updating system search template records...' => 'Systeemzoeksjablonen worden bijgewerkt...',
	'Custom ([_1])' => 'Gepersonaliseerd ([_1])',
	'This role was generated by Movable Type upon upgrade.' => 'Deze rol werd aangemaakt door Movable Type tijdens de upgrade.',
	'Migrating permission records to new structure...' => 'Permissies worden gemigreerd naar de nieuwe structuur...',
	'Migrating role records to new structure...' => 'Rollen worden gemigreerd naar de nieuwe structuur',
	'Migrating system level permissions to new structure...' => 'Systeempermissies worden gemigreerd naar de nieuwe structuur...',
	'Invalid upgrade function: [_1].' => 'Ongeldige upgrade-functie: [_1].',
	'Error loading class [_1].' => 'Fout bij het laden van klasse [_1].',
	'Creating initial blog and user records...' => 'Initiële blog en gebruiker worden aangemaakt...',
	'Error saving record: [_1].' => 'Fout bij opslaan gegevens: [_1].',
	'First Blog' => 'Eerste weblog',
	'I just finished installing Movable Type [_1]!' => 'Ik heb net Movable Type [_1] geïnstalleerd!',
	'Welcome to my new blog powered by Movable Type. This is the first post on my blog and was created for me automatically when I finished the installation process. But that is ok, because I will soon be creating posts of my own!' => 'Welkom op mijn nieuwe weblog aangedreven door Movable Type.  Dit is het eerste bericht op mijn blog dat automatisch voor mij werd aangemaakt op het einde van het installatieproces.  Maar dat geeft niet, want binnenkort zal ik mijn eigen berichten beginnen schrijven!',
	'Movable Type also created a comment for me as well so that I could see what a comment will look like on my blog once people start submitting comments on all the posts I will write.' => 'Movable Type maakte ook al een reactie aan voor me zodat ik kan zien hoe een reactie er zal uitzien op mijn weblog zodra mensen beginnen te reageren op de berichten die ik zal schrijven.',
	'Blog Administrator' => 'Blogadministrator',
	'Can administer the blog.' => 'Kan deze weblog beheren',
	'Editor' => 'Redacteur',
	'Can upload files, edit all entries/categories/tags on a blog and publish the blog.' => 'Kan bestanden opladen, alle berichten/categorieën/tags op een blog bewerken en de blog publiceren.',
	'Can create entries, edit their own, upload files and publish.' => 'Kan berichten aanmaken, eigen berichten bewerken, bestanden opladen en publiceren.',
	'Designer' => 'Designer',
	'Can edit, manage and publish blog templates.' => 'Kan blogsjablonen bewerken, beheren en opnieuw opbouwen.',
	'Webmaster' => 'Webmaster',
	'Can manage pages and publish blog templates.' => 'Kan pagina\'s beheren en blogsjablonen opnieuw opbouwen.',
	'Contributor' => 'Redactielid',
	'Can create entries, edit their own and comment.' => 'Kan berichten aanmaken, eigen berichten bewerken en reageren.',
	'Moderator' => 'Moderator',
	'Can comment and manage feedback.' => 'Kan reageren en feedback beheren',
	'Can comment.' => 'Kan reageren.',
	'Removing Dynamic Site Bootstrapper index template...' => 'Dynamisch site bootstrapper indexsjabloon wordt verwijderd...',
	'Creating new template: \'[_1]\'.' => 'Nieuw sjabloon wordt aangemaakt: \'[_1]\'.',
	'Mapping templates to blog archive types...' => 'Bezig met sjablonen aan archieftypes toe te wijzen...',
	'Renaming PHP plugin file names...' => 'PHP plugin bestandsnamen aan het aanpassen...',
	'Error renaming PHP files. Please check the Activity Log.' => 'Fout bij het aanpassen van de bestandsnamen van PHP bestanden.  Kijk in het activiteitenlog voor details.',
	'Cannot rename in [_1]: [_2].' => 'Kan naam niet aanpassen in [_1]: [_2]',
	'Updating widget template records...' => 'Bezig widgetsjablooninformatie bij te werken...',
	'Removing unused template maps...' => 'Bezig ongebruikte sjabloon-mappings te verwijderen...',
	'Upgrading table for [_1] records...' => 'Tabel aan het upgraden voor [_1] records...',
	'Upgrading database from version [_1].' => 'Database wordt bijgewerkt van versie [_1].',
	'Database has been upgraded to version [_1].' => 'Database is bijgewerkt naar versie [_1].',
	'User \'[_1]\' upgraded database to version [_2]' => 'Gebruiker \'[_1]\' deed een upgrade van de database naar versie [_2]',
	'Plugin \'[_1]\' upgraded successfully to version [_2] (schema version [_3]).' => 'Plugin \'[_1]\' met succes bijgewerkt naar versie [_2] (schema versie [_3]).',
	'User \'[_1]\' upgraded plugin \'[_2]\' to version [_3] (schema version [_4]).' => 'Gebruiker \'[_1]\' deed een upgrade van plugin \'[_2]\' naar versie [_3] (schema versie [_4]).',
	'Plugin \'[_1]\' installed successfully.' => 'Plugin \'[_1]\' met succes geïnstalleerd.',
	'User \'[_1]\' installed plugin \'[_2]\', version [_3] (schema version [_4]).' => 'Gebruiker \'[_1]\' installeerde plugin \'[_2]\', versie [_3] (schema versie [_4]).',
	'Setting your permissions to administrator.' => 'Bezig uw permissies als administrator in te stellen.',
	'Comment Response' => 'Bevestiging reactie',
	'Creating configuration record.' => 'Configuratiegegevens aan het aanmaken.',
	'Creating template maps...' => 'Bezig sjabloonkoppelingen aan te maken...',
	'Mapping template ID [_1] to [_2] ([_3]).' => 'Sjabloon ID [_1] wordt gekoppeld aan [_2] ([_3]).',
	'Mapping template ID [_1] to [_2].' => 'Sjabloon ID [_1] wordt gekoppeld aan [_2].',
	'Error loading class: [_1].' => 'Fout bij het laden van klasse: [_1].',
	'Error saving [_1] record # [_3]: [_2]... [_4].' => 'Fout bij opslaan van [_1] record # [_3]: [_2]... [_4].',
	'Creating entry category placements...' => 'Bezig berichten in categoriën te plaatsen...',
	'Updating category placements...' => 'Categorieplaatsingen worden bijgewerkt...',
	'Assigning comment/moderation settings...' => 'Instellingen voor reacties/moderatie worden toegewezen...',
	'Setting blog basename limits...' => 'Basisnaamlimieten blog worden ingesteld...',
	'Setting default blog file extension...' => 'Standaard blogbestand extensie wordt ingesteld...',
	'Updating comment status flags...' => 'Statusvelden van reacties worden bijgewerkt...',
	'Updating commenter records...' => 'Info over reageerders wordt bijgewerkt...',
	'Assigning blog administration permissions...' => 'Blog administrator permissies worden toegekend...',
	'Setting blog allow pings status...' => 'Status voor toelaten van pings per blog wordt ingesteld...',
	'Updating blog comment email requirements...' => 'Vereisten voor e-mail bij reacties op de weblog worden bijgewerkt...',
	'Assigning entry basenames for old entries...' => 'Basisnamen voor oude berichten worden toegekend...',
	'Updating user web services passwords...' => 'Web service wachtwoorden van de gebruiker worden bijgewerkt...',
	'Updating blog old archive link status...' => 'Status van oude archieflinks van blog wordt bijgewerkt...',
	'Updating entry week numbers...' => 'Weeknummers van berichten worden bijgewerkt...',
	'Updating user permissions for editing tags...' => 'Gebruikerspermissies voor het bewerken van tags worden bijgewerkt...',
	'Setting new entry defaults for blogs...' => 'Standaardinstellingen voor nieuwe blogs aan het vastleggen...',
	'Migrating any "tag" categories to new tags...' => 'Alle "tag" categorieën worden naar nieuwe tags gemigreerd...',
	'Assigning custom dynamic template settings...' => 'Aangepaste instellingen voor dynamische sjablonen worden toegewezen...',
	'Assigning user types...' => 'Gebruikertypes worden toegewezen...',
	'Assigning category parent fields...' => 'Velden van hoofdcategorieën worden toegewezen...',
	'Assigning template build dynamic settings...' => 'Instellingen voor dynamische sjabloonopbouw worden toegewezen...',
	'Assigning visible status for comments...' => 'Status zichtbaarheid van reacties wordt toegekend...',
	'Assigning junk status for comments...' => 'Spamstatus wordt aan reacties toegewezen...',
	'Assigning visible status for TrackBacks...' => 'Zichtbaarheidsstatus van TrackBacks wordt toegekend...',
	'Assigning junk status for TrackBacks...' => 'Spamstatus wordt toegekend aan TrackBacks...',
	'Assigning basename for categories...' => 'Basisnaam voor categorieën wordt toegekend...',
	'Assigning user status...' => 'Gebruikersstatus wordt toegekend...',
	'Migrating permissions to roles...' => 'Permissies aan het migreren naar rollen...',
	'Populating authored and published dates for entries...' => 'Bezig creatie- en publicatiedatums voor berichten in te stellen...',
	'Classifying category records...' => 'Categorieën aan het klasseren...',
	'Classifying entry records...' => 'Berichten aan het klasseren...',
	'Merging comment system templates...' => 'Bezig reactiesysteemsjabonen samen te voegen...',
	'Populating default file template for templatemaps...' => 'Bezig standaard sjabloonbestand voor sjabloonmappings in te stellen...',
	'Assigning user authentication type...' => 'Gebruikersauthenticatietype aan het toekennen...',
	'Adding new feature widget to dashboard...' => 'Nieuw widget wordt aan dashbord toegevoegd...',
	'Moving OpenID usernames to external_id fields...' => 'OpenID gebruikersnamen aan het verplaatsen naar external_id velden...',
	'Assigning blog template set...' => 'Blog sjabloonset aan het toekennen...',
	'Assigning blog page layout...' => 'Blog pagina layout aan het toekennen...', # Translate - New

## lib/MT/Core.pm
	'Create Blogs' => 'Blogs aanmaken',
	'Manage Plugins' => 'Plugins beheren',
	'Manage Templates' => 'Sjablonen beheren',
	'View System Activity Log' => 'Systeemactiviteitlog bekijken',
	'Configure Blog' => 'Blog configureren',
	'Set Publishing Paths' => 'Publicatiepaden instellen',
	'Manage Categories' => 'Categorieën beheren',
	'Manage Tags' => 'Tags beheren',
	'Manage Address Book' => 'Adresboek beheren',
	'View Activity Log' => 'Activiteitenlog bekijken',
	'Create Entries' => 'Berichten aanmaken',
	'Send Notifications' => 'Notificaties verzenden',
	'Edit All Entries' => 'Alle berichten bewerken',
	'Manage Pages' => 'Pagina\'s beheren',
	'Publish Blog' => 'Blog publiceren',
	'Save Image Defaults' => 'Standaardinstellingen afbeeldingen opslaan',
	'Manage Assets' => 'Mediabestanden beheren',
	'Post Comments' => 'Reacties publiceren',
	'Manage Feedback' => 'Feedback beheren',
	'MySQL Database' => 'MySQL databank',
	'PostgreSQL Database' => 'PostgreSQL databank',
	'SQLite Database' => 'SQLite databank',
	'SQLite Database (v2)' => 'SQLite databank (v2)',
	'Convert Line Breaks' => 'Regeleindes omzetten',
	'Rich Text' => 'Rich text',
	'Movable Type Default' => 'Movable Type standaardinstelling',
	'weblogs.com' => 'weblogs.com',
	'technorati.com' => 'technorati.com',
	'google.com' => 'google.com',
	'Classic Blog' => 'Klassieke weblog',
	'Publishes content.' => 'Publiceert inhoud.',
	'Synchronizes content to other server(s).' => 'Synchroniseert inhoud naar andere server(s).',
	'zip' => 'zip',
	'tar.gz' => 'tar.gz',
	'Entries List' => 'Lijst berichten',
	'Blog URL' => 'Blog-URL',
	'Blog ID' => 'Blog ID',
	'Entry Excerpt' => 'Berichtuittreksel',
	'Entry Link' => 'Link bericht',
	'Entry Extended Text' => 'Uitgebreide tekst bericht',
	'Entry Title' => 'Berichttitel',
	'If Block' => 'If blok',
	'If/Else Block' => 'If/Else blok',
	'Include Template Module' => 'Sjabloonmodule includeren',
	'Include Template File' => 'Sjabloonbestand includeren',
	'Get Variable' => 'Haal variabele op',
	'Set Variable' => 'Stel variabele in',
	'Set Variable Block' => 'Stel variabel blok in',
	'Publish Scheduled Entries' => 'Publiceer geplande berichten',
	'Junk Folder Expiration' => 'Vervaldatum spam-map',
	'Remove Temporary Files' => 'Tijdelijke bestanden verwijderen',
	'Remove Expired User Sessions' => 'Verlopen gebruikerssessies verwijderen',

## lib/MT/ObjectTag.pm
	'Tag Placement' => 'Tagplaatsing',
	'Tag Placements' => 'Tagplaatsingen',

## lib/MT/Author.pm
	'The approval could not be committed: [_1]' => 'De goedkeuring kon niet worden weggeschreven: [_1]',

## lib/MT/XMLRPC.pm
	'No WeblogsPingURL defined in the configuration file' => 'Geen WeblogsPingURL opgegeven in het configuratiebestand',
	'No MTPingURL defined in the configuration file' => 'Geen MTPingURL opgegeven in het configuratiebestand',
	'HTTP error: [_1]' => 'HTTP fout: [_1]',
	'Ping error: [_1]' => 'Ping fout: [_1]',

## lib/MT/ObjectAsset.pm
	'Asset Placement' => 'Assetplaatsing',

## lib/MT/BackupRestore.pm
	'Backing up [_1] records:' => 'Er worden [_1] records gebackupt:',
	'[_1] records backed up...' => '[_1] records gebackupt...',
	'[_1] records backed up.' => '[_1] records gebackupt.',
	'There were no [_1] records to be backed up.' => 'Er waren geen [_1] records om te backuppen.',
	'Can\'t open directory \'[_1]\': [_2]' => 'Kan map \'[_1]\' niet openen: [_2]',
	'No manifest file could be found in your import directory [_1].' => 'Er werd geen manifest-bestand gevonden in de importdirectory [_1].',
	'Can\'t open [_1].' => 'Kan [_1] niet openen.',
	'Manifest file [_1] was not a valid Movable Type backup manifest file.' => 'Manifest-bestand [_1] was geen geldig Movable Type backup manifest-bestand.',
	'Manifest file: [_1]' => 'Manifestbestand: [_1]',
	'Path was not found for the file ([_1]).' => 'Geen pad gevonden voor het bestadn ([_1]).',
	'[_1] is not writable.' => '[_1] is niet beschrijfbaar.',
	'Error making path \'[_1]\': [_2]' => 'Fout bij aanmaken pad \'[_1]\': [_2]',
	'Copying [_1] to [_2]...' => 'Bezig [_1] te copiëren naar [_2]...',
	'Failed: ' => 'Mislukt: ',
	'Done.' => 'Klaar.',
	'Restoring asset associations ... ( [_1] )' => 'Associaties met mediabestanden aan het terugzetten ... ( [_1] )',
	'Restoring asset associations in entry ... ( [_1] )' => 'Associaties met mediabestanden aan het terugzetten in bericht ... ( [_1] )',
	'Restoring asset associations in page ... ( [_1] )' => 'Associaties met mediabestanden aan het terugzetten in pagina... ( [_1] )',
	'Restoring url of the assets ( [_1] )...' => 'URL van de mediabestanden aan het terugzetten ( [_1] )...',
	'Restoring url of the assets in entry ( [_1] )...' => 'URL van de mediabestanden aan het terugzetten in bercht ( [_1] )...',
	'Restoring url of the assets in page ( [_1] )...' => 'URL van de mediabestanden aan het terugzetten in pagina ( [_1] )...',
	'ID for the file was not set.' => 'ID van het bestand was niet ingesteld.',
	'The file ([_1]) was not restored.' => 'Het bestand ([_1]) werd niet teruggezet.',
	'Changing path for the file \'[_1]\' (ID:[_2])...' => 'Pad voor bestand \'[_1]\' (ID:[_2]) wordt aangepast...',

## lib/MT/TemplateMap.pm
	'Archive Mapping' => 'Archiefkoppeling',
	'Archive Mappings' => 'Archiefkoppelingen',

## lib/MT/ConfigMgr.pm
	'Alias for [_1] is looping in the configuration.' => 'Alias voor [_1] zit in een lus in de configuratie',
	'Error opening file \'[_1]\': [_2]' => 'Fout bij openen bestand \'[_1]\': [_2]',
	'Config directive [_1] without value at [_2] line [_3]' => 'Configuratie-directief [_1] zonder waarde in [_2] lijn [_3]',
	'No such config variable \'[_1]\'' => 'Onbekende configuratievariabele \'[_1]\'',

## lib/MT/Association.pm
	'Association' => 'Associatie',
	'association' => 'associatie',
	'associations' => 'associaties',

## lib/MT/Blog.pm
	'No default templates were found.' => 'Er werden geen standaardsjablonen gevonden.',
	'Cloned blog... new id is [_1].' => 'Blog gekloond... nieuw ID is [_1]',
	'Cloning permissions for blog:' => 'Permissies worden gekloond voor blog:',
	'[_1] records processed...' => '[_1] items verwerkt...',
	'[_1] records processed.' => '[_1] items verwerkt.',
	'Cloning associations for blog:' => 'Associaties worden gekloond voor blog:',
	'Cloning entries for blog...' => 'Berichten worden gekloond voor blog...',
	'Cloning categories for blog...' => 'Categorieën worden gekloond voor blog...',
	'Cloning entry placements for blog...' => 'Berichtcategorieën wordt gekloond voor blog...',
	'Cloning comments for blog...' => 'Reacties worden gekloond voor blog...',
	'Cloning entry tags for blog...' => 'Berichttags worden gekloond voor blog...',
	'Cloning TrackBacks for blog...' => 'Trackbacks worden gekloond voor blog...',
	'Cloning TrackBack pings for blog...' => 'TrackBack pings worden gekloond voor blog...',
	'Cloning templates for blog...' => 'Sjablonen worden gekloond voor blog...',
	'Cloning template maps for blog...' => 'Sjabloonkoppelingen worden gekloond voor blog...',
	'blog' => 'blog',
	'blogs' => 'blogs',

## lib/MT/TBPing.pm

## lib/MT/Builder.pm
	'<[_1]> at line [_2] is unrecognized.' => '<[_1]> op regel [_2] is niet herkend',
	'<[_1]> with no </[_1]> on line #' => '<[_1]> zonder </[_1]> op regel #',
	'<[_1]> with no </[_1]> on line [_2].' => '<[_1]> zonder </[_1]> op regel [_2].',
	'<[_1]> with no </[_1]> on line [_2]' => '<[_1]> zonder </[_1]> op regel [_2]',
	'Error in <mt:[_1]> tag: [_2]' => 'Fout in <mt:[_1]> tag: [_2]',
	'Unknown tag found: [_1]' => 'Onbekende tag gevonden: [_1]',

## lib/MT/ObjectScore.pm
	'Object Score' => 'Objectscore',
	'Object Scores' => 'Objectscores',

## lib/MT/Import.pm
	'Can\'t rewind' => 'Kan niet terugspoelen',
	'No readable files could be found in your import directory [_1].' => 'Er werden geen leesbare bestanden gevonden in uw importmap [_1].',
	'Importing entries from file \'[_1]\'' => 'Berichten worden ingevoerd uit bestand  \'[_1]\'',
	'Couldn\'t resolve import format [_1]' => 'Kon importformaat niet onderscheiden [_1]',
	'Movable Type' => 'Movable Type',
	'Another system (Movable Type format)' => 'Een ander systeem (Movable Type formaat)',

## lib/MT/Folder.pm

## lib/MT/Tag.pm
	'Tag must have a valid name' => 'Tag moet een geldige naam hebben',
	'This tag is referenced by others.' => 'Deze tag is gerefereerd door anderen.',

## lib/MT/App.pm
	'First Weblog' => 'Eerste weblog',
	'Error loading blog #[_1] for user provisioning. Check your NewUserTemplateBlogId setting.' => 'Fout bij het laden van blog #[_1] tijdens gebruikersprovisie.  Controleer uw NewUserTemplateBlogId instelling.',
	'Error provisioning blog for new user \'[_1]\' using template blog #[_2].' => 'Fout bij het aanmaken van een blog voor nieuwe gebruiker \'[_1]\' met blog #[_1] als sjabloonblog.',
	'Error creating directory [_1] for blog #[_2].' => 'Fout bij het aanmaken van map [_1] voor blog #[_2].',
	'Error provisioning blog for new user \'[_1] (ID: [_2])\'.' => 'Fout bij het aanmaken van een blog voor nieuwe gebruiker \'[_1] (ID: [_2])\'.',
	'Blog \'[_1] (ID: [_2])\' for user \'[_3] (ID: [_4])\' has been created.' => 'Blog \'[_1] (ID: [_2])\' voor gebruiker \'[_3] (ID: [_4])\' werd aangemaakt.',
	'Error assigning blog administration rights to user \'[_1] (ID: [_2])\' for blog \'[_3] (ID: [_4])\'. No suitable blog administrator role was found.' => 'Fout bij het toekennen van blog administratierechten aan gebruiker \'[_1] (ID: [_2])\' op blog \'[_3] (ID: [_4])\'.  Er werd geen geschikte blog administrator rol gevonden.',
	'The login could not be confirmed because of a database error ([_1])' => 'Het aanmelden kon niet worden bevestigd wegens een databaseprobleem ([_1])',
	'Our apologies, but you do not have permission to access any blogs within this installation. If you feel you have reached this message in error, please contact your Movable Type system administrator.' => 'Onze excuses, maar u heeft geen permissies om toegang te krijgen tot één of meer blogs op deze installatie.  Als u meent dat u dit bericht onterecht te zien krijgt, gelieve uw Movable Type systeembeheerder te contacteren.',
	'This account has been disabled. Please see your system administrator for access.' => 'Deze account werd uitgeschakeld.  Contacteer uw systeembeheerder om weer toegang te krijgen.',
	'Failed login attempt by pending user \'[_1]\'' => 'Mislukte poging tot aanmelden van een gebruiker \'[_1]\' die nog gekeurd moet worden',
	'This account has been deleted. Please see your system administrator for access.' => 'Deze account werd verwijderd.  Contacteer uw systeembeheerder om weer toegang te krijgen.',
	'User cannot be created: [_1].' => 'Gebruiker kan niet worden aangemaakt: [_1].',
	'User \'[_1]\' has been created.' => 'Gebruiker \'[_1]\' is aangemaakt',
	'User \'[_1]\' (ID:[_2]) logged in successfully' => 'Gebruiker \'[_1]\' (ID:[_2]) met succes aangemeld',
	'Invalid login attempt from user \'[_1]\'' => 'Ongeldige poging tot aanmelden van gebruiker \'[_1]\'',
	'User \'[_1]\' (ID:[_2]) logged out' => 'Gebruiker \'[_1]\' (ID:[_2]) werd afgemeld',
	'User requires password.' => 'Gebruiker heeft wachtwoord nodig.',
	'User requires password recovery word/phrase.' => 'Gebruiker heeft woord/zin om het wachtwoord terug te vinden nodig.',
	'User requires username.' => 'Gebruiker heeft gebruikersnaam nodig.',
	'User requires display name.' => 'Gebruiker heeft getoonde naam nodig.',
	'Email Address is required for password recovery.' => 'E-mail adres is vereist om het wachtwoord te kunnen terugvinden.',
	'Something wrong happened when trying to process signup: [_1]' => 'Er ging iets mis bij het verwerken van de registratie: [_1]',
	'New Comment Added to \'[_1]\'' => 'Nieuwe reactie achtergelaten op \'[_1]\'',
	'Close' => 'Sluiten',
	'The file you uploaded is too large.' => 'Het bestand dat u heeft geupload is te groot.',
	'Unknown action [_1]' => 'Onbekende actie [_1]',
	'Warnings and Log Messages' => 'Waarschuwingen en logberichten',
	'Removed [_1].' => '[_1] verwijderd.',

## lib/MT/Log.pm
	'System' => 'Systeem',
	'Page # [_1] not found.' => 'Pagina # [_1] niet gevonden.',
	'Entry # [_1] not found.' => 'Bericht # [_1] niet gevonden.',
	'Comment # [_1] not found.' => 'Reactie # [_1] niet gevonden.',
	'TrackBack # [_1] not found.' => 'TrackBack # [_1] niet gevonden.',

## lib/MT/IPBanList.pm
	'IP Ban' => 'IP ban',
	'IP Bans' => 'IP bans',

## lib/MT/AtomServer.pm
	'PreSave failed [_1]' => 'PreSave mislukt [_1]',
	'User \'[_1]\' (user #[_2]) added [lc,_4] #[_3]' => 'Gebruiker \'[_1]\' (gebruiker #[_2]) voegde [lc,_4] #[_3] toe',
	'User \'[_1]\' (user #[_2]) edited [lc,_4] #[_3]' => 'Gebruiker \'[_1]\' (gebruiker #[_2]) bewerkte [lc,_4] #[_3]',

## lib/MT/PluginData.pm
	'Plugin Data' => 'Plugindata',

## lib/MT/Plugin.pm
	'Publish' => 'Publiceren',
	'My Text Format' => 'Mijn tekstformaat',

## lib/MT/Role.pm
	'Role' => 'Rol',

## lib/MT/Entry.pm
	'Draft' => 'Klad',
	'Review' => 'Na te kijken',
	'Future' => 'Toekomstig',

## lib/MT/Config.pm
	'Configuration' => 'Configuratie',

## lib/MT/Template.pm
	'Template' => 'Sjabloon',
	'Error reading file \'[_1]\': [_2]' => 'Fout bij het lezen van bestand \'[_1]\': [_2]',
	'Publish error in template \'[_1]\': [_2]' => 'Publicatiefout in sjabloon \'[_1]\': [_2]',
	'Template with the same name already exists in this blog.' => 'Er bestaat al een sjabloon met dezelfde naam in deze weblog.',
	'You cannot use a [_1] extension for a linked file.' => 'U kunt geen [_1] extensie gebruiken voor een gelinkt bestand.',
	'Opening linked file \'[_1]\' failed: [_2]' => 'Gelinkt bestand \'[_1]\' openen mislukt: [_2]',
	'Index' => 'Index',
	'Category Archive' => 'Archief per categorie',
	'Comment Listing' => 'Overzicht reacties',
	'Ping Listing' => 'Overzicht pings',
	'Comment Preview' => 'Voorbeeld reactie',
	'Comment Error' => 'Reactie fout',
	'Dynamic Error' => 'Dynamische fout',
	'Uploaded Image' => 'Opgeladen afbeelding',
	'Module' => 'Module',
	'Widget' => 'Widget',

## lib/MT/ImportExport.pm
	'No Blog' => 'Geen blog',
	'Need either ImportAs or ParentAuthor' => 'ImportAs ofwel ParentAuthor vereist',
	'Creating new user (\'[_1]\')...' => 'Nieuwe gebruiker (\'[_1]\') wordt aangemaakt...',
	'Saving user failed: [_1]' => 'Gebruiker opslaan mislukt: [_1]',
	'Assigning permissions for new user...' => 'Permissies worden toegekend aan nieuwe gebruiker...',
	'Saving permission failed: [_1]' => 'Permissies opslaan mislukt: [_1]',
	'Creating new category (\'[_1]\')...' => 'Nieuwe categorie wordt aangemaakt (\'[_1]\')...',
	'Invalid status value \'[_1]\'' => 'Ongeldige statuswaarde \'[_1]\'',
	'Invalid allow pings value \'[_1]\'' => 'Ongeldige instelling voor het toelaten van pings \'[_1]\'',
	'Can\'t find existing entry with timestamp \'[_1]\'... skipping comments, and moving on to next entry.' => 'Kan geen bestaand bericht vinden met tijdstip \'[_1]\'... reacties worden overgeslagen, verder naar volgende bericht.',
	'Importing into existing entry [_1] (\'[_2]\')' => 'Aan het importeren in bestaand bericht [_1] (\'[_2]\')',
	'Saving entry (\'[_1]\')...' => 'Bericht aan het opslaan (\'[_1]\')...',
	'ok (ID [_1])' => 'ok (ID [_1])',
	'Saving entry failed: [_1]' => 'Bericht opslaan mislukt: [_1]',
	'Creating new comment (from \'[_1]\')...' => 'Nieuwe reactie aan het aanmaken (van \'[_1]\')...',
	'Saving comment failed: [_1]' => 'Reactie opslaan mislukt: [_1]',
	'Entry has no MT::Trackback object!' => 'Bericht heeft geen MT::Trackback object!',
	'Creating new ping (\'[_1]\')...' => 'Nieuwe ping aan het aanmaken (\'[_1]\')...',
	'Saving ping failed: [_1]' => 'Ping opslaan mislukt: [_1]',
	'Export failed on entry \'[_1]\': [_2]' => 'Export mislukt bij bericht \'[_1]\': [_2]',
	'Invalid date format \'[_1]\'; must be \'MM/DD/YYYY HH:MM:SS AM|PM\' (AM|PM is optional)' => 'Ongeldig datumformaat \'[_1]\'; dit moet \'MM/DD/JJJJ HH:MM:SS AM|PM\' zijn (AM|PM is optioneel)',

## lib/MT/JunkFilter.pm
	'Action: Junked (score below threshold)' => 'Handeling: Verworpen (score onder drempel)',
	'Action: Published (default action)' => 'Handeling: Gepubliceerd (standaardhandeling)',
	'Junk Filter [_1] died with: [_2]' => 'Spamfilter [_1] liep vast met: [_2]',
	'Unnamed Junk Filter' => 'Naamloze spamfilter',
	'Composite score: [_1]' => 'Samengestelde score: [_1]',

## lib/MT/Util.pm
	'moments from now' => 'ogenblikken in de toekomst',
	'moments ago' => 'ogenblikken geleden',
	'[quant,_1,hour,hours] from now' => 'over [quant,_1,uur,uur]',
	'[quant,_1,hour,hours] ago' => '[quant,_1,uur,uur] geleden',
	'[quant,_1,minute,minutes] from now' => 'over [quant,_1,minuut,minuten]',
	'[quant,_1,minute,minutes] ago' => '[quant,_1,minuut,minuten] geleden',
	'[quant,_1,day,days] from now' => 'over [quant,_1,dag,dagen]',
	'[quant,_1,day,days] ago' => '[quant,_1,dag,dagen] geleden',
	'less than 1 minute from now' => 'binnen minder dan 1 minuut',
	'less than 1 minute ago' => 'minder dan 1 minuut geleden',
	'[quant,_1,hour,hours], [quant,_2,minute,minutes] from now' => 'over [quant,_1,uur,uur] en [quant,_2,minuut,minuten]',
	'[quant,_1,hour,hours], [quant,_2,minute,minutes] ago' => '[quant,_1,uur,uur], [quant,_2,minuut,minuten] geleden',
	'[quant,_1,day,days], [quant,_2,hour,hours] from now' => 'over [quant,_1,dag,dagen] en [quant,_2,uur,uur]',
	'[quant,_1,day,days], [quant,_2,hour,hours] ago' => '[quant,_1,dag,dagen] en [quant,_2,uur,uur] geleden',

## lib/MT/Mail.pm
	'Unknown MailTransfer method \'[_1]\'' => 'Onbekende MailTransfer methode \'[_1]\'',
	'Sending mail via SMTP requires that your server have Mail::Sendmail installed: [_1]' => 'Het versturen van e-mail via SMTP vereist dat op uw server Mail::Sendmail is geïnstalleerd: [_1]',
	'Error sending mail: [_1]' => 'Fout bij versturen mail: [_1]',
	'You do not have a valid path to sendmail on your machine. Perhaps you should try using SMTP?' => 'U heeft geen geldig pad naar sendmail op uw machine.  Misschien moet u proberen om SMTP te gebruiken?',
	'Exec of sendmail failed: [_1]' => 'Exec van sendmail mislukt: [_1]',

## lib/MT/Permission.pm
	'Permission' => 'Permissie',
	'Permissions' => 'Permissies',

## lib/MT/Scorable.pm
	'Object must be saved first.' => 'Object moet eerst worden opgeslagen',
	'Already scored for this object.' => 'Aan dit object is reeds een score toegekend.',
	'Could not set score to the object \'[_1]\'(ID: [_2])' => 'Kon score niet instellen voor object \'[_1]\'(ID: [_2])',

## lib/MT/XMLRPCServer.pm
	'Invalid timestamp format' => 'Ongeldig timestamp formaat',
	'No web services password assigned.  Please see your user profile to set it.' => 'Geen web services wachtwoord ingesteld.  Ga naar uw gebruikersprofiel om het in te stellen.',
	'Requested permalink \'[_1]\' is not available for this page' => 'Gevraagde permalink \'[_1]\' is niet beschikbaar voor deze pagina',
	'Saving folder failed: [_1]' => 'Map opslaan mislukt: [_1]',
	'No blog_id' => 'Geen blog_id',
	'Invalid blog ID \'[_1]\'' => 'Ongeldig blog ID \'[_1]\'',
	'Value for \'mt_[_1]\' must be either 0 or 1 (was \'[_2]\')' => 'Waarde voor \'mt_[_1]\' moet 0 of 1 zijn (was \'[_2]\')',
	'Not privileged to edit entry' => 'Geen rechten om bericht te bewerken',
	'Entry \'[_1]\' ([lc,_5] #[_2]) deleted by \'[_3]\' (user #[_4]) from xml-rpc' => 'Bericht \'[_1]\' ([lc,_5] #[_2]) verwijderd door \'[_3]\' (gebruiker #[_4]) via xml-rpc',
	'Not privileged to get entry' => 'Geen rechten om bericht op te halen',
	'Not privileged to set entry categories' => 'Geen rechten om berichtcategorieën in te stellen',
	'Not privileged to upload files' => 'Geen rechten om bestenden te uploaden',
	'No filename provided' => 'Geen bestandsnaam opgegeven',
	'Error writing uploaded file: [_1]' => 'Fout bij het schrijven van opgeladen bestand: [_1]',
	'Template methods are not implemented, due to differences between the Blogger API and the Movable Type API.' => 'Sjabloonmethodes zijn niet geïmplementeerd wegens het verschil tussen de Blogger API en de Movable Type API.',

## lib/MT/WeblogPublisher.pm
	'yyyy/index.html' => 'jjjj/index.html',
	'yyyy/mm/index.html' => 'jjjj/mm/index.html',
	'yyyy/mm/day-week/index.html' => 'jjjj/mm/dag-week/index.html',
	'yyyy/mm/entry-basename.html' => 'jjjj/mm/basisnaam-bericht.html',
	'yyyy/mm/entry_basename.html' => 'jjjj/mm/basisnaam_bericht.html',
	'yyyy/mm/entry-basename/index.html' => 'jjjj/mm/basisnaam-bericht/index.html',
	'yyyy/mm/entry_basename/index.html' => 'jjjj/mm/basisnaam_bericht/index.html',
	'yyyy/mm/dd/entry-basename.html' => 'jjjj/mm/dd/basisnaam-bericht.html',
	'yyyy/mm/dd/entry_basename.html' => 'jjjj/mm/dd/basisnaam_bericht.html',
	'yyyy/mm/dd/entry-basename/index.html' => 'jjjj/mm/dd/basisnaam-bericht/index.html',
	'yyyy/mm/dd/entry_basename/index.html' => 'jjjj/mm/dd/basisnaam_bericht/index.html',
	'category/sub-category/entry-basename.html' => 'categorie/sub-categorie/basisnaam-bericht.html',
	'category/sub-category/entry-basename/index.html' => 'categorie/sub-categorie/basisnaam-bericht/index.html',
	'category/sub_category/entry_basename.html' => 'categorie/sub_categorie/basisnaam_bericht.html',
	'category/sub_category/entry_basename/index.html' => 'categorie/sub_categorie/basisnaam_bericht/index.html',
	'folder-path/page-basename.html' => 'map-pad/basisnaam-pagina.html',
	'folder-path/page-basename/index.html' => 'map-pad/basisnaam-pagina/index.html',
	'folder_path/page_basename.html' => 'map_pad/basisnaam_pagina.html',
	'folder_path/page_basename/index.html' => 'map_pad/basisnaam_pagina/index.html',
	'folder/sub_folder/index.html' => 'map/sub_map/index.html',
	'folder/sub-folder/index.html' => 'map/sub-map/index.html',
	'yyyy/mm/dd/index.html' => 'jjjj/mm/dd/index.html',
	'category/sub-category/index.html' => 'categorie/sub-categorie/index.html',
	'category/sub_category/index.html' => 'categorie/sub_categorie/index.html',
	'Archive type \'[_1]\' is not a chosen archive type' => 'Archieftype \'[_1]\' is geen gekozen archieftype',
	'Parameter \'[_1]\' is required' => 'Parameter \'[_1]\' is vereist',
	'You did not set your blog publishing path' => 'U stelde geen blogpublicatiepad in',
	'The same archive file exists. You should change the basename or the archive path. ([_1])' => 'Hetzelfde archiefbestand bestaat al. U moet de basisnaam of het archiefpad wijzigen. ([_1])',
	'An error occurred publishing [_1] \'[_2]\': [_3]' => 'Er deed zich een fout voor bij het publiceren van [_1] \'[_2]\': [_3]',
	'An error occurred publishing date-based archive \'[_1]\': [_2]' => 'Er deed zich een fout voor bij het publiceren van datum-gebaseerd archief \'[_1]\': [_2]',
	'Writing to \'[_1]\' failed: [_2]' => 'Schrijven naar \'[_1]\' mislukt: [_2]',
	'Renaming tempfile \'[_1]\' failed: [_2]' => 'Tijdelijk bestand \'[_1]\' van naam veranderen mislukt: [_2]',
	'Template \'[_1]\' does not have an Output File.' => 'Sjabloon \'[_1]\' heeft geen uitvoerbestand.',
	'An error occurred while publishing scheduled entries: [_1]' => 'Er deed zich een fout voor bij het publiceren van van geplande berichten: [_1]',
	'YEARLY_ADV' => 'per jaar',
	'MONTHLY_ADV' => 'per maand',
	'CATEGORY_ADV' => 'per categorie',
	'PAGE_ADV' => 'per pagina',
	'INDIVIDUAL_ADV' => 'per bericht',
	'DAILY_ADV' => 'per dag',
	'WEEKLY_ADV' => 'per week',
	'Author (#[_1])' => 'Auteur (#[_1])',
	'AUTHOR_ADV' => 'per auteur',
	'AUTHOR-YEARLY_ADV' => 'per auteur per jaar',
	'AUTHOR-MONTHLY_ADV' => 'per auteur per maand',
	'AUTHOR-WEEKLY_ADV' => 'per auteur per week',
	'AUTHOR-DAILY_ADV' => 'per auteur per dag',
	'CATEGORY-YEARLY_ADV' => 'per categorie per jaar',
	'CATEGORY-MONTHLY_ADV' => 'per categorie per maand',
	'CATEGORY-DAILY_ADV' => 'per categorie per dag',
	'CATEGORY-WEEKLY_ADV' => 'per categorie per week',
	'author-display-name/index.html' => 'naam-auteur/index.html',
	'author_display_name/index.html' => 'naam_auteur/index.html',
	'author-display-name/yyyy/index.html' => 'naam-auteur/jjjj/index.html',
	'author_display_name/yyyy/index.html' => 'naam_auteur/jjjj/index.html',
	'author-display-name/yyyy/mm/index.html' => 'naam-auteur/jjjj/mm/index.html',
	'author_display_name/yyyy/mm/index.html' => 'naam_auteur/jjjj/mm/index.html',
	'author-display-name/yyyy/mm/day-week/index.html' => 'naam-auteur/jjjj/mm/dag-week/index.html',
	'author_display_name/yyyy/mm/day-week/index.html' => 'naam_auteur/jjjj/mm/dag-week/index.html',
	'author-display-name/yyyy/mm/dd/index.html' => 'naam-auteur/jjjj/mm/dd/index.html',
	'author_display_name/yyyy/mm/dd/index.html' => 'naam_auteur/jjjj/mm/dd/index.html',
	'category/sub-category/yyyy/index.html' => 'categorie/sub-categorie/jjjj/index.html',
	'category/sub_category/yyyy/index.html' => 'categorie/sub_categorie/jjjj/index.html',
	'category/sub-category/yyyy/mm/index.html' => 'categorie/sub-categorie/jjjj/mm/index.html',
	'category/sub_category/yyyy/mm/index.html' => 'categorie/sub_categorie/jjjj/mm/index.html',
	'category/sub-category/yyyy/mm/dd/index.html' => 'categorie/sub-categorie/jjjj/dd/index.html',
	'category/sub_category/yyyy/mm/dd/index.html' => 'categorie/sub_categorie/jjjj/dd/index.html',
	'category/sub-category/yyyy/mm/day-week/index.html' => 'categorie/sub-categorie/jjjj/mm/dag-week/index.html',
	'category/sub_category/yyyy/mm/day-week/index.html' => 'categorie/sub_categorie/jjjj/mm/dag-week/index.html',

## lib/MT/Auth.pm
	'Bad AuthenticationModule config \'[_1]\': [_2]' => 'Foute AuthenticationModule configuratie \'[_1]\': [_2]',
	'Bad AuthenticationModule config' => 'Foute AuthenticationModule configuratie',

## lib/MT/Comment.pm
	'Comment' => 'Reactie',
	'Load of entry \'[_1]\' failed: [_2]' => 'Laden van bericht \'[_1]\' mislukt: [_2]',

## lib/MT/Component.pm
	'Loading template \'[_1]\' failed: [_2]' => 'Sjabloon \'[_1]\' laden mislukt: [_2]',

## lib/MT/DefaultTemplates.pm
	'Archive Index' => 'Archiefindex',
	'Stylesheet' => 'Stylesheet',
	'JavaScript' => 'JavaScript',
	'RSD' => 'RSD',
	'Atom' => 'Atom',
	'RSS' => 'RSS',
	'Entry Listing' => 'Overzicht berichten',
	'Displays error, pending or confirmation message for comments.' => 'Toont foutboodschappen, bevestigingen en \'even geduld\' berichten voor reacties.',
	'Displays preview of comment.' => 'Toont voorbeeld van reactie.',
	'Displays errors for dynamically published templates.' => 'Toont fouten bij dynamisch gepubliceerde sjablonen.',
	'Popup Image' => 'Pop-up afbeelding',
	'Displays image when user clicks a popup-linked image.' => 'Toont afbeelding wanneer de gebruiker op een afbeelding klikt die in een popup verschijnt.',
	'Displays results of a search.' => 'Toont zoekresultaten',
	'Footer' => 'Voettekst',
	'Sidebar - 2 Column Layout' => 'Zijkolom - Tweekolomslay-out',
	'Sidebar - 3 Column Layout' => 'Zijkolom - Driekolomslay-out',
	'Comment throttle' => 'Beperking reacties',
	'Commenter Confirm' => 'Bevestiging reageerder',
	'Commenter Notify' => 'Notificatie reageerder',
	'New Comment' => 'Nieuwe reactie',
	'New Ping' => 'Nieuwe ping',
	'Entry Notify' => 'Notificatie bericht',
	'Subscribe Verify' => 'Verificatie inschrijving',

## lib/MT.pm.pre
	'Powered by [_1]' => 'Aangedreven door [_1]',
	'Version [_1]' => 'Versie [_1]',
	'http://www.sixapart.com/movabletype/' => 'http://www.sixapart.com/movabletype',
	'OpenID URL' => 'OpenID URL',
	'Sign in using your OpenID identity.' => 'Aanmelden met uw OpenID identiteit.',
	'OpenID is an open and decentralized single sign-on identity system.' => 'OpenID is een open en gedecentraliseerd single sign-on identiteitssysteem.',
	'Sign In' => 'Aanmelden',
	'Learn more about OpenID.' => 'Meer weten over OpenID.',
	'Your LiveJournal Username' => 'Uw LiveJournal gebruikersnaam',
	'Sign in using your Vox blog URL' => 'Aanmelden met de URL van uw Vox blog',
	'Learn more about LiveJournal.' => 'Meer weten over LiveJournal.',
	'Your Vox Blog URL' => 'URL van uw Vox blog',
	'Learn more about Vox.' => 'Meer weten over Vox.',
	'TypeKey is a free, open system providing you a central identity for posting comments on weblogs and logging into other websites. You can register for free.' => 'TypeKey is een gratis, open systtem dat uw een centrale identiteit verschaft om te reageren op weblogs en om u mee aan te melden op andere websites.  U kunt hier gratis registreren.',
	'Sign in or register with TypeKey.' => 'Aanmelden of registreren via TypeKey',
	'Hello, world' => 'Hello, world',
	'Hello, [_1]' => 'Hallo, [_1]',
	'Message: [_1]' => 'Bericht: [_1]',
	'If present, 3rd argument to add_callback must be an object of type MT::Component or MT::Plugin' => 'Indien aanwezig, moet het derde argument van add_callback een object zijn van het type MT::Component of MT::Plugin',
	'4th argument to add_callback must be a CODE reference.' => '4th argument van add_callback moet een CODE referentie zijn.',
	'Two plugins are in conflict' => 'Twee plugins zijn in conflict',
	'Invalid priority level [_1] at add_callback' => 'Ongeldig prioriteitsniveau [_1] in add_callback',
	'Unnamed plugin' => 'Naamloze plugin',
	'[_1] died with: [_2]' => '[_1] faalde met volgende boorschap: [_2]',
	'Bad ObjectDriver config' => 'Fout in ObjectDriver configuratie',
	'Bad CGIPath config' => 'Fout in CGIPath configuratie',
	'Missing configuration file. Maybe you forgot to move mt-config.cgi-original to mt-config.cgi?' => 'Ontbrekend configuratiebestand.  Misschien vergat u mt-config.cgi-original te hernoemen naar mt-config.cgi?',
	'Plugin error: [_1] [_2]' => 'Plugin fout: [_1] [_2]',
	'Loading template \'[_1]\' failed.' => 'Laden van sjabloon \'[_1]\' mislukt.',
	'__PORTAL_URL__' => '', # Translate - New
	'http://www.movabletype.org/documentation/' => 'http://www.movabletype.org/documentation/',
	'OpenID' => 'OpenID',
	'LiveJournal' => 'LiveJournal',
	'Vox' => 'Vox',
	'TypeKey' => 'TypeKey',
	'Movable Type default' => 'Standaard Movable Type',

## mt-static/js/dialog.js
	'(None)' => '(Geen)',

## mt-static/js/assetdetail.js
	'No Preview Available' => 'Geen voorbeeld beschikbaar',
	'View uploaded file' => 'Opgeladen bestand bekijken',

## mt-static/mt.js
	'delete' => 'verwijderen',
	'remove' => 'verwijderen',
	'enable' => 'activeren',
	'disable' => 'desactiveren',
	'You did not select any [_1] to [_2].' => 'U selecteerde geen [_1] om te [_2].',
	'Are you sure you want to [_2] this [_1]?' => 'Opgelet: [_1] echt [_2]?',
	'Are you sure you want to [_3] the [_1] selected [_2]?' => 'Bent u zeker dat u deze [_1] geselecteerde [_2] wenst te [_3]?',
	'Are you certain you want to remove this role? By doing so you will be taking away the permissions currently assigned to any users and groups associated with this role.' => 'Bent u zeker dat u deze rol wenst te verwijderen?  Door dit te doen worden de permissies weggenomen van gebruikers en groepen die momenteel met deze rol geassocieerd zijn.',
	'Are you certain you want to remove these [_1] roles? By doing so you will be taking away the permissions currently assigned to any users and groups associated with these roles.' => 'Bent u zeker dat u deze [_1] rollen wenst te verwijderen?  Door dit te doen worden de permissies weggenomen van gebruikers en groepen die momenteel met deze rollen geassocieerd zijn.',
	'You did not select any [_1] [_2].' => 'U selecteerde geen [_1] [_2]',
	'You can only act upon a minimum of [_1] [_2].' => 'U kunt enkel een handeling uitvoeren om minimaal [_1] [_2].',
	'You can only act upon a maximum of [_1] [_2].' => 'U kunt enkel een handeling uitvoeren op maximum [_1] [_2].',
	'You must select an action.' => 'U moet een handeling selecteren',
	'to mark as spam' => 'om als spam aan te merken',
	'to remove spam status' => 'om spamstatus van te verwijderen',
	'Enter email address:' => 'Voer e-mail adres in:',
	'Enter URL:' => 'Voer URL in:',
	'The tag \'[_2]\' already exists. Are you sure you want to merge \'[_1]\' with \'[_2]\'?' => 'De tag \'[_2]\' bestaat al.  Bent u zeker dat u \'[_1]\' met \'[_2]\' wenst samen te voegen?',
	'The tag \'[_2]\' already exists. Are you sure you want to merge \'[_1]\' with \'[_2]\' across all weblogs?' => 'De tag \'[_2]\' bestaat al.  Bent u zeker dat u \'[_1]\' met \'[_2]\' wenst samen te voegen over alle weblogs?',
	'Loading...' => 'Laden...',
	'[_1] &ndash; [_2] of [_3]' => '[_1] &ndash; [_2] van [_3]',
	'[_1] &ndash; [_2]' => '[_1] &ndash; [_2]',

## search_templates/default.tmpl
	'SEARCH FEED AUTODISCOVERY LINK PUBLISHED ONLY WHEN A SEARCH HAS BEEN EXECUTED' => 'AUTODISCOVERY LINK VOOR ZOEKFEED WORDT ENKEL GEPUBLICEERD WANNEER EEN ZOEKOPDRACHT IS UITGEVOERD',
	'Blog Search Results' => 'Blog zoekresultaten',
	'Blog search' => 'Blog doorzoeken',
	'STRAIGHT SEARCHES GET THE SEARCH QUERY FORM' => 'GEWONE ZOEKOPDRACHTEN KRIJGEN HET ZOEKFORMULIER TE ZIEN',
	'Search this site' => 'Deze website doorzoeken',
	'Match case' => 'Kapitalisering moet overeen komen',
	'SEARCH RESULTS DISPLAY' => 'ZOEKRESULTATEN TONEN',
	'Matching entries from [_1]' => 'Gevonden berichten op [_1]',
	'Entries from [_1] tagged with \'[_2]\'' => 'Berichten op [_1] getagd met \'[_2]\'',
	'Posted <MTIfNonEmpty tag="EntryAuthorDisplayName">by [_1] </MTIfNonEmpty>on [_2]' => 'Gepubliceerd <MTIfNonEmpty tag="EntryAuthorDisplayName">door [_1] </MTIfNonEmpty>op [_2]',
	'Showing the first [_1] results.' => 'De eerste [_1] resultaten worden getoond.',
	'NO RESULTS FOUND MESSAGE' => 'GEEN RESULTATEN GEVONDEN BOODSCHAP',
	'Entries matching \'[_1]\'' => 'Berichten met \'[_1]\' in',
	'Entries tagged with \'[_1]\'' => 'Berichten getagd met \'[_1]\'',
	'No pages were found containing \'[_1]\'.' => 'Er werden geen berichten gevonden met \'[_1]\' in.',
	'By default, this search engine looks for all words in any order. To search for an exact phrase, enclose the phrase in quotes' => 'Standaard zoekt deze zoekmachine naar alle woorden in eender welke volgorde.  Om een precieze uitdrukking te vinden, moet ze tussen aanhalingstekens geplaatst worden',
	'The search engine also supports AND, OR, and NOT keywords to specify boolean expressions' => 'De zoekmachine ondersteunt ook AND, OR en NOT sleutelwoorden om booleaanse expressies mee op te geven',
	'END OF ALPHA SEARCH RESULTS DIV' => 'EINDE VAN ALPHA ZOEKRESULTATEN DIV',
	'BEGINNING OF BETA SIDEBAR FOR DISPLAY OF SEARCH INFORMATION' => 'BEGIN VAN BETA ZIJKOLOM OM ZOEKINFORMATIE IN TE TONEN',
	'SET VARIABLES FOR SEARCH vs TAG information' => 'STEL VARIABELEN IN VOOR ZOEK vs TAG informatie',
	'If you use an RSS reader, you can subscribe to a feed of all future entries tagged \'[_1]\'.' => 'Als u een RSS lezer gebruikt, kunt u inschrijven op een feed met alle toekomstige berichten met de tag \'[_1]\'.',
	'If you use an RSS reader, you can subscribe to a feed of all future entries matching \'[_1]\'.' => 'Als u een RSS lezer gebruikt, kunt u inschrijven op een feed met alle toekomstige berichten met \'[_1]\' in.',
	'SEARCH/TAG FEED SUBSCRIPTION INFORMATION' => 'ZOEK/TAG FEED INSCHRIJVINGSINFORMATIE',
	'Feed Subscription' => 'Feed inschrijving',
	'http://www.sixapart.com/about/feeds' => 'http://www.sixapart.com/about/feeds',
	'What is this?' => 'Wat is dit?',
	'TAG LISTING FOR TAG SEARCH ONLY' => 'TAG OPSOMMING ENKEL VOOR TAG ZOEKEN',
	'Other Tags' => 'Andere tags',
	'END OF PAGE BODY' => 'EINDE VAN PAGINA BODY',
	'END OF CONTAINER' => 'EINDE VAN CONTAINER',

## search_templates/results_feed.tmpl
	'Search Results for [_1]' => 'Zoekresultaten voor [_1]',

## search_templates/comments.tmpl
	'Search for new comments from:' => 'Zoeken naar reacties vanaf:',
	'the beginning' => 'het begin',
	'one week back' => 'een week geleden',
	'two weeks back' => 'twee weken geleden',
	'one month back' => 'een maand geleden',
	'two months back' => 'twee maanden geleden',
	'three months back' => 'drie maanden geleden',
	'four months back' => 'vier maanden geleden',
	'five months back' => 'vijf maanden geleden',
	'six months back' => 'zes maanden geleden',
	'one year back' => 'een jaar geleden',
	'Find new comments' => 'Nieuwe reacties zoeken',
	'Posted in [_1] on [_2]' => 'Gepubliceerd in [_1] op [_2]',
	'No results found' => 'Geen resultaten gevonden',
	'No new comments were found in the specified interval.' => 'Geen nieuwe reacties gevonden in het opgegeven interval.',
	'Select the time interval that you\'d like to search in, then click \'Find new comments\'' => 'Selecteer het tijdsinterval waarin u wenst te zoeken en klik dan op \'Nieuwe reacties zoeken\'',

## search_templates/results_feed_rss2.tmpl

## tmpl/wizard/optional.tmpl
	'Mail Configuration' => 'E-mail instellingen',
	'Your mail configuration is complete.' => 'Uw mailconfiguratie is volledig',
	'Check your email to confirm receipt of a test email from Movable Type and then proceed to the next step.' => 'Controleer uw e-mail om te bevestigen of uw een testmail van Movable Type heeft ontvangen en ga dan verder naar de volgende stap.',
	'Back' => 'Terug',
	'Continue' => 'Doorgaan',
	'Show current mail settings' => 'Toon alle huidige mailinstellingen',
	'Periodically Movable Type will send email to inform users of new comments as well as other other events. For these emails to be sent properly, you must instruct Movable Type how to send email.' => 'Movable Type zal af en toe e-mail versturen om gebruikers op de hoogte te brengen van nieuwe reacties en andere gebeurtenissen.  Om deze e-mails goed te kunnen versturen, moet u Movable Type vertellen hoe ze verstuurd moeten worden.',
	'An error occurred while attempting to send mail: ' => 'Er deed zich een fout voor toen er werd geprobeerd e-mail te verzenden: ',
	'Send email via:' => 'Stuur e-mail via',
	'Select One...' => 'Selecteer er één...',
	'sendmail Path' => 'sendmail pad',
	'The physical file path for your sendmail binary.' => 'Het fysieke bestandspad van uw sendmail binary',
	'Outbound Mail Server (SMTP)' => 'Uitgaande mailserver (SMTP)',
	'Address of your SMTP Server.' => 'Adres van uw SMTP server.',
	'Mail address for test sending' => 'E-mail adres om een testmail te sturen',
	'Send Test Email' => 'Verstuur testbericht',

## tmpl/wizard/complete.tmpl
	'Configuration File' => 'Configuratiebestand',
	'The [_1] configuration file can\'t be located.' => 'Het configuratiebestand [_1] kan niet worden gevonden',
	'Please use the configuration text below to create a file named \'mt-config.cgi\' in the root directory of [_1] (the same directory in which mt.cgi is found).' => 'Gelieve de configuratietekst hieronder te gebruiken om een bestand mee aan te maken genaamd \'mt-config.cgi\' in de hoofdmap van [_1] (dezelfde map waar u ook mt.cgi in aantreft).',
	'The wizard was unable to save the [_1] configuration file.' => 'De wizard kon het [_1] configuratiebestand niet opslaan.',
	'Confirm your [_1] home directory (the directory that contains mt.cgi) is writable by your web server and then click \'Retry\'.' => 'Controleer dat uw [_1] hoofdmap (de map waar mt.cgi zich bevindt) beschrijfbaar is door de webserver en klik op \'Opnieuw\'.',
	'Congratulations! You\'ve successfully configured [_1].' => 'Proficiat! U heeft met succes [_1] geconfigureerd.',
	'Your configuration settings have been written to the following file:' => 'Uw configuratie-instellingen zijn opgeslagen in volgend bestand:',
	'To reconfigure the settings, click the \'Back\' button below.' => 'Om de instellingen opnieuw aan te passen, klik op de \'Terug\' knop hieronder.',
	'Show the mt-config.cgi file generated by the wizard' => 'Toon het mt-config.cgi bestand dat door de wizard is aangemaakt',
	'I will create the mt-config.cgi file manually.' => 'Ik zal het mt-config.cgi bestand met de hand aanmaken.',
	'Retry' => 'Opnieuw',

## tmpl/wizard/cfg_dir.tmpl
	'Temporary Directory Configuration' => 'Tijdelijke map configuratie',
	'You should configure you temporary directory settings.' => 'U moet uw instellingen configureren voor de tijdelijke map.',
	'Your TempDir has been successfully configured. Click \'Continue\' below to continue configuration.' => 'Uw TempDir is met succes ingesteld.  Klik op \'Doorgaan\' hieronder om verder te gaan met de configuratie.',
	'[_1] could not be found.' => '[_1] kon niet worden gevonden.',
	'TempDir is required.' => 'TempDir is vereist.',
	'TempDir' => 'TempDir',
	'The physical path for temporary directory.' => 'Het fysieke pad naar de tijdelijke map.',
	'Test' => 'Test',

## tmpl/wizard/start.tmpl
	'Welcome to Movable Type' => 'Welkom bij Movable Type',
	'Configuration File Exists' => 'Configuratiebestand bestaat',
	'A configuration (mt-config.cgi) file already exists, <a href="[_1]">sign in</a> to Movable Type.' => 'Er bestaat al een configuratiebestand (mt-config.cgi), U kunt <a href="[_1]">aanmelden</a> bij Movable Type.',
	'To create a new configuration file using the Wizard, remove the current configuration file and then refresh this page' => 'Om een nieuw configuratiebestand aan te maken met de Wizard moet u het huidige configuratiebestand verwijderen en deze pagina vernieuwen.',
	'Movable Type requires that you enable JavaScript in your browser. Please enable it and refresh this page to proceed.' => 'Movable Type vereist dat JavaScript ingeschakeld is in uw browser.  Gelieve het in te schakelen en herlaad deze pagina om opnieuw te proberen.',
	'This wizard will help you configure the basic settings needed to run Movable Type.' => 'Deze wizard zal u helpen met het configureren van de basisinstellingen om Movable Type te doen werken.',
	'<strong>Error: \'[_1]\' could not be found.</strong>  Please move your static files to the directory first or correct the setting if it is incorrect.' => '<strong>Fout: \'[_1]\' werd niet gevonden.</strong>  Gelieve uw statische bestanden eerst te verplaatsen naar de map of corrigeer de instelling als ze niet juist is.',
	'Configure Static Web Path' => 'Statisch webpad instellen',
	'Movable Type ships with directory named [_1] which contains a number of important files such as images, javascript files and stylesheets.' => 'Movable Type wordt geleverd met een map genaamd [_1] die een aantal belangrijke bestanden bevat zoals afbeeldingen, javascript bestanden en stylesheets.',
	'The [_1] directory is in the main Movable Type directory which this wizard script resides, but due to your web server\'s configuration, the [_1] directory is not accessible in this location and must be moved to a web-accessible location (e.g., your web document root directory).' => 'De map [_1] bevindt zich in de hoofdmap van Movable Type waar ook dit wizard script zich bevindt, maar door de configuratie van uw webserver is de [_1] map niet toegankelijk op deze locatie en moet deze dus verplaatst worden naar een locatie die toegankelijk is vanop het web (m.a.w. uw document root map).',
	'This directory has either been renamed or moved to a location outside of the Movable Type directory.' => 'Deze map is ofwel van naam veranderd of is verplaatst naar een locatie buiten de Movable Type map.',
	'Once the [_1] directory is in a web-accessible location, specify the location below.' => 'Zodra de [_1] map verplaatst is naar een web-toegankelijke plaats, geef dan de locatie ervan hieronder op.',
	'This URL path can be in the form of [_1] or simply [_2]' => 'Dit URL pad kan in de vorm zijn van [_1] of eenvoudigweg [_2]',
	'This path must be in the form of [_1]' => 'Dit pad moet deze vorm hebben [_1]',
	'Static web path' => 'Pad voor statische bestanden',
	'Static file path' => 'Statisch bestandspad',
	'Begin' => 'Start!',

## tmpl/wizard/packages.tmpl
	'Requirements Check' => 'Controle systeemvereisten',
	'The following Perl modules are required in order to make a database connection.  Movable Type requires a database in order to store your blog\'s data.  Please install one of the packages listed here in order to proceed.  When you are ready, click the \'Retry\' button.' => 'Volgende Perl modules zijn vereist om een databaseconnectie te kunnen maken.  Movable Type heeft een database nodig om de gegevens van uw weblog in op te slaan.  Gelieve één van de packages hieronder te installeren om verder te kunnen gaan.  Wanneer u klaar bent, klik dan op de knop \'Opnieuw\'.',
	'All required Perl modules were found.' => 'Alle vereiste Perl modules werden gevonden',
	'You are ready to proceed with the installation of Movable Type.' => 'U bent klaar om verder te gaan met de installatie van Movable Type',
	'Some optional Perl modules could not be found. <a href="javascript:void(0)" onclick="[_1]">Display list of optional modules</a>' => 'Een aantal optionele Perl modules kon niet worden gevonden. <a href="javascript:void(0)" onclick="[_1]">Toon lijst optionele modules</a>',
	'One or more Perl modules required by Movable Type could not be found.' => 'Eén of meer Perl modules vereist door Movable Type werden niet gevonden.',
	'The following Perl modules are required for Movable Type to run properly. Once you have met these requirements, click the \'Retry\' button to re-test for these packages.' => 'De onderstaande Perl modules zijn nodig voor de werking van Movable Type.  Eens uw systeem aan deze voorwaarden voldoet, klik op de \'Opnieuw\' knop om opnieuw te testen of deze modules geïnstalleerd zijn.',
	'Some optional Perl modules could not be found. You may continue without installing these optional Perl modules. They may be installed at any time if they are needed. Click \'Retry\' to test for the modules again.' => 'Een aantal optionele Perl modules konden niet worden gevonden.  U kunt verder gaan zonder deze optionele modules te installeren.  Ze kunnen op gelijk welk moment geïnstalleerd worden indien ze nodig zijn.  Klik op \'Opnieuw\' om opnieuw te testen of de modules aanwezig zijn.',
	'Missing Database Modules' => 'Ontbrekende databasemodules',
	'Missing Optional Modules' => 'Ontbrekende optionele modules',
	'Missing Required Modules' => 'Ontbrekende vereiste modules',
	'Minimal version requirement: [_1]' => 'Minimale versievereisten: [_1]',
	'Learn more about installing Perl modules.' => 'Meer weten over het installeren van Perl modules',
	'Your server has all of the required modules installed; you do not need to perform any additional module installations.' => 'Op uw server zijn alle vereiste modules geïnstalleerd; u hoeft geen bijkomende modules te installeren.',

## tmpl/wizard/configure.tmpl
	'Database Configuration' => 'Database configuratie',
	'You must set your Database Path.' => 'U moet uw databasepad instellen.',
	'You must set your Database Name.' => 'U moet de naam van uw database instellen.',
	'You must set your Username.' => 'U moet uw gebruikersnaam instellen.',
	'You must set your Database Server.' => 'U moet uw database server instellen.',
	'Your database configuration is complete.' => 'Uw databaseconfiguratie is voltooid.',
	'You may proceed to the next step.' => 'U kunt verder gaan naar de volgende stap.',
	'Please enter the parameters necessary for connecting to your database.' => 'Gelieve de parameters in te vullen die nodig zijn om met uw database te verbinden.',
	'Show Current Settings' => 'Huidige instellingen tonen',
	'Database Type' => 'Databasetype',
	'If your database type is not listed in the menu above, then you need to <a target="help" href="[_1]">install the Perl module necessary to connect to your database</a>.  If this is the case, please check your installation and <a href="javascript:void(0)" onclick="[_2]">re-test your installation</a>.' => 'Als uw databasetype niet voorkomt in het menu hierboven dan moet u <a target="help" href="[_1]">de Perl module installeren die nodig is om naar uw database te connecteren</a>.  Als dit het al geval is, gelieve dan uw installatie na te kijken en <a href="javascript:void(0)" onclick="[_2]">voor de test opnieuw uit</a>.',
	'Database Path' => 'Databasepad',
	'The physical file path for your SQLite database. ' => 'Het fysieke bestandspad voor uw SQLite database',
	'A default location of \'./db/mt.db\' will store the database file underneath your Movable Type directory.' => 'Een standaardlocatie van \'./db/mt.db\' zal het databasebestadn opslaan onder uw Movable Type map.',
	'Database Server' => 'Databaseserver',
	'This is usually \'localhost\'.' => 'Dit is meestal \'localhost\'.',
	'Database Name' => 'Databasenaam',
	'The name of your SQL database (this database must already exist).' => 'De naam van uw SQL database (deze database moet al bestaan).',
	'The username to login to your SQL database.' => 'De gebruikersnaam om in te loggen op uw SQL database.',
	'Password' => 'Wachtwoord',
	'The password to login to your SQL database.' => 'Het wachtwoord om in te loggen op uw SQL database.',
	'Show Advanced Configuration Options' => 'Geavanceerde configuratieopties tonen',
	'Database Port' => 'Databasepoort',
	'This can usually be left blank.' => 'Dit kan meestal leeg blijven.',
	'Database Socket' => 'Databasesocket',
	'Publish Charset' => 'Karakterset voor publicatie',
	'MS SQL Server driver must use either Shift_JIS or ISO-8859-1.  MS SQL Server driver does not support UTF-8 or any other character set.' => 'De MS SQL Server driver heeft ofwel Shift_JIS of ISO-8859-1 nodig.  De MS SQL Server driver ondersteunt noch UTF-8 noch een andere karakterset.',
	'Test Connection' => 'Verbinding testen',

## tmpl/wizard/blog.tmpl
	'Setup Your First Blog' => 'Maak uw eerste blog aan',
	'In order to properly publish your blog, you must provide Movable Type with your blog\'s URL and the path on the filesystem where its files should be published.' => 'Om uw blog goed te kunnen publiceren, moet u aan Movable Type de URL van uw weblog en het pad op het bestandssysteem opgeven waar de bestanden gepubliceerd moeten worden.',
	'My First Blog' => 'Mijn eerste weblog',
	'Publishing Path' => 'Publicatiepad',
	'Your \'Publishing Path\' is the path on your web server\'s file system where Movable Type will publish all the files for your blog. Your web server must have write access to this directory.' => 'Uw \'publicatiepad\' is het pad op het bestandsysteem van uw webserver waar Movable Type alle bestanden zal publiceren van uw weblog.  Uw webserver moet schrijfrechten hebben op deze map. ',

## tmpl/cms/include/list_associations/page_title.tmpl
	'Permissions for [_1]' => 'Permissies voor [_1]',
	'Permissions: System-wide' => 'Permissies: over het hele systeem',
	'Users for [_1]' => 'Gebruikers voor [_1]',

## tmpl/cms/include/copyright.tmpl
	'Copyright &copy; 2001-[_1] Six Apart. All Rights Reserved.' => 'Copyright &copy; 2001-[_1] Six Apart. All Rights Reserved.',

## tmpl/cms/include/comment_table.tmpl
	'comment' => 'reactie',
	'comments' => 'reacties',
	'to publish' => 'om te publiceren',
	'Publish selected comments (a)' => 'Geselecteerde reacties publiceren (a)',
	'Delete selected comments (x)' => 'Geselecteerde reacties verwijderen (x)',
	'Report selected comments as Spam (j)' => 'Geselecteerde reacties verwijderen als spam (j)',
	'Spam' => 'Spam',
	'Report selected comments as Not Spam and Publish (j)' => 'Geselecteerde reacties rapporteren als niet-spam en publiceren (j)',
	'Not Spam' => 'Geen spam',
	'Are you sure you want to remove all comments reported as spam?' => 'Bent u zeker dat u alle reacties die als spam gemarkeerd zijn wenst te verwijderen?',
	'Delete all comments reported as Spam' => 'Alle reacties gerapporteerd als spam verwijderen',
	'Empty' => 'Leeg',
	'Ban This IP' => 'Dit IP-adres verbannen',
	'Status' => 'Status',
	'Entry/Page' => 'Bericht/pagina',
	'Date' => 'Datum',
	'IP' => 'IP',
	'Only show published comments' => 'Enkel gepubliceerde reacties tonen',
	'Published' => 'Gepubliceerd',
	'Only show pending comments' => 'Enkel hangende reacties tonen',
	'Pending' => 'In afwachting',
	'Edit this comment' => 'Deze reactie bewerken',
	'([quant,_1,reply,replies])' => '([quant,_1,antwoord,antwoorden])',
	'Reply' => 'Antwoorden',
	'Trusted' => 'Vertrouwde',
	'Blocked' => 'Geblokkeerd',
	'Authenticated' => 'Bevestigd',
	'Edit this [_1] commenter' => '[_1] reageerder bewerken',
	'Search for comments by this commenter' => 'Zoek naar reacties door deze reageerder',
	'Anonymous' => 'Anonieme',
	'View this entry' => 'Dit bericht bekijken',
	'View this page' => 'Deze pagina bekijken',
	'Search for all comments from this IP address' => 'Zoek naar alle reacties van dit IP adres',

## tmpl/cms/include/member_table.tmpl
	'user' => 'gebruiker',
	'users' => 'gebruikers',
	'Are you sure you want to remove the selected user from this blog?' => 'Bent u zeker dat u de geselecteerde gebruiker wenst te verwijderen van deze weblog?',
	'Are you sure you want to remove the [_1] selected users from this blog?' => 'Bent u zeker dat u de [_1] geselecteerde gebruikers wenst te verwijderen van deze weblog?',
	'Remove selected user(s) (r)' => 'Geselecteerde gebruiker(s) verwijderen (r)',
	'Remove' => 'Verwijder',
	'_USER_ENABLED' => 'Ingeschakeld',
	'Trusted commenter' => 'Vertrouwde reageerder',
	'Email' => 'E-mail',
	'Link' => 'Link',
	'Remove this role' => 'Verwijder deze rol',

## tmpl/cms/include/feed_link.tmpl
	'Activity Feed' => 'Activiteit-feed',
	'Disabled' => 'Uitgeschakeld',
	'Set Web Services Password' => 'Webservices wachtwoord instellen',

## tmpl/cms/include/overview-left-nav.tmpl
	'List Weblogs' => 'Lijst weblogs',
	'Weblogs' => 'Weblogs',
	'List Users and Groups' => 'Lijst gebruikers en groepen',
	'Users &amp; Groups' => 'Gebruikers &amp; Groepen',
	'List Associations and Roles' => 'Lijst associaties en rollen',
	'Privileges' => 'Privileges',
	'List Plugins' => 'Lijst plugins',
	'Aggregate' => 'Inhoudelijk',
	'List Entries' => 'Berichten weergeven',
	'List uploaded files' => 'Opgeladen bestanden weergeven',
	'List Tags' => 'Tags oplijsten',
	'List Comments' => 'Reacties weergeven',
	'List TrackBacks' => 'TrackBacks tonen',
	'Configure' => 'Configureren',
	'Edit System Settings' => 'Systeeminstellingen bewerken',
	'Utilities' => 'Hulpmiddelen',
	'Search &amp; Replace' => 'Zoeken en vervangen',
	'_SEARCH_SIDEBAR' => 'Zoeken',
	'Show Activity Log' => 'Activiteitenlog bekijken',

## tmpl/cms/include/asset_table.tmpl
	'asset' => 'mediabestand',
	'assets' => 'mediabestanden',
	'Delete selected assets (x)' => 'Geselecteerde media verwijderen (x)',
	'Size' => 'Grootte',
	'Created By' => 'Aangemaakt door',
	'Created On' => 'Aangemaakt',
	'View' => 'Bekijken',
	'Asset Missing' => 'Ontbrekend mediabestand',
	'No thumbnail image' => 'Geen thumbnail',
	'[_1] is missing' => '[_1] ontbreekt',

## tmpl/cms/include/import_start.tmpl
	'Importing...' => 'Importeren...',
	'Importing entries into blog' => 'Berichten worden geïmporteerd in de blog',
	'Importing entries as user \'[_1]\'' => 'Berichten worden geïmporteerd als gebruiker \'[_1]\'',
	'Creating new users for each user found in the blog' => 'Nieuwe gebruikers worden aangemaakt voor elke gebruiker gevonden in de weblog',

## tmpl/cms/include/log_table.tmpl
	'No log records could be found.' => 'Er konden geen logberichten worden gevonden.',
	'_LOG_TABLE_BY' => 'Door',
	'IP: [_1]' => 'IP: [_1]',
	'[_1]' => '[_1]',

## tmpl/cms/include/pagination.tmpl

## tmpl/cms/include/backup_end.tmpl
	'All of the data has been backed up successfully!' => 'Alle gegevens zijn met succes opgeslagen!',
	'_external_link_target' => '_new',
	'Download This File' => 'Dit bestand downloaden',
	'_BACKUP_TEMPDIR_WARNING' => 'Gevraagde gegevens zijn met succes gebackupt in de map [_1].  Gelieve bovenstaande bestanden te downloaden en vervolgens <strong>onmiddellijk te verwijderen</strong> uit [_1] omdat backupbestanden vertrouwelijke informatie bevatten.',
	'_BACKUP_DOWNLOAD_MESSAGE' => 'Het downloaden van het backup-bestand zal over een paar seconden automatisch beginnen.  Als dit niet het geval is om wat voor reden dan ook, klik dan <a href=\'#\' onclick=\'submit_form()\'>hier</a> om de download met de hand in gang te zetten.  Merk op dat u het backupbestand slechts één keer kunt downloaden gedurende een sessie.',
	'An error occurred during the backup process: [_1]' => 'Er deed zich een fout voor tijdens het backup-proces: [_1]',

## tmpl/cms/include/cfg_content_nav.tmpl
	'Registration' => 'Registratie',
	'Web Services' => 'Webservices',

## tmpl/cms/include/notification_table.tmpl
	'Date Added' => 'Toegevoegd',
	'Click to edit contact' => 'Klik om contact te bewerken',
	'Save changes' => 'Wijzigingen opslaan',
	'Save' => 'Opslaan',

## tmpl/cms/include/footer.tmpl
	'Hey, this is a Beta version of MT: Don\'t use it in production! And you\'ll want to upgrade to the release version by January 31, 2008. (<a href="[_1]" target="_blank">License details</a>)' => '
	He, dit is een Betaversie van MT: niet voor productiedoeleinden gebruiken!  En na 31 januari 2008 zeker upgraden naar de release-versie. (<a href="[_1]" target="_blank">Licentiedetails</a>)',
	'Dashboard' => 'Dashboard',
	'Compose Entry' => 'Bericht opstellen',
	'Manage Entries' => 'Berichten beheren',
	'System Settings' => 'Systeeminstellingen',
	'Help' => 'Hulp',
	'<a href="[_1]"><mt:var name="mt_product_name"></a> version [_2]' => '<a href="[_1]"><mt:var name="mt_product_name"></a> versie [_2]',
	'with' => 'met',

## tmpl/cms/include/tools_content_nav.tmpl

## tmpl/cms/include/commenter_table.tmpl
	'Identity' => 'Identiteit',
	'Last Commented' => 'Laatste reactie',
	'Only show trusted commenters' => 'Enkel vertrouwde reageerders tonen',
	'Only show banned commenters' => 'Enkel verbannen reageerders tonen',
	'Banned' => 'Uitgesloten',
	'Only show neutral commenters' => 'Enkel neutrale reageerders tonen',
	'Edit this commenter' => 'Deze reageerder bewerken',
	'View this commenter&rsquo;s profile' => 'Bekijk het profiel van deze reageerder',

## tmpl/cms/include/ping_table.tmpl
	'Publish selected [_1] (p)' => 'Geselecteerde [_1] publiceren (p)',
	'Delete selected [_1] (x)' => 'Geselecteerde [_1] verwijderen (x)',
	'Report selected [_1] as Spam (j)' => 'Geselecteerde [_1] als spam rapporteren (j)',
	'Report selected [_1] as Not Spam and Publish (j)' => 'Geselecteerde [_1] als niet-spam rapporteren en publiceren (j)',
	'Are you sure you want to remove all TrackBacks reported as spam?' => 'Bent u zeker dat u alle TrackBacks die als spam zijn gerapporteerd wenst te verwijderen?',
	'Deletes all [_1] reported as Spam' => 'Verwijdert alle [_1] die als spam gerapporteerd werden',
	'From' => 'Van',
	'Target' => 'Doel',
	'Only show published TrackBacks' => 'Enkel gepubliceerde TrackBacks tonen',
	'Only show pending TrackBacks' => 'Enkel hangende TrackBacks tonen',
	'Edit this TrackBack' => 'Deze TrackBack bewerken',
	'Go to the source entry of this TrackBack' => 'Ga naar het bronbericht van deze TrackBack',
	'View the [_1] for this TrackBack' => 'De [_1] bekijken voor deze TrackBack',

## tmpl/cms/include/entry_table.tmpl
	'Save these entries (s)' => 'Deze berichten opslaan (s)',
	'Republish selected entries (r)' => 'Geselecteerde berichten opnieuw publiceren (r)',
	'Delete selected entries (x)' => 'Geselecteerde berichten verwijderen (x)',
	'Save these pages (s)' => 'Deze pagina\'s opslaan',
	'Republish selected pages (r)' => 'Geselecteerde pagina\'s opnieuw publiceren (r)',
	'Delete selected pages (x)' => 'Geselecteerde pagina\'s verwijderen (x)',
	'to republish' => 'om opnieuw te publiceren',
	'Republish' => 'Herpubliceren',
	'Last Modified' => 'Laatst aangepast',
	'Created' => 'Aangemaakt',
	'Unpublished (Draft)' => 'Niet gepubliceerd (klad)',
	'Unpublished (Review)' => 'Niet gepubliceerd (na te kijken)',
	'Scheduled' => 'Gepland',
	'Only show unpublished entries' => 'Enkel ongepubliceerde berichten tonen',
	'Only show unpublished pages' => 'Enkel ongepubliceerde pagina\'s tonen',
	'Only show published entries' => 'Enkel gepubliceerde berichten tonen',
	'Only show published pages' => 'Enkel gepubliceerde pagina\'s tonen',
	'Only show entries for review' => 'Enkel na te kijken berichten tonen',
	'Only show pages for review' => 'Enkel na te kijken pagina\'s tonen',
	'Only show scheduled entries' => 'Enkel geplande berichten tonen',
	'Only show scheduled pages' => 'Enkel geplande pagina\'s tonen',
	'Edit Entry' => 'Bericht bewerken',
	'Edit Page' => 'Pagina bewerken',
	'View entry' => 'Bericht bekijken',
	'View page' => 'Pagina bekijken',
	'No entries could be found. <a href="[_1]">Create an entry</a> now.' => 'Er werden geen berichten gevonden. Nu <a href="[_1]">een bericht aanmaken</a>.', # Translate - New
	'No page could be found. <a href="[_1]">Create a page</a> now.' => 'Er werden geen pagina\'s gevonden. Nu <a href="[_1]">een pagina aanmaken</a>.', # Translate - New

## tmpl/cms/include/login_mt.tmpl

## tmpl/cms/include/author_table.tmpl
	'_USER_DISABLED' => 'Uitgeschakeld',

## tmpl/cms/include/calendar.tmpl
	'_LOCALE_WEEK_START' => '1',
	'Sunday' => 'Zondag',
	'Monday' => 'Maandag',
	'Tuesday' => 'Dinsdag',
	'Wednesday' => 'Woensdag',
	'Thursday' => 'Donderdag',
	'Friday' => 'Vrijdag',
	'Saturday' => 'Zaterdag',
	'S|M|T|W|T|F|S' => 'M|D|W|D|V|Z|Z',
	'January' => 'Januari',
	'Febuary' => 'Februari',
	'March' => 'Maart',
	'April' => 'April',
	'May' => 'Mei',
	'June' => 'Juni',
	'July' => 'Juli',
	'August' => 'Augustus',
	'September' => 'September',
	'October' => 'Oktober',
	'November' => 'November',
	'December' => 'December',
	'Jan' => 'Jan',
	'Feb' => 'Feb',
	'Mar' => 'Maa',
	'Apr' => 'Apr',
	'_SHORT_MAY' => 'Mei',
	'Jun' => 'Jun',
	'Jul' => 'Jul',
	'Aug' => 'Aug',
	'Sep' => 'Sep',
	'Oct' => 'Okt',
	'Nov' => 'Nov',
	'Dec' => 'Dec',
	'OK' => 'OK',
	'[_1:calMonth] [_2:calYear]' => '[_1:calMonth] [_2:calYear]',

## tmpl/cms/include/itemset_action_widget.tmpl
	'More actions...' => 'Meer mogelijkheden...',
	'Plugin Actions' => 'Plugin-mogelijkheden',
	'to act upon' => 'om de handeling op uit te voeren',
	'Go' => 'Ga',

## tmpl/cms/include/anonymous_comment.tmpl
	'Anonymous Comments' => 'Anonieme reacties',
	'Require E-mail Address for Anonymous Comments' => 'E-mail adres vereisen voor anonieme reacties',
	'If enabled, visitors must provide a valid e-mail address when commenting.' => 'Indien ingeschakeld moeten bezoekers een geldig e-mail adres opgeven wanneer ze reageren.',

## tmpl/cms/include/category_selector.tmpl
	'Add sub category' => 'Subcategorie toevoegen',
	'Add new' => 'Nieuw toevogen',

## tmpl/cms/include/display_options.tmpl
	'Display Options' => 'Opties voor schermindeling',
	'_DISPLAY_OPTIONS_SHOW' => 'Toon',
	'[quant,_1,row,rows]' => '[quant,_1,rij,rijen]',
	'Compact' => 'Compact',
	'Expanded' => 'Uitgebreid',
	'Action Bar' => 'Actiebalk',
	'Top' => 'Bovenaan',
	'Both' => 'Allebei',
	'Bottom' => 'Onderaan',
	'Date Format' => 'Datumformaat',
	'Relative' => 'Relatief',
	'Full' => 'Volledig',
	'Save display options' => 'Opties schermindeling opslaan',
	'Close display options' => 'Opties schermindeling sluiten',

## tmpl/cms/include/backup_start.tmpl
	'Backing up Movable Type' => 'Backup maken van Movable Type',

## tmpl/cms/include/chromeless_footer.tmpl
	'<a href="[_1]">Movable Type</a> version [_2]' => '<a href="[_1]">Movable Type</a> versie [_2]',

## tmpl/cms/include/template_table.tmpl
	'template' => 'sjabloon',
	'templates' => 'sjablonen',
	'Output File' => 'Uitvoerbestand',
	'Type' => 'Type',
	'Linked' => 'Gelinkt',
	'Linked Template' => 'Gelinkt sjabloon',
	'Dynamic' => 'Dynamisch',
	'Dynamic Template' => 'Dynamisch sjabloon',
	'Published w/Indexes' => 'Gepubliceerd met indexen',
	'Published Template w/Indexes' => 'Sjabloon gepubliceerd met indexen',
	'-' => '-',
	'Yes' => 'Ja',
	'No' => 'Nee',
	'View Published Template' => 'Gepubliceerd sjabloon bekijken',

## tmpl/cms/include/asset_upload.tmpl
	'Before you can upload a file, you need to publish your blog. [_1]Configure your blog\'s publishing paths[_2] and rebuild your blog.' => 'Voor u een bestand kunt opladen, moet u eerst uw blog publiceren. [_1]Stel het publicatiepad van uw blog in[_2] en publiceer uw blog opnieuw.',
	'Your system or blog administrator needs to publish the blog before you can upload files. Please contact your system or blog administrator.' => 'Uw systeem- of blogbeheerder moet de blog publiceren voor u bestanden kunt opladen.  Gelieve uw systeem- of blogbeheerder te contacteren.',
	'Close (x)' => 'Sluiten (x)',
	'Select File to Upload' => 'Selecteer bestand om te uploaden',
	'_USAGE_UPLOAD' => 'U kunt het bestand opladen naar een submap van het geselecteerde pad.  De submap zal worden aangemaakt als die nog niet bestaat.',
	'Upload Destination' => 'Uploadbestemming',
	'Choose Folder' => 'Kies map',
	'Upload (s)' => 'Opladen (s)',
	'Upload' => 'Opladen',
	'Back (b)' => 'Terug (b)',
	'Cancel (x)' => 'Annuleren (x)',

## tmpl/cms/include/header.tmpl
	'Hi [_1],' => 'Hallo [_1],',
	'Logout' => 'Afmelden',
	'Select another blog...' => 'Selecteer een andere blog...',
	'Create a new blog' => 'Maak een nieuwe blog aan',
	'Write Entry' => 'Schrijf bericht',
	'Blog Dashboard' => 'Blogdashboard',
	'View Site' => 'Site bekijken',
	'Search (q)' => 'Zoeken (q)',

## tmpl/cms/include/listing_panel.tmpl
	'Step [_1] of [_2]' => 'Stap [_1] van [_2]',
	'Reset' => 'Leegmaken',
	'Go to [_1]' => 'Ga naar [_1]',
	'Sorry, there were no results for your search. Please try searching again.' => 'Sorry, er waren geen resultaten voor uw zoekopdracht. Probeer opnieuw te zoeken.',
	'Sorry, there is no data for this object set.' => 'Sorry, er zijn geen gegevens ingesteld voor dit object.',
	'Confirm (s)' => 'Bevestigen (s)',
	'Confirm' => 'Bevestigen',
	'Continue (s)' => 'Doorgaan (s)',

## tmpl/cms/include/archetype_editor.tmpl
	'Decrease Text Size' => 'Kleiner tekstformaat',
	'Increase Text Size' => 'Groter tekstformaat',
	'Bold' => 'Vet',
	'Italic' => 'Cursief',
	'Underline' => 'Onderstrepen',
	'Strikethrough' => 'Doorstrepen',
	'Text Color' => 'Tekstkleur',
	'Email Link' => 'E-mail link',
	'Begin Blockquote' => 'Begin citaat',
	'End Blockquote' => 'Einde citaat',
	'Bulleted List' => 'Ongeordende lijst',
	'Numbered List' => 'Genummerde lijst',
	'Left Align Item' => 'Item links uitlijnen',
	'Center Item' => 'Centreer item',
	'Right Align Item' => 'Item rechts uitlijnen',
	'Left Align Text' => 'Tekst links uitlijnen',
	'Center Text' => 'Tekst centreren',
	'Right Align Text' => 'Tekst rechts uitlijnen',
	'Insert Image' => 'Afbeelding invoegen',
	'Insert File' => 'Bestand invoegen',
	'WYSIWYG Mode' => 'WYSIWYG modus',
	'HTML Mode' => 'HTML modus',

## tmpl/cms/include/blog_table.tmpl
	'Delete selected blogs (x)' => 'Geselecteerde blogs verwijderen (x)',

## tmpl/cms/include/blog-left-nav.tmpl
	'Creating' => 'Bezig aan te maken',
	'Create Entry' => 'Nieuw bericht opstellen',
	'Community' => 'Gemeenschap',
	'List Commenters' => 'Reageerders tonen',
	'Edit Address Book' => 'Adresboek bewerken',
	'List Users &amp; Groups' => 'Groepen en gebruikers tonen',
	'List &amp; Edit Templates' => 'Sjablonen weergeven en bewerken',
	'Edit Categories' => 'Categorieën bewerken',
	'Edit Tags' => 'Tags bewerken',
	'Edit Weblog Configuration' => 'Weblogconfiguratie bewerken',
	'Backup this weblog' => 'Maak een backup van deze weblog',
	'Import &amp; Export Entries' => 'Berichten importeren en exporteren',
	'Import / Export' => 'Import/export',
	'Rebuild Site' => 'Site herbouwen',

## tmpl/cms/include/users_content_nav.tmpl
	'Profile' => 'Profiel',
	'Details' => 'Details',

## tmpl/cms/include/import_end.tmpl
	'All data imported successfully!' => 'Alle gegevens werden met succes geïmporteerd!',
	'Make sure that you remove the files that you imported from the \'import\' folder, so that if/when you run the import process again, those files will not be re-imported.' => 'Verwijder zeker de bestanden waaruit u gegevens importeerde uit de \'import\' folder, zodat wanneer u het import proces ooit opnieuw draait deze bestanden niet nog eens worden geïmporteerd.',
	'An error occurred during the import process: [_1]. Please check your import file.' => 'Er deed zich een fout voor tijdens het importproces: [_1]. Gelieve uw importbestand na te kijken.',

## tmpl/cms/include/archive_maps.tmpl
	'Path' => 'Pad',
	'Custom...' => 'Gepersonaliseerd...',

## tmpl/cms/include/cfg_system_content_nav.tmpl

## tmpl/cms/dialog/recover.tmpl
	'Your password has been changed, and the new password has been sent to your email address ([_1]).' => 'Uw wachtwoord is veranderd en het nieuwe wachtwoord is naar uw e-mailadres ([_1]) gestuurd.',
	'Sign in to Movable Type (s)' => 'Aanmelden op Movable Tpe (s)',
	'Sign in to Movable Type' => 'Aanmelden op Movable Type',
	'Password recovery word/phrase' => 'Woord/uitdrukking om wachtwoord terug te vinden',
	'Recover (s)' => 'Terugvinden (s)',
	'Recover' => 'Terugvinden',
	'Go Back (x)' => 'Ga terug (x)',

## tmpl/cms/dialog/restore_end.tmpl
	'An error occurred during the restore process: [_1] Please check your restore file.' => 'Er deed zich een fout voor tijdens het terugzetten: [_1] Gelieve uw restore-bestand na te kijken.',
	'View Activity Log (v)' => 'Activiteitenlog bekijken (v)',
	'All data restored successfully!' => 'Alle gegevens met succes teruggezet!',
	'Close (s)' => 'Sluiten (s)',
	'Next Page' => 'Volgende pagina',
	'The page will redirect to a new page in 3 seconds. [_1]Stop the redirect.[_2]' => 'Deze pagina zal binnen drie seconden doorverwijzen naar een andere pagina. [_1]Stop de doorverwijzing[_2]',

## tmpl/cms/dialog/asset_replace.tmpl
	'A file named \'[_1]\' already exists. Do you want to overwrite this file?' => 'Er bestaat reeds een bestand net de naam \'[_1]\'. Wilt u dit bestand overschrijven?',
	'Yes (s)' => 'Ja (s)',

## tmpl/cms/dialog/asset_list.tmpl
	'Insert Asset' => 'Mediabestand invoegen',
	'Upload New File' => 'Nieuw bestand opladen',
	'Upload New Image' => 'Nieuwe afbeelding opladen',
	'Asset Name' => 'Naam mediabestand',
	'View Asset' => 'Mediabestand bekijken',
	'Next (s)' => 'Volgende (s)',
	'Insert (s)' => 'Invoegen (s)',
	'Insert' => 'Invoegen',
	'No assets could be found.' => 'Kon geen mediabestand vinden',

## tmpl/cms/dialog/refresh_templates.tmpl
	'Refresh Template Set' => 'Sjabloonset verversen',
	'Refresh [_1] template set' => 'Ververs [_1] sjabloonset',
	'Updates current templates while retaining any user-created or user-modified templates.' => 'Werkt huidige sjablonen bij behalve die door gebruiker(s) zijn aangemaakt of aangepast.',
	'Apply a new template set' => 'Nieuwe sjabloonset toepassen',
	'Deletes all existing templates and installs factory default template set.' => 'Verwijdert alle bestaande sjablonen en installeert de standaard sjabloonset uit de \'fabrieksinstellingen\'.',
	'Make backups of existing templates first' => 'Eerst backups nemen van bestaande sjablonen',
	'You have requested to <strong>refresh the current template set</strong>. This action will:' => 'U heeft gevraagd om <strong>de huidige sjabloonset te verversen</strong>.  Deze actie zal:',
	'potentially install new templates' => 'potentiëel nieuwe sjablonen installeren',
	'overwrite some existing templates with new template code' => 'enkele bestaande sjablonen overschrijven met nieuwe sjablooncode',
	'backups will be made of your templates and can be accessed through your backup filter' => 'backups zullen gemaakt worden van al uw sjabonen waartoe u achteraf via de backup-filter toegang kunt krijgen.',
	'You have requested to <strong>apply a new template set</strong>. This action will:' => 'U heeft gevraagd om <strong>een nieuwe sjabloonset toe te passen</strong>. Deze actie zal:',
	'delete all of the templates in your blog' => 'alle sjablonen in uw blog verwijderen',
	'install new templates from the selected template set' => 'nieuwe sjablonen installeren uit de geselecteerde sjabloonset',
	'Are you sure you wish to continue?' => 'Bent u zeker dat verder u wenst te gaan?',

## tmpl/cms/dialog/comment_reply.tmpl
	'Reply to comment' => 'Reactie beantwoorden',
	'On [_1], [_2] commented on [_3]' => 'Op [_1] reageerde [_2] op [_3]',
	'Preview of your comment' => 'Voorbeeld van uw reactie',
	'Your reply:' => 'Uw antwoord:',
	'Submit reply (s)' => 'Antwoord ingeven (s)',
	'Preview reply (v)' => 'Voorbeeld antwoord (v)',
	'Re-edit reply (r)' => 'Antwoord opnieuw bewerken (r)',
	'Re-edit' => 'Opnieuw bewerken',

## tmpl/cms/dialog/asset_upload.tmpl
	'You need to configure your blog.' => 'U moet uw weblog configureren.',
	'Your blog has not been published.' => 'Uw blog is nog niet gepubliceerd.',

## tmpl/cms/dialog/restore_upload.tmpl
	'Restore: Multiple Files' => 'Terugzetten: meerdere bestanden',
	'Canceling the process will create orphaned objects.  Are you sure you want to cancel the restore operation?' => 'De procedure nu stopzetten zal wees-objecten achterlaten.  Bent u zeker dat u de restore-operatie wenst te annuleren.',
	'Please upload the file [_1]' => 'Gelieve bestand [_1] te uploaden',

## tmpl/cms/dialog/entry_notify.tmpl
	'Send a Notification' => 'Notificatie versturen',
	'You must specify at least one recipient.' => 'U moet minstens één ontvanger opgeven.',
	'Your blog\'s name, this entry\'s title and a link to view it will be sent in the notification.  Additionally, you can add a  message, include an excerpt of the entry and/or send the entire entry.' => '\n	De naam van uw blog, de berichttitel en een link naar het bericht zullen per mail verzonden worden.  Bijkomend kunt u een boodschap toevoegen, een uittreksel en/of de hele inhoud van het bericht.',
	'Recipients' => 'Ontvangers',
	'Enter email addresses on separate lines, or comma separated.' => 'Vul e-mail adressen in op aparte regels of gescheiden door komma\'s.',
	'All addresses from Address Book' => 'Alle adressen uit het adresboek',
	'Optional Message' => 'Optionele boodschap',
	'Optional Content' => 'Optionele inhoud',
	'(Entry Body will be sent without any text formatting applied)' => '(Romp van het bericht zal verstuurd worden zonder dat er tekstformattering op wordt toegepast)',
	'Send notification (s)' => 'Notificaties versturen (s)',
	'Send' => 'Versturen',

## tmpl/cms/dialog/asset_options.tmpl
	'File Options' => 'Bestandsopties',
	'The file named \'[_1]\' has been uploaded. Size: [quant,_2,byte,bytes].' => 'Het bestand met de naam \'[_1]\' is opgeladen.  Grootte: [quant,_2,byte,bytes].',
	'Create entry using this uploaded file' => 'Bericht aanmaken met dit opgeladen bestand',
	'Create a new entry using this uploaded file.' => 'Maak een nieuw bericht aan met dit opgeladen bestand',
	'Finish (s)' => 'Klaar (s)',
	'Finish' => 'Klaar',

## tmpl/cms/dialog/adjust_sitepath.tmpl
	'Confirm Publishing Configuration' => 'Bevestig publicatieconfiguratie',
	'URL is not valid.' => 'URL is niet geldig.',
	'You can not have spaces in the URL.' => 'Er mogen geen spaties in de URL staan.',
	'You can not have spaces in the path.' => 'Er mogen geen spaties in het pad staan.',
	'Path is not valid.' => 'Pad is ongeldig',
	'Archive URL' => 'Archief-URL',

## tmpl/cms/dialog/asset_options_image.tmpl
	'Display image in entry' => 'Afbeelding tonen in bericht',
	'Alignment' => 'Uitlijning',
	'Left' => 'Links',
	'Center' => 'Centreren',
	'Right' => 'Rechts',
	'Use thumbnail' => 'Thumbnail gebruiken',
	'width:' => 'breedte:',
	'pixels' => 'pixels',
	'Link image to full-size version in a popup window.' => 'Link naar oorspronkelijke afbeelding in popup venster.',
	'Remember these settings' => 'Deze instellingen onthouden',

## tmpl/cms/dialog/create_association.tmpl
	'No roles exist in this installation. [_1]Create a role</a>' => 'Er bestaan geen rollen in deze installatie.[_1]Maak een rol aan</a>',
	'No groups exist in this installation. [_1]Create a group</a>' => 'Er bestaan geen groepen in deze installatie.[_1]Maak een groep aan</a>',
	'No users exist in this installation. [_1]Create a user</a>' => 'Er bestaan geen gebruikers in deze installatie.[_1]Maak een gebruiker aan</a>',
	'No blogs exist in this installation. [_1]Create a blog</a>' => 'Er bestaan geen blogs in deze installatie.[_1]Maak een blog aan</a>',

## tmpl/cms/dialog/restore_start.tmpl
	'Restoring...' => 'Terug aan het zetten...',

## tmpl/cms/widget/new_user.tmpl
	'Welcome to Movable Type, the world\'s most powerful blogging, publishing and social media platform. To help you get started we have provided you with links to some of the more common tasks new users like to perform:' => 'Welkom in Movable Type, het meest krachtige blog-, publicatie- en mediaplatform ter wereld.  Om u te helpen van start te gaan hebben we voor u enkele links voorzien naar de vaakst voorkomende handelingen die nieuwe gebruikers wensen uit te voeren:',
	'Write your first post' => 'Schrijf uw eerste bericht',
	'What would a blog be without content? Start your Movable Type experience by creating your very first post.' => 'Wat is een blog zonder inhoud?  Ervaar de kracht van Movable Type door uw eerste bericht te schrijven.',
	'Design your blog' => 'Ontwerp uw weblog',
	'Customize the look and feel of your blog quickly by selecting a design from one of our professionally designed themes.' => 'Pas snel en eenvoudig het uitzicht van uw weblog aan door te kiezen uit één van onze vele professioneel ontworpen thema\'s.',
	'Explore what\'s new in Movable Type 4' => 'Ontdek wat er nieuw is in Movable Type 4',
	'Whether you\'re new to Movable Type or using it for the first time, learn more about what this tool can do for you.' => 'Of u Movable Type nu voor de eerste keer gebruikt of u er al ervaring mee heeft, ontdek meer over wat het voor u kan doen.',

## tmpl/cms/widget/blog_stats_recent_entries.tmpl
	'[quant,_1,entry,entries] tagged &ldquo;[_2]&rdquo;' => 'quant,_1,entry,entries] getagd &ldquo;[_2]&rdquo;',
	'...' => '...',
	'Posted by [_1] [_2] in [_3]' => 'Gepubliceerd door [_1] [_2] op [_3]',
	'Posted by [_1] [_2]' => 'Gepubliceerd door [_1] [_2]',
	'Tagged: [_1]' => 'Getagd: [_1]',
	'View all entries tagged &ldquo;[_1]&rdquo;' => 'Alle berichten bekijken getagd als &ldquo;[_1]&rdquo;',
	'No entries available.' => 'Geen berichten beschikbaar',

## tmpl/cms/widget/mt_news.tmpl
	'News' => 'Nieuws',
	'MT News' => 'MT Nieuws',
	'Learning MT' => 'Learning MT',
	'Hacking MT' => 'Hacking MT',
	'Pronet' => 'Pronet',
	'No Movable Type news available.' => 'Geen Movable Type nieuws beschikbaar.',
	'No Learning Movable Type news available.' => 'Geen Learning Movable Type nieuws beschikbaar.',

## tmpl/cms/widget/custom_message.tmpl
	'This is you' => 'Dit bent u',
	'Welcome to [_1].' => 'Welkom bij [_1].',
	'You can manage your blog by selecting an option from the menu located to the left of this message.' => 'U kunt uw blog beheren door een optie te selecteren uit het menu aan de linkerkant.',
	'If you need assistance, try:' => 'Als u hulp nodig hebt, probeer:',
	'Movable Type User Manual' => 'Gebruikershandleiding van Movable Type',
	'http://www.sixapart.com/movabletype/support' => 'http://www.sixapart.com/movabletype/support',
	'Movable Type Technical Support' => 'Movable Type technische ondersteuning',
	'Movable Type Community Forums' => 'Movable Type community forums',
	'Save Changes (s)' => 'Wijzigingen opslaan (s)',
	'Save Changes' => 'Wijzigingen opslaan',
	'Change this message.' => 'Dit bericht wijzigen.',
	'Edit this message.' => 'Dit bericht wijzigen.',

## tmpl/cms/widget/mt_shortcuts.tmpl
	'Trackbacks' => 'TrackBacks',
	'Import Content' => 'Inhoud importeren',
	'Blog Preferences' => 'Blogvoorkeuren',

## tmpl/cms/widget/new_version.tmpl
	'What\'s new in Movable Type [_1]' => 'Nieuw in Movable Type [_1]',
	'Congratulations, you have successfully installed Movable Type [_1]. Listed below is an overview of the new features found in this release.' => 'Proficiat, u heeft met succes Movable Type [_1] geïnstalleerd.  Hieronder vindt u een overzicht van de nieuwe mogelijkheden in deze release.',

## tmpl/cms/widget/this_is_you.tmpl
	'Your <a href="[_1]">last entry</a> was [_2] in <a href="[_3]">[_4]</a>.' => 'Uw <a href="[_1]">laatste bericht</a> was [_2] op <a href="[_3]">[_4]</a>.',
	'You have <a href="[_1]">[quant,_2,draft,drafts]</a>.' => 'U heeft <a href="[_1]">[quant,_2,kladbericht, kladberichten]</a>.',
	'You\'ve written <a href="[_1]">[quant,_2,entry,entries]</a> with <a href="[_3]">[quant,_4,comment,comments]</a>.' => 'U heeft <a href="[_1]">[quant,_2,bericht,berichten]</a> geschreven met <a href="[_3]">[quant,_4,reactie,reacties]</a>.',
	'You\'ve written <a href="[_1]">[quant,_2,entry,entries]</a>.' => 'U heeft <a href="[_1]">[quant,_2,bericht,berichten]</a> geschreven.',
	'Edit your profile' => 'Bewerk uw profiel',

## tmpl/cms/widget/new_install.tmpl
	'Thank you for installing Movable Type' => 'Bedankt om Movable Type te installeren!',
	'Congratulations on installing Movable Type, the world\'s most powerful blogging, publishing and social media platform. To help you get started we have provided you with links to some of the more common tasks new users like to perform:' => '\n	Gelukwensen met de installatie van Movable Type, het krachtigste blog-, publicatie- en social mediaplatform ter wereld.  Om u te helpen van start te gaan hebben we enkele links verzameld naar de meest voorkomende dingen die nieuwe gebruikers willen doen:',
	'Add more users to your blog' => 'Voeg meer gebruikers toe aan uw weblog',
	'Start building your network of blogs and your community now. Invite users to join your blog and promote them to authors.' => 'Begin met het opbouwen van uw blognetwerk en uw gemeenschap.  Nodig gebruikers uit om lid te worden van uw blog en promoveer hen tot auteur.',

## tmpl/cms/widget/blog_stats.tmpl
	'Error retrieving recent entries.' => 'Fout bij het ophalen van recente berichten.',
	'Loading recent entries...' => 'Recente berichten aan het laden...',
	'Jan.' => 'Jan.',
	'Feb.' => 'Feb.',
	'July.' => 'Juli',
	'Aug.' => 'Aug.',
	'Sept.' => 'Sept.',
	'Oct.' => 'Okt.',
	'Nov.' => 'Nov.',
	'Dec.' => 'Dec.',
	'Movable Type was unable to locate your \'mt-static\' directory. Please configure the \'StaticFilePath\' configuration setting in your mt-config.cgi file, and create a writable \'support\' directory underneath your \'mt-static\' directory.' => 'Movable Type kon uw \'mt-static\' map niet vinden.  Gelieve de \'StaticFilePath\' directief in uw mt-config.cgi file in te stellen en maak een beschrijfbare \'support\' map aan in uw \'mt-static\' map.',
	'Movable Type was unable to write to its \'support\' directory. Please create a directory at this location: [_1], and assign permissions that will allow the web server write access to it.' => 'Movable Type was niet in staat om te schrijven in de \'support\' map.  Gelieve een map aan te maken in deze locatie: [_1] en er genoeg permissies aan toe te kennen zodat de webserver er in kan schrijven.',
	'[_1] [_2] - [_3] [_4]' => '[_1] [_2] - [_3] [_4]',
	'You have <a href=\'[_3]\'>[quant,_1,comment,comments] from [_2]</a>' => 'U heeft <a href=\'[_3]\'>[quant,_1,reactie,reacties] van [_2]</a>',
	'You have <a href=\'[_3]\'>[quant,_1,entry,entries] from [_2]</a>' => 'U heeft <a href=\'[_3]\'>[quant,_1,bericht,berichten] van [_2]</a>',

## tmpl/cms/widget/blog_stats_entry.tmpl
	'Most Recent Entries' => 'Recentste berichten',
	'View all entries' => 'Alle berichten bekijken',

## tmpl/cms/widget/blog_stats_tag_cloud.tmpl

## tmpl/cms/widget/blog_stats_comment.tmpl
	'Most Recent Comments' => 'Recentste reacties',
	'[_1] [_2], [_3] on [_4]' => '[_1] [_2], [_3] op [_4]',
	'View all comments' => 'Alle reacties bekijken',
	'No comments available.' => 'Geen reacties beschikbaar',

## tmpl/cms/popup/rebuilt.tmpl
	'Success' => 'Succes',
	'All of your files have been published.' => 'Al uw bestanden zijn gepubliceerd.',
	'Your [_1] has been published.' => 'Uw [_1] is opnieuw gepubliceerd.',
	'Your [_1] archives have been published.' => 'Uw [_1] archieven zijn gepubliceerd.',
	'Your [_1] templates have been published.' => 'Uw [_1] sjablonen zijn gepubliceerd.',
	'View your site.' => 'Uw site bekijken.',
	'View this page.' => 'Deze pagina bekijken.',
	'Publish Again (s)' => 'Opnieuw pubiceren (s)',
	'Publish Again' => 'Opnieuw publiceren',

## tmpl/cms/popup/pinged_urls.tmpl
	'Successful Trackbacks' => 'Gelukte TrackBacks',
	'Failed Trackbacks' => 'Mislukte TrackBacks',
	'To retry, include these TrackBacks in the Outbound TrackBack URLs list for your entry.' => 'Om opnieuw te proberen: zet deze TrackBacks in het veld voor uitgaande TrackBack URL\'s van uw bericht.',

## tmpl/cms/popup/rebuild_confirm.tmpl
	'Publish [_1]' => 'Publiceer [_1]',
	'Publish <em>[_1]</em>' => 'Publiceer <em>[_1]</em>',
	'_REBUILD_PUBLISH' => 'Publiceren',
	'All Files' => 'Alle bestanden',
	'Index Template: [_1]' => 'Indexsjabloon: [_1]',
	'Only Indexes' => 'Alleen indexen',
	'Only [_1] Archives' => 'Alleen archieven [_1]',
	'Publish (s)' => 'Publiceer (s)',

## tmpl/cms/edit_role.tmpl
	'Edit Role' => 'Rol bewerken',
	'Your changes have been saved.' => 'Uw wijzigingen zijn opgeslagen.',
	'List Roles' => 'Toon rollen',
	'[quant,_1,User,Users] with this role' => '[quant,_1,gebruiker,gebruikers] met deze rol',
	'You have changed the privileges for this role. This will alter what it is that the users associated with this role will be able to do. If you prefer, you can save this role with a different name.  Otherwise, be aware of any changes to users with this role.' => 'U heeft de rechten van deze rol aangepast.  Hierdoor is gewijzigd wat gebruikers kunnen doen die met deze rol zijn geassocieerd.  Als u dat verkiest, kunt u deze rol ook opslaan met een andere naam.  In het andere geval moet u er zich van bewust zijn welke wijzigingen er gebeuren bij gebruikers met deze rol.',
	'Role Details' => 'Rol details',
	'Created by' => 'Aangemaakt door',
	'Check All' => 'Alles aanvinken',
	'Uncheck All' => 'Alles uitvinken',
	'Administration' => 'Administratie',
	'Authoring and Publishing' => 'Schrijven en publiceren',
	'Designing' => 'Ontwerpen',
	'Commenting' => 'Reageren',
	'Duplicate Roles' => 'Dubbele rollen',
	'These roles have the same privileges as this role' => 'Deze rollen hebben dezelfde rechten als deze rol',
	'Save changes to this role (s)' => 'Wijzigingen aan deze rol opslaan (s)',

## tmpl/cms/cfg_plugin.tmpl
	'System Plugin Settings' => 'Systeeminstellingen plugins',
	'Useful links' => 'Nuttige links',
	'http://plugins.movabletype.org/' => 'http://plugins.movabletype.org',
	'Find Plugins' => 'Plugins vinden',
	'Plugin System' => 'Plugin systeem',
	'Manually enable or disable plugin-system functionality. Re-enabling plugin-system functionality, will return all plugins to their original state.' => 'Manueel pluginsysteem functionaliteit in- of uitschakelen.  Pluginsysteem functionaliteit opnieuw inschakelen zal alle plugins weer in hun oorspronkelijke staat brengen.',
	'Disable plugin functionality' => 'Plugin functionaliteit uitschakelen',
	'Disable Plugins' => 'Plugins uitschakelen',
	'Enable plugin functionality' => 'Plugin functionaliteit inschakelen',
	'Enable Plugins' => 'Plugins inschakelen',
	'Your plugin settings have been saved.' => 'Uw plugin-instellingen zijn opgeslagen.',
	'Your plugin settings have been reset.' => 'Uw plugin-instellingen zijn teruggezet op de standaardwaarden.',
	'Your plugins have been reconfigured. Since you\'re running mod_perl, you will need to restart your web server for these changes to take effect.' => '    Uw plugins zijn opnieuw geconfigureerd.  Omdat u mod_perl draait, moet u uw webserver opnieuw starten om de wijzigingen van kracht te maken.',
	'Your plugins have been reconfigured.' => 'Uw plugins zijn opnieuw geconfigureerd.',
	'Are you sure you want to reset the settings for this plugin?' => 'Bent u zeker dat u de instellingen voor deze plugin wil terugzetten naar de standaardwaarden?',
	'Are you sure you want to disable plugin functionality?' => 'Bent u zeker dat u plugin functionaliteit wenst uit te schakelen?',
	'Disable this plugin?' => 'Deze plugin uitschakelen?',
	'Are you sure you want to enable plugin functionality? (This will re-enable any plugins that were not individually disabled.)' => 'Bent u zeker dat u plugin-functies weer wenst in te schakelen? (Hierdoor zullen alle plugins opnieuw actief worden die niet individueel uitgeschakeld waren.)',
	'Enable this plugin?' => 'Deze plugin activeren?',
	'Failed to Load' => 'Laden mislukt',
	'(Disable)' => '(Desactiveren)',
	'Enabled' => 'Ingeschakeld',
	'(Enable)' => '(Activeren)',
	'Settings for [_1]' => 'Instellingen voor [_1]',
	'This plugin has not been upgraded to support Movable Type [_1]. As such, it may not be 100% functional. Furthermore, it will require an upgrade once you have upgraded to the next Movable Type major release (when available).' => 'Deze plugin is niet bijgewerkt om Movable Type [_1] te ondersteunen.  Om die reden kan het zijn dat hij niet voor 100% werkt.  Bovendien zal er een upgrade nodig zijn wanneer u een upgrade uitvoert naar de volgende major versie van Movable Type (wanneer die beschikbaar komt).',
	'Plugin error:' => 'Pluginfout:',
	'Info' => 'Info',
	'Resources' => 'Bronnen',
	'Run [_1]' => '[_1] uitvoeren',
	'Documentation for [_1]' => 'Documentatie voor [_1]',
	'Documentation' => 'Documentatie',
	'More about [_1]' => 'Meer over [_1]',
	'Plugin Home' => 'Homepage van deze plugin',
	'Author of [_1]' => 'Auteur van [_1]',
	'Tags:' => 'Tags:',
	'Tag Attributes:' => 'Tag attributen:',
	'Text Filters' => 'Tekstfilters',
	'Junk Filters:' => 'Spamfilters:',
	'Reset to Defaults' => 'Terugzetten naar standaardwaarden',
	'No plugins with blog-level configuration settings are installed.' => 'Er zijn geen plugins geïnstalleerd die configuratie-opties hebben op weblogniveau.',
	'No plugins with configuration settings are installed.' => 'Er zijn geen plugins geïnstalleerd met configuratie-opties.',

## tmpl/cms/list_blog.tmpl
	'You have successfully deleted the blogs from the Movable Type system.' => 'U heeft met succes de blogs verwijderd uit het Movable Type systeem.',
	'Create Blog' => 'Blog aanmaken',
	'Are you sure you want to delete this blog?' => 'Bent u zeker dat u deze weblog wenst te verwijderen?',

## tmpl/cms/edit_template.tmpl
	'Create Template' => 'Sjabloon aanmaken',
	'A saved version of this [_1] was auto-saved [_3]. <a href="[_2]">Recover auto-saved content</a>' => '[_1] werd automatisch opgeslagen [_3]. <a href="[_2]">Automatisch opgeslagen versie terughalen</a>',
	'You have successfully recovered your saved [_1].' => '[_1] met succes teruggehaald.',
	'An error occurred while trying to recover your saved [_1].' => 'Er deed zich een fout voor bij het terughalen van uw opgeslagen [_1]',
	'Your template changes have been saved.' => 'De wijzigingen aan uw sjabloon zijn opgeslagen.',
	'<a href="[_1]" class="rebuild-link">Publish</a> this template.' => '<a href="[_1]" class="rebuild-link">Publiceer</a> dit sjabloon.',
	'Useful Links' => 'Nuttige links',
	'List [_1] templates' => 'Toon [_1] sjablonen',
	'Template tag reference' => 'Sjabloontags referentie',
	'Includes and Widgets' => 'Includes en widgets',
	'create' => 'aanmaken',
	'Tag Documentation' => 'Tag documentatie',
	'Unrecognized Tags' => 'Niet herkende tags',
	'Save (s)' => 'Opslaan (s)',
	'Save and Publish this template (r)' => 'Dit sjabloon opslaan en publiceren (r)',
	'Save &amp; Publish' => 'Opslaan &amp; publiceren',
	'You have unsaved changes to this template that will be lost.' => 'U heeft niet opgeslagen wijzigingen aan dit sjabloon die verloren zullen gaan.',
	'You must set the Template Name.' => 'U moet de naam van het sjabloon instellen',
	'You must set the template Output File.' => 'U moet het uitvoerbestand van het sjabloon instellen.',
	'Please wait...' => 'Even wachten...',
	'Error occurred while updating archive maps.' => 'Er deed zich teen fout voor bij het bijwerken van de archiefkoppelingen.',
	'Archive map has been successfully updated.' => 'Archiefkoppelingen zijn met succes bijgewerkt.',
	'Are you sure you want to remove this template map?' => 'Bent u zeker dat u deze sjabloonmapping wenst te verwijderen?',
	'Module Body' => 'Moduletekst',
	'Template Body' => 'Sjabloontekst',
	'Syntax Highlight On' => 'Syntax highlighting aan',
	'Syntax Highlight Off' => 'Syntax highlighting uit',
	'Insert...' => 'Invoegen...',
	'Template Type' => 'Sjabloontype',
	'Custom Index Template' => 'Gepersonaliseerd indexsjabloon',
	'Publish Options' => 'Publicatieopties',
	'Enable dynamic publishing for this template' => 'Dynamisch publiceren inschakelen voor dit sjabloon',
	'Publish this template automatically when rebuilding index templates' => 'Publiceer dit sjabloon automatisch wanneer indexsjablonen worden gepubliceerd',
	'Link to File' => 'Koppelen aan bestand',
	'Create Archive Mapping' => 'Nieuwe archiefkoppeling aanmaken',
	'Add' => 'Toevoegen',
	'Auto-saving...' => 'Auto-opslaan...',
	'Last auto-save at [_1]:[_2]:[_3]' => 'Laatste auto-opslag om [_1]:[_2]:[_3]',

## tmpl/cms/dashboard.tmpl
	'Select a Widget...' => 'Selecteer een widget...',
	'Your Dashboard has been updated.' => 'Uw dashboard is bijgewerkt.',
	'You have attempted to use a feature that you do not have permission to access. If you believe you are seeing this message in error contact your system administrator.' => 'U heeft geprobeerd een optie te gebruiken waar u niet voldoende rechten voor heeft.  Als u gelooft dat u deze boodschap onterecht te zien krijgt, contacteer dan uw systeembeheerder.',
	'The directory you have configured for uploading avatars is not writable. In order to enable users to upload userpics, please make the following directory writable by your web server: [_1]' => 'De map die u heeft ingesteld om avatars te uploaden is niet beschrijfbaar.  Om uw gebruikers de optie te geven gebruikersafbeeldingen te uploaden, moet u deze map beschrijfbaar maken door uw webserver: [_1]',
	'Your dashboard is empty!' => 'Uw dashboard is leeg!',

## tmpl/cms/cfg_trackbacks.tmpl
	'TrackBack Settings' => 'TrackBack instellingen ',
	'Your TrackBack preferences have been saved.' => 'Uw TrackBackvoorkeuren zijn opgeslagen',
	'Note: TrackBacks are currently disabled at the system level.' => 'Opmerking: TrackBacks zijn momenteel uitgeschakeld op systeemniveau.',
	'Accept TrackBacks' => 'TrackBacks aanvaarden',
	'If enabled, TrackBacks will be accepted from any source.' => 'Indien ingeschakeld zullen TrackBacks worden aanvaard van eender welke bron.',
	'TrackBack Policy' => 'TrackBack beleid',
	'Moderation' => 'Moderatie',
	'Hold all TrackBacks for approval before they\'re published.' => 'Alle TrackBacks moeten eerst goedgekeurd worden voor ze worden gepubliceerd.',
	'Apply \'nofollow\' to URLs' => '\'nofollow\' toepassen op URL\'s',
	'This preference affects both comments and TrackBacks.' => 'Deze instelling heeft effect op reacties en TrackBacks',
	'If enabled, all URLs in comments and TrackBacks will be assigned a \'nofollow\' link relation.' => 'Indien ingeschakeld, zullen alle URL\'s in reacties en TrackBacks een \'nofollow\' linkrelatie toegewezen krijgen.',
	'E-mail Notification' => 'E-mail notificatie',
	'Specify when Movable Type should notify you of new TrackBacks if at all.' => 'Geef aan wanneer Movable Type u op de hoogte moet brengen van nieuwe TrackBacks, indien gewenst.',
	'On' => 'Aan',
	'Only when attention is required' => 'Alleen wanneer er aandacht is vereist',
	'Off' => 'Uit',
	'TrackBack Options' => 'TrackBack opties',
	'TrackBack Auto-Discovery' => 'Automatisch TrackBacks ontdekken',
	'If you turn on auto-discovery, when you write a new entry, any external links will be extracted and the appropriate sites automatically sent TrackBacks.' => 'Indien u auto-discovery inschakelt dan zullen telkens u een nieuw bericht schrijft er automatisch TrackBacks worden gestuurd naar de betreffende site voor alle links in uw bericht.',
	'Enable External TrackBack Auto-Discovery' => 'Externe automatische TrackBack-ontdekking inschakelen',
	'Setting Notice' => 'Opmerking bij deze instelling',
	'Note: The above option may be affected since outbound pings are constrained system-wide.' => 'Opmerking: Bovenstaande optie kan beïnvloed zijn omdat uitgaande pings op systeemniveau beperkt zijn.',
	'Setting Ignored' => 'Instelling genegeerd',
	'Note: The above option is currently ignored since outbound pings are disabled system-wide.' => 'Opmerking: bovenstaande optie wordt momenteel genegeerd omdat uitgaande pings op systeemniveau uitgeschakeld zijn.',
	'Enable Internal TrackBack Auto-Discovery' => 'Interne automatische TrackBack-ontdekking inschakelen',
	'Save changes to these settings (s)' => 'Wijzigingen aan deze instellingen opslaan (s)',

## tmpl/cms/list_entry.tmpl
	'Entries Feed' => 'Berichtenfeed',
	'Pages Feed' => 'Feed pagina\'s',
	'The entry has been deleted from the database.' => 'Dit bericht werd verwijderd uit de database',
	'The page has been deleted from the database.' => 'Deze pagina werd verwijderd uit de database',
	'Quickfilters' => 'Snelfilters',
	'[_1] (Disabled)' => '[_1] (Uitgeschakeld)',
	'Showing only: [_1]' => 'Enkel: [_1]',
	'Remove filter' => 'Filter verwijderen',
	'All [_1]' => 'Alle [_1]',
	'change' => 'wijzig',
	'[_1] where [_2] is [_3]' => '[_1] waar [_2] gelijk is aan [_3]',
	'Show only entries where' => 'Toon enkel berichten waar',
	'Show only pages where' => 'Toon enkel pagina\'s waar',
	'status' => 'status',
	'tag (exact match)' => 'tag (exacte overeenkomst)',
	'tag (fuzzy match)' => 'tag (fuzzy overeenkomst)',
	'is' => 'gelijk is aan',
	'published' => 'gepubliceerd',
	'unpublished' => 'ongepubliceerd',
	'scheduled' => 'gepland',
	'Select An Asset:' => 'Selecteer een mediabestand',
	'Asset Search...' => 'Zoek mediabestanden...',
	'Recent Assets...' => 'Recente mediabestanden',
	'Select A User:' => 'Selecteer een gebruiker:',
	'User Search...' => 'Zoeken naar gebruiker...',
	'Recent Users...' => 'Recente gebruikers...',
	'Filter' => 'Filter',

## tmpl/cms/edit_commenter.tmpl
	'The commenter has been trusted.' => 'Deze reageerder wordt vertrouwd.',
	'The commenter has been banned.' => 'Deze reageerder is verbannen.',
	'Comments from [_1]' => 'Reacties van [_1]',
	'commenter' => 'reageerder',
	'commenters' => 'reageerders',
	'Trust user (t)' => 'Gebruiker vertrouwen (t)',
	'Trust' => 'Vertrouwen',
	'Untrust user (t)' => 'Gebruiker niet meer vertrouwen (r)',
	'Untrust' => 'Niet vetrouwen',
	'Ban user (b)' => 'Gebruiker verbannen (b)',
	'Ban' => 'Verban',
	'Unban user (b)' => 'Ban op gebruiker opheffen',
	'Unban' => 'Ban opheffen',
	'The Name of the commenter' => 'Naam van de reageerder',
	'View all comments with this name' => 'Alle reacties met deze naam bekijken',
	'The Identity of the commenter' => 'De identiteit van de reageerder',
	'The Email of the commenter' => 'De e-mail van de reageerder',
	'Withheld' => 'Niet onthuld',
	'View all comments with this email address' => 'Alle reacties met dit e-mail adres bekijken',
	'The URL of the commenter' => 'De URL van de reageerder',
	'View all comments with this URL address' => 'Alle reacties met deze URL bekijken',
	'The trusted status of the commenter' => 'De vertrouwd/niet-vertrouwd status van de reageerder',
	'View all commenters' => 'Bekijk alle reageerders',

## tmpl/cms/cfg_system_general.tmpl
	'System: General Settings' => 'Systeem: Algemene instellingen',
	'Your settings have been saved.' => 'Uw instellingen zijn opgeslagen.',
	'(No blog selected)' => '(Geen blog geselecteerd)',
	'Select blog' => 'Selecteer blog',
	'You must set a valid Default Site URL.' => 'U moet een geldige standaard hoofd-URL voor de site instellen.',
	'You must set a valid Default Site Root.' => 'U moet een geldige standaard weblogmap voor de site instellen.',
	'System Email' => 'Systeem e-mail',
	'The email address used in the From: header of each email sent from the system.  The address is used in password recovery, commenter registration, comment, trackback notification and a few other minor events.' => 'Het e-mail adres gebruikt in de From: hader van elke e-mail verstuurd door het systeem.  Dit adres wordt gebruikt bij het terugvinden van wachtwoorden, registratie van reageerders, trackback- en berichtnotificaties en een aantal andere, minder belangrijke gebeurtenissen.',

## tmpl/cms/list_member.tmpl
	'Manage Users' => 'Gebruikers beheren',
	'Are you sure you want to remove this role?' => 'Bent u zeker dat u deze rol wenst te verwijderen?',
	'Add a user to this blog' => 'Voeg een gebruiker toe aan deze blog',
	'Show only users where' => 'Enkel gebruikers tonen waar',
	'role' => 'rol',
	'enabled' => 'ingeschakeld',
	'disabled' => 'uitgeschakeld',
	'pending' => 'te bekijken',

## tmpl/cms/cfg_comments.tmpl
	'Comment Settings' => 'Instellingen voor reacties',
	'Your preferences have been saved.' => 'Uw voorkeuren zijn opgeslagen',
	'Note: Commenting is currently disabled at the system level.' => 'Opmerking: reacties zijn momenteel uitgeschakeld op het systeemniveau.',
	'Comment authentication is not available because one of the needed modules, MIME::Base64 or LWP::UserAgent is not installed. Talk to your host about getting this module installed.' => 'Reactie-authenticatie is niet beschikbaar omdat één van de benodigde modules, MIME::Base64 of LWP::UserAgent niet is geïnstalleerd.  Praat met uw host om de module te doen installeren.',
	'Accept Comments' => 'Reacties aanvaarden',
	'If enabled, comments will be accepted.' => 'Indien ingeschakeld zullen reacties worden aanvaard.',
	'Commenting Policy' => 'Reactiebeleid',
	'Immediately approve comments from' => 'Onmiddellijk reacties goedkeuren van',
	'Specify what should happen to comments after submission. Unapproved comments are held for moderation.' => 'Instellen wat er moet gebeuren met reacties nadat ze zijn ingevoerd.  Niet gekeurde reacties worden bewaard voor latere moderatie.',
	'No one' => 'Niemand',
	'Trusted commenters only' => 'Enkel vertrouwde reageerders',
	'Any authenticated commenters' => 'Elke geauthenticeerde reageerder',
	'Anyone' => 'Iedereen',
	'Allow HTML' => 'HTML toestaan',
	'If enabled, users will be able to enter a limited set of HTML in their comments. If not, all HTML will be stripped out.' => 'Indien ingeschakeld zullen gebruikers een beperkte set HTML tags kunnen gebruiken in hun reacties.  Indien niet zal alle HTML verwijderd worden.',
	'Limit HTML Tags' => 'HTML tags beperken',
	'Specifies the list of HTML tags allowed by default when cleaning an HTML string (a comment, for example).' => 'Geeft een lijst met HTML-tags op die standaard zijn toegestaan wanneer een HTML-string wordt schoongemaakt (bijv. een reactie).',
	'Use defaults' => 'Standaardwaarden gebruiken',
	'([_1])' => '([_1])',
	'Use my settings' => 'Mijn instellingen gebruiken',
	'Disable \'nofollow\' for trusted commenters' => '\'nofollow\' uitschakelen voor vertrouwde reageerders',
	'If enabled, the \'nofollow\' link relation will not be applied to any comments left by trusted commenters.' => 'Indien ingeschakeld, dan zal de \'nofollow\' linkrelatie niet worden toegepast op links in reacties achtergelaten door vertrouwde reageerders.',
	'Specify when Movable Type should notify you of new comments if at all.' => 'Geef aan wanneer Movable Type u op de hoogte moet brengen van reacties, indien gewenst.',
	'Comment Display Options' => 'Opties voor het tonen van reacties',
	'Comment Order' => 'Volgorde reacties',
	'Select whether you want visitor comments displayed in ascending (oldest at top) or descending (newest at top) order.' => 'Selecteer of u reacties van bezoekers wilt weergeven in oplopende (oudste bovenaan) of aflopende (nieuwste bovenaan) volgorde.',
	'Ascending' => 'Oplopend',
	'Descending' => 'Aflopend',
	'Auto-Link URLs' => 'Automatisch URL\'s omzetten in links',
	'If enabled, all non-linked URLs will be transformed into links to that URL.' => 'Indien ingeschakeld zullen alle URLs die nog geen link zijn automatisch omgezet worden in links naar die URL.',
	'Text Formatting' => 'Tekstopmaak',
	'Specifies the Text Formatting option to use for formatting visitor comments.' => 'Geeft weer welke tekstopmaakoptie moet worden gebruikt voor de opmaak van reacties van bezoekers.',
	'CAPTCHA Provider' => 'CAPTCHA dienstverlener',
	'none' => 'geen',
	'No CAPTCHA provider available' => 'Geen CAPTCHA provider beschikbaar',
	'No CAPTCHA provider is available in this system.  Please check to see if Image::Magick is installed, and CaptchaSourceImageBase directive points to captcha-source directory under mt-static/images.' => 'Er is geen CAPTCHA provider beschikbaar in dit systeem.  Gelieve te controleren of Image::Magick is geïnstalleerd en of de CaptchaSourceImageBase directief verwijst naar de captcha-source map onder mt-static/images.',
	'Use Comment Confirmation Page' => 'Pagina voor bevestigen reacties gebruiken',
	'Use comment confirmation page' => 'Pagina voor bevestigen reacties gebruiken',

## tmpl/cms/backup.tmpl
	'What to backup' => 'Wat moet gebackupt worden?',
	'This option will backup Users, Roles, Associations, Blogs, Entries, Categories, Templates and Tags.' => 'Deze optie zal een backup maken van gebruikers, rollen, associaties, blogs, berichten, categorieën, sjablonen en tags.',
	'Everything' => 'Alles',
	'Choose blogs...' => 'Kies blogs...',
	'Archive Format' => 'Archiefformaat',
	'The type of archive format to use.' => 'Soort archiefformaat om te gebruiken',
	'Don\'t compress' => 'Niet comprimeren',
	'Target File Size' => 'Grootte doelbestand',
	'Approximate file size per backup file.' => 'Bestandsgrootte bij benadering per backupbestand',
	'Don\'t Divide' => 'Niet opsplitsen',
	'Make Backup (b)' => 'Backup maken (b)',
	'Make Backup' => 'Backup maken',

## tmpl/cms/edit_entry.tmpl
	'Create Page' => 'Pagina aanmaken',
	'Add folder' => 'Map toevoegen',
	'Add folder name' => 'Mapnaam toevoegen',
	'Add new folder parent' => 'Nieuwe bovenliggende map toevoegen',
	'Save this page (s)' => 'Pagina opslaan (s)',
	'Preview this page (v)' => 'Voorbeeld pagina bekijken (v)',
	'Delete this page (x)' => 'Pagina verwijderen (x)',
	'View Page' => 'Pagina bekijken', # Translate - Case
	'Add category' => 'Categorie toevoegen',
	'Add category name' => 'Categorienaam toevoegen',
	'Add new category parent' => 'Nieuwe bovenliggende categorie toevoegen',
	'Save this entry (s)' => 'Bericht opslaan (s)',
	'Preview this entry (v)' => 'Voorbeeld bericht bekijken (v)',
	'Delete this entry (x)' => 'Bericht verwijderen (x)',
	'View Entry' => 'Bericht bekijken',
	'A saved version of this entry was auto-saved [_2]. <a href="[_1]">Recover auto-saved content</a>' => 'Een veiligheidskopie van dit bericht werd automatisch opgeslagen [_2]. <a href="[_1]">Automatisch opgeslagen inhoud terughalen</a>', # Translate - New
	'A saved version of this page was auto-saved [_2]. <a href="[_1]">Recover auto-saved content</a>' => 'Een veiligheidskopie van deze pagina werd automatisch opgeslagen [_2]. <a href="[_1]">Automatisch opgeslagen inhoud terughalen</a>', # Translate - New
	'This entry has been saved.' => 'Dit bericht werd opgeslagen', # Translate - New
	'This page has been saved.' => 'Deze pagina werd opgeslagen', # Translate - New
	'One or more errors occurred when sending update pings or TrackBacks.' => 'Eén of meer problemen deden zich voor bij het versturen van update pings of TrackBacks.',
	'_USAGE_VIEW_LOG' => 'Controleer het <a href=\"[_1]\">Activiteitenlog</a> op deze fout.',
	'Your customization preferences have been saved, and are visible in the form below.' => 'Uw voorkeuren zijn opgeslagen en het formulier hieronder is aangepast.',
	'Your changes to the comment have been saved.' => 'Uw wijzigingen aan de reactie zijn opgeslagen.',
	'Your notification has been sent.' => 'Uw notificatie is verzonden.',
	'You have successfully recovered your saved entry.' => 'Veiligheidskopie van opgeslagen bericht met succes teruggehaald.', # Translate - New
	'You have successfully recovered your saved page.' => 'Veiligheidskopie van opgeslagen pagina met succes teruggehaald.', # Translate - New
	'An error occurred while trying to recover your saved entry.' => 'Er deed zich een fout voor bij het terughalen van uw opgeslagen bericht.', # Translate - New
	'An error occurred while trying to recover your saved page.' => 'Er deed zich een fout voor bij het terughalen van uw opgeslagen pagina.', # Translate - New
	'You have successfully deleted the checked comment(s).' => 'Verwijdering van de geselecteerde reactie(s) is geslaagd.',
	'You have successfully deleted the checked TrackBack(s).' => 'U heeft de geselecteerde TrackBack(s) met succes verwijderd.',
	'Change Folder' => 'Map wijzigen', # Translate - New
	'Stats' => 'Statistieken', # Translate - New
	'Share' => 'Delen', # Translate - New
	'<a href="[_2]">[quant,_1,comment,comments]</a>' => '<a href="[_2]">[quant,_1,reactie,reacties]</a>', # Translate - New
	'<a href="[_2]">[quant,_1,trackback,trackbacks]</a>' => '<a href="[_2]">[quant,_1,trackback,trackbacks]</a>', # Translate - New
	'Unpublished' => 'Ongepubliceerd',
	'You must configure this blog before you can publish this entry.' => 'U moet deze weblog configureren voor u dit bericht kunt publiceren.', # Translate - New
	'You must configure this blog before you can publish this page.' => 'U moet deze weblog configureren voor u deze pagina kunt publiceren.', # Translate - New
	'[_1] - Created by [_2]' => '[_1] - aangemaakt door [_2]', # Translate - New
	'[_1] - Published by [_2]' => '[_1] - gepubliceerd door [_2]', # Translate - New
	'[_1] - Edited by [_2]' => '[_1] - bewerkt door [_2]', # Translate - New
	'Publish On' => 'Publiceren op',
	'Publish Date' => 'Datum publicatie',
	'Select entry date' => 'Selecteer berichtdatum',
	'Unlock this entry&rsquo;s output filename for editing' => 'Maak het mogelijk om de uitvoerbestandsnaam te wijzigen',
	'Warning: If you set the basename manually, it may conflict with another entry.' => 'Waarschuwing: de basisnaam van het bericht met de hand aanpassen kan een conflict met een ander bericht veroorzaken.',
	'Warning: Changing this entry\'s basename may break inbound links.' => 'Waarschuwing: de basisnaam van het bericht aanpassen kan inkomende links breken.',
	'edit' => 'bewerken',
	'close' => 'Sluiten',
	'Accept' => 'Aanvaarden',
	'Outbound TrackBack URLs' => 'Uitgaande TrackBack URLs',
	'View Previously Sent TrackBacks' => 'Eerder verzonden TrackBacks bekijken',
	'You have unsaved changes to this entry that will be lost.' => 'U heeft niet opgeslagen wijzigingen aan dit bericht die verloren zullen gaan.', # Translate - New
	'You have unsaved changes to this page that will be lost.' => 'U heeft niet opgeslagen wijzigingen aan deze pagina die verloren zullen gaan.', # Translate - New
	'Enter the link address:' => 'Vul het adres van de link in:',
	'Enter the text to link to:' => 'Vul de tekst van de link in:',
	'Your entry screen preferences have been saved.' => 'Uw voorkeuren voor het berichtenscherm zijn opgeslagen.',
	'Your entry screen preferences have been saved. Please refresh the page to reorder the custom fields.' => 'Uw voorkeuren voor uw berichtenscherm zijn opgeslagen.  Gelieve de pagina te verversen om de volgorde van uw extra velden te zien veranderen.',
	'Are you sure you want to use the Rich Text editor?' => 'Bent u zeker dat u de Rich Text Editor wenst te gebruiken?',
	'Make primary' => 'Maak dit een hoofdcategorie',
	'Fields' => 'Velden',
	'Body' => 'Romp',
	'Reset display options' => 'Opties schermindeling terugzetten',
	'Reset display options to blog defaults' => 'Opties schermindeling terugzetten naar blogstandaard',
	'Reset defaults' => 'Standaardinstellingen terugzetten',
	'Previous' => 'Vorige',
	'Next' => 'Volgende',
	'Extended' => 'Uitgebreid',
	'Format:' => 'Formaat:',
	'(comma-delimited list)' => '(lijst gescheiden met komma\'s)',
	'(space-delimited list)' => '(lijst gescheiden met spaties)',
	'(delimited by \'[_1]\')' => '(gescheiden door \'[_1]\')',
	'<a href="<mt:var name="quickpost_js" escape="html">' => '<a href="<mt:var name="quickpost_js" escape="html">', # Translate - New
	'None selected' => 'Geen geselecteerd',

## tmpl/cms/view_log.tmpl
	'The activity log has been reset.' => 'Het activiteitlog is leeggemaakt.',
	'All times are displayed in GMT[_1].' => 'Alle tijdstippen worden getoond in GMT[_1].',
	'All times are displayed in GMT.' => 'Alle tijdstippen worden getoond in GMT.',
	'Show only errors' => 'Enkel fouten tonen',
	'System Activity Log' => 'Systeemactiviteitenlog',
	'Filtered' => 'Gefilterde',
	'Filtered Activity Feed' => 'Gefilterde activiteitenfeed',
	'Download Filtered Log (CSV)' => 'Gefilterde log downloaden',
	'Download Log (CSV)' => 'Log downloaden (CSV)',
	'Clear Activity Log' => 'Activiteitenlog leegmaken',
	'Are you sure you want to reset the activity log?' => 'Bent u zeker dat u het activiteitenlog wil leegmaken?',
	'Showing all log records' => 'Alle logberichten worden getoond',
	'Showing log records where' => 'Alleen logberichten worden getoond waar',
	'Show log records where' => 'Toon logberichten waar',
	'level' => 'niveau',
	'classification' => 'classificatie',
	'Security' => 'Beveiliging',
	'Error' => 'Fout',
	'Information' => 'Informatie',
	'Debug' => 'Debug',
	'Security or error' => 'Beveiliging of fout',
	'Security/error/warning' => 'Beveiliging/fout/waarschuwing',
	'Not debug' => 'Debug niet',
	'Debug/error' => 'Debug/fout',

## tmpl/cms/setup_initial_blog.tmpl
	'Create Your First Blog' => 'Maak uw eerste weblog aan',
	'The blog name is required.' => 'De naam van de blog is vereist',
	'The blog URL is required.' => 'De url van de blog is vereist',
	'The publishing path is required.' => 'Het publicatiepad is vereist',
	'The timezone is required.' => 'De tijdzone is vereist',
	'Template Set' => 'Set sjablonen',
	'Select the templates you wish to use for this new blog.' => 'Selecteer de sjablonen die u wenst te gebruiken voor deze nieuwe blog.',
	'Timezone' => 'Tijdzone',
	'Select your timezone from the pulldown menu.' => 'Selecteer uw tijdzone in de keuzelijst.',
	'Time zone not selected' => 'Geen tijdzone geselecteerd',
	'UTC+13 (New Zealand Daylight Savings Time)' => 'UTC+13 (Nieuw-Zeeland - zomertijd)',
	'UTC+12 (International Date Line East)' => 'UTC+12 (Internationale datumgrens - Oost)',
	'UTC+11' => 'UTC+11',
	'UTC+10 (East Australian Time)' => 'UTC+10 (Oost-Australische tijd)',
	'UTC+9.5 (Central Australian Time)' => 'UTC+9,5 (Centraal-Australische tijd)',
	'UTC+9 (Japan Time)' => 'UTC+9 (Japanse tijd)',
	'UTC+8 (China Coast Time)' => 'UTC+8 (Chinese kusttijd)',
	'UTC+7 (West Australian Time)' => 'UTC+7 (West-Australische tijd)',
	'UTC+6.5 (North Sumatra)' => 'UTC+6,5 (Noord-Sumatra)',
	'UTC+6 (Russian Federation Zone 5)' => 'UTC+6 (Russische Federatie Zone 5)',
	'UTC+5.5 (Indian)' => 'UTC+5,5 (Indische tijd)',
	'UTC+5 (Russian Federation Zone 4)' => 'UTC+5 (Russische Federatie Zone 4)',
	'UTC+4 (Russian Federation Zone 3)' => 'UTC+4 (Russische Federatie Zone 3)',
	'UTC+3.5 (Iran)' => 'UTC+3,5 (Iran)',
	'UTC+3 (Baghdad Time/Moscow Time)' => 'UTC+3 (Tijd in Bagdad/Moskau)',
	'UTC+2 (Eastern Europe Time)' => 'UTC+2 (Oost-Europese tijd)',
	'UTC+1 (Central European Time)' => 'UTC+1 (Centraal-Europese tijd)',
	'UTC+0 (Universal Time Coordinated)' => 'UTC+0 (Universeel Gecoördineerde Tijd)',
	'UTC-1 (West Africa Time)' => 'UTC-1 (West-Afrika-tijd)',
	'UTC-2 (Azores Time)' => 'UTC-2 (Azorentijd)',
	'UTC-3 (Atlantic Time)' => 'UTC-3 (Atlantische tijd)',
	'UTC-3.5 (Newfoundland)' => 'UTC-3,5 (Newfoundland)',
	'UTC-4 (Atlantic Time)' => 'UTC-4 (Atlantische tijd)',
	'UTC-5 (Eastern Time)' => 'UTC-5 (Oostkust tijd)',
	'UTC-6 (Central Time)' => 'UTC-6 (Central tijd)',
	'UTC-7 (Mountain Time)' => 'UTC-7 (Mountain tijd)',
	'UTC-8 (Pacific Time)' => 'UTC-8 (Westkust tijd)',
	'UTC-9 (Alaskan Time)' => 'UTC-9 (Alaska tijd)',
	'UTC-10 (Aleutians-Hawaii Time)' => 'UTC-10 (Aleutianen-Hawaïaanse tijd)',
	'UTC-11 (Nome Time)' => 'UTC-11 (Nome tijd)',
	'Finish install (s)' => 'Installatie afronden (s)',
	'Finish install' => 'Installatie afronden',
	'Back (x)' => 'Terug (x)',

## tmpl/cms/refresh_results.tmpl
	'Template Refresh' => 'Sjabloonverversing', # Translate - New
	'No templates were selected to process.' => 'Er werden geen sjablonen geselecteerd om te bewerken.',
	'Return to templates' => 'Terugkeren naar sjablonen',

## tmpl/cms/cfg_spam.tmpl
	'Spam Settings' => 'Spaminstellingen',
	'Your spam preferences have been saved.' => 'Uw spamvoorkeuren zijn opgeslagen',
	'Auto-Delete Spam' => 'Spam auto-wissen',
	'If enabled, feedback reported as spam will be automatically erased after a number of days.' => 'Indien ingeschakeld zal alle feedback die als spam is gemarkeerd automatisch verwijderd worden na een aantal dagen.',
	'Delete Spam After' => 'Spam verwijderen na',
	'When an item has been reported as spam for this many days, it is automatically deleted.' => 'Als een item langer dan dit aantal dagen als spam is gemarkeerd, wordt het automatisch gewist.',
	'days' => 'dagen',
	'Spam Score Threshold' => 'Spamscoredrempel',
	'Comments and TrackBacks receive a spam score between -10 (complete spam) and +10 (not spam). Feedback with a score which is lower than the threshold shown above will be reported as spam.' => 'Reacties en TrackBacks ontvangen een spamscoren tussen -10 (helemaal zeker spam) en +10 (helemaal zeker geen spam).  Feedback met een score die lager is dan de drempel hierboven zal als spam gemarkeerd worden.',
	'Less Aggressive' => 'Minder aggressief',
	'Decrease' => 'Verlaag',
	'Increase' => 'Verhoog',
	'More Aggressive' => 'Aggressiever',

## tmpl/cms/edit_folder.tmpl
	'Edit Folder' => 'Map bewerken',
	'Your folder changes have been made.' => 'De wijzigingen aan de map zijn uitgevoerd.',
	'You must specify a label for the folder.' => 'U moet een naam opgeven voor de map',
	'Save changes to this folder (s)' => 'Wijzigingen aan deze map opslaan (s)', # Translate - New

## tmpl/cms/list_notification.tmpl
	'You have added [_1] to your address book.' => 'U heeft [_1] toegevoegd aan uw adresboek.',
	'You have successfully deleted the selected contacts from your address book.' => 'U heeft met succes de geselecteerde contacten verwijderd uit uw adresboek.',
	'Download Address Book (CSV)' => 'Adresboek downloaden (CSV)',
	'contact' => 'contact',
	'contacts' => 'contacten',
	'Create Contact' => 'Contact aanmaken',
	'Website URL' => 'URL website',
	'Add Contact' => 'Contact toevoegen',

## tmpl/cms/export.tmpl
	'You must select a blog to export.' => 'U moet een blog kiezen om te exporteren.',
	'_USAGE_EXPORT_1' => 'Exporteer de berichten, reacties en TrackBacks van een blog.  Een export kan niet beschouwd worden als een <em>volledige</em> backup van een blog.',
	'Blog to Export' => 'Blog te exporteren',
	'Select a blog for exporting.' => 'Selecteer een blog om te exporteren.',
	'Change blog' => 'Wijzig blog',
	'Export Blog (s)' => 'Exporteer blog (s)',
	'Export Blog' => 'Exporteer blog',

## tmpl/cms/edit_category.tmpl
	'Edit Category' => 'Categorie bewerken',
	'Your category changes have been made.' => 'Uw categoriewijzigingen zijn gemaakt.',
	'You must specify a label for the category.' => 'U moet een label opgeven voor de categorie.',
	'_CATEGORY_BASENAME' => 'Basename',
	'This is the basename assigned to your category.' => 'Dit is de basisnaam toegekend aan uw categorie',
	'Unlock this category&rsquo;s output filename for editing' => 'De basisnaam van deze categorie bewerkbaar maken',
	'Warning: Changing this category\'s basename may break inbound links.' => 'Waarschuwing: de basisnaam van deze categorie veranderen kan inkomende links verbreken.',
	'Inbound TrackBacks' => 'Inkomende TrackBacks',
	'Accept Trackbacks' => 'TrackBacks aanvaarden',
	'If enabled, TrackBacks will be accepted for this category from any source.' => 'Indien ingeschakeld, zullen TrackBacks voor deze categorie worden aanvaard uit elke bron.',
	'View TrackBacks' => 'TrackBacks bekijken',
	'TrackBack URL for this category' => 'TrackBack URL voor deze categorie',
	'_USAGE_CATEGORY_PING_URL' => 'Dit is de URL die anderen zullen gebruiken om TrackBacks naar uw weblog te sturen.  Als u wenst dat eender wie een TrackBack naar uw weblog kan sturen indien ze een bericht hebben dat specifiek is aan deze categrie, maak deze URL dan bekend.  Als u wenst dat bekenden TrackBacks kunnen sturen, bezorg hen dan deze URL.  Om een lijst van binnengekomen TrackBacks aan uw hoofdindexsjabloon teo te voegen, kijk in de documentatie en zoek naar sjabloontags die te maken hebben met TrackBacks.',
	'Passphrase Protection' => 'Wachtwoordbeveiliging',
	'Optional' => 'optionele',
	'Outbound TrackBacks' => 'Uitgaande TrackBacks',
	'Trackback URLs' => 'TrackBack URL\'s',
	'Enter the URL(s) of the websites that you would like to send a TrackBack to each time you create an entry in this category. (Separate URLs with a carriage return.)' => 'Vul de URL(s) in van de websites waar u een TrackBack naartoe wenst te sturen elke keer u een bericht aanmaakt in deze categorie.  (Splits URL\'s van elkaar met een carriage return.)',
	'Save changes to this category (s)' => 'Wijzigingen aan deze categorie opslaan (s)', # Translate - New

## tmpl/cms/list_banlist.tmpl
	'IP Banning Settings' => 'IP-verbanningsinstellingen',
	'IP addresses' => 'IP adressen',
	'Delete selected IP Address (x)' => 'Verwijder geselecteerd IP adres (s)',
	'You have added [_1] to your list of banned IP addresses.' => 'U hebt [_1] toegevoegd aan uw lijst met uitgesloten IP adressen.',
	'You have successfully deleted the selected IP addresses from the list.' => 'U hebt de geselecteerde IP adressen uit de lijst is verwijderd.',
	'Ban IP Address' => 'Verban IP adres',
	'Date Banned' => 'Verbanningsdatum',

## tmpl/cms/list_ping.tmpl
	'Manage Trackbacks' => 'TrackBacks beheren',
	'The selected TrackBack(s) has been approved.' => 'De geselecteerde TrackBack(s) zijn goedgekeurd',
	'All TrackBacks reported as spam have been removed.' => 'Alle TrackBacks gerapporteerd als spam zijn verwijderd',
	'The selected TrackBack(s) has been unapproved.' => 'De geselecteerde TrackBack(s) zijn niet langer goedgekeurd',
	'The selected TrackBack(s) has been reported as spam.' => 'De geselecteerde TrackBack(s) zijn gerapporteerd als spam',
	'The selected TrackBack(s) has been recovered from spam.' => 'De geselecteerde TrackBack(s) zijn teruggehaald uit de spam-map',
	'The selected TrackBack(s) has been deleted from the database.' => 'De geselecteerde TrackBack(s) zijn uit de database verwijderd.',
	'No TrackBacks appeared to be spam.' => 'Geen enkele TrackBack leek spam te zijn.',
	'Show only [_1] where' => 'Enkel [_1] tonen waar', # Translate - New
	'approved' => 'goedgekeurd',
	'unapproved' => 'niet goedgekeurd',

## tmpl/cms/error.tmpl
	'An error occurred' => 'Er deed zich een probleem voor',

## tmpl/cms/list_role.tmpl
	'Roles: System-wide' => 'Rollen: over heel het systeem',
	'You have successfully deleted the role(s).' => 'De rol(len) zijn met succes verwijderd.',
	'roles' => 'rollen',
	'_USER_STATUS_CAPTION' => 'status',
	'Members' => 'Leden',
	'Role Is Active' => 'Rol is actief',
	'Role Not Being Used' => 'Rol wordt niet gebruikt',

## tmpl/cms/list_comment.tmpl
	'Manage Comments' => 'Reacties beheren',
	'The selected comment(s) has been approved.' => 'De geselecteerde reactie(s) zijn goedgekeurd.',
	'All comments reported as spam have been removed.' => 'Alle reaactie die aangemerkt waren als spam zijn verwijderd.',
	'The selected comment(s) has been unapproved.' => 'De geselecteerde reactie(s) zijn niet langer goedgekeurd.',
	'The selected comment(s) has been reported as spam.' => 'De geselecteerde reactie(s) zijn als spam gerapporteerd.',
	'The selected comment(s) has been recovered from spam.' => 'De geselecteerde reactie(s) zijn teruggehaald uit de spam-map',
	'The selected comment(s) has been deleted from the database.' => 'Geselecteerde reactie(en) zijn uit de database verwijderd.',
	'One or more comments you selected were submitted by an unauthenticated commenter. These commenters cannot be Banned or Trusted.' => 'Eén of meer reacties die u selecteerde werd ingegeven door een niet geauthenticeerde reageerder. Deze reageerders kunnen niet verbannen of vertrouwd worden.',
	'No comments appeared to be spam.' => 'Er lijken geen berichten als spam gemarkeerd te zijn',
	'[_1] on entries created within the last [_2] days' => '[_1] op berichten aangemaakt in de laatste [_2] dagen',
	'[_1] on entries created more than [_2] days ago' => '[_1] op berichten aangemaakt langer dan [_2] dagen geleden',
	'[_1] where [_2] [_3]' => '[_1] waar [_2] [_3]',

## tmpl/cms/cfg_web_services.tmpl
	'Web Services Settings' => 'Instellingen webservices',
	'Your blog preferences have been saved.' => 'Uw blogvoorkeuren zijn opgeslagen.',
	'Six Apart Services' => 'Six Apart diensten',
	'Your TypeKey token is used to access Six Apart services like its free Authentication service.' => 'Uw TypeKey token kan gebruikt worden om toegang te krijgen tot Six Apart diensten zoals de gratis authenticatieservice.',
	'TypeKey is enabled.' => 'TypeKey is ingeschakeld',
	'TypeKey token:' => 'TypeKey token:',
	'Clear TypeKey Token' => 'TypeKey token leegmaken',
	'Please click the Save Changes button below to disable authentication.' => 'Gelieve op de knop \'Wijzigingen opslaan\' te drukken om authenticatie uit te schakelen.',
	'TypeKey is not enabled.' => 'TypeKey is niet ingeschakeld',
	'or' => 'of',
	'Obtain TypeKey token' => 'TypeKey token bekomen',
	'Please click the Save Changes button below to enable TypeKey.' => 'Gelieve op de knop \'Wijzigingen opslaan\' te klikken om TypeKey in te schakelen.',
	'External Notifications' => 'Externe notificaties',
	'Notify of blog updates' => 'Op de hoogte brengen van blogupdates',
	'When this blog is updated, Movable Type will automatically notify the selected sites.' => 'Wanneer deze weblog wordt bijgewerkt, zal Movable Type automatisch de geselecteerde sites op de hoogte brengen.',
	'Note: This option is currently ignored since outbound notification pings are disabled system-wide.' => 'Opmerking: deze instelling wordt momenteel genegeerd, omdat uitgaande notificatie-pings zijn uitgeschakeld op systeemniveau.',
	'Others:' => 'Andere:',
	'(Separate URLs with a carriage return.)' => '(URL\'s van elkaar scheiden met een carriage return.)',
	'Recently Updated Key' => 'Recent bijgewerkt sleutel',
	'If you have received a recently updated key (by virtue of your purchase), enter it here.' => 'Als u een \'Recent bijgewerkt\' sleutel heeft ontvangen (door uw aankoop), vul die dan hier in.',

## tmpl/cms/list_template.tmpl
	'Blog Templates' => 'Blogsjablonen',
	'Blog Publishing Settings' => 'Blogpublicatie-instellingen',
	'All Templates' => 'Alle sjablonen', # Translate - New
	'You have successfully deleted the checked template(s).' => 'Verwijdering van geselecteerde sjabloon/sjablonen is geslaagd.',
	'You have successfully refreshed your templates.' => 'U heeft met succes uw sjablonen ververst.', # Translate - New
	'Your templates have been published.' => 'Uw sjablonen werden gepubliceerd.', # Translate - New
	'Create Archive Template:' => 'Archiefsjabloon aanmaken:',
	'Create [_1] template' => 'Nieuw [_1] sjabloon aanmaken',

## tmpl/cms/list_tag.tmpl
	'Your tag changes and additions have been made.' => 'Uw tag-wijzigingen en toevoegingen zijn uitgevoerd.',
	'You have successfully deleted the selected tags.' => 'U hebt met succes de geselecteerde tags verwijderd.',
	'tag' => 'tag',
	'tags' => 'tags',
	'Specify new name of the tag.' => 'Geef een nieuwe naam op voor de tag',
	'Tag Name' => 'Tag-naam',
	'Click to edit tag name' => 'Klik om de naam van de tag te wijzigen',
	'Rename [_1]' => 'Wijzig de naam van [_1]',
	'Rename' => 'Naam wijzigen',
	'Show all [_1] with this tag' => 'Alle [_1] tonen met deze tag',
	'[quant,_1,_2,_3]' => '[quant,_1,_2,_3]', # Translate - New
	'[quant,_1,entry,entries]' => '[quant,_1,bericht,berichten]',
	'The tag \'[_2]\' already exists. Are you sure you want to merge \'[_1]\' with \'[_2]\' across all blogs?' => 'De tag \'[_2]\' bestaat al.  Zeker dat u \'[_1]\' en \'[_2]\' wenst samen te voegen over alle blogs?',
	'An error occurred while testing for the new tag name.' => 'Er deed zich een fout voor bij het testen op de nieuwe tagnaam.',

## tmpl/cms/install.tmpl
	'Create Your Account' => 'Maak uw account aan',
	'The initial account name is required.' => 'De oorspronkelijke accountnaam is vereist.',
	'Password recovery word/phrase is required.' => 'Woord/uitdrukking om uw wachtwoord terug te vinden is vereist.',
	'The version of Perl installed on your server ([_1]) is lower than the minimum supported version ([_2]).' => 'De versie van Perl die op uw server is geïnstalleerd ([_1]) is lager dan de ondersteunde minimale versie ([_2]).',
	'While Movable Type may run, it is an <strong>untested and unsupported environment</strong>.  We strongly recommend upgrading to at least Perl [_1].' => 'Hoewel Movable Type er misschien op draait, is het een <strong>ongetesten en niet ondersteunde omgeving</strong>.  We raden ten zeerste aan om minstens te upgraden tot Perl [_1].',
	'Do you want to proceed with the installation anyway?' => 'Wenst u toch door te gaan met de installatie?',
	'View MT-Check (x)' => 'Bekijk MT-Check (x)',
	'Before you can begin blogging, you must create an administrator account for your system. When you are done, Movable Type will then initialize your database.' => 'Voor u kunt beginnen blogggen, moet u een administrator-account aanmaken voor uw systeem.  Wanneer u klaar bent zal Movable Type uw database initialiseren.',
	'To proceed, you must authenticate properly with your LDAP server.' => 'Om verder te gaan moet u zich aanmelden bij uw LDAP server.',
	'The name used by this user to login.' => 'De naam gebruikt door deze gebruiker om zich aan te melden.',
	'The name used when published.' => 'De naam gebruikt bij het publiceren',
	'The user&rsquo;s email address.' => 'E-mail adres van de gebruiker.',
	'Language' => 'Taal',
	'The user&rsquo;s preferred language.' => 'Voorkeurstaal van de gebruiker.',
	'Select a password for your account.' => 'Kies een wachtwoord voor uw account.',
	'Password Confirm' => 'Wachtwoord bevestigen',
	'Repeat the password for confirmation.' => 'Herhaal het wachtwoord ter bevestiging.',
	'This word or phrase will be required to recover your password if you forget it.' => 'Dit woord of deze uitdrukking zal gevraagd worden om uw wachtwoord terug te vinden als u het mocht vergeten.',
	'Your LDAP username.' => 'Uw LDAP gebruikersnaam.',
	'Enter your LDAP password.' => 'Geef uw LDAP wachtwoord op.',

## tmpl/cms/cfg_system_feedback.tmpl
	'System: Feedback Settings' => 'Systeem: Feedbackinstellingen',
	'Your feedback preferences have been saved.' => 'Uw voorkeuren voor feedback zijn opgeslagen.',
	'Feedback: Master Switch' => 'Feedback: Hoofdschakelaar',
	'This will override all individual blog settings.' => 'Deze instelling zal van toepassing zijn over alle instellingen op individuele blogs heen.',
	'Disable comments for all blogs' => 'Reacties uitschakelen op alle blogs',
	'Disable TrackBacks for all blogs' => 'TrackBacks uitschakelen op alle blogs',
	'Outbound Notifications' => 'Uitgaande notificaties',
	'Notification pings' => 'Notificatiepings',
	'This feature allows you to disable sending notification pings when a new entry is created.' => 'Met deze optie kunt u uitgaande notificatie-pings uitschakelen wanneer een nieuw bericht is aangemaakt.',
	'Disable notification pings for all blogs' => 'Notificatiepings uitschakelen op alle blogs',
	'Limit outbound TrackBacks and TrackBack auto-discovery for the purposes of keeping your installation private.' => 'Beperk uitgaande TrackBacks en TrackBack autodiscovery om uw installatie privé te houden.',
	'Allow to any site' => 'Toestaan naar alle sites',
	'(No outbound TrackBacks)' => '(Geen uitgaande TrackBacks)',
	'Only allow to blogs on this installation' => 'Enkel toestaan naar blogs op deze installatie',
	'Only allow the sites on the following domains:' => 'Enken toestaan naar sites op volgende domeinen:',

## tmpl/cms/edit_author.tmpl
	'Edit Profile' => 'Profiel bewerken',
	'This profile has been updated.' => 'Dit profiel werd bijgewerkt.',
	'A new password has been generated and sent to the email address [_1].' => 'Een nieuw wachtwoord werd gegenerereerd en is verzonden naar het e-mail adres [_1].',
	'Your Web services password is currently' => 'Uw huidig webservices wachtwoord is',
	'_WARNING_PASSWORD_RESET_SINGLE' => 'U staat op het punt het wachtwoord voor \"[_1]\" opnieuw in te stellen.  Een nieuw wachtwoord zal willekeurig worden aangemaakt en zal rechtstreeks naar het e-mail adres van deze gebruiker ([_2]) worden gestuurd.\n\nWenst u verder te gaan?',
	'Error occurred while removing userpic.' => 'Er deed zich een fout voor bij het verwijderen van de gebruikersafbeelding', # Translate - New
	'Status of user in the system. Disabling a user removes their access to the system but preserves their content and history.' => 'Status van de gebruiker in het systeem.  Een gebruiker uitschakelen ontzegt hem/haar toegang tot het systeem maar bewaart content en geschiedenis.',
	'_USER_PENDING' => 'Te keuren',
	'The username used to login.' => 'Gebruikersnaam om mee aan te melden',
	'External user ID' => 'Extern user ID',
	'The email address associated with this user.' => 'Het e-mail adres gekoppeld aan deze gebruiker',
	'The URL of the site associated with this user. eg. http://www.movabletype.com/' => 'De URL van de site gekoppeld aan deze gebruiker, bv. http://www.movabletype.com/',
	'Userpic' => 'Foto gebruiker',
	'The image associated with this user.' => 'De afbeelding verbonden aan deze gebruiker',
	'Select Userpic' => 'Selecteer foto gebruiker',
	'Remove Userpic' => 'Verwijder foto gebruiker',
	'Change Password' => 'Wachtwoord wijzigen',
	'Current Password' => 'Huidig wachtwoord',
	'Existing password required to create a new password.' => 'Bestaand wachtwoord vereist om een nieuw wachtwoord aan te maken',
	'Initial Password' => 'Initiëel wachtwoord',
	'Enter preferred password.' => 'Gekozen wachtwoord invoeren',
	'New Password' => 'Nieuw wachtwoord',
	'Enter the new password.' => 'Vul het nieuwe wachtwoord in',
	'Confirm Password' => 'Wachtwoord bevestigen',
	'This word or phrase will be required to recover a forgotten password.' => 'Dit woord of deze uitdrukking zal gebruikt worden om een vergeten wachtwoord terug te halen.',
	'Preferred language of this user.' => 'Voorkeurstaal van deze gebruiker',
	'Text Format' => 'Tekstformaat',
	'Preferred text format option.' => 'Voorkeursoptie tekstformaat',
	'(Use Blog Default)' => '(Standaard bloginstelling gebruiken)',
	'Tag Delimiter' => 'Scheidingsteken tags',
	'Preferred method of separating tags.' => 'Voorkeursmethode om tags van elkaar te scheiden',
	'Comma' => 'Komma',
	'Space' => 'Spatie',
	'Web Services Password' => 'Webservices wachtwoord',
	'For use by Activity feeds and with XML-RPC and Atom-enabled clients.' => 'Voor gebruik door activiteiten-feeds en met XML-RPC en Atom-gebaseerde cliënten.',
	'Reveal' => 'Onthul',
	'System Permissions' => 'Systeempermissies',
	'Options' => 'Opties',
	'Create personal blog for user' => 'Persoonlijke blog aanmaken voor gebruiker',
	'Create User (s)' => 'Gebruiker aanmaken (s)', # Translate - New
	'Save changes to this author (s)' => 'Wijzigingen aan deze auteur opslaan (s)', # Translate - New
	'_USAGE_PASSWORD_RESET' => 'Hieronder kunt u een nieuw wachtwoord laten instellen voor deze gebruiker.  Als u ervoor kiest om dit te doen, zal een willekeurig gegenereerd wachtwoord worden aangemaakt en rechtstreeks naar volgend e-mail adres worden verstuurd: [_1].',
	'Initiate Password Recovery' => 'Procedure starten om wachtwoord terug te halen',

## tmpl/cms/edit_comment.tmpl
	'The comment has been approved.' => 'De reactie is goedgekeurd.',
	'Save changes to this comment (s)' => 'Wijzigingen aan deze reactie opslaan (s)', # Translate - New
	'Delete this comment (x)' => 'Deze reactie verwijderen (x)', # Translate - New
	'Previous Comment' => 'Vorige reactie',
	'Next Comment' => 'Volgende reactie',
	'View entry comment was left on' => 'Bekijk het bericht waar dit een reactie op is',
	'Reply to this comment' => 'Antwoorden op deze reactie',
	'Update the status of this comment' => 'Status van dit bericht bijwerken',
	'Approved' => 'Goedgekeurd',
	'Unapproved' => 'Niet gekeurd',
	'Reported as Spam' => 'Gerapporteerd als spam',
	'View all comments with this status' => 'Alle reacties met deze status bekijken',
	'Spam Details' => 'Spamdetails',
	'Total Feedback Rating: [_1]' => 'Totale feedbackscore: [_1]',
	'Score' => 'Score',
	'Results' => 'Resultaten',
	'The name of the person who posted the comment' => 'De naam van de persoon die deze reactie',
	'(Trusted)' => '(Vertrouwd)',
	'Ban Commenter' => 'Verban reageerder',
	'Untrust Commenter' => 'Wantrouw reageerder',
	'(Banned)' => '(uitgesloten)',
	'Trust Commenter' => 'Vertrouw reageerder',
	'Unban Commenter' => 'Ontban reageerder',
	'View all comments by this commenter' => 'Alle reacties van deze reageerder bekijken',
	'Email address of commenter' => 'E-mail adres reageerder',
	'None given' => 'Niet opgegeven',
	'URL of commenter' => 'URL van de reageerder',
	'View all comments with this URL' => 'Alle reacties met deze URL bekijken',
	'[_1] this comment was made on' => '[_1] waarop deze reactie werd achtergelaten',
	'[_1] no longer exists' => '[_1] bestaat niet meer',
	'View all comments on this [_1]' => 'Alle reacties bekijken op [_1]',
	'Date this comment was made' => 'Datum van deze reactie',
	'View all comments created on this day' => 'Alle reacties van die dag bekijken',
	'IP Address of the commenter' => 'IP adres van de reageerder',
	'View all comments from this IP address' => 'Alle reacties van dit IP-adres bekijken',
	'Fulltext of the comment entry' => 'Volledige tekst van de reactie',
	'Responses to this comment' => 'Antwoorden op dit bericht',

## tmpl/cms/restore_end.tmpl
	'Make sure that you remove the files that you restored from the \'import\' folder, so that if/when you run the restore process again, those files will not be re-restored.' => 'Verwijder de bestanden die u heeft teruggezet uit de map \'import\', om te vermijden dat ze opnieuw worden teruggezet wanneer u ooit het restore-proces opnieuw uitvoert.',
	'An error occurred during the restore process: [_1] Please check activity log for more details.' => 'Er deed zich een fout voor tijdens het restore-proces: [_1].  Kijk het activiteitenlog na voor meer details.',

## tmpl/cms/list_asset.tmpl
	'You have successfully deleted the asset(s).' => 'U heeft met suuces de mediabestand(en) verwijderd.',
	'Show only assets where' => 'Enkel mediabestanden tonen waar', # Translate - New
	'type' => 'type',

## tmpl/cms/import.tmpl
	'You must select a blog to import.' => 'U moet een blog selecteren om te importeren.',
	'Transfer weblog entries into Movable Type from other Movable Type installations or even other blogging tools or export your entries to create a backup or copy.' => 'Importeer weblogberichten in Movable Type uit andere Movable Type installaties of zelfs andere blogsystemen, of exporteer uw berichten om een backup of kopie te maken.',
	'Blog to Import' => 'Blog om in te importeren',
	'Select a blog to import.' => 'Kies een blog om te importeren',
	'Importing from' => 'Aan het importeren uit',
	'Ownership of imported entries' => 'Eigenaarschap van geïmporteerde berichten',
	'Import as me' => 'Importeer als mezelf',
	'Preserve original user' => 'Oorspronkelijke gebruiker bewaren',
	'If you choose to preserve the ownership of the imported entries and any of those users must be created in this installation, you must define a default password for those new accounts.' => 'Als u ervoor kiest om het eigenaarschap van de geïmporteerde berichten te bewaren en als één of meer van die gebruikers nog moeten aangemaakt worden in deze installatie, moet u een standaard wachtwoord opgeven voor die nieuwe accounts.',
	'Default password for new users:' => 'Standaard wachtwoord voor nieuwe gebruikers:',
	'You will be assigned the user of all imported entries.  If you wish the original user to keep ownership, you must contact your MT system administrator to perform the import so that new users can be created if necessary.' => 'U zal eigenaar worden van alle geïmporteerde berichten.  Als u wenst dat de oorspronkelijke gebruiker eigenaar blijft, moet u uw MT systeembeheerder contacteren om de import te doen zodat nieuwe gebruikers aangemaakt kunnen worden indien nodig.',
	'Upload import file (optional)' => 'Importbestand opladen (optioneel)',
	'If your import file is located on your computer, you can upload it here.  Otherwise, Movable Type will automatically look in the \'import\' folder of your Movable Type directory.' => 'Als uw importbestand zich nog op uw eigen computer bevindt, kunt u het hier opladen.  In het andere geval zal Movable Type automatisch kijken in de \'import\' map van uw Movable Type map.',
	'More options' => 'Meer opties',
	'Import File Encoding' => 'Encodering importbestand',
	'By default, Movable Type will attempt to automatically detect the character encoding of your import file.  However, if you experience difficulties, you can set it explicitly.' => 'Standaard zal Movable Type proberen om automatisch de karakter encodering van het importbestand te bepalen.  Mocht u echter problemen ondervinden, kunt u het ook uitdrukkelijk instellen.',
	'<mt:var name="display_name">' => '<mt:var name="display_name">',
	'Default category for entries (optional)' => 'Standaardcategorie voor berichten (optioneel)',
	'You can specify a default category for imported entries which have none assigned.' => 'U kunt een standaardcategorie instellen voor geïmporteerde berichten waar er nog geen aan is toegewezen.',
	'Select a category' => 'Categorie selecteren',
	'Import Entries (s)' => 'Berichten importeren (s)',
	'Import Entries' => 'Berichten importeren',

## tmpl/cms/upgrade_runner.tmpl
	'Initializing database...' => 'Database wordt geïnitialiseerd...',
	'Upgrading database...' => 'Database wordt bijgewerkt...',
	'Installation complete!' => 'Installatie voltooid!',
	'Upgrade complete!' => 'Upgrade voltooid!',
	'Starting installation...' => 'Instalatie gaat van start...',
	'Starting upgrade...' => 'Upgrade gaat van start...',
	'Error during installation:' => 'Fout tijdens installatie:',
	'Error during upgrade:' => 'Fout tijdens upgrade:',
	'Return to Movable Type (s)' => 'Terugkeren naar Movable Type (s)',
	'Return to Movable Type' => 'Terugkeren naar Movable Type',
	'Your database is already current.' => 'Uw database is reeds up-to-date.',

## tmpl/cms/system_check.tmpl
	'User Counts' => 'Aantal gebruikers',
	'Number of users in this system.' => 'Aantal gebruikers in dit systeem',
	'Total Users' => 'Totaal aantal gebruikers',
	'Active Users' => 'Actieve gebruikers',
	'Users who have logged in within 90 days are considered <strong>active</strong> in Movable Type license agreement.' => 'Gebruikers die zich in de afgelopen 90 dagen hebben aangemeld worden als <strong>actief</strong> beschouwd voor de Movable Type licentieovereenkomst.',
	'Movable Type could not find the script named \'mt-check.cgi\'. To resolve this issue, please ensure that the mt-check.cgi script exists and/or the CheckScript configuration parameter references it properly.' => 'Movable Type kon het script met de naam \'mt-check.cgi\' niet vinden.  Om dit probleem op te lossen, gelieve te controleren dat het mt-check.cgi script bestaat en/of dat de MTCheckScript configuratieparameter er op de juiste manier naar verwijst.',

## tmpl/cms/restore.tmpl
	'Restore from a Backup' => 'Terugzetten uit een backup',
	'Perl module XML::SAX and/or its dependencies are missing - Movable Type can not restore the system without it.' => 'Perl module XML::SAX ontbreekt en/of enkele modules waarvan deze afhankelijk is - Movable Type kan geen restore operatie uitvoeren zonder deze module.',
	'Backup file' => 'Bestand backuppen',
	'If your backup file is located on your computer, you can upload it here.  Otherwise, Movable Type will automatically look in the \'import\' folder of your Movable Type directory.' => 'Als uw backup-bestand zich op uw computer bevindt, kunt u het hier opladen.  In het andere geval zal Movable Type automatisch in de \'omport\' map kijken in uw Movable Type map.',
	'Check this and files backed up from newer versions can be restored to this system.  NOTE: Ignoring Schema Version can damage Movable Type permanently.' => 'Kruis dit aan en ook bestanden die gebackupt zijn van nieuwere versies van Movable Type kunnen teruggezet worden op dit systeem.  Opmerking: de schemaversie negeren kan Movable Type permanent beschadigen.',
	'Ignore schema version conflicts' => 'Negeer schemaversieconflicten',
	'Check this and existing global templates will be overwritten from the backup file.' => 'Kruis dit aan en bestaande globale sjablonen zullen worden overschreven vanuit het backup bestand.',
	'Overwrite global templates.' => 'Globale sjablonen overschrijven.',
	'Restore (r)' => 'Terugzetten (r)',

## tmpl/cms/cfg_archives.tmpl
	'Error: Movable Type was not able to create a directory for publishing your blog. If you create this directory yourself, assign sufficient permissions that allow Movable Type to create files within it.' => 'Fout: Movable Type kon geen map maken om uw weblog in te publiceren.  Als u deze map zelf aanmaakt, ken er dan genoeg permissies aan toe zodat Movable Type er bestanden in kan aanmaken',
	'Your blog\'s archive configuration has been saved.' => 'De archiefinstellingen van uw weblog zijn opgeslagen.',
	'You have successfully added a new archive-template association.' => 'U hebt een nieuwe koppeling tussen een archief en een sjabloon toegevoegd.',
	'You may need to update your \'Master Archive Index\' template to account for your new archive configuration.' => 'Het kan zijn dat u uw \'Hoofdarchiefindex\' sjabloon moet bijwerken om rekening te houden met uw nieuwe archiefconfiguratie.',
	'The selected archive-template associations have been deleted.' => 'De geselecteerde koppelingen tussen een archief en een sjabloon zijn verwijderd.',
	'You must set your Local Site Path.' => 'U dient het lokale pad van uw site in te stellen.',
	'You must set a valid Site URL.' => 'U moet een geldige URL instellen voor uw site.',
	'You must set a valid Local Site Path.' => 'U moet een geldig lokaal site-pad instellen.',
	'Publishing Paths' => 'Publicatiepaden',
	'The URL of your website. Do not include a filename (i.e. exclude index.html). Example: http://www.example.com/blog/' => 'De URL van uw website.  Zet er geen bestandsnaam in (m.a.w. laat index.html weg).  Voorbeeld: http://www.voorbeeld.com/blog/',
	'Unlock this blog&rsquo;s site URL for editing' => 'Maak de site URL van deze weblog bewerkbaar',
	'Warning: Changing the site URL can result in breaking all the links in your blog.' => 'Waarschuwing: de site URL aanpassen kan tot gevolg hebben dat alle links naar uw weblog niet langer werken.',
	'The path where your index files will be published. An absolute path (starting with \'/\') is preferred, but you can also use a path relative to the Movable Type directory. Example: /home/melody/public_html/blog' => 'Het pad waar uw indexbestanden gepubliceerd zullen worden.  Een absoluut pad (beginnend met \'/\') verdient de voorkeur, maar u kunt ook een pad ingeven dat relatief is t.o.v. de Movable Type map.  Voorbeeld: /home/melody/public_html/blog',
	'Unlock this blog&rsquo;s site path for editing' => 'Maak het sitepad van deze weblog bewerkbaar',
	'Note: Changing your site root requires a complete publish of your site.' => 'Opmerking: De siteroot aanpassen vereist een volledige herpublicatie van uw site.',
	'Advanced Archive Publishing' => 'Geavanceerde archiefpublicatie',
	'Select this option only if you need to publish your archives outside of your Site Root.' => 'Selecteer deze optie alleen als u uw archieven buiten de root van uw site wenst te publiceren.',
	'Publish archives outside of Site Root' => 'Archieven buiten de siteroot publiceren',
	'Enter the URL of the archives section of your website. Example: http://archives.example.com/' => 'Geef de URL in van het archiefgedeelte van uw website.  Voorbeeld: http://archieven.voorbeeld.com/',
	'Unlock this blog&rsquo;s archive url for editing' => 'Maak de archief-URL van deze weblog bewerkbaar',
	'Warning: Changing the archive URL can result in breaking all the links in your blog.' => 'Waarschuwing: het aanpassen van de archief-URL kan ervoor zorgen dat alle links in uw weblog niet meer werken.',
	'Enter the path where your archive files will be published. Example: /home/melody/public_html/archives' => 'Vul het pad in waar uw archiefbestanden gepubliceerd moeten worden.  Voorbeeld: /home/melody/public_html/archieven',
	'Warning: Changing the archive path can result in breaking all the links in your blog.' => 'Waarschuwing: het aanpassen van het archiefpad kan ervoor zorgen dat alle links in uw weblog niet meer werken.',
	'Publishing Options' => 'Publicatie-opties',
	'Preferred Archive Type' => 'Voorkeursarchieftype',
	'Used for creating links to an archived entry (permalink). Select from the archive types used in this blogs archive templates.' => 'Gebruikt om links te leggen naar een gearchiveerd bericht (permalink).  Selecteer uit de archieftypes gebruikt in de archiefsjablonen van deze weblog.',
	'No archives are active' => 'Geen archieven actief',
	'Publishing Method' => 'Publicatiemethode',
	'Publish all templates statically' => 'Alle sjablonen statisch publiceren',
	'Publish only Archive Templates dynamically' => 'Enkel archiefsjablonen dynamisch publiceren',
	'Set each template\'s Publish Options separately' => 'Publicatie-instellingen voor elk sjabloon apart instellen',
	'Publish all templates dynamically' => 'Alle sjablonen dynamisch publiceren',
	'Use Publishing Queue' => 'Publicatiewachtrij gebruiken',
	'Requires the use of a cron job to publish pages in the background.' => 'Hiervoor is een cron job vereist die pagina\'s kan publiceren in de achtergrond.',
	'Use background publishing queue for publishing static pages for this blog' => 'Publicatiewachtrij in de achtergrond gebruiken om statische pagina\'s te publiceren op deze weblog.',
	'Enable Dynamic Cache' => 'Dynamische cache inschakelen',
	'Turn on caching.' => 'Caching inschakelen',
	'Enable caching' => 'Caching mogelijk maken',
	'Enable Conditional Retrieval' => 'Conditioneel ophalen mogelijk maken',
	'Turn on conditional retrieval of cached content.' => 'Conditioneel ophalen van inhoud uit de cache inschakelen.',
	'Enable conditional retrieval' => 'Conditioneel ophalen mogelijk maken',
	'File Extension for Archive Files' => 'Bestandsextensie voor archiefbestanden',
	'Enter the archive file extension. This can take the form of \'html\', \'shtml\', \'php\', etc. Note: Do not enter the leading period (\'.\').' => 'Voer de bestandsextensie voor het archief in. Dit kan zijn in de vorm van \'html\', \'shtml\', \'php\', enz. Opmerking: voer het eerste punt niet in (\'.\').',

## tmpl/cms/rebuilding.tmpl
	'Publishing...' => 'Publiceren...',
	'Publishing [_1]...' => '[_1] wordt gepubliceerd...',
	'Publishing [_1] [_2]...' => '[_1] [_2] wordt gepubliceerd...',
	'Publishing [_1] dynamic links...' => 'Bezig [_1] dynamische links te publiceren...',
	'Publishing [_1] archives...' => 'Bezig archieven [_1] te publiceren...',
	'Publishing [_1] templates...' => 'Bezig [_1] sjablonen te publiceren...',

## tmpl/cms/edit_asset.tmpl
	'Edit Asset' => 'Mediabestand bewerken', # Translate - New
	'Your asset changes have been made.' => 'De wijzigingen aan uw mediabestanden zijn aangebracht.', # Translate - New
	'[_1] - Modified by [_2]' => '[_1] - aangepast door [_2]', # Translate - New
	'Appears in...' => 'Komt voor in...', # Translate - New
	'Published on [_1]' => 'Gepubliceerd op [_1]', # Translate - New
	'Show all entries' => 'Alle berichten tonen', # Translate - New
	'Show all pages' => 'Alle pagina\'s tonen', # Translate - New
	'This asset has not been used.' => 'Dit mediabestand wordt nergens gebruikt.', # Translate - New
	'Related Assets' => 'Gerelateerde mediabestanden', # Translate - New
	'You must specify a label for the asset.' => 'U moet een label opgeven voor dit mediabestand.', # Translate - New
	'Embed Asset' => 'Mediabestand inbedden', # Translate - New
	'Save changes to this asset (s)' => 'Wijzigingen aan dit mediabestand opslaan (s)', # Translate - New

## tmpl/cms/upgrade.tmpl
	'Time to Upgrade!' => 'Tijd voor een upgrade!',
	'Upgrade Check' => 'Upgrade-controle',
	'Do you want to proceed with the upgrade anyway?' => 'Wenst u toch door te gaan met de upgrade?',
	'A new version of Movable Type has been installed.  We\'ll need to complete a few tasks to update your database.' => 'Er is een nieuwe versie van Movable Type geïnstalleerd.  Er moeten een aantal dingen gebeuren om uw database bij te werken.',
	'Information about this upgrade can be found <a href=\'[_1]\' target=\'_blank\'>here</a>.' => 'Informatie over deze upgrade kan <a href=\'[_1]\' target=\'_blank\'>hier</a> worden gevonden.',
	'In addition, the following Movable Type components require upgrading or installation:' => 'Bovendien hebben volgende Movable Type componenten een upgrade nodig of moeten ze geïnstalleerd worden:',
	'The following Movable Type components require upgrading or installation:' => 'Volgende Movable Type componenten hebben een upgrade nodig of moeten geïnstalleerd worden:',
	'Begin Upgrade' => 'Begin de upgrade',
	'Congratulations, you have successfully upgraded to Movable Type [_1].' => 'Proficiat, u heeft met succes een upgrade uitgevoerd aan Movable Type [_1].',
	'Your Movable Type installation is already up to date.' => 'Uw Movable Type installation is al up-to-date.',

## tmpl/cms/edit_blog.tmpl
	'Your blog configuration has been saved.' => 'Uw blogconfiguratie is opgeslagen',
	'You must set your Blog Name.' => 'U moet uw blognaam instellen.',
	'You did not select a timezone.' => 'U hebt geen tijdzone geselecteerd.',
	'You must set your Site URL.' => 'U dient de URL van uw site in te stellen.',
	'Your Site URL is not valid.' => 'De URL van uw site is niet geldig.',
	'You can not have spaces in your Site URL.' => 'Er mogen geen spaties in de URL van uw site zitten.',
	'You can not have spaces in your Local Site Path.' => 'Er mogen geen spaties in het locale pad van uw site.',
	'Your Local Site Path is not valid.' => 'Het lokale pad van uw site is niet geldig.',
	'Blog Details' => 'Blog details', # Translate - New
	'Name your blog. The blog name can be changed at any time.' => 'Geef uw blog een naam.  De blognaam kan op elk moment aangepast worden.',
	'Enter the URL of your public website. Do not include a filename (i.e. exclude index.html). Example: http://www.example.com/weblog/' => 'Vul de URL in van uw publieke website.  Laat de bestandsnaam weg (m.a.w. laat index.html weg).  Voorbeeld: http://www.voorbeeld.com/blog/',
	'Enter the path where your main index file will be located. An absolute path (starting with \'/\') is preferred, but you can also use a path relative to the Movable Type directory. Example: /home/melody/public_html/weblog' => 'Vul het pad in waar uw hoofdindexbestand zich zal bevingen.  Een absoluut pad (dat begint met \'/\') verdient de voorkeur, maar u kunt ook een pad gebruiken relatief aan de Movable Type map.  Voorbeeld: /home/melody/public_html/weblog',
	'Create Blog (s)' => 'Blog aanmaken (s)', # Translate - New

## tmpl/cms/pinging.tmpl
	'Trackback' => 'TrackBack',
	'Pinging sites...' => 'Bezig met pingen van sites...',

## tmpl/cms/cfg_prefs.tmpl
	'Enter a description for your blog.' => 'Geef een beschrijving op voor uw weblog.',
	'License' => 'Licentie',
	'Your blog is currently licensed under:' => 'Uw weblog valt momenteel onder deze licentie:',
	'Change license' => 'Licentie aanpassen',
	'Remove license' => 'Licentie verwijderen',
	'Your blog does not have an explicit Creative Commons license.' => 'Uw weblog heeft geen expliciete Creative Commons licentie',
	'Select a license' => 'Selecteer een licentie',

## tmpl/cms/restore_start.tmpl
	'Restoring Movable Type' => 'Movable Type terugzetten',

## tmpl/cms/preview_entry.tmpl
	'Preview [_1]' => '[_1]voorbeeld',
	'Re-Edit this [_1]' => '[_1] opnieuw bewerken',
	'Re-Edit this [_1] (e)' => '[_1] opnieuw bewerken (e)',
	'Save this [_1]' => '[_1] bewaren',
	'Save this [_1] (s)' => 'Deze [_1] opslaan (s)', # Translate - New
	'Cancel (c)' => 'Annuleer (c)',

## tmpl/cms/list_folder.tmpl
	'Manage Folders' => 'Mappen beheren', # Translate - New
	'Your folder changes and additions have been made.' => 'De wijzigingen en toevoegingen aan uw mappen zijn aangebracht.', # Translate - New
	'You have successfully deleted the selected folder.' => 'De geselecteerde map werden met succes verwijderd.', # Translate - New
	'Delete selected folders (x)' => 'Geselecteerde mappen verwijderen (x)', # Translate - New
	'Create top level folder' => 'Nieuwe map op topniveau aanmaken', # Translate - New
	'New Parent [_1]' => 'Nieuwe ouder-[_1]',
	'Create Folder' => 'Map aanmaken', # Translate - New
	'Top Level' => 'Topniveau',
	'Create Subfolder' => 'Submap aanmaken', # Translate - New
	'Move Folder' => 'Map verplaatsen', # Translate - New
	'Move' => 'Verplaatsen',
	'[quant,_1,page,pages]' => '[quant,_1,pagina,pagina\'s]',
	'No folders could be found.' => 'Er werden geen mappen gevonden.', # Translate - New

## tmpl/cms/list_association.tmpl
	'permission' => 'permissie',
	'permissions' => 'permissies',
	'Remove selected permissions (x)' => 'Geselecteerde permissies verwijderen (x)', # Translate - New
	'Revoke Permission' => 'Permissie intrekken',
	'[_1] <em>[_2]</em> is currently disabled.' => '[_1] <em>[_2]</em> is momenteel uitgeschakeld.',
	'Grant Permission' => 'Permissie toekennen',
	'You can not create permissions for disabled users.' => 'U kunt geen permissies aanmaken voor non-actieve gebruikers.', # Translate - New
	'Assign Role to User' => 'Ken rol toe aan gebruiker',
	'Grant permission to a user' => 'Ken permissie toe aan gebruiker',
	'You have successfully revoked the given permission(s).' => 'De gekozen permissie(s) zijn met succes ingetrokken.',
	'You have successfully granted the given permission(s).' => 'De gekozen permissie(s) zijn met succes toegekend.',
	'No permissions could be found.' => 'Er werden geen permissies gevonden.', # Translate - New

## tmpl/cms/login.tmpl
	'Your Movable Type session has ended.' => 'Uw Movable Type sessie is beëindigd.',
	'Your Movable Type session has ended. If you wish to sign in again, you can do so below.' => 'Uw Movable Type sessie is beëindigd.  Als u zich opnieuw wenst aan te melden, dan kan dat hieronder.',
	'Your Movable Type session has ended. Please sign in again to continue this action.' => 'Uw Movable Type sessie is beëindigd. Gelieve u opnieuw aan te melden om deze handeling voort te zetten.',
	'Forgot your password?' => 'Uw wachtwoord vergeten?',
	'Sign In (s)' => 'Aanmelden (s)',

## tmpl/cms/list_category.tmpl
	'Your category changes and additions have been made.' => 'Uw wijzigingen en toevoegingen aan de categorieën zijn uitgevoerd.', # Translate - New
	'You have successfully deleted the selected category.' => 'De geselecteerde categorie werd met succes verwijderd.', # Translate - New
	'categories' => 'categorieën',
	'Delete selected category (x)' => 'Geselecteerde categorie verwijderen (x)', # Translate - New
	'Create top level category' => 'Hoofdcategorie aanmaken', # Translate - New
	'Create Category' => 'Categorie aanmaken', # Translate - New
	'Collapse' => 'Inklappen',
	'Expand' => 'Uitklappen',
	'Move Category' => 'Categorie verplaatsen', # Translate - New
	'[quant,_1,TrackBack,TrackBacks]' => '[quant,_1,TrackBack,TrackBacks]',
	'No categories could be found.' => 'Er werden categorieën gevonden.', # Translate - New

## tmpl/cms/cfg_entry.tmpl
	'Entry Settings' => 'Berichtinstellingen',
	'Display Settings' => 'Toon instellingen',
	'Entry Listing Default' => 'Standaardinstelling overzicht berichten',
	'Select the number of days of entries or the exact number of entries you would like displayed on your blog.' => 'Selecteer het aantal dagen waarvoor of het exacte aantal berichten dat u op de voorpagina van uw weblog wenst te tonen.',
	'Days' => 'Dagen',
	'Entry Order' => 'Volgorde berichten',
	'Select whether you want your entries displayed in ascending (oldest at top) or descending (newest at top) order.' => 'Selecteer of u uw berichten wenst te tonen in opklimmende (oudste bovenaan) of dalende (nieuwste bovenaan) volgorde.',
	'Excerpt Length' => 'Lengte uittreksel',
	'Enter the number of words that should appear in an auto-generated excerpt.' => 'Vul het aantal woorden in dat moet verschijnen in automatisch gegenereerde uittreksels.',
	'Date Language' => 'Datumtaal',
	'Select the language in which you would like dates on your blog displayed.' => 'Selecteer de taal waarin u de datums op uw blogs wilt weergeven.',
	'Czech' => 'Tsjechisch',
	'Danish' => 'Deens',
	'Dutch' => 'Nederlands',
	'English' => 'Engels',
	'Estonian' => 'Estlands',
	'French' => 'Frans',
	'German' => 'Duits',
	'Icelandic' => 'IJslands',
	'Italian' => 'Italiaans',
	'Japanese' => 'Japans',
	'Norwegian' => 'Noors',
	'Polish' => 'Pools',
	'Portuguese' => 'Portugees',
	'Slovak' => 'Slowaaks',
	'Slovenian' => 'Sloveens',
	'Spanish' => 'Spaans',
	'Suomi' => 'Fins',
	'Swedish' => 'Zweeds',
	'Basename Length' => 'Lengte basisnaam',
	'Specifies the default length of an auto-generated basename. The range for this setting is 15 to 250.' => 'Bepaalt de standaardlengte van automatisch gegenereerde basisnamen.  Het bereik van deze instelling is tussen 15 en 250.',
	'New Entry Defaults' => 'Standaardinstellingen nieuw bericht',
	'Specifies the default Entry Status when creating a new entry.' => 'Bepaalt de standaardstatus van een nieuw aangemaakt bericht',
	'Specifies the default Text Formatting option when creating a new entry.' => 'Bepaalt de standaard tekstopmaak voor het aanmaken van een nieuw bericht.',
	'Specifies the default Accept Comments setting when creating a new entry.' => 'Bepaalt de standaardinstelling voor het aanvaarden van nieuwe reacties bij nieuwe berichten.',
	'Note: This option is currently ignored since comments are disabled either blog or system-wide.' => 'Opmerking: deze optie wordt momenteel genegeerd omdat reacties zijn uitgeschakeld op blog- of systeemniveau.',
	'Specifies the default Accept TrackBacks setting when creating a new entry.' => 'Bepaalt de standaardinstelling voor het aanvaarden van nieuwe TrackBacks bij nieuwe berichten.',
	'Note: This option is currently ignored since TrackBacks are disabled either blog or system-wide.' => 'Opmerking: deze optie wordt momenteel genegeerd omdat TrackBacks zijn uitgeschakeld op blog- of systeemniveau.',
	'Replace Word Chars' => 'Karakters uit Word vervangen',
	'Smart Replace' => 'Slim vervangen',
	'Replace UTF-8 characters frequently used by word processors with their more common web equivalents.' => 'Vervang UTF-8 karakters die vaak worden gebruikt door tekstverwerkers door hun meer gestandaardiseerde web-equivalenten.',
	'No substitution' => 'Geen vervanging',
	'Character entities (&amp#8221;, &amp#8220;, etc.)' => 'Karakter entiteiten (&amp#8221;, &amp#8220;, etc.)',
	'ASCII equivalents (&quot;, \', ..., -, --)' => 'ASCII equivalenten (&quot;, \', ..., -, --)',
	'Replace Fields' => 'Velden vervangen',
	'Extended entry' => 'Uitgebreid bericht',
	'Default Editor Fields' => 'Standaard velden voor de editor',
	'Editor Fields' => 'Velden van de tekstbewerker',
	'_USAGE_ENTRYPREFS' => 'Selecteer de velden die getoond moeten worden in het scherm om berichten te bewerken.',
	'Action Bars' => 'Actiebalken',
	'Select the location of the entry editor&rsquo;s action bar.' => 'Selecteer de locatie voor de actiebalk in de berichteneditor.',

## tmpl/cms/cfg_system_users.tmpl
	'System: User Settings' => 'Systeem: Gebruikersinstellingen',
	'(None selected)' => '(geen geselecteerd)',
	'User Registration' => 'Gebruikersregistratie',
	'Allow Registration' => 'Registratie toestaan',
	'Select a system administrator you wish to notify when commenters successfully registered themselves.' => 'Selecteer een systeembeheerder die op de hoogte gebracht moet worden wanneer nieuwe reageerders zich met succes registreren.',
	'Allow commenters to register to Movable Type' => 'Geef reageerders de optie zich te registreren via Movable Type',
	'Notify the following administrators upon registration:' => 'Waarschuw volgende administrators bij registraties',
	'Select Administrators' => 'Selecteer administrators',
	'Clear' => 'Leegmaken',
	'Note: System Email Address is not set. Emails will not be sent.' => 'Noot: Systeem e-mailadres is niet ingesteld.  Er zullen geen e-mails worden verstuurd.',
	'New User Defaults' => 'Standaardinstellingen nieuwe gebruikers',
	'Personal blog' => 'Persoonlijke blog',
	'Check to have the system automatically create a new personal blog when a user is created in the system. The user will be granted a blog administrator role on the blog.' => 'Kruis dit aan om het systeem automatisch een nieuwe persoonlijke blog aan te laten maken voor elke nieuwe gebruiker die wordt aangemaakt.  De gebruiker zal een blogadministrator rol krijgen op de blog.',
	'Automatically create a new blog for each new user' => 'Automatisch een nieuwe blog aanmaken voor elke nieuwe gebruiker',
	'Personal blog clone source' => 'Kloonbron persoonlijke blog',
	'Select a blog you wish to use as the source for new personal blogs. The new blog will be identical to the source except for the name, publishing paths and permissions.' => 'Selecteer een blog die u wenst te gebruiken als bron voor nieuw persoonlijke blogs.  De nieuwe blog zal identiek zijn aan de bron op de naam, publicatiepaden en permissies na.',
	'Default Site URL' => 'Standaard URL van de site',
	'Define the default site URL for new blogs. This URL will be appended with a unique identifier for the blog.' => 'Stel de standaard site URL in voor nieuwe blogs.  Deze URL zal vervolledigd worden met een unieke identificatie voor de blog.',
	'Default Site Root' => 'Standaard hoofdmap van de site',
	'Define the default site root for new blogs. This path will be appended with a unique identifier for the blog.' => 'Stel de standaard siteroot in voor nieuwe blogs.  Dit pad zal vervolledigd worden met een unieke identificatie voor de blog.',
	'Default User Language' => 'Standaard taal',
	'Define the default language to apply to all new users.' => 'Stel de standaard taal in voor nieuwe gebruikers',
	'Default Timezone' => 'Standaard tijdzone',
	'Default Tag Delimiter' => 'Standaard tagscheidingsteken',
	'Define the default delimiter for entering tags.' => 'Stel het standaard teken in om tags van elkaar te onderscheiden bij het invoeren.',

## tmpl/cms/recover_password_result.tmpl
	'Recover Passwords' => 'Wachtwoorden terugvinden',
	'No users were selected to process.' => 'Er werden geen gebruikers geselecteerd om te verwerken.',
	'Return' => 'Terug',

## tmpl/cms/cfg_registration.tmpl
	'Registration Settings' => 'Registratie-instellingen',
	'Allow registration for Movable Type.' => 'Laat registratie toe in Movable Type',
	'Registration Not Enabled' => 'Registratie niet ingeschakeld',
	'Note: Registration is currently disabled at the system level.' => 'Opmerking: Registratie is momenteel uitgeschakeld op systeemniveau',
	'Authentication Methods' => 'Methodes voor authenticatie',
	'Note: You have selected to accept comments from authenticated commenters only but authentication is not enabled. In order to receive authenticated comments, you must enable authentication.' => 'Opmerking: u heeft ervoor gekozen om enkel reacties te aanvaarden van geauthenticeerde reageerders, maar authenticatie is niet ingeschakeld.  Om geauthenticeerde reacties te kunnen ontvangen, moet u authenticatie inschakelen.',
	'Native' => 'Ingebouwd',
	'Require E-mail Address for Comments via TypeKey' => 'E-mail adres vereisen voor reacties via TypeKey',
	'If enabled, visitors must allow their TypeKey account to share e-mail address when commenting.' => 'Indien ingeschakeld, moeten bezoekers hun TypeKey account toestaan om hun e-mail adres vrij te geven bij het reageren.',
	'Setup TypeKey' => 'TypeKey instellen',
	'OpenID providers disabled' => 'OpenID providers uitgeschakeld',
	'Required module (Digest::SHA1) for OpenID commenter authentication is missing.' => 'Vereiste module (Digest::SHA1) voor OpenID reageerders-authenticatie ontbreekt.',

## tmpl/cms/list_author.tmpl
	'Users: System-wide' => 'Gebruikers: over heel het systeem',
	'_USAGE_AUTHORS_LDAP' => 'Dit is een lijst met alle gebruikers in het Movable Type systeem.  U kunt de permissies van een gebruiker bewerken door op zijn/haar naam te klikken.  U kunt gebruikers uitschakelen door het vakje naast hun naam aan te kruisen en dan UITSCHAKELEN te kiezen.  Wanneer u dit doet, zal de gebruiker zich niet meer kunnen aanmelden bij Movable Type.',
	'You have successfully disabled the selected user(s).' => 'Geselecteerde gebruiker(s) met succes uitgeschakeld.',
	'You have successfully enabled the selected user(s).' => 'Geselecteerde gebruiker(s) met succes ingeschakeld.',
	'You have successfully deleted the user(s) from the Movable Type system.' => 'U heeft met succes de gebruiker(s) verwijderd uit het Movable Type systeem.',
	'The deleted user(s) still exist in the external directory. As such, they will still be able to login to Movable Type Enterprise.' => 'De verwijderde gebruiker(s) blijven bestaan in de externe directory. Om die reden zullen ze zich nog steeds kunnen aanmelden op Movable Type Enterprise.',
	'You have successfully synchronized users\' information with the external directory.' => 'U heeft met succes de gebruikersgegevens gesynchroniseerd met de externe directory.',
	'Some ([_1]) of the selected user(s) could not be re-enabled because they were no longer found in the external directory.' => 'Een aantal ([_1]) van de geselecteerde gebruiker(s) konden niet opniew worden ingeschakeld omdat ze niet meer werden gevonden in de externe directory.',
	'An error occured during synchronization.  See the <a href=\'[_1]\'>activity log</a> for detailed information.' => 'Er deed zich een fout voor tijdens de synchronisatie.  Kijk in het <a href=\'[_1]\'>activiteitenlog</a> voor gedetailleerde informatie.',
	'Enable selected users (e)' => 'Geselecteerde gebruikers activeren (E)',
	'_USER_ENABLE' => 'Activeren',
	'_NO_SUPERUSER_DISABLE' => 'Omdat u een systeembeheerder bent in het Movable Type systeem, kunt u zichzelf niet desactiveren.',
	'Disable selected users (d)' => 'Geselecteerde gebruikers desactiveren (D)',
	'_USER_DISABLE' => 'Desactiveren',
	'Showing All Users' => 'Alle gebruikers worden getoond',

## tmpl/cms/import_others.tmpl
	'Start title HTML (optional)' => 'Start-HTML titel (optioneel)',
	'End title HTML (optional)' => 'Eind-HTML titel (optioneel-',
	'If the software you are importing from does not have title field, you can use this setting to identify a title inside the body of the entry.' => 'Als de software waaruit u importeert geen titelveld heeft, kunt u deze instelling gebruiken om aan te geven hoe een titel te herkennen in de tekst van een bericht.',
	'Default entry status (optional)' => 'Standaardstatus berichten (optioneel)',
	'If the software you are importing from does not specify an entry status in its export file, you can set this as the status to use when importing entries.' => 'Als de software waaruit u importeert geen status opgeeft voor de berichten in het importbestand, kunt u hiermee een standaardstatus instellen om te gebruiken bij het importeren.',
	'Select an entry status' => 'Selecteer een berichtstatus',

## tmpl/cms/search_replace.tmpl
	'You must select one or more item to replace.' => 'U moet één of meer items selecteren om te vervangen.',
	'Search Again' => 'Opnieuw zoeken',
	'Submit search (s)' => 'Zoekopdracht ingeven (s)',
	'Replace' => 'Vervangen',
	'Replace Checked' => 'Aangekruiste items vervangen',
	'Case Sensitive' => 'Hoofdlettergevoelig',
	'Regex Match' => 'Regex-overeenkomst',
	'Limited Fields' => 'Beperkte velden',
	'Date Range' => 'Bereik wissen',
	'Reported as Spam?' => 'Rapporteren als spam?',
	'Search Fields:' => 'Zoekvelden:',
	'_DATE_FROM' => 'Van',
	'_DATE_TO' => 'Tot',
	'Successfully replaced [quant,_1,record,records].' => 'Met succes [quant,_1,record,records] vervangen.',
	'Showing first [_1] results.' => 'Eerste [_1] resultaten worden getoond.',
	'Show all matches' => 'Alle overeenkomsten worden getoond',
	'[quant,_1,result,results] found' => '[quant,_1,resultaat,resultaten] found',

## tmpl/cms/preview_strip.tmpl
	'Save this entry' => 'Dit bericht opslaan', # Translate - New
	'Re-Edit this entry' => 'Dit bericht opnieuw bewerken', # Translate - New
	'Re-Edit this entry (e)' => 'Dit bericht opnieuw bewerken (e)', # Translate - New
	'Save this page' => 'Deze pagina opslaan', # Translate - New
	'Re-Edit this page' => 'Deze pagina opnieuw bewerken', # Translate - New
	'Re-Edit this page (e)' => 'Deze pagina opnieuw bewerken (e)', # Translate - New
	'You are previewing the entry titled &ldquo;[_1]&rdquo;' => 'U bekijkt een voorbeeld van het bericht met de titel &ldquo;[_1]&rdquo;', # Translate - New
	'You are previewing the page titled &ldquo;[_1]&rdquo;' => 'U bekijkt een voorbeeld van de pagina met de titel &ldquo;[_1]&rdquo;', # Translate - New

## tmpl/cms/edit_ping.tmpl
	'Edit Trackback' => 'TrackBack bewerken',
	'The TrackBack has been approved.' => 'De TrackBack is goedgekeurd.',
	'List &amp; Edit TrackBacks' => 'TrackBacks tonen &amp; bewerken',
	'Save changes to this TrackBack (s)' => 'Wijzigingen aan deze TrackBack opslaan (s)', # Translate - New
	'Delete this TrackBack (x)' => 'Deze TrackBack verwijderen (x)', # Translate - New
	'Update the status of this TrackBack' => 'Status van deze TrackBack bijwerken',
	'Junk' => 'Spam',
	'View all TrackBacks with this status' => 'Alle TrackBacks met deze status bekijken',
	'Source Site' => 'Bronsite',
	'Search for other TrackBacks from this site' => 'Andere TrackBacks van deze site zoeken',
	'Source Title' => 'Brontitel',
	'Search for other TrackBacks with this title' => 'Andere TrackBacks met deze titel zoeken',
	'Search for other TrackBacks with this status' => 'Andere TrackBacks met deze status zoeken',
	'Target Entry' => 'Doelbericht',
	'Entry no longer exists' => 'Bericht bestaat niet meer',
	'No title' => 'Geen titel',
	'View all TrackBacks on this entry' => 'Alle TrackBacks op dit bericht bekijken',
	'Target Category' => 'Doelcategorie',
	'Category no longer exists' => 'Categorie bestaat niet meer',
	'View all TrackBacks on this category' => 'Alle TrackBacks op deze categorie bekijken',
	'View all TrackBacks created on this day' => 'Bekijk alle TrackBacks aangemaakt op deze dag',
	'View all TrackBacks from this IP address' => 'Alle TrackBacks van dit IP adres bekijken',
	'TrackBack Text' => 'TrackBack-tekst',
	'Excerpt of the TrackBack entry' => 'Uittreksel van het TrackBackbericht',

## tmpl/comment/register.tmpl
	'Create an account' => 'Maak een account aan',
	'Your email address.' => 'Uw e-mail adres.',
	'Your login name.' => 'Uw gebruikersnaam.',
	'The name appears on your comment.' => 'Deze naam verschijnt onder uw reactie',
	'Select a password for yourself.' => 'Kies een wachtwoord voor uzelf.',
	'This word or phrase will be required to recover the password if you forget it.' => 'Dit woord of deze uitdrukking zal gevraagd worden om uw wachtwoord terug te vinden als u het bent verloren.',
	'The URL of your website. (Optional)' => 'De URL van uw website. (Optioneel)',
	'Register' => 'Registreer',

## tmpl/comment/signup.tmpl

## tmpl/comment/login.tmpl
	'Sign in to comment' => 'Aanmelden om te reageren',
	'Sign in using' => 'Aanmelden met',
	'Remember me?' => 'Mij onthouden?',
	'Not a member?&nbsp;&nbsp;<a href="[_1]">Sign Up</a>!' => 'Nog geen lid?&nbsp;&nbsp;<a href="[_1]">Registreer</a>!',

## tmpl/comment/error.tmpl
	'Go Back (s)' => 'Ga terug (s)',

## tmpl/comment/signup_thanks.tmpl
	'Thanks for signing up' => 'Bedankt om te registreren',
	'Before you can leave a comment you must first complete the registration process by confirming your account. An email has been sent to [_1].' => 'Voordat u een reactie kunt achterlaten, moet u eerst het registratieproces doorlopen door uw account te bevestigen.  Er is een e-mail verstuurd naar [_1].',
	'To complete the registration process you must first confirm your account. An email has been sent to [_1].' => 'Om de registratieprocedure te voltooien moet u eerst uw account bevestigen.  Er is een e-mail verstuurd naar [_1].',
	'To confirm and activate your account please check your inbox and click on the link found in the email we just sent you.' => 'Om uw account te bestigen en activeren, gelieve in uw inbox te kijken en op de link te klikken in de e-mail die u net is toegestuurd.',
	'Return to the original entry.' => 'Terugkeren naar oorspronkelijk bericht',
	'Return to the original page.' => 'Terugkeren naar oorspronkelijke pagina',

## tmpl/comment/profile.tmpl
	'Your Profile' => 'Uw profiel',
	'Password recovery' => 'Wachtwoord terugvinden',
	'Return to the <a href="[_1]">original page</a>.' => 'Keer terug naar de <a href="[_1]">oorspronkelijke pagina</a>.',

## tmpl/feeds/feed_entry.tmpl
	'Unpublish' => 'Publicatie ongedaan maken',
	'More like this' => 'Meer zoals dit',
	'From this blog' => 'Van deze blog',
	'From this author' => 'Van deze auteur',
	'On this day' => 'Op deze dag',

## tmpl/feeds/feed_comment.tmpl
	'On this entry' => 'Op dit bericht',
	'By commenter identity' => 'Volgens identiteit reageerders',
	'By commenter name' => 'Volgens naam reageerders',
	'By commenter email' => 'Volgens e-mail reageerders',
	'By commenter URL' => 'Volgens URL reageerders',

## tmpl/feeds/login.tmpl
	'Movable Type Activity Log' => 'Movable Type activiteitlog',
	'This link is invalid. Please resubscribe to your activity feed.' => 'Deze link is niet geldig. Gelieve opnieuw in te schrijven op uw activiteitenfeed.',

## tmpl/feeds/error.tmpl

## tmpl/feeds/feed_page.tmpl

## tmpl/feeds/feed_ping.tmpl
	'Source blog' => 'Bronblog',
	'By source blog' => 'Volgens bronblog',
	'By source title' => 'Volgens titel bron',
	'By source URL' => 'Volgens URL bron',

## tmpl/error.tmpl
	'Missing Configuration File' => 'Ontbrekend configuratiebestand',
	'_ERROR_CONFIG_FILE' => 'Uw Movable Type configuratiebestand ontbreekt of kan niet gelezen worden. Gelieve het deel <a href=\"#\">Installation and Configuration</a> van de handleiding van Movable Type te raadplegen voor meer informatie.',
	'Database Connection Error' => 'Databaseverbindingsfout',
	'_ERROR_DATABASE_CONNECTION' => 'Uw database instellingen zijn ofwel ongeldig ofwel ontbreken ze in uw Movable Type configuratiebestand. Bekijk het deel <a href=\"#\">Installation and Configuration</a> van de Movable Type handleiding voor meer informatie.',
	'CGI Path Configuration Required' => 'CGI-pad configuratie vereist',
	'_ERROR_CGI_PATH' => 'Uw CGIPath configuratieinstelling is ofwel ongeldig ofwel ontbreekt ze in uw Movable Type configuratiebestand. Bekijk het deel <a href=\"#\">Installation and Configuration</a> van de Movable Type handleiding voor meer informatie.',

## addons/Community.pack/lib/MT/App/Community.pm
	'No login form template defined' => 'Geen sjabloon gedefiniëerd voor het aanmeldformulier',
	'Before you can sign in, you must authenticate your email address. <a href="[_1]">Click here</a> to resend the verification email.' => 'Voor u kunt aanmelden, moet u eerst uw e-mail adres bevestigen. <a href="[_1]">Klik hier</a> om de verificatiemail opnieuw te versturen.',
	'Your confirmation have expired. Please register again.' => 'Uw bevestiging is verlopen.  Gelieve opnieuw te registeren.',
	'User \'[_1]\' (ID:[_2]) has been successfully registered.' => 'Gebruiker \'[_1]\' (ID:[_2]) werd met succes geregistreerd.',
	'Thanks for the confirmation.  Please sign in.' => 'Bedankt voor de bevestiging.  Gelieve u aan te melden.',
	'Login required' => 'Aanmelden vereist',
	'System template entry_response not found in blog: [_1]' => 'Systeemsjabloon entry_response niet gevonden voor blog: [_1]',
	'Posting a new entry failed.' => 'Publiceren van nieuw bericht mislukt',
	'New entry \'[_1]\' added to the blog \'[_2]\'' => 'Nieuw bericht \'[_1]\' toegevoegd aan de blog \'[_2]\'',
	'Id or Username is required' => 'ID of gebruikersnaam is verplicht',
	'Unknown user' => 'Onbekende gebruiker',
	'Cannot edit profile.' => 'Kan profiel niet bewerken.',
	'Recent Entries from [_1]' => 'Recente berichten van [_1]',
	'Responses to Comments from [_1]' => 'Antwoorden op reacties van [_1]',

## addons/Community.pack/lib/MT/Community/Tags.pm
	'You used an \'[_1]\' tag outside of the block of MTIfEntryRecommended; perhaps you mistakenly placed it outside of an \'MTIfEntryRecommended\' container?' => 'U gebruikte een \'[_1]\' tag buiten een MTIfEntryRecommended blok; misschien heeft u die daar per ongeluk geplaatst?',
	'Click here to recommend' => 'Klik hier om aan te raden',

## addons/Community.pack/lib/MT/Community/CMS.pm
	'Welcome to the Movable Type Community Solution' => 'Welkom op de Movable Type Community Solution',
	'The Community Solution gives you to the tools to build a successful community with active, engaged conversations. Some key features to explore:' => 'De Community Solution geeft u de middelen in handen om een succesvolle gemeenschap uit te bouwen met actieve, geëngageerde conversaties.  Hieronder staan de belangrijkste mogelijkheden opgesomd:',
	'Member Profiles' => 'Profielen voor leden',
	'Allow registered members of your community to create and customize profiles, including user pictures' => 'Geef geregistreerde leden van uw community de kans om profielen aan te maken en aan te passen, met o.a. hun foto',
	'Favoriting, Recommendations and User Voting' => 'Favorieten, aanbevelingen en peilingen bij gebruikers ',
	'Your community can vote for its favorite content, making it easy for your readers and authors to see what\'s most popular' => 'Uw community kan stemmen voor hun favoriete inhoud, waardoor het makkelijk wordt voor uw leden en auteurs om te zien wat er populair is',
	'User-Contributed Content' => 'Inhoud aangeleverd door gebruikers',
	'Registered users can submit content to your site, and administrators have full control over what gets published' => 'Geregistreerde leden kunnen inhoud insturen voor uw site en administratoren hebben de volledige controle over wat er wordt gepubliceerd',
	'Forums and Community Blogs' => 'Forums en gemeenschapsblogs',
	'Add forums and group blogs to your site with just a few clicks' => 'Voeg forums en groepsblogs toe aan uw site in een paar klikken',
	'Completely Customizable Design' => 'Volledig aanpasbaar design',
	'Every element of your site experience is customizable, including login screens, registration forms, profile editing, and even email messages' => 'Elk element van uw site is aanpasbaar, inclusief aanmeldschermen, registratieformulieren, de profielbewerkingspagina en zelfs e-mail boodschappen.',

## addons/Community.pack/php/function.mtentryrecommendvotelink.php

## addons/Community.pack/tmpl/widget/blog_stats_registration.mtml
	'Registrations' => 'Registraties',
	'Recent Registrations' => 'Recent geregistreerd',
	'default userpic' => 'standaardfoto gebruiker',
	'You have [quant,_1,registration,registrations] from [_2]' => 'U heeft [quant,_1,registratie,registraties] van [_2]', # Translate - New

## addons/Community.pack/tmpl/widget/most_popular_entries.mtml
	'Most Popular Entries' => 'Populairste berichten',
	'There are no popular entries.' => 'Er zijn geen populaire berichten.',

## addons/Community.pack/tmpl/widget/recent_submissions.mtml
	'Recent Submissions' => 'Recente inzendingen',

## addons/Community.pack/tmpl/widget/recent_favorites.mtml
	'Recent Favorites' => 'Recente favorieten',
	'There are no recently favorited entries.' => 'Er zijn geen recente favoriete berichten.',

## addons/Community.pack/tmpl/cfg_community_prefs.tmpl
	'Community Settings' => 'Community instellingen',
	'Anonymous Recommendation' => 'Anonieme aanbevelingen',
	'Check to allow anonymous users (users not logged in) to recommend discussion.  IP address is recorded and used to identify each user.' => 'Kruis dit vakje aan om anonieme gebruikers (gebruikers die niet zijn aangemeld) toe te laten discussies aan te raden.  Het IP adres van de gebruiker wordt gebruikt om gebruikers uit elkaar te houden.',
	'Allow anonymous user to recommend' => 'Anonieme gebruikers toelaten aanbevelingen te doen',
	'Save changes to blog (s)' => 'Wijzigingen aan blog opslaan (s)', # Translate - New

## addons/Community.pack/templates/global/register_form.mtml
	'Sign up' => 'Registreer',
	'Simple Header' => 'Eenvoudige hoofding',

## addons/Community.pack/templates/global/simple_footer.mtml

## addons/Community.pack/templates/global/profile_error.mtml
	'Profile Error' => 'Profielfout',
	'Status Message' => 'Statusboodschap',

## addons/Community.pack/templates/global/profile_feed_rss.mtml

## addons/Community.pack/templates/global/userpic.mtml

## addons/Community.pack/templates/global/new_entry_email.mtml
	'A new entry \'[_1]([_2])\' has been posted on your blog [_3].' => 'Een nieuw bericht  \'[_1]([_2])\' werd gepubliceerd op uw blog [_3].',
	'Author name: [_1]' => 'Auteursnaam: [_1]',
	'Author nickname: [_1]' => 'Bijnaam auteur: [_1]',
	'Title: [_1]' => 'Titel: [_1]',
	'Edit entry:' => 'Bewerk bericht:',

## addons/Community.pack/templates/global/password_reset_form.mtml
	'Reset Password' => 'Wachtwoord opnieuw instellen',
	'Back to the original page' => 'Terug naar de oorspronkelijke pagina',
	'Simple Footer' => 'Eenvoudige voettekst',

## addons/Community.pack/templates/global/profile_edit_form.mtml
	'Go <a href="[_1]">back to the previous page</a> or <a href="[_2]">view your profile</a>.' => 'Ga <a href="[_1]">terug naar de vorige pagina</a> of <a href="[_2]">bekijk uw profiel</a>.',
	'Form Field' => 'Veld in formulier',
	'User Name' => 'Naam gebruiker',
	'Upload New Userpic' => 'Nieuwe gebruikersafbeelding uploaden',

## addons/Community.pack/templates/global/header.mtml
	'Blog Description' => 'Blogbeschrijving',
	'GlobalJavaScript' => 'GlobaalJavaScript',
	'Navigation' => 'Navigatie',
	'User Navigation' => 'Gebruikersnavigatie',

## addons/Community.pack/templates/global/profile_view.mtml
	'User Profile' => 'Gebruikersprofiel',
	'Website:' => 'Website:',
	'Recent Comments' => 'Recente reacties',
	'Responses to Comments' => 'Antwoorden op reacties',
	'Favorites' => 'Favorieten',
	'No recent entries.' => 'Geen recente berichten',
	'Recents Comments from [_1]' => 'Recente reacties van [_1]',
	'(posted to [_1])' => '(gepubliceerd op [_1])',
	'No recent comments.' => 'Geen recente reacties.',
	'No responses to comments.' => 'Geen antwoorden op reacties.',
	'Favorites of [_1]' => 'Favorieten van [_1]',
	'[_1] has not added any favorites yet.' => '[_1] heeft nog geen favorieten toegevoegd.',

## addons/Community.pack/templates/global/login_form.mtml

## addons/Community.pack/templates/global/register_confirmation.mtml
	'Authentication Email Sent' => 'Authenticatiemail verzonden',
	'Profile Created' => 'Profiel aangemaakt',
	'<a href="[_1]">Return to the original page.</a>' => '<a href="[_1]">Terugkeren naar de oorspronkelijke pagina.</a>',

## addons/Community.pack/templates/global/user_navigation.mtml
	'Logged in as <a href="[_1]">[_2]</a>' => 'Aangemeld als <a href="[_1]">[_2]</a>',
	'Sign out' => 'Afmelden',
	'Not a member? <a href="[_1]">Register</a>' => 'Nog geen lid? <a href="[_1]">Registreer nu</a>',

## addons/Community.pack/templates/global/footer.mtml

## addons/Community.pack/templates/global/navigation.mtml
	'Home' => 'Hoofdpagina',

## addons/Community.pack/templates/global/login_form_module.mtml
	'Hello [_1]' => 'Hallo [_1]',
	'Forgot Password' => 'Wachtwoord vergeten',

## addons/Community.pack/templates/global/email_verification_email.mtml
	'Thank you registering for an account to [_1].' => 'Bedankt om een account te registreren op [_1]',
	'For your own security and to prevent fraud, we ask that you please confirm your account and email address before continuing. Once confirmed you will immediately be allowed to sign in to [_1].' => 'Voor uw eigen veiligheid en om fraude te voorkomen, vragen we om uw account en e-mail adres te bevestigen vooraleer verder te gaan.  Zodra u bevestigd heeft, kunt u onmiddellijk aanmelden bij [_1].',
	'If you did not make this request, or you don\'t want to register for an account to [_1], then no further action is required.' => 'Als u hier niet zelf om gevraagd heeft, of u wenst geen account te registreren op [_1], dan is er niets dat u verder hoeft te doen.',

## addons/Community.pack/templates/global/register_notification_email.mtml

## addons/Community.pack/templates/global/search.mtml

## addons/Community.pack/templates/blog/rss.mtml

## addons/Community.pack/templates/blog/archive_index.mtml
	'Content Navigation' => 'Navigatie inhoud',

## addons/Community.pack/templates/blog/trackbacks.mtml

## addons/Community.pack/templates/blog/main_index.mtml

## addons/Community.pack/templates/blog/page.mtml

## addons/Community.pack/templates/blog/content_nav.mtml
	'Blog Home' => 'Hoofdpagina blog',

## addons/Community.pack/templates/blog/entry_summary.mtml
	'A favorite' => 'Een favoriet',
	'Favorite' => 'Favoriet',

## addons/Community.pack/templates/blog/entry_response.mtml
	'Thank you for posting an entry.' => 'Bedankt om uw bericht in te sturen.',
	'Entry Pending' => 'Goed te keuren bericht',
	'Your entry has been received and held for approval by the blog owner.' => 'Uw bericht is ontvagen en wordt bewaard tot de blog-eigenaar het goedkeurt.',
	'Entry Posted' => 'Bericht gepubliceerd',
	'Your entry has been posted.' => 'Uw bericht is gepubliceerd.',
	'Your entry has been received.' => 'Uw bericht is ontvangen.',
	'Return to the <a href="[_1]">blog\'s main index</a>.' => 'Terugkeren naar de <a href="[_1]">hoofdpagina van de blog</a>.',

## addons/Community.pack/templates/blog/comment_response.mtml

## addons/Community.pack/templates/blog/entry_detail.mtml

## addons/Community.pack/templates/blog/entry_form.mtml
	'You don\'t have permission to post.' => 'U heeft geen permissie om een bericht te publiceren.',
	'<a href="[_1]">Sign in</a> to create an entry.' => '<a href="[_1]">Aanmelden</a> om een bericht aan te maken.',
	'Select Category...' => 'Selecteer categorie...',

## addons/Community.pack/templates/blog/entry_create.mtml
	'Entry Form' => 'Berichtenformulier',

## addons/Community.pack/templates/blog/comment_detail.mtml

## addons/Community.pack/templates/blog/comments.mtml

## addons/Community.pack/templates/blog/comment_form.mtml

## addons/Community.pack/templates/blog/categories.mtml

## addons/Community.pack/templates/blog/search_results.mtml

## addons/Community.pack/templates/blog/sidebar_2col.mtml
	'Subscribe icon' => 'Icoon om in te schrijven',
	'Subscribe' => 'Inschrijven',

## addons/Community.pack/templates/blog/sidebar_3col.mtml

## addons/Community.pack/templates/blog/entry_listing.mtml

## addons/Community.pack/templates/blog/dynamic_error.mtml

## addons/Community.pack/templates/blog/tags.mtml

## addons/Community.pack/templates/blog/entry_metadata.mtml

## addons/Community.pack/templates/blog/entry.mtml

## addons/Community.pack/templates/blog/comment_preview.mtml

## addons/Community.pack/templates/blog/javascript.mtml

## addons/Community.pack/templates/forum/main_index.mtml
	'Forum Home' => 'Forum hoofdpagina',
	'Content Header' => 'Hoofding inhoud',
	'Popular Entry' => 'Populair bericht',
	'Entry Table' => 'Berichttabel',

## addons/Community.pack/templates/forum/page.mtml

## addons/Community.pack/templates/forum/entry_summary.mtml

## addons/Community.pack/templates/forum/content_nav.mtml
	'Start Topic' => 'Onderwerp beginnen',

## addons/Community.pack/templates/forum/entry_response.mtml
	'Thank you for posting a new topic to the forums.' => 'Bedankt om een nieuw onderwerp te publiceren in de forums.',
	'Topic Pending' => 'Onderwerp wacht op goedkeuring',
	'The topic you posted has been received and held for approval by the forum administrators.' => 'Het onderwerp dat u instuurde werd ontvangen en wordt bewaard tot de administratoren van het forum goedkeuren.',
	'Topic Posted' => 'Onderwerp gepubliceerd',
	'The topic you posted has been received and published. Thank you for your submission.' => 'Het onderwerp dat u instuurde werd ontvangen en gepubliceerd.  Bedankt voor uw bijdrage.',
	'Return to the <a href="[_1]">forum\'s homepage</a>.' => 'Terugkeren naar de <a href="[_1]">hoofdpagina van het forum</a>.',

## addons/Community.pack/templates/forum/comment_response.mtml
	'Reply Submitted' => 'Antwoord ingediend',
	'Your reply has been accepted' => 'Uw antwoord is ontvangen',
	'Thank you for your reply. It has been accepted and should appear momentarily.' => 'Bedankt voor uw antwoord.  Het is ontvangen en zou zodadelijk moeten verschijnen.',
	'Reply Pending' => 'Antwoord wordt beoordeeld',
	'Your reply has been received' => 'Uw antwoord  werd ontvangen',
	'Thank you for your reply. However, your reply is currently being held for approval by the forum\'s administrator.' => 'Bedankt voor uw antwoord.  Het wordt momenteel bewaard tot een administrator van het forum het kan beoordelen.',
	'Reply Submission Error' => 'Fout bij indienen antwoord',
	'Your reply submission failed for the following reasons:' => 'Het indienen van uw antwoord mislukte wegens volgende redenen:',
	'Return to the <a href="[_1]">original topic</a>.' => 'Terugkeren naar <a href="[_1]">het oorspronkelijke onderwerp</a>.',

## addons/Community.pack/templates/forum/content_header.mtml

## addons/Community.pack/templates/forum/entry_detail.mtml

## addons/Community.pack/templates/forum/entry_form.mtml
	'<a href="[_1]">Sign in</a> to create a topic.' => '<a href="[_1]">Aanmelden</a> om een onderwerp te starten.',
	'Topic' => 'Onderwerp',
	'Select Forum...' => 'Selecteer forum...',
	'Forum' => 'Forum',

## addons/Community.pack/templates/forum/comment_detail.mtml

## addons/Community.pack/templates/forum/entry_create.mtml
	'Start a Topic' => 'Begin een onderwerp',

## addons/Community.pack/templates/forum/comment_form.mtml

## addons/Community.pack/templates/forum/entry_listing.mtml

## addons/Community.pack/templates/forum/entry_metadata.mtml
	'Replies ([_1])' => 'Antwoorden ([_1])',

## addons/Community.pack/templates/forum/entry.mtml

## addons/Community.pack/templates/forum/javascript.mtml
	'. Now you can reply to this topic.' => '. Nu kunt u antwoorden op dit onderwerp.',
	' to comment on this topic.' => ' om te reageren op dit onderwerp.',
	' to comment on this topic,' => ' om te reageren op dit onderwerp,',

## addons/Community.pack/templates/forum/rss.mtml

## addons/Community.pack/templates/forum/entry_table.mtml
	'Recent Topics' => 'Recente onderwerpen',
	'Replies' => 'Antwoorden',
	'Last Reply' => 'Laatste antwoord',
	'Permalink to this Reply' => 'Permanente link naar dit antwoord',
	'By [_1]' => 'Door [_1]',
	'Closed' => 'Gesloten',
	'Post the first topic in this forum.' => 'Plaats het eerste onderwerp in dit forum',

## addons/Community.pack/templates/forum/archive_index.mtml

## addons/Community.pack/templates/forum/sidebar.mtml
	'Category Groups' => 'Categoriegroepen',
	'All Forums' => 'Alle forums',
	'[_1] Forum' => '[_] forum', # Translate - New

## addons/Community.pack/templates/forum/category_groups.mtml
	'Forum Groups' => 'Forum groepen',
	'Last Topic: [_1] by [_2] on [_3]' => 'Laatste onderwerp: [_1] door [_2] op [_3]',

## addons/Community.pack/templates/forum/comments.mtml
	'[_1] Replies' => '[_1] antwoorden',
	'_NUM_FAVORITES' => 'Favoriet',
	'Favorite This' => 'Maak favoriet!',

## addons/Community.pack/templates/forum/search_results.mtml

## addons/Community.pack/templates/forum/dynamic_error.mtml

## addons/Community.pack/templates/forum/entry_popular.mtml
	'Popular topics' => 'Populaire onderwerpen',
	'No Reply' => 'Geen antwoord',

## addons/Community.pack/templates/forum/comment_preview.mtml
	'Reply on [_1]' => 'Antwoord op [_1]',
	'Previewing your Reply' => 'Voorbeeld van antwoord aan het bekijken',

## addons/Community.pack/config.yaml
	'Login Form' => 'Aanmeldformulier',
	'Password Reset Form' => 'Recuperatieformulier wachtwoorden',
	'Registration Form' => 'Registratieformulier',
	'Registration Confirmation' => 'Registratiebevestiging',
	'Profile View' => 'Profiel bekijken',
	'Profile Edit Form' => 'Bewerkingsformulier profiel',
	'Profile Feed (Atom)' => 'Profielfeed (Atom)',
	'Profile Feed (RSS)' => 'Profielfeed (RSS)',
	'Email verification' => 'E-mail verificatie',
	'Registration notification' => 'Registratienotificatie',
	'New entry notification' => 'Notificatie nieuw bericht',
	'Community Blog' => 'Community-blog',
	'Entry Response' => 'Antwoord op bericht',
	'Displays error, pending or confirmation message when submitting an entry.' => 'Toont foutboodschappen, \'even geduld\' berichten of bevestigingen bij het indienen van een bericht.',
	'Community Forum' => 'Community forum',
	'Entry Feed (Atom)' => 'Berichtfeed (Atom)',
	'Entry Feed (RSS)' => 'Berichtfeed (RSS)',
	'Displays error, pending or confirmation message when submitting a entry.' => 'Toont foutboodschappen, \'even geduld\' berichten of bevestigingen bij het indienen van een bericht.',

## addons/Commercial.pack/lib/CustomFields/App/CMS.pm
	'Show' => 'Toon',
	'Date & Time' => 'Datum en tijd',
	'Date Only' => 'Enkel datum',
	'Time Only' => 'Enkel tijd',
	'Please enter all allowable options for this field as a comma delimited list' => 'Gelieve alle toegestane waarden voor dit veld in te vullen als een lijst gescheiden door komma\'s',
	'Custom Fields' => 'Extra velden',
	'[_1] Fields' => 'Velden bij [_1]',
	'Edit Field' => 'Veld bewerken',
	'Invalid date \'[_1]\'; dates must be in the format YYYY-MM-DD HH:MM:SS.' => 'Ongeldige datum \'[_1]\'; datums moeten in het formaat YYYY-MM-DD HH:MM:SS staan.',
	'Invalid date \'[_1]\'; dates should be real dates.' => 'Ongeldige datum \'[_1]\'; datums moeten echte datums zijn.',
	'Please enter valid URL for the URL field: [_1]' => 'Gelieve een geldige URL in te vullen in het URL veld: [_1]', # Translate - New
	'Please enter some value for required \'[_1]\' field.' => 'Gelieve een waarde in te vullen voor het verplichte \'[_1]\' veld.',
	'Please ensure all required fields have been filled in.' => 'Kijk na of alle verplichte velden ingevuld zijn.',
	'The template tag \'[_1]\' is an invalid tag name.' => 'Sjabloontag \'[_1]\' is een ongeldige tagnaam.', # Translate - New
	'The template tag \'[_1]\' is already in use.' => 'De sjabloontag \'[_1]\' is al in gebruik.',
	'The basename \'[_1]\' is already in use.' => 'De basisnaam \'[_1]\' is al in gebruik',
	'Default value must be valid URL.' => 'Standaardwaarde moet een geldige URL zijn.', # Translate - New
	'Customize the forms and fields for entries, pages, folders, categories, and users, storing exactly the information you need.' => 'Pas de formulieren en velden aan voor berichten, pagina\'s, mappen, categoriën en gebruikers aan en sla exact die informatie op die u nodig heeft.', # Translate - New
	' ' => '', # Translate - New
	'Single-Line Text' => 'Een regel tekst',
	'Multi-Line Textfield' => 'Meerdere regels tekst',
	'Checkbox' => 'Checkbox',
	'Date and Time' => 'Datum en tijd',
	'Drop Down Menu' => 'Uitklapmenu',
	'Radio Buttons' => 'Radiobuttons',

## addons/Commercial.pack/lib/CustomFields/Template/ContextHandlers.pm
	'Are you sure you have used a \'[_1]\' tag in the correct context? We could not find the [_2]' => 'Bent u zeker dat u een \'[_1]\' tag gebruikte in de juiste context?  We vonden geen [_2]',
	'You used an \'[_1]\' tag outside of the context of the correct content; ' => 'U gebruikte een \'[_1]\' tag buiten de correcte context;',

## addons/Commercial.pack/lib/CustomFields/Upgrade.pm
	'Moving metadata storage for pages...' => 'Metadata opslag voor pagina\'s word verplaatst...', # Translate - New

## addons/Commercial.pack/lib/CustomFields/BackupRestore.pm
	'Restoring custom fields data stored in MT::PluginData...' => 'Custom Fields data opgeslagen in MT::PluginData aan het terugzetten...', # Translate - New
	'Restoring asset associations found in custom fields ( [_1] ) ...' => 'Mediabestand-associaties aan het terugzetten die werden gevonden in gepersonaliseerde velden ( [_1] ) ...', # Translate - New
	'Restoring url of the assets associated in custom fields ( [_1] )...' => 'URL van de mediabestand aan het terugzetten geassocieerd via gepersonaliseerde velden ( [_1] )', # Translate - New

## addons/Commercial.pack/lib/CustomFields/Util.pm
	'Failed to find [_1]::[_2]' => 'Kon [_1]::[_2] niet vinden',

## addons/Commercial.pack/lib/CustomFields/Field.pm
	'Field' => 'Veld',

## addons/Commercial.pack/tmpl/date-picker.tmpl
	'Select date' => 'Selecteer datum',

## addons/Commercial.pack/tmpl/edit_field.tmpl
	'New Field' => 'Nieuw weld',
	'The selected fields(s) has been deleted from the database.' => 'Geselecteerd(e) veld(en) verwijderd uit de database.',
	'Please ensure all required fields (highlighted) have been filled in.' => 'Gelieve te controleren dat alle verplichte velden (gekleurd) ingevuld zijn.',
	'System Object' => 'Systeemobject',
	'Select the system object this field is for' => 'Selecteer het systeemobject waar dit veld voor dient',
	'Select...' => 'Selecteer...',
	'Required?' => 'Verplicht?',
	'Should a value be chosen or entered into this field?' => 'Moet er een waarde gekozen of ingevuld worden in dit veld?',
	'Default' => 'Standaard',
	'You will need to first save this field in order to set a default value' => 'U moet dit veld eerst opslaan om een standaardwaarde te kunnen instellen',
	'_CF_BASENAME' => 'Basename',
	'The basename is used for entering custom field data through a 3rd party client. It must be unique.' => 'De basisnaam wordt gebruikt om gepersonaliseerde veld informatie in te voeren via een cliënt van derden.  Hij moet uniek zijn.', # Translate - New
	'Unlock this for editing' => 'Maak dit aanpasbaar',
	'Warning: Changing this field\'s basename may cause serious data loss.' => 'Waarschuwing: de basinaam van dit veld aanpassen kan leiden tot ernstig gegevensverlies.',
	'Template Tag' => 'Sjabloontag',
	'Create a custom template tag for this field.' => 'Maak een gepersonaliseerde sjabloontag aan voor dit veld',
	'Example Template Code' => 'Voorbeeldsjablooncode',
	'Save this field (s)' => 'Dit veld opslaan (s)', # Translate - New
	'field' => 'veld',
	'fields' => 'velden',
	'Delete this field (x)' => 'Dit veld verwijderen (x)', # Translate - New

## addons/Commercial.pack/tmpl/reorder_fields.tmpl
	'Your field order has been saved. Please refresh this page to see the new order.' => 'De volgorde van uw velden is opgeslagen.  Vernieuw deze pagina om de nieuwe volgorde te zien.',
	'Reorder Fields' => 'Velden rangschikken',
	'Save field order' => 'Volgorde opslaan',
	'Close field order widget' => 'Widged volgorde velden sluiten',
	'open' => 'open', # Translate - New
	'click-down and drag to move this field' => 'klik en sleep om dit veld te verplaatsen', # Translate - New
	'click to %toggle% this box' => 'klik om dit vakje te %schakelen%', # Translate - New
	'use the arrow keys to move this box' => 'gebruik de pijltjestoetsen om dit vakje te verplaatsen', # Translate - New
	', or press the enter key to %toggle% it' => ', of druk op de enter-toets om het te %schakelen%', # Translate - New

## addons/Commercial.pack/tmpl/list_field.tmpl
	'New [_1] Field' => 'Nieuw [_1] veld',
	'Delete selected fields (x)' => 'Geselecteerde velden verwijderen (x)',
	'No fields could be found.' => 'Er werden geen velden gevonden.',
	'System-Wide' => 'Over heel het systeem',

## addons/Commercial.pack/tmpl/asset-chooser.tmpl
	'Choose [_1]' => 'Kies [_1]',
	'Remove [_1]' => 'Verwijder [_1]',

## addons/Commercial.pack/config.yaml

## addons/Enterprise.pack/lib/MT/Enterprise/Upgrade.pm
	'Fixing binary data for Microsoft SQL Server storage...' => 'Binaire data aan het fixen voor opslag in Microsoft SQL Server...',

## addons/Enterprise.pack/lib/MT/Enterprise/Wizard.pm
	'PLAIN' => 'PLAIN',
	'CRAM-MD5' => 'CRAM-MD5',
	'Digest-MD5' => 'Digest-MD5',
	'Login' => 'Login',
	'Found' => 'Gevonden',
	'Not Found' => 'Niet gevonden',

## addons/Enterprise.pack/lib/MT/Enterprise/BulkCreation.pm
	'Format error at line [_1]: [_2]' => 'Formaatfout op regel [_1]: ´[_2]',
	'Invalid command: [_1]' => 'Ongeldig commando: [_1]',
	'Invalid number of columns for [_1]' => 'Ongeldig aantal kolommen voor [_1]',
	'Invalid user name: [_1]' => 'Ongeldige gebruikersnaam: [_1]',
	'Invalid display name: [_1]' => 'Ongeldige getoonde naam: [_1]',
	'Invalid email address: [_1]' => 'Ongeldig e-mail adres: [_1]',
	'Invalid language: [_1]' => 'Ongeldige taal: [_1]',
	'Invalid password: [_1]' => 'Ongeldig wachtwoord: [_1]',
	'Invalid password recovery phrase: [_1]' => 'Ongeldig woord of uitdrukking om wachtwoord terug te vinden: [_1]',
	'Invalid weblog name: [_1]' => 'Ongeldige weblognaam: [_1]',
	'Invalid weblog description: [_1]' => 'Ongeldige weblogbeschrijving: [_1]',
	'Invalid site url: [_1]' => 'Ongeldige site URL: [_1]',
	'Invalid site root: [_1]' => 'Ongeldige siteroot: [_1]',
	'Invalid timezone: [_1]' => 'Ongeldige tijdzone: [_1]',
	'Invalid new user name: [_1]' => 'Ongeldige gebruikersnaam: [_1]',
	'A user with the same name was found.  Register was not processed: [_1]' => 'Een gebruiker met dezelfde naam werd al gevonden.  Registratie niet verwerkt: [_1]',
	'Blog for user \'[_1]\' can not be created.' => 'Blog voor gebruiker \'[_1]\' kon niet worden aangemaakt.',
	'Blog \'[_1]\' for user \'[_2]\' has been created.' => 'Blog \'[_1]\' voor gebruiker \'[_2]\' werd aangemaakt.',
	'Error assigning weblog administration rights to user \'[_1] (ID: [_2])\' for weblog \'[_3] (ID: [_4])\'. No suitable weblog administrator role was found.' => 'Fout bij toekennen ven weblog administratierechten aan gebruiker \'[_1] (ID: [_2])\' voor weblog \'[_3] (ID: [_4])\'.  Er werd geen geschikte administrator rol gevonden in het systeem.',
	'Permission granted to user \'[_1]\'' => 'Permissie toegekend aan gebruiker \{[_1]\'',
	'User \'[_1]\' already exists. Update was not processed: [_2]' => 'Gebruiker \'[_1]\' bestaat al.  Update niet uitgevoerd: [_2]',
	'User cannot be updated: [_1].' => 'Gebruiker kan niet worden bijgewerkt: [_1].',
	'User \'[_1]\' not found.  Update was not processed.' => 'Gebruiker \'[_1]\' niet gevonden.  Update niet uitgevoerd.',
	'User \'[_1]\' has been updated.' => 'Gebruiker \'[_1]\' is bijgewerkt.',
	'User \'[_1]\' was found, but delete was not processed' => 'Gebruiker \'[_1]\' werd gevonden, maar niet verwijderd.',
	'User \'[_1]\' not found.  Delete was not processed.' => 'Gebruiker \'[_1]\' werd gevonden.  Verwijdering werd niet uitgevoerd.',
	'User \'[_1]\' has been deleted.' => 'Gebruiker \'[_1]\' werd verwijderd.',

## addons/Enterprise.pack/lib/MT/Enterprise/CMS.pm
	'Add [_1] to a blog' => 'Voeg [_1] toe aan een blog',
	'You can not create associations for disabled groups.' => 'U kunt geen associaties aanmaken voor uitgeschakelde groepen',
	'Assign Role to Group' => 'Ken rol toe aan groep',
	'Add a group to this blog' => 'Voeg een groep toe aan deze blog',
	'Grant permission to a group' => 'Ken permissie to aan groep',
	'Movable Type Enterprise has just attempted to disable your account during synchronization with the external directory. Some of the external user management settings must be wrong. Please correct your configuration before proceeding.' => 'Movable Type Enterprise probeerde net uw account uit te schakelen tijdens synchronisatie met de externe directory.  Er moet een fout zitten in de instellingen voor extern gebruikersbeheer.  Gelieve uw configuratie bij te stellen voor u verder gaat.',
	'Group requires name' => 'Groep vereist naam',
	'Invalid group' => 'Ongeldige groep',
	'Add Users to Group [_1]' => 'Voeg gebruikers toe aan groep [_1]',
	'Users & Groups' => 'Gebruikers & Groepen',
	'Group Members' => 'Groepsleden',
	'Groups' => 'Groepen',
	'User Groups' => 'Groepen van gebruiker',
	'Group load failed: [_1]' => 'Laden groep mislukt: [_1]',
	'User load failed: [_1]' => 'Laden gebruiker mislukt: [_1]',
	'User \'[_1]\' (ID:[_2]) removed from group \'[_3]\' (ID:[_4]) by \'[_5]\'' => 'Gebruiker \'[_1]\' (ID:[_2]) verwijderd uit groep \'[_3]\' (ID:[_4]) door \'[_5]\'',
	'User \'[_1]\' (ID:[_2]) was added to group \'[_3]\' (ID:[_4]) by \'[_5]\'' => 'Gebruiker \'[_1]\' (ID:[_2]) toegevoegd aan groep \'[_3]\' (ID:[_4]) door \'[_5]\'',
	'Group Profile' => 'Groepsprofiel',
	'Author load failed: [_1]' => 'Laden auteur mislukt: [_1]',
	'Invalid user' => 'Ongeldige gebruiker',
	'Assign User [_1] to Groups' => 'Gebruiker [_1] toewijzen aan groepen',
	'Select Groups' => 'Selecteer groepen',
	'Group' => 'Groep',
	'Groups Selected' => 'Geselecteerde groepen',
	'Type a group name to filter the choices below.' => 'Tik een groepsnaam in om de onderstaande keuzes te filteren',
	'Group Name' => 'Groepsnaam',
	'Search Groups' => 'Groepen zoeken',
	'Bulk import cannot be used under external user management.' => 'Bulk import kan niet worden gebruikt onder extern gebruikersbeheer.',
	'Bulk management' => 'Bulkbeheer',
	'The group' => 'De groep',
	'User/Group' => 'Gebruiker/groep',
	'A user can\'t change his/her own username in this environment.' => 'Een gebruiker kan zijn/haar gebruikersnaam niet aanpassen in deze omgeving',
	'An error occurred when enabling this user.' => 'Er deed zich een fout voor bij het activeren van deze gebruiker.',

## addons/Enterprise.pack/lib/MT/Auth/LDAP.pm
	'User [_1]([_2]) not found.' => 'Gebruker [_1]([_2]) niet gevonden.',
	'User \'[_1]\' cannot be updated.' => 'Gebruiker \'[_1]\' kan niet worden bijgewerkt.',
	'User \'[_1]\' updated with LDAP login ID.' => 'Gebruiker \'[_1]\' bijgewerkt met LDAP login ID.',
	'LDAP user [_1] not found.' => 'LDAP gebruiker [_1] niet gevonden.',
	'User [_1] cannot be updated.' => 'Gebruiker [_1] kan niet worden bijgewerkt.',
	'Failed login attempt by user \'[_1]\' deleted from LDAP.' => 'Mislukte aanmeldpoging van gebruiker \'[_1]\' verwijderd uit de LDAP.',
	'User \'[_1]\' updated with LDAP login name \'[_2]\'.' => 'Gebruiker \'[_1]\' bijgewerkt met LDAP loginnaam \'[_2]\'.',
	"Failed login attempt by user \'[_1]\'. A user with that\nusername already exists in the system with a different UUID." => "Mislukte aanmeldpoging door gebruiker \'[_1]\'. Er bestaat al een gebruiker met die gebruikersnaam in het systeem met een andere UUID",
	'User \'[_1]\' account is disabled.' => 'Account van gebruiker \'[_1]\' is niet actief.',
	'LDAP users synchronization interrupted.' => 'LDAP gebruikerssynchronisatie onderbroken',
	'Loading MT::LDAP failed: [_1]' => 'Laden van MT::LDAP mislukt: [_1]',
	'External user synchronization failed.' => 'Externe gebruikerssynchronisatie mislukt.',
	'An attempt to disable all system administrators in the system was made.  Synchronization of users was interrupted.' => 'Een poging om alle systeembeheerders in het systeem uit te schakelen werd ondernomen.  Synchronisatie van gebruikers werd onderbroken.',
	'The following users\' information were modified:' => 'Gebruikersinformaie van deze gebruikers werd aangepast:',
	'The following users were disabled:' => 'Deze gebruikers werden gedesactiveerd:',
	'LDAP users synchronized.' => 'LDAP gebruikers gesynchroniseerd',
	'Synchronization of groups can not be performed without LDAPGroupIdAttribute and/or LDAPGroupNameAttribute is set.' => 'Synchronisatie van groepen kan niet worden uitgevoerd zonder dat LDAPGroupIdAttribute en/of LDAPGroupNameAttribute ingesteld is.',
	'LDAP groups synchronized with existing groups.' => 'LDAP groepen zijn gesynchroniseerd met bestaande groepen.',
	'The following groups\' information were modified:' => 'De informatie van volgende groepen werd gewijzigd.',
	'No LDAP group was found using given filter.' => 'Er werd geen LDAP groep gevonden met de opgegeven filter.',
	"Filter used to search for groups: [_1]\nSearch base: [_2]" => "Filter gebruikt om naar groepen te zoeken: [_1]
Zoekbasis: [_2]",
	'(none)' => '(Geen)',
	'The following groups were deleted:' => 'Volgende groepen werden verwijderd:',
	'Failed to create a new group: [_1]' => 'Nieuwe groep aanmaken mislukt: [_1]',
	'[_1] directive must be set to synchronize members of LDAP groups to Movable Type Enterprise.' => '´[_1] directief moet ingesteld zijn om leden van een LDAP groep te synchroniseren naar Movable Type Enterprise',
	'Members removed: ' => 'Leden verwijderd:',
	'Members added: ' => 'Leden toegevoegd:',
	'Memberships of the group \'[_2]\' (#[_3]) has been changed in synchronizing with external directory.' => 'Lidmaatschappen van de groep \'[_2]\' (#[_3] zijn gewijzigd tijdens het synchroniseren met de externe directory.',
	'LDAPUserGroupMemberAttribute must be set to enable synchronize members of groups.' => 'LDAPUserGroupMemberAttribuut moet ingesteld zijn om synchronisatie tussen de leden van groepen toe te staan.',

## addons/Enterprise.pack/lib/MT/ObjectDriver/Driver/DBD/MSSQLServer.pm
	'PublishCharset [_1] is not supported in this version of MS SQL Server Driver.' => 'PublishCharset [_1] wordt niet ondersteund in deze versie van de MS SQL Server driver.',

## addons/Enterprise.pack/lib/MT/ObjectDriver/Driver/DBD/UMSSQLServer.pm
	'This version of UMSSQLServer driver requires DBD::ODBC version 1.14.' => 'Deze versie van de UMSSQLServer driver vereist DBD::ODBC versie 1.14.',
	'This version of UMSSQLServer driver requires DBD::ODBC compiled with Unicode support.' => 'Deze verie van de UMSSQLServer driver vereist DBD::ODBC gecompileerd met Unicode ondersteuning.',

## addons/Enterprise.pack/lib/MT/Group.pm

## addons/Enterprise.pack/lib/MT/LDAP.pm
	'Invalid LDAPAuthURL scheme: [_1].' => 'Ongeldig LDAPAuthURL schema: [_1].',
	'Error connecting to LDAP server [_1]: [_2]' => 'Probleem bij connecteren naar LDAP server [_1]: [_2]',
	'User not found on LDAP: [_1]' => 'Gebruiker niet gevonden op LDAP: [_1]',
	'Binding to LDAP server failed: [_1]' => 'Binden aan LDAP server mislukt: [_1]',
	'More than one user with the same name found on LDAP: [_1]' => 'Meer dan één gebruiker gevonden met dezelfde naam op LDAP: [_1]',

## addons/Enterprise.pack/tmpl/dialog/select_groups.tmpl
	'You need to create some groups.' => 'U moet een paar groepen aanmaken.',
	'Before you can do this, you need to create some groups. <a href="javascript:void(0);" onclick="closeDialog(\'[_1]\');">Click here</a> to create a group.' => 'Voor u dit kunt doen, moet u eerst een paar groepen aanmaken. <a href="javascript:void(0);" onclick="closeDialog(\'[_1]\');">Klik hier</a> om een groep aan te maken.',

## addons/Enterprise.pack/tmpl/include/list_associations/page_title.group.tmpl
	'Users &amp; Groups for [_1]' => 'Gebruikers &amp; groepen voor [_1]',
	'Group Associations for [_1]' => 'Groepsassociaties voor [_1]',

## addons/Enterprise.pack/tmpl/include/users_content_nav.tmpl

## addons/Enterprise.pack/tmpl/include/group_table.tmpl
	'group' => 'groep',
	'groups' => 'groepen',
	'Enable selected group (e)' => 'Geselecteerde groep activeren (e)', # Translate - New
	'Disable selected group (d)' => 'Geselecteerde groep deactiveren (d)', # Translate - New
	'Remove selected group (d)' => 'Geselecteerde groep verwijderen (d)', # Translate - New
	'Only show enabled groups' => 'Enkel actieve groepen tonen',
	'Only show disabled groups' => 'Enkel niet-actieve groepen tonen',

## addons/Enterprise.pack/tmpl/list_group.tmpl
	'[_1]: User&rsquo;s Groups' => '[_1] groepen van gebruiker',
	'Groups: System Wide' => 'Groepen: over heel het systeem',
	'Synchronize groups now' => 'Groepen nu synchroniseren',
	'You have successfully disabled the selected group(s).' => 'De geselecteerde groep(en) werden met suuces uitgeschakeld.',
	'You have successfully enabled the selected group(s).' => 'De geselecteerde groep(en) werden met suuces ingeschakeld.',
	'You have successfully deleted the groups from the Movable Type system.' => 'De geselecteerde groep werd verwijderd uit het Movable Type systeem.',
	'You have successfully synchronized groups\' information with the external directory.' => 'U heeft met succes groepsinformatie gesynchroniseerd met de externe directory.',
	'The user <em>[_1]</em> is currently disabled.' => 'De gebruiker <em>[_1]</em> is momenteel niet actief.',
	'You can not add disabled users to groups.' => 'U kunt geen uitgeschakelde gebruikers toevoegen aan een groep.',
	'Add [_1] to another group' => 'Voeg [_1] toe aan een andere groep',
	'Create Group' => 'Groep aanmaken',
	'You did not select any [_1] to remove.' => 'U selecteerde geen [_] om te verwijderen.',
	'Are you sure you want to remove this [_1]?' => 'Bent u zeker dat u deze [_1] wenst te verwijderen?',
	'Are you sure you want to remove the [_1] selected [_2]?' => 'Bent u zeker dat u de [_1] geselecteerde [_2] wenst te verwijderen?',
	'to remove' => 'te verwijderen',

## addons/Enterprise.pack/tmpl/create_author_bulk_end.tmpl
	'All users updated successfully!' => 'Alle gebruikers met succes bijgewerkt',
	'An error occurred during the updating process. Please check your CSV file.' => 'Er deed zich een probleem voor tijdens het updateproces.  Controleer uw CSV bestand.',

## addons/Enterprise.pack/tmpl/list_group_member.tmpl
	'[_1]: Group Members' => '[_1]: Groepsleden',
	'<em>[_1]</em>: Group Members' => '<em>[_1]</em>: Groepsleden',
	'You have successfully deleted the users.' => 'De geselecteerde gebruikers werden verwijderd',
	'You have successfully added new users to this group.' => 'U heeft met succes nieuwe gebruikers toegevoegd aan deze groep.',
	'You have successfully synchronized users\' information with external directory.' => 'U heeft met succes de gebruikersinformatie gesynchroniseerd met een externe directory.',
	'Some ([_1]) of the selected users could not be re-enabled because they were no longer found in LDAP.' => 'Enkele ([_1]) van de geselecteerde gebruikers konden niet opnieuw worden ingeschakeld omdat ze niet meer werden gevonden in de LDAP.',
	'You have successfully removed the users from this group.' => 'U heeft met succes de gebruikers verwijderd uit deze groep.',
	'Group Disabled' => 'Groep uitgeschakeld',
	'You can not add users to a disabled group.' => 'U kunt geen leden toevoegen aan een uitgeschakelde groep.',
	'Add user to [_1]' => 'Gebruiker toevoegen aan [_1]',
	'member' => 'lid',
	'Show Enabled Members' => 'Actieve gebruikers tonen',
	'Show Disabled Members' => 'Niet-actieve gebruikers tonen',
	'Show All Members' => 'Alle leden tonen',
	'None.' => 'Geen.',
	'(Showing all users.)' => '(Alle gebruikers worden getoond.)',
	'Showing only users whose [_1] is [_2].' => 'Enkel gebruikers waarvan de [_1] [_2] is.',
	'all' => 'alle',
	'only' => 'enkel',
	'users where' => 'gebruikers waarvan de',
	'No members in group' => 'Geen leden in de groep',
	'Only show enabled users' => 'Enkel actieve gebruikers tonen',
	'Only show disabled users' => 'Enkel niet-actieve gebruikers tonen',
	'Are you sure you want to remove this [_1] from this group?' => 'Bent u zeker dat u deze [_1] wenst te verwijderen uit deze groep?',
	'Are you sure you want to remove the [_1] selected [_2] from this group?' => 'Bent u zeker dat u de [_1] geselecteerde [_2] wenst te verwijderen uit deze groep?',

## addons/Enterprise.pack/tmpl/author_bulk.tmpl
	'Manage Users in bulk' => 'Gebruikers beheren in bulk',
	'_USAGE_AUTHORS_2' => 'U kunt gebruikers aanmaken, bewerken en verwijderen in bulk door een CSV-geformatteerd bestand te uploaden dat de juiste instructies en relevante gegevens bevat.',
	'Upload source file' => 'Bronbestand uploaden',
	'Specify the CSV-formatted source file for upload' => 'Geef het CSV-geformatteerde bronbestand op dat moet worden geupload',
	'Source File Encoding' => 'Encodering bronbestand',
	'Upload (u)' => 'Uploaden (u)',

## addons/Enterprise.pack/tmpl/cfg_ldap.tmpl
	'Authentication Configuration' => 'Authenticatieconfiguratie',
	'You must set your Authentication URL.' => 'U moet uw AuthenticatieURL instellen.',
	'You must set your Group search base.' => 'U moet uw Group search base instellen.',
	'You must set your UserID attribute.' => 'U moet uw UserID attribuut instellen.',
	'You must set your email attribute.' => 'U moet uw email attribuut instellen.',
	'You must set your user fullname attribute.' => 'U moet uw user fullname attribuut instellen.',
	'You must set your user member attribute.' => 'U moet uw user member attribuut instellen.',
	'You must set your GroupID attribute.' => 'U moet uw GroupID attribuut instellen.',
	'You must set your group name attribute.' => 'U moet uw group name attribuut instellen.',
	'You must set your group fullname attribute.' => 'U moet uw fullname attribuut instellen.',
	'You must set your group member attribute.' => 'U moet uw group member attribuut instellen.',
	'You can configure your LDAP settings from here if you would like to use LDAP-based authentication.' => 'U kunt uw LDAP instellingen van hieruit configureren als uw LDAP-gebaseerde authenticatie wenst te gebruiken.',
	'Your configuration was successful.' => 'Configuratie is geslaagd.',
	'Click \'Continue\' below to configure the External User Management settings.' => 'Klik hieronder op \'Doorgaan\' om de instellingen voor extern gebruikersbeheer te configureren.',
	'Click \'Continue\' below to configure your LDAP attribute mappings.' => 'Klik hieronder op \'Doorgaan\' om uw LDAP attribute mappings in te stellen.',
	'Your LDAP configuration is complete.' => 'Uw LDAP configuratie is voltooid.',
	'To finish with the configuration wizard, press \'Continue\' below.' => 'Om naar het einde van de configuratiewizard te gaan, klik hieronder op \'Doorgaan\'.',
	'An error occurred while attempting to connect to the LDAP server: ' => 'Er deed zich een fout voor bij het verbinden met de LDAP server: ',
	'Use LDAP' => 'LDAP gebruiken',
	'Authentication URL' => 'Authenticatie URL',
	'The URL to access for LDAP authentication.' => 'De URL te gebruiken om toegang te krijgen tot LDAP authenticatie',
	'Authentication DN' => 'Authenticatie DN',
	'An optional DN used to bind to the LDAP directory when searching for a user.' => 'Een optionele DN die wordt gebruikt om aan de LDAP directory te binden wanneer er naar een gebruiker wordt gezocht.',
	'Authentication password' => 'Authenticatiewachtwoord',
	'Used for setting the password of the LDAP DN.' => 'Gebruikt om het wachtwoord in te stellen van de LDAP DN',
	'SASL Mechanism' => 'SASL mechanisme',
	'The name of SASL Mechanism to use for both binding and authentication.' => 'De naam van het SASL mechanisme dat gebruikt moet worden bij het binden en de authenticatie.',
	'Test Username' => 'Test gebruikersnaam',
	'Test Password' => 'Test wachtwoord',
	'Enable External User Management' => 'Extern gebruikersbeheer inschakelen',
	'Synchronization Frequency' => 'Synchronisatiefrequentie',
	'Frequency of synchronization in minutes. (Default is 60 minutes)' => 'Synchronisatiefrequentie in minuten. (Standaard is 60 minuten)',
	'15 Minutes' => '15 minuten',
	'30 Minutes' => '30 minuten',
	'60 Minutes' => '60 minuten',
	'90 Minutes' => '90 minuten',
	'Group search base attribute' => 'Group search basisattribuut',
	'Group filter attribute' => 'Group filter attribuut',
	'Search Results (max 10 entries)' => 'Zoekresultaten (max. 10 items)',
	'CN' => 'CN',
	'No groups were found with these settings.' => 'Er werden geen groepen gevonden met deze instellingen',
	'Attribute mapping' => 'Attribuutmapping',
	'LDAP Server' => 'LDAP server',
	'Other' => 'Andere',
	'User ID attribute' => 'User ID attribuut',
	'Email Attribute' => 'Email attribuut',
	'User fullname attribute' => 'User fullname attribuut',
	'User member attribute' => 'User member attribuut',
	'GroupID attribute' => 'GroupID attribuut',
	'Group name attribute' => 'Group name attribuut',
	'Group fullname attribute' => 'Group fullname attribuut',
	'Group member attribute' => 'Group member attribuut',
	'Search result (max 10 entries)' => 'Zoekresultaat (max. 10 items)',
	'Group Fullname' => 'Volledige naam groep',
	'Group Member' => 'Groepslid',
	'No groups could be found.' => 'Er werden geen groepen gevonden',
	'User Fullname' => 'Volledige naam gebruiker',
	'No users could be found.' => 'Er werden geen gebruikers gevonden',
	'Test connection to LDAP' => 'Verbinding met LDAP testen',
	'Test search' => 'Zoektest',

## addons/Enterprise.pack/tmpl/create_author_bulk_start.tmpl
	'Bulk Author Import' => 'Auteurs importeren in bulk',
	'Updating...' => 'Bijwerken...',

## addons/Enterprise.pack/tmpl/edit_group.tmpl
	'Edit Group' => 'Groep bewerken',
	'Group profile has been updated.' => 'Groepsprofiel is bijgewerkt',
	'LDAP Group ID' => 'LDAP Group ID',
	'The LDAP directory ID for this group.' => 'Het LDAP directory ID van deze groep',
	'Status of group in the system. Disabling a group removes its members&rsquo; access to the system but preserves their content and history.' => 'Status van de groep in het systeem.  Een groep uitschakelen heft de toegang tot het systeem op van de groepsleden maar bewaart wel hun inhoud en geschiedenis.',
	'The name used for identifying this group.' => 'De naam gebruikt om deze groep mee aan te duiden.',
	'The display name for this group.' => 'De getoonde naam van deze groep.',
	'Enter a description for your group.' => 'Vul een beschrijving in voor uw groep.',
	'Created on' => 'Aangemaakt',
	'Save changes to this field (s)' => 'Wijzigingen aan dit veld opslaan (s)', # Translate - New

## addons/Enterprise.pack/app-wizard.yaml
	'This module is required in order to use the LDAP Authentication.' => 'Deze module is vereist als u LDAP authenticatie wenst te gebruiken.',
	'This module is required in order to use SSL/TLS connection with the LDAP Authentication.' => 'Deze module is vereist om SSL/TLS connecties te kunnen gebruiken met LDAP authenticatie.',

## addons/Enterprise.pack/app-cms.yaml
	'Are you sure you want to delete the selected group(s)?' => 'Bent u zeker dat u de geselecteerde groep(en) wenst te verwijderen?',
	'Bulk Author Export' => 'Auteurs exporteren in bulk',
	'Synchronize Users' => 'Gebruikers synchroniseren',

## addons/Enterprise.pack/config.yaml
	'Enterprise Pack' => 'Enterprise pack',
	'Oracle Database' => 'Oracle database',
	'Microsoft SQL Server Database' => 'Microsoft SQL Server database',
	'Microsoft SQL Server Database (UTF-8 support)' => 'Microsoft SQL Server database (UTF-8 ondersteuning)',
	'External Directory Synchronization' => 'Externe directory-synchronisatie',
	'Populating author\'s external ID to have lower case user name...' => 'Extern auteurs-ID wordt ingevuld om een gebruikersnaam in kleine letters te krijgen.',

## plugins/Cloner/cloner.pl
	'Clones a blog and all of its contents.' => 'Maakt een kloon van een blog en alle inhoud er in.', # Translate - New
	'Cloning blog \'[_1]\'...' => 'Bezit blog \'[_1]\' te klonen...',
	'Finished! You can <a href="javascript:void(0);" onclick="closeDialog(\'[_1]\');">return to the blog listing</a> or <a href="javascript:void(0);" onclick="closeDialog(\'[_2]\');">configure the Site root and URL of the new blog</a>.' => 'Klaar! U kan nu <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_1]\');\">terugkeren naar het overzicht van de blogs</a> of <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_2]\');\">de siteroot en URL van de nieuwe blog configureren</a>',
	'No blog was selected to clone.' => 'U selecteerde geen blog om te klonen.',
	'This action can only be run for a single blog at a time.' => 'Deze handeling kan maar op één blog tegelijk uitgevoerd worden.',
	'Invalid blog_id' => 'Ongeldig blog_id',
	'Clone Blog' => 'Kloon blog',

## plugins/Markdown/SmartyPants.pl
	'Easily translates plain punctuation characters into \'smart\' typographic punctuation.' => 'Vertaalt op eenvoudige menier gewone punctuatie in \'slimme\' typografische punctuatie.',
	'Markdown With SmartyPants' => 'Markdown met SmartyPants',

## plugins/Markdown/Markdown.pl
	'A plain-text-to-HTML formatting plugin.' => 'Een plugin om gewone tekst naar HTML te formatteren',
	'Markdown' => 'Markdown',

## plugins/WXRImporter/lib/WXRImporter/Import.pm

## plugins/WXRImporter/lib/WXRImporter/WXRHandler.pm
	'File is not in WXR format.' => 'Bestand is niet in WXR formaat.',
	'Duplicate asset (\'[_1]\') found.  Skipping.' => 'Dubbel mediabestand (\'[_1]\') gevonden.  Wordt overgeslagen.', # Translate - New
	'Saving asset (\'[_1]\')...' => 'Bezig met opslaan mediabestand (\'[_1]\')...',
	' and asset will be tagged (\'[_1]\')...' => ' en mediabestand zal getagd worden als (\'[_1]\')...',
	'Duplicate entry (\'[_1]\') found.  Skipping.' => 'Dubbel bericht (\'[_1]\') gevonden.  Wordt overgeslagen.', # Translate - New
	'Saving page (\'[_1]\')...' => 'Pagina aan het opslaan (\'[_1]\')...',

## plugins/WXRImporter/tmpl/options.tmpl
	'Before you import WordPress posts to Movable Type, we recommend that you <a href=\'[_1]\'>configure your blog\'s publishing paths</a> first.' => '\n	Voor u WordPress berichten importeert in Movable Type, raden we aan om eerst <a href=\'[_1]\'>de publicatiepaden van uw weblog in te stellen</a>.',
	'Upload path for this WordPress blog' => 'Uploadpad voor deze WordPress blog',
	'Replace with' => 'Vervangen door',
	'Download attachments' => 'Attachments downloaden', # Translate - New
	'Requires the use of a cron job to download attachments from WordPress powered blog in the background.' => 'Vereist het gebruik van een cronjob om attachments van een WordPress blog te downloaden op de achtergrond.', # Translate - New
	'Download attachments (images and files) from the imported WordPress powered blog.' => 'Attachments (afbeeldingen en bestanden) downloaden van de geïmporteerde WordPress blog.', # Translate - New

## plugins/WXRImporter/WXRImporter.pl
	'Import WordPress exported RSS into MT.' => 'Importeer RSS geëxporteerd uit WordPress in MT.',
	'WordPress eXtended RSS (WXR)' => 'WordPress eXtended RSS (WXR)',
	'Download WP attachments via HTTP.' => 'WP attachments downloaden via HTTP.', # Translate - New

## plugins/StyleCatcher/lib/StyleCatcher/CMS.pm
	'Your mt-static directory could not be found. Please configure \'StaticFilePath\' to continue.' => 'Uw mt-static map kon niet worden gevonden.  Gelieve \'StaticFilePath\' te configureren om verder te gaan.', # Translate - New
	'Could not create [_1] folder - Check that your \'themes\' folder is webserver-writable.' => 'Kon map [_1] niet aanmaken - Controleer of uw \'themes\' map beschrijfbaar is voor de webserver.',
	'Error downloading image: [_1]' => 'Fout bij downloaden afbeelding: [_1]',
	'Successfully applied new theme selection.' => 'Nieuwe thema-selectie met succes toegepast.',
	'Invalid URL: [_1]' => 'Ongeldige URL: [_1]',

## plugins/StyleCatcher/tmpl/view.tmpl
	'Select a Style' => 'Selecteer een stijl',
	'3-Columns, Wide, Thin, Thin' => '3-kolommen, breed, smal, smal',
	'3-Columns, Thin, Wide, Thin' => '3-kolommen, smal, breed, smal',
	'2-Columns, Thin, Wide' => '2-kolommen, smal, breed',
	'2-Columns, Wide, Thin' => '2-kolommen, breed, smal',
	'None available' => 'Geen beschikbaar',
	'Applying...' => 'Wordt toegepast...',
	'Apply Design' => 'Design toepassen',
	'Error applying theme: ' => 'Fout bij toepassen thema:',
	'The selected theme has been applied, but as you have changed the layout, you will need to republish your blog to apply the new layout.' => 'Het geselecteerde thema is toegepast, maar omdat u een andere lay-out heeft gekozen, moet u eerst uw weblog opnieuw publiceren om de nieuwe lay-out zichtbaar te maken.',
	'The selected theme has been applied!' => 'Het geselecteerde thema is toegepast',
	'Error loading themes! -- [_1]' => 'Fout bij het laden van thema\'s! -- [_1]',
	'Stylesheet or Repository URL' => 'Stylesheet of bibliotheek URL',
	'Stylesheet or Repository URL:' => 'Stylesheet of bibliotheek URL:',
	'Download Styles' => 'Stijlen downloaden',
	'Current theme for your weblog' => 'Huidig thema van uw weblog',
	'Current Style' => 'Huidige stijl',
	'Locally saved themes' => 'Lokaal opgeslagen thema\'s',
	'Saved Styles' => 'Opgeslagen stijlen',
	'Default Styles' => 'Standaard stijlen',
	'Single themes from the web' => 'Losse thema\'s van het web',
	'More Styles' => 'Meer stijlen',
	'Selected Design' => 'Geselecteerde designs',
	'Layout' => 'Lay-out',

## plugins/StyleCatcher/stylecatcher.pl
	'StyleCatcher lets you easily browse through styles and then apply them to your blog in just a few clicks. To find out more about Movable Type styles, or for new sources for styles, visit the <a href=\'http://www.sixapart.com/movabletype/styles\'>Movable Type styles</a> page.' => 'Met StyleCatcher kunt u makkelijk een keuze maken tussen stijlen om ze daarna op uw blog toe te passen in een paar klikken.  Om meer te weten over Movable Type stijlen, of om een bron te vinden van nog meer stijlen, bezoek de <a href=\'http://www.sixapart.com/movabletype/styles\'>Movable Type styles</a> pagina.',
	'MT 4 Style Library' => 'MT 4 Stijlenbibliotheek',
	'A collection of styles compatible with Movable Type 4 default templates.' => 'Een verzameling stijlen compatibel met de standaardsjablonen van Movable Type 4.',
	'MT 3 Style Library' => 'MT 3 Stijlenbibliotheek',
	'A collection of styles compatible with Movable Type 3.3+ default templates.' => 'Een verzameling stijlen compatibel met de standaardsjablonen van Movable Type 3.3+.',
	'Styles' => 'Stijlen',

## plugins/spamlookup/lib/spamlookup.pm
	'Failed to resolve IP address for source URL [_1]' => 'Resolutie van IP adres mislukt voor bron URL [_1]',
	'Moderating: Domain IP does not match ping IP for source URL [_1]; domain IP: [_2]; ping IP: [_3]' => 'In moderatie: IP van domein komt niet overeen met IP van ping voor bron URL [_1]; domein IP: [_2]; ping IP: [_3]',
	'Domain IP does not match ping IP for source URL [_1]; domain IP: [_2]; ping IP: [_3]' => 'Domein IO komt niet overeen met ping IP van bron URL [_1]; domein IP: [_2]; ping IP: [_3]',
	'No links are present in feedback' => 'Geen links aanwezig in feedback',
	'Number of links exceed junk limit ([_1])' => 'Aantal links hoger dan spamlimiet ([_1])',
	'Number of links exceed moderation limit ([_1])' => 'Aantal links hoger dan moderatielimiet ([_1])',
	'Link was previously published (comment id [_1]).' => 'Link werd eerder al gepubliceerd (reactie id [_1])',
	'Link was previously published (TrackBack id [_1]).' => 'Link werd eerder al gepubliceerd (TrackBack id [_1])',
	'E-mail was previously published (comment id [_1]).' => 'E-mail werd eerder al gepubliceerd (reactie id [_1])',
	'Word Filter match on \'[_1]\': \'[_2]\'.' => 'Woordfilter overeenkomst op \'[_1]\': \'[_2]\'.',
	'Moderating for Word Filter match on \'[_1]\': \'[_2]\'.' => 'Te modereren wegens woordfilter overeenkomst op \'[_1]\': \'[_2]\'.',
	'domain \'[_1]\' found on service [_2]' => 'domein \'[_1]\' gevonden op service [_2].',
	'[_1] found on service [_2]' => '[_1] gevonden op service [_2]',

## plugins/spamlookup/tmpl/url_config.tmpl
	'Link filters monitor the number of hyperlinks in incoming feedback. Feedback with many links can be held for moderation or scored as junk. Conversely, feedback that does not contain links or only refers to previously published URLs can be positively rated. (Only enable this option if you are sure your site is already spam-free.)' => 'Linkfilters houden het aantal hyperlinks in binnenkomende feedback in de gaten.  Feedback met veel links in kan tegengehouden worden voor moderatie of kan een spamscore krijgen.  Langs de andere kant kan feedback die geen links bevat of enkel verwijst naar eerder gepubliceerde URL\'s een positieve score krijgen. (Deze optie enkel inschakelen indien uw site reeds spam-vrij is).',
	'Link Limits' => 'Linklimieten',
	'Credit feedback rating when no hyperlinks are present' => 'Ken extra score toe indien geen hyperlinks aanwezig',
	'Adjust scoring' => 'Score bijwerken',
	'Score weight:' => 'Scoregewicht',
	'Moderate when more than' => 'Modereer indien er meer dan',
	'link(s) are given' => 'link(s) voorkomen',
	'Junk when more than' => 'Ken een spamscore toe indien er meer dan',
	'Link Memory' => 'Linkgeheugen',
	'Credit feedback rating when &quot;URL&quot; element of feedback has been published before' => 'Ken een positieve score toe indien het &quot;URL&quot; element in de feedback al eens eerder gepubliceerd werd',
	'Only applied when no other links are present in message of feedback.' => 'Enkel toegepast indien er geen andere links in het bericht van de feedback staan',
	'Exclude URLs from comments published within last [_1] days.' => 'URL\'s uitsluiten van reacties gepubliceerd in de laastste [_1] dagen.',
	'Email Memory' => 'E-mail geheugen',
	'Credit feedback rating when previously published comments are found matching on the &quot;Email&quot; address' => 'Ken een positieve score toe indien er eerder gepubliceerde reacties gevonden worden met hetzelfde e-mail adres',
	'Exclude Email addresses from comments published within last [_1] days.' => 'E-mail adressen uitsluiten van reacties gepubliceerd in de laatste [_1] dagen.',

## plugins/spamlookup/tmpl/lookup_config.tmpl
	'Lookups monitor the source IP addresses and hyperlinks of all incoming feedback. If a comment or TrackBack comes from a blacklisted IP address or contains a blacklisted domain, it can be held for moderation or scored as junk and placed into the blog\'s Junk folder. Additionally, advanced lookups on TrackBack source data can be performed.' => 'Lookups houden het bron IP adres en de URL in het oog van alle binnenkomende feedback.  Als een reactie of TrackBack afkomstig is van een IP adres op de zwarte lijst of een domein bevat dat op de zwarte lijst staat, dan kan het worden tegengehouden voor moderatie of een score ontvangen als junk en in de spam-map worden geplaatst.  Bovendien kunnen geavanceerde opzoekingen gedaan worden op de brondata van een TrackBack.',
	'IP Address Lookups' => 'Opzoeken IP adressen',
	'Moderate feedback from blacklisted IP addresses' => 'Feedback modereren van IP adressen op de zwarte lijst',
	'Junk feedback from blacklisted IP addresses' => 'Feedback van IP adressen op de zwarte lijst een spamscore toekennen',
	'Less' => 'Minder',
	'More' => 'Meer',
	'block' => 'blokkeer',
	'IP Blacklist Services' => 'IP zwarte lijst diensten',
	'Domain Name Lookups' => 'Opzoeken domeinnamen',
	'Moderate feedback containing blacklisted domains' => 'Modereer feedback die domeinen bevat die op de zwarte lijst staan',
	'Junk feedback containing blacklisted domains' => 'Ken een spamscore to aan feedback die domeinen bevat die op de zwarte lijst staan ',
	'Domain Blacklist Services' => 'Domein zwarte lijst diensten',
	'Advanced TrackBack Lookups' => 'Geavanceerde TrackBack opzoekingen',
	'Moderate TrackBacks from suspicious sources' => 'Modereer TrackBacks uit verdachte bronnen',
	'Junk TrackBacks from suspicious sources' => 'Ken een spamscore toe aan TrackBacks uit verdachte bronnen',
	'Lookup Whitelist' => 'Witte lijst voor opzoekingen',
	'To prevent lookups for some IP addresses or domains, list them below. Place each entry on a line by itself.' => 'Om te voorkomen dat bepaalde IP adressen of domeinen opgezocht worden, kunt u ze hieronder opsommen.  Gelieve elk gegeven op een aparte regel te plaatsen.',

## plugins/spamlookup/tmpl/word_config.tmpl
	'Incomming feedback can be monitored for specific keywords, domain names, and patterns. Matches can be held for moderation or scored as junk. Additionally, junk scores for these matches can be customized.' => 'Binnenkomende feedback kan onderzocht worden op specifieke sleutelwoorden, domeinnamen en patronen.  Feedback waar deze in gevonden worden kan worden tegengehouden voor moderatie of een spamscore krijgen.  Bovendien kunnen spamscores voor overeenkomsten gepersonaliseerd worden.',
	'Keywords to Moderate' => 'Sleutelwoorden om te modereren',
	'Keywords to Junk' => 'Sleutelwoorden om een spamscore toe te kennen',

## plugins/spamlookup/spamlookup_words.pl
	'SpamLookup module for moderating and junking feedback using keyword filters.' => 'SpamLookup module voor het modereren en aanmerken als spam van feedback door sleutelwoord-filters',
	'SpamLookup Keyword Filter' => 'SpamLookup sleutelwoord-filter',

## plugins/spamlookup/spamlookup.pl
	'SpamLookup module for using blacklist lookup services to filter feedback.' => 'SpamLookup module om zwarte lijsten te gebruiken om feedback mee te filteren.',
	'SpamLookup IP Lookup' => 'SpamLookup IP opzoeken',
	'SpamLookup Domain Lookup' => 'SpamLookup domein opzoeken',
	'SpamLookup TrackBack Origin' => 'SpamLookup TrackBack origine',
	'Despam Comments' => 'Filter spam uit reacties',
	'Despam TrackBacks' => 'Filter spam uit TrackBacks',
	'Despam' => 'Filter spam',

## plugins/spamlookup/spamlookup_urls.pl
	'SpamLookup - Link' => 'SpamLookup - Link',
	'SpamLookup module for junking and moderating feedback based on link filters.' => 'SpamLookup module om feedback als spam te merken of te modereren gebaseerd op linkfilters.',
	'SpamLookup Link Filter' => 'SpamLookup linkfilter',
	'SpamLookup Link Memory' => 'SpamLookup linkgeheugen',
	'SpamLookup Email Memory' => 'SpamLookup e-mail geheugen',

## plugins/MultiBlog/lib/MultiBlog/Tags.pm
	'MTMultiBlog tags cannot be nested.' => 'MTMultiBlog tags mogen niet genest zijn.',
	'Unknown "mode" attribute value: [_1]. Valid values are "loop" and "context".' => 'Onbekende "mode" attribuutwaarde: [_1].  Geldige waarden zijn "loop" en "context".',

## plugins/MultiBlog/lib/MultiBlog.pm
	'The include_blogs, exclude_blogs, blog_ids and blog_id attributes cannot be used together.' => 'De include_blogs, exclude_blogs, blog_ids en blog_id attributen kunnen niet samen gebruikt worden.',
	'The attribute exclude_blogs cannot take "all" for a value.' => 'Het attribuut exclude_blogs kan niet "all" als waarde hebben.',
	'The value of the blog_id attribute must be a single blog ID.' => 'De waarde van het blog_id attribuut moet één Blog ID zijn.',
	'The value for the include_blogs/exclude_blogs attributes must be one or more blog IDs, separated by commas.' => 'De waarde voor de include_blogs/exclude_blogs attributen moet één of meer Blog ID\'s zijn, gescheiden door komma\'s.',

## plugins/MultiBlog/tmpl/dialog_create_trigger.tmpl
	'Create MultiBlog Trigger' => 'Multiblogtrigger aanmaken',

## plugins/MultiBlog/tmpl/blog_config.tmpl
	'When' => 'Wanneer',
	'Any Weblog' => 'Eender welke weblog',
	'Weblog' => 'Weblog',
	'Trigger' => 'Trigger',
	'Action' => 'Actie',
	'Content Privacy' => 'Privacy inhoud',
	'Specify whether other blogs in the installation may publish content from this blog. This setting takes precedence over the default system aggregation policy found in the system-level MultiBlog configuration.' => 'Geef aan of andere blogs op deze installatie inhoud van deze blog mogen publiceren.  Deze instelling krijgt voorrang op het standaard aggregatiebeleid op systeemniveau wat u kunt terugvinden in het configuratiescherm voor MultiBlog op systeemniveau.',
	'Use system default' => 'Standaard systeeminstelling gebruiken',
	'Allow' => 'Toestaan',
	'Disallow' => 'Verbieden',
	'MTMultiBlog tag default arguments' => 'MTMultiBlog tag standaard argumenten',
	'Enables use of the MTMultiBlog tag without include_blogs/exclude_blogs attributes. Comma-separated BlogIDs or \'all\' (include_blogs only) are acceptable values.' => 'Maakt het mogelijk om de MTMultiBlog tag te gebruiken zonder include_blogs/exclude_blogs attributen.  Toegestane waarden zijn BlogID\'s gescheden door komma\'s of \'all\' (enkel bij include_blogs).',
	'Include blogs' => 'Includeer blogs',
	'Exclude blogs' => 'Excludeer blogs',
	'Rebuild Triggers' => 'Rebuild-triggers',
	'Create Rebuild Trigger' => 'Rebuild-trigger aanmaken',
	'You have not defined any rebuild triggers.' => 'U heeft nog geen rebuild-triggers gedefiniëerd',

## plugins/MultiBlog/tmpl/system_config.tmpl
	'Default system aggregation policy' => 'Standaard aggregatiebeleid voor het systeem',
	'Cross-blog aggregation will be allowed by default.  Individual blogs can be configured through the blog-level MultiBlog settings to restrict access to their content by other blogs.' => 'Cross-blog aggregatie zal standaard toegestaan zijn.  Individuele blgos kunnen via de MultiBlog instellingen op blogniveau worden ingesteld om toegang tot hun inhoud voor andere blogs te beperken.',
	'Cross-blog aggregation will be disallowed by default.  Individual blogs can be configured through the blog-level MultiBlog settings to allow access to their content by other blogs.' => 'Cross-blog aggregatie zal standaard verboden zijn.  Individuele blgos kunnen via de MultiBlog instellingen op blogniveau worden ingesteld om toegang tot hun inhoud voor andere blogs te verlenen.',

## plugins/MultiBlog/multiblog.pl
	'MultiBlog allows you to publish content from other blogs and define publishing rules and access controls between them.' => 'Met MultiBlog kunt u inhoud van andere blogs publiceren en kunt u onderlinge publicatieregels en toegangsbeheer regelen.',
	'MultiBlog' => 'MultiBlog',
	'Create Trigger' => 'Nieuwe trigger aanmaken',
	'Weblog Name' => 'Weblognaam',
	'Search Weblogs' => 'Doorzoek weblogs',
	'When this' => 'indien dit',
	'* All Weblogs' => '* Alle weblogs',
	'Select to apply this trigger to all weblogs' => 'Selecteer dit om de trigger toe te passen op alle weblogs',
	'saves an entry' => 'een bericht opslaat',
	'publishes an entry' => 'een bericht publiceert',
	'publishes a comment' => 'een reactie publiceert',
	'publishes a TrackBack' => 'een TrackBack publiceert',
	'rebuild indexes.' => 'indexen opnieuw opbouwt.',
	'rebuild indexes and send pings.' => 'indexen opnieuw opbouwt en pings verstuurt.',

## plugins/Textile/textile2.pl
	'A humane web text generator.' => 'Een mensvriendelijke tekstgenerator',
	'Textile 2' => 'Textile 2',

## plugins/WidgetManager/lib/WidgetManager/Plugin.pm
	'Can\'t find included template widget \'[_1]\'' => 'Kan geïncludeerd sjabloonwidget \'[_1]\' niet vinden',
	'Cloning Widgets for blog...' => 'Bezig widgets te klonen van blog...',

## plugins/WidgetManager/lib/WidgetManager/CMS.pm
	'Can\'t duplicate the existing \'[_1]\' Widget Manager. Please go back and enter a unique name.' => 'Kan de bestaande \'[_1]\' WidgetManager niet dupliceren. Gelieve terug te gaan en een unieke naam in te geven.',
	'Main Menu' => 'Hoofdmenu',
	'Widget Manager' => 'Widget Manager',
	'New Widget Set' => 'Nieuwe widgetset',

## plugins/WidgetManager/default_widgets/monthly_archive_dropdown.mtml
	'Select a Month...' => 'Selecteer een maand...',

## plugins/WidgetManager/default_widgets/category_archive_list.mtml

## plugins/WidgetManager/default_widgets/calendar.mtml
	'Monthly calendar with links to daily posts' => 'Maandkalender met links naar de berichten van alle dagen', # Translate - New
	'Sun' => 'Zon',
	'Mon' => 'Maa',
	'Tue' => 'Din',
	'Wed' => 'Woe',
	'Thu' => 'Don',
	'Fri' => 'Vri',
	'Sat' => 'Zat',

## plugins/WidgetManager/default_widgets/recent_entries.mtml

## plugins/WidgetManager/default_widgets/current_author_monthly_archive_list.mtml

## plugins/WidgetManager/default_widgets/date_based_author_archives.mtml
	'Author Yearly Archives' => 'Archieven per auteur per jaar', # Translate - New
	'Author Weekly Archives' => 'Archieven per auteur per week', # Translate - New
	'Author Daily Archives' => 'Archieven per auteur per dag', # Translate - New

## plugins/WidgetManager/default_widgets/main_index_meta_widget.mtml
	'This is a custom set of widgets that are conditioned to only appear on the homepage (or "main_index"). More info: [_1]' => 'Dit is een gepersonaliseerde set widgets die enkel op de hoofpagina (of "hoofdindex") verschijnen.  Meer info: [_1]', # Translate - New
	'Recent Assets' => 'Recente mediabestanden', # Translate - New

## plugins/WidgetManager/default_widgets/syndication.mtml
	'Search results matching &ldquo;<$mt:SearchString$>&rdquo;' => 'Zoekresultaten die overeen komen met &ldquo;<$mt:SearchString$>&rdquo;', # Translate - New

## plugins/WidgetManager/default_widgets/current_category_monthly_archive_list.mtml

## plugins/WidgetManager/default_widgets/recent_comments.mtml
	'<a href="[_1]">[_2] commented on [_3]</a>: [_4]' => '<a href="[_1]">[_2] reageerde op [_3]</a>: [_4]', # Translate - New

## plugins/WidgetManager/default_widgets/technorati_search.mtml
	'Technorati' => 'Technorati',
	'<a href=\'http://www.technorati.com/\'>Technorati</a> search' => 'Zoek op <a href=\'http://www.technorati.com/\'>Technorati</a>',
	'this blog' => 'deze weblog',
	'all blogs' => 'alle blogs',
	'Blogs that link here' => 'Blogs die hierheen linken',

## plugins/WidgetManager/default_widgets/monthly_archive_list.mtml

## plugins/WidgetManager/default_widgets/signin.mtml
	'You are signed in as ' => 'U bent aangemeld als',
	'You do not have permission to sign in to this blog.' => 'U heeft geen toestemming om aan te melden op deze weblog',

## plugins/WidgetManager/default_widgets/pages_list.mtml

## plugins/WidgetManager/default_widgets/archive_meta_widget.mtml
	'This is a custom set of widgets that are conditioned to serve different content based upon what type of archive it is included. More info: [_1]' => 'Dit is een set widgets die andere inhoud tonen gebaseerd op het archieftype waarin ze voorkomen.  Meer info: [_1]', # Translate - New
	'Current Category Monthly Archives' => 'Archieven van de huidige categorie per maand', # Translate - New
	'Category Archives' => 'Archieven per categorie', # Translate - New

## plugins/WidgetManager/default_widgets/date_based_category_archives.mtml
	'Category Yearly Archives' => 'Archieven per categorie per jaar', # Translate - New
	'Category Weekly Archives' => 'Archieven per categorie per week', # Translate - New
	'Category Daily Archives' => 'Archieven per categorie per dag', # Translate - New

## plugins/WidgetManager/default_widgets/widgets.cfg
	'About This Page' => 'Over deze pagina', # Translate - New
	'Current Author Monthly Archives' => 'Archieven per maand van de huidige auteur', # Translate - New
	'Calendar' => 'Kalender',
	'Creative Commons' => 'Creative Commons',
	'Home Page Widgets' => 'Hoofdpaginawidgets', # Translate - New
	'Monthly Archives Dropdown' => 'Uitklapmenu archieven per maand', # Translate - New
	'Page Listing' => '', # Translate - New
	'Powered By' => 'Aangedreven door',
	'Syndication' => 'Syndicatie', # Translate - New
	'Technorati Search' => 'Technorati zoekformulier',
	'Date-Based Author Archives' => 'Datum-gebaseerde auteursactieven',
	'Date-Based Category Archives' => 'Datum-gebaseerde categorie-archieven',

## plugins/WidgetManager/default_widgets/creative_commons.mtml
	'This weblog is licensed under a' => 'Deze weblog valt onder een licentie van het type',
	'Creative Commons License' => 'Creative Commons Licentie',

## plugins/WidgetManager/default_widgets/about_this_page.mtml

## plugins/WidgetManager/default_widgets/author_archive_list.mtml

## plugins/WidgetManager/default_widgets/powered_by.mtml

## plugins/WidgetManager/default_widgets/tag_cloud.mtml

## plugins/WidgetManager/default_widgets/recent_assets.mtml

## plugins/WidgetManager/default_widgets/search.mtml

## plugins/WidgetManager/tmpl/edit.tmpl
	'Edit Widget Set' => 'Widgetset bewerken',
	'Please use a unique name for this widget set.' => 'Gelieve een unieke naam voor deze widgetset te gebruiken',
	'You already have a widget set named \'[_1].\' Please use a unique name for this widget set.' => 'U heeft al een widgetste met de naam \'[_1]\'.  Gelieve een unieke naam te gebruiken voor deze widgetset.',
	'Your changes to the Widget Set have been saved.' => 'Uw wijzigingen aan de widgetset zijn opgeslagen.',
	'Set Name' => 'Naam instellen',
	'Drag and drop the widgets you want into the Installed column.' => 'Klik en sleep de widgets die u wenst in de \'Geïnstalleerde widgets\' kolom.',
	'Installed Widgets' => 'Geïnstalleerde widgets',
	'Available Widgets' => 'Beschikbare widgets',
	'Save changes to this widget set (s)' => 'Wijzignen aan deze widgetset opslaan (s)', # Translate - New

## plugins/WidgetManager/tmpl/list.tmpl
	'Widget Sets' => 'Widgetsets',
	'Widget Set' => 'Widgetset',
	'Delete selected Widget Sets (x)' => 'Geselecteerde widgetsets verwijderen (x)',
	'Helpful Tips' => 'Nuttige tips',
	'To add a widget set to your templates, use the following syntax:' => 'Om een widgetset aan uw sjablonen toe te voegen, gebruikt u volgende syntax:',
	'<strong>&lt;$MTWidgetSet name=&quot;Name of the Widget Set&quot;$&gt;</strong>' => '<strong>&lt;$MTWidgetSet name=&quot;Naam van de widgetset&quot;$&gt;</strong>',
	'Edit Widget Templates' => 'Bewerk widgetsjablonen',
	'Your changes to the widget set have been saved.' => 'Uw wijzigingen aan de widgetset werden opgeslagen.',
	'You have successfully deleted the selected widget set(s) from your blog.' => 'U heeft met succes de geselecteerde widgetset(s) van uw weblog verwijderd.',
	'Create Widget Set' => 'Widgetset aanmaken',
	'No Widget Sets could be found.' => 'Er werden geen widgetsets gevonden.',

## plugins/WidgetManager/WidgetManager.pl
	'Maintain your blog\'s widget content using a handy drag and drop interface.' => 'Beheer de widget-inhoud van uw weblog via een handige klik-en-sleep interface.',
	'Widgets' => 'Widgets',

);

## New words: 807

1;
