package ClassicBlogThemePack::L10N::fr;
use strict;
use ClassicBlogThemePack::L10N;
use ClassicBlogThemePack::L10N::en_us;
use vars qw( @ISA %Lexicon );
@ISA = qw( ClassicBlogThemePack::L10N::en_us );

## The following is the translation table.

%Lexicon = (
## default_templates/comments.mtml
	'1 Comment' => '1 Commentaire',
	'# Comments' => '# Commentaires',
	'No Comments' => 'Aucun Commentaire',
	'Comment Detail' => 'D√©tail du Commentaire',
	'The data is modified by the paginate script' => 'Les donn√©es sont modifi√©es par le script de pagination', # Translate - New
	'Older Comments' => 'Anciens commentaires', # Translate - New
	'Newer Comments' => 'Nouveaux commentaires', # Translate - New
	'Leave a comment' => 'Laisser un commentaire',
	'Name' => 'Nom',
	'Email Address' => 'Adresse e-mail',
	'URL' => 'URL',
	'Remember personal info?' => 'M√©moriser mes infos personnelles ?',
	'Comments' => 'Commentaires',
	'(You may use HTML tags for style)' => '(Vous pouvez utiliser des balises HTML pour le style)',
	'Preview' => 'Aper√ßu',
	'Submit' => 'Envoyer',

## default_templates/search.mtml
	'Search' => 'Rechercher',
	'Case sensitive' => 'Sensible √† la casse',
	'Regex search' => 'Expression rationnelle',
	'Tags' => 'Tags',
	'[_1] ([_2])' => '[_1] ([_2])',

## default_templates/monthly_archive_dropdown.mtml
	'Archives' => 'Archives',
	'Select a Month...' => 'S√©lectionnez un Mois...',

## default_templates/notify-entry.mtml
	'A new [lc,_3] entitled \'[_1]\' has been published to [_2].' => 'Une nouvelle [lc,_3] intitul√©e \'[_1]\' a √©t√© publi√©e sur [_2].',
	'View entry:' => 'Voir la note :',
	'View page:' => 'Voir la page :',
	'[_1] Title: [_2]' => 'Titre du [_1] : [_2]',
	'Publish Date: [_1]' => 'Date de publication : [_1]',
	'Message from Sender:' => 'Message de l\'exp√©diteur :',
	'You are receiving this email either because you have elected to receive notifications about new content on [_1], or the author of the post thought you would be interested. If you no longer wish to receive these emails, please contact the following person:' => 'Vous recevez cet email car vous avez demand√© √† recevoir les notifications de nouveau contenu sur [_1], ou l\'auteur de la note a pens√© que vous seriez int√©ress√©. Si vous ne souhaitez plus recevoir ces emails, merci de contacter la personne suivante:',

## default_templates/category_archive_list.mtml
	'Categories' => 'Cat√©gories',

## default_templates/date_based_author_archives.mtml
	'Author Yearly Archives' => 'Archives Annuelles par Auteurs',
	'Author Monthly Archives' => 'Archives par auteurs et mois',
	'Author Weekly Archives' => 'Archives Hebdomadaires par Auteurs',
	'Author Daily Archives' => 'Archives Quotidiennes par Auteurs',

## default_templates/current_author_monthly_archive_list.mtml
	'[_1]: Monthly Archives' => '[_1]: Archives Mensuelles',

## default_templates/main_index.mtml
	'HTML Head' => 'En-t√™te HTML',
	'Banner Header' => 'Bloc de l\'En-t√™te',
	'Entry Summary' => 'R√©sum√© de la note',
	'Sidebar' => 'Colonne lat√©rale',
	'Banner Footer' => 'Bloc du Pied de page',

## default_templates/page.mtml
	'Trackbacks' => 'Trackbacks',

## default_templates/comment_preview.mtml
	'Previewing your Comment' => 'Aper√ßu de votre commentaire',
	'[_1] replied to <a href="[_2]">comment from [_3]</a>' => '[_1] en r√©ponse au <a href="[_2]">commentaire de [_3]</a>',
	'Replying to comment from [_1]' => 'En r√©ponse au commentaire de [_1]',
	'Cancel' => 'Annuler',

## default_templates/main_index_widgets_group.mtml
	'This is a custom set of widgets that are conditioned to only appear on the homepage (or "main_index"). More info: [_1]' => 'Ceci est un groupe de wigets personnalis√© qui est conditionn√© pour n\'appara√Ætre que sur la page d\'accueil (ou "main_index"). Plus d\'infos : [_1]',
	'Recent Comments' => 'Commentaires r√©cents',
	'Recent Entries' => 'Notes r√©centes',
	'Recent Assets' => '√âl√©ments r√©cents',
	'Tag Cloud' => 'Nuage de tags',

## default_templates/entry_summary.mtml
	'By [_1] on [_2]' => 'Par [_1] le [_2]',
	'1 TrackBack' => '1 Trackback',
	'# TrackBacks' => '# Trackbacks',
	'No TrackBacks' => 'Aucun Trackback',
	'Continue reading <a href="[_1]" rel="bookmark">[_2]</a>.' => 'Lire la suite de <a href="[_1]" rel="bookmark">[_2]</a>.',

## default_templates/comment_response.mtml
	'Confirmation...' => 'Confirmation...',
	'Your comment has been submitted!' => 'Votre commentaire a √©t√© envoy√© !',
	'Thank you for commenting.' => 'Merci de votre commentaire.',
	'Your comment has been received and held for approval by the blog owner.' => 'Votre commentaire a √©t√© re√ßu et est en attente de validation par le propri√©taire de ce blog.',
	'Comment Submission Error' => 'Erreur d\'envoi du commentaire',
	'Your comment submission failed for the following reasons: [_1]' => 'La soumission de votre commentaire a √©chou√© pour la raison suivante : [_1]',
	'Return to the <a href="[_1]">original entry</a>.' => 'Retourner √† la <a href="[_1]">note originale</a>.',

## default_templates/commenter_notify.mtml
	'This email is to notify you that a new user has successfully registered on the blog \'[_1]\'. Listed below you will find some useful information about this new user.' => 'Un nouvel utilisateur s\'est enregistr√© sur le blog \'[_1]\'. Vous trouverez ci-dessous quelques informations utiles √† propos de ce nouvel utilisateur.',
	'New User Information:' => 'Informations concernant ce nouvel utilisateur :',
	'Username: [_1]' => 'Identifiant : [_1]',
	'Full Name: [_1]' => 'Nom complet : [_1]',
	'Email: [_1]' => 'Email : [_1]',
	'To view or edit this user, please click on or cut and paste the following URL into a web browser:' => 'Pour voir ou modifier cet utilisateur, merci de cliquer ou copier-coller l\'adresse suivante dans votre navigateur web:',

## default_templates/footer-email.mtml
	'Powered by Melody [_1]' => 'Powered by Melody [_1]',

## default_templates/comment_listing_dynamic.mtml

## default_templates/archive_widgets_group.mtml
	'This is a custom set of widgets that are conditioned to serve different content based upon what type of archive it is included. More info: [_1]' => 'Ceci est un groupe de widgets personnalis√© qui est conditionn√© pour afficher un contenu diff√©rent bas√© sur le type d\'archives qui est inclue. Plus d\'infos : [_1]',
	'Current Category Monthly Archives' => 'Archives Mensuelles de la Cat√©gorie Courante',
	'Category Archives' => 'Archives par Cat√©gories',
	'Monthly Archives' => 'Archives mensuelles',

## default_templates/verify-subscribe.mtml
	'Thanks for subscribing to notifications about updates to [_1]. Follow the link below to confirm your subscription:' => 'Merci d\'avoir pour votre inscription aux mises √† jours [_1]. Cliquez sur le lien ci-dessous pour confirmer cette inscription :',
	'If the link is not clickable, just copy and paste it into your browser.' => 'Si le lien n\'est pas cliquable, faites simplement un copier-coller dans votre navigateur.',

## default_templates/new-ping.mtml
	'An unapproved TrackBack has been posted on your blog [_1], for entry #[_2] ([_3]). You need to approve this TrackBack before it will appear on your site.' => 'Un Trackback non-approuv√© a √©t√© d√©pos√© sur votre blog [_1], pour la note #[_2] ([_3]). Vous devez approuver ce Trackback pour qu\'il apparaisse sur votre site.',
	'An unapproved TrackBack has been posted on your blog [_1], for category #[_2], ([_3]). You need to approve this TrackBack before it will appear on your site.' => 'Un Trackback non-approuv√© a √©t√© d√©pos√© sur votre blog [_1], pour la cat√©gorie #[_2] ([_3]). Vous devez approuver ce Trackback pour qu\'il apparaisse sur votre site.',
	'A new TrackBack has been posted on your blog [_1], on entry #[_2] ([_3]).' => 'Un nouveau TrackBack a √©t√© d√©pos√© sur votre blog [_1], pour la note #[_2] ([_3]).',
	'A new TrackBack has been posted on your blog [_1], on category #[_2] ([_3]).' => 'Un nouveau TrackBack a √©t√© d√©pos√© sur votre blog [_1], pour la cat√©gorie #[_2] ([_3]).',
	'Excerpt' => 'Extrait',
	'Title' => 'Titre',
	'Blog' => 'Blog',
	'IP address' => 'Adresse IP',
	'Approve TrackBack' => 'Approuver le Trackback',
	'View TrackBack' => 'Voir le Trackback',
	'Report TrackBack as spam' => 'Notifier le Trackback comme spam',
	'Edit TrackBack' => '√âditer les Trackbacks',

## default_templates/syndication.mtml
	'Subscribe to feed' => 'S\'abonner au flux',
	'Subscribe to this blog\'s feed' => 'S\'abonner au flux de ce blog',
	'Subscribe to a feed of all future entries tagged &ldquo;[_1]&ldquo;' => 'S\'abonner au flux de toutes les futurs notes taggu√©es &ldquo;[_1]&ldquo;',
	'Subscribe to a feed of all future entries matching &ldquo;[_1]&ldquo;' => 'S\'abonner au flux de toutes les futurs notes contenant &ldquo;[_1]&ldquo;',
	'Feed of results tagged &ldquo;[_1]&ldquo;' => 'Flux des r√©sultats tagg√©s &ldquo;[_1]&ldquo;',
	'Feed of results matching &ldquo;[_1]&ldquo;' => 'Flux des r√©sultats pour &ldquo;[_1]&ldquo;',

## default_templates/comment_detail.mtml

## default_templates/banner_footer.mtml
	'_POWERED_BY' => 'Powered by <a href="http://www.movabletype.org/"><MTProductName></a>',
	'This blog is licensed under a <a href="[_1]">Creative Commons License</a>.' => 'Ce blog poss√®de une licence <a href="[_1]">Creative Commons</a>.',

## default_templates/search_results.mtml
	'Search Results' => 'R√©sultats de recherche',
	'Results matching &ldquo;[_1]&rdquo;' => 'R√©sultats pour &ldquo;[_1]&rdquo;',
	'Results tagged &ldquo;[_1]&rdquo;' => 'R√©sultats tagu√©s &ldquo;[_1]&rdquo;',
	'Previous' => 'Pr√©c√©dent',
	'Next' => 'Suivant',
	'No results found for &ldquo;[_1]&rdquo;.' => 'Aucun r√©sultat pour &ldquo;[_1]&rdquo;.',
	'Instructions' => 'Instructions',
	'By default, this search engine looks for all words in any order. To search for an exact phrase, enclose the phrase in quotes:' => 'Par d√©faut, ce moteur va rechercher tous les mots, quelque soit leur ordre. Pour lancer une recherche sur une phrase exacte, ins√©rez la phrase entre des apostrophes : ',
	'movable type' => 'movable type',
	'The search engine also supports AND, OR, and NOT keywords to specify boolean expressions:' => 'Le moteur de recherche supporte aussi les mot-cl√©s AND, OR, NOT pour sp√©cifier des expressions bool√©ennes :',
	'personal OR publishing' => 'personnel OR publication',
	'publishing NOT personal' => 'publication NOT personnel',

## default_templates/current_category_monthly_archive_list.mtml
	'[_1]' => '[_1]',

## default_templates/date_based_category_archives.mtml
	'Category Yearly Archives' => 'Archives Annuelles par Cat√©gories',
	'Category Monthly Archives' => 'Archives par cat√©gories et mois',
	'Category Weekly Archives' => 'Archives Hebdomadaires par Cat√©gories',
	'Category Daily Archives' => 'Archives Quotidiennes par Cat√©gories',

## default_templates/recent_comments.mtml
	'<strong>[_1]:</strong> [_2] <a href="[_3]" title="full comment on: [_4]">read more</a>' => '<strong>[_1] :</strong> [_2] <a href="[_3]" title="commentaire complet sur : [_4]">lire la suite</a>',

## default_templates/dynamic_error.mtml
	'Page Not Found' => 'Page Non Trouv√©e',

## default_templates/technorati_search.mtml
	'Technorati' => 'Technorati',
	'<a href=\'http://www.technorati.com/\'>Technorati</a> search' => 'Recherche <a href=\'http://www.technorati.com/\'>Technorati</a> ',
	'this blog' => 'ce blog',
	'all blogs' => 'tous les blogs',
	'Blogs that link here' => 'Blogs pointant ici',

## default_templates/monthly_archive_list.mtml
	'[_1] <a href="[_2]">Archives</a>' => '<a href="[_2]">Archives</a> [_1]',

## default_templates/category_entry_listing.mtml
	'[_1] Archives' => 'Archives [_1]',
	'Recently in <em>[_1]</em> Category' => 'R√©cemment dans la cat√©gorie <em>[_1]</em>',
	'Main Index' => 'Index principal',

## default_templates/comment_throttle.mtml
	'If this was a mistake, you can unblock the IP address and allow the visitor to add it again by logging in to your Melody installation, going to Blog Config - IP Banning, and deleting the IP address [_1] from the list of banned addresses.' => 'Si c\'√©tait une erreur, vous pouvez d√©bloquer l\'adresse IP et autoriser le visiteur √† nouveau en vous identifiant dans Melody, dans Configuration du Blog - Blocage IP, et en effa√ßant l\'adresse IP [_1] de la liste des adresses bannies.',
	'A visitor to your blog [_1] has automatically been banned by adding more than the allowed number of comments in the last [_2] seconds.' => 'Un visiteur de votre blog [_1] a √©t√© automatiquement banni apr√®s avoir publi√© une quantit√© de commentaires sup√©rieure √† la limite √©tablie au cours des [_2] secondes.',
	'This has been done to prevent a malicious script from overwhelming your weblog with comments. The banned IP address is' => 'Cette op√©ration est destin√©e √† emp√™cher la publication automatis√©e de commentaires par des scripts. L\'adresse IP bannie est',

## default_templates/signin.mtml
	'Sign In' => 'Connexion',
	'You are signed in as ' => 'Vous √™tes identifi√© en tant que ',
	'sign out' => 'd√©connexion',
	'You do not have permission to sign in to this blog.' => 'Vous n\'avez pas l\'autorisation de vous identifier sur ce blog.',

## default_templates/new-comment.mtml
	'An unapproved comment has been posted on your blog [_1], for entry #[_2] ([_3]). You need to approve this comment before it will appear on your site.' => 'Un commentaire non approuv√© a √©t√© envoy√© sur votre blog [_1], pour la note #[_2] ([_3]). Vous devez l\'approuver pour qu\'il apparaisse sur votre blog.',
	'A new comment has been posted on your blog [_1], on entry #[_2] ([_3]).' => 'Un nouveau commentaire a √©t√© publi√© sur votre blog [_1], au sujet de la note [_2] ([_3]). ',
	'Commenter name: [_1]' => 'Nom de l\'auteur de commentaires',
	'Commenter email address: [_1]' => 'Adresse email de l\'auteur de commentaires :  [_1]',
	'Commenter URL: [_1]' => 'URL de l\'auteur de commentaires : [_1]',
	'Commenter IP address: [_1]' => 'Adresse IP de l\'auteur de commentaires : [_1]',
	'Approve comment:' => 'Accepter le commentaire :',
	'View comment:' => 'Voir le commentaire :',
	'Edit comment:' => '√âditer le commentaire :',
	'Report comment as spam:' => 'Marquer le commentaire comme √©tant du spam :',

## default_templates/pages_list.mtml
	'Pages' => 'Pages',

## default_templates/creative_commons.mtml

## default_templates/about_this_page.mtml
	'About this Entry' => '√Ä propos de cette note',
	'About this Archive' => '√Ä propos de cette archive',
	'About Archives' => '√Ä propos des archives',
	'This page contains links to all the archived content.' => 'Cette page contient des liens vers toutes les archives.',
	'This page contains a single entry by [_1] published on <em>[_2]</em>.' => 'Cette page contient une unique note de [_1] publi√©e le <em>[_2]</em>.',
	'<a href="[_1]">[_2]</a> was the previous entry in this blog.' => '<a href="[_1]">[_2]</a> est la note pr√©c√©dente de ce blog.',
	'<a href="[_1]">[_2]</a> is the next entry in this blog.' => '<a href="[_1]">[_2]</a> est la note suivante de ce blog.',
	'This page is an archive of entries in the <strong>[_1]</strong> category from <strong>[_2]</strong>.' => 'Cette page est une archive des notes dans la cat√©gorie <strong>[_1]</strong> de <strong>[_2]</strong>.',
	'<a href="[_1]">[_2]</a> is the previous archive.' => '<a href="[_1]">[_2]</a> est l\'archive pr√©c√©dente.',
	'<a href="[_1]">[_2]</a> is the next archive.' => '<a href="[_1]">[_2]</a> est l\'archive suivante.',
	'This page is an archive of recent entries in the <strong>[_1]</strong> category.' => 'Cette page est une archive des notes r√©centes dans la cat√©gorie <strong>[_1]</strong>.',
	'<a href="[_1]">[_2]</a> is the previous category.' => '<a href="[_1]">[_2]</a> est la cat√©gorie pr√©c√©dente.',
	'<a href="[_1]">[_2]</a> is the next category.' => '<a href="[_1]">[_2]</a> est la cat√©gorie suivante.',
	'This page is an archive of recent entries written by <strong>[_1]</strong> in <strong>[_2]</strong>.' => 'Cette page est une archive des notes r√©centes √©crites par <strong>[_1]</strong> dans <strong>[_2]</strong>.',
	'This page is an archive of recent entries written by <strong>[_1]</strong>.' => 'Cette page est une archive des notes r√©centes √©crites par <strong>[_1]</strong>.',
	'This page is an archive of entries from <strong>[_2]</strong> listed from newest to oldest.' => 'Cette page est une archive des notes de <strong>[_2]</strong> list√©es de la plus r√©cente √† la plus ancienne.',
	'Find recent content on the <a href="[_1]">main index</a>.' => 'Retrouvez le contenu r√©cent sur <a href="[_1]">l\'index principal</a>.',
	'Find recent content on the <a href="[_1]">main index</a> or look in the <a href="[_2]">archives</a> to find all content.' => 'Retrouvez le contenu r√©cent sur <a href="[_1]">l\'index principal</a> ou allez dans les <a href="[_2]">archives</a> pour retrouver tout le contenu.',

## default_templates/entry.mtml

## default_templates/recover-password.mtml
	'A request has been made to change your password in Melody. To complete this process click on the link below to select a new password.' => 'Une requ√™te a √©t√© faite pour changer votre mot de passe dans Melody. Pour terminer cliquez sur le lien ci-dessous pour choisir un nouveau mot de passe.',
	'If you did not request this change, you can safely ignore this email.' => 'Si vous n\'avez pas demand√© ce changement, vous pouvez ignorer cet email.',

## default_templates/javascript.mtml
	'moments ago' => 'il y a quelques instants',
	'[quant,_1,hour,hours] ago' => 'il y a [quant,_1,heure,heures]',
	'[quant,_1,minute,minutes] ago' => 'il y a [quant,_1,minute,minutes]',
	'[quant,_1,day,days] ago' => 'il y a [quant,_1,jour,jours]',
	'Edit' => 'Editer',
	'Your session has expired. Please sign in again to comment.' => 'Votre session a expir√©. Veuillez vous identifier √† nouveau pour commenter.',
	'Signing in...' => 'Identification ...',
	'You do not have permission to comment on this blog. ([_1]sign out[_2])' => 'Vous n\'avez pas la permission de commenter sur ce blog. ([_1]d√©connexion[_2])',
	'Thanks for signing in, __NAME__. ([_1]sign out[_2])' => 'Merci de vous √™tre identifi√©(e) en tant que __NAME__. ([_1]fermer la session[_2])',
	'[_1]Sign in[_2] to comment.' => '[_1]Identifiez-vous[_2] pour commenter.',
	'[_1]Sign in[_2] to comment, or comment anonymously.' => '[_1]Identifiez-vous[_2] pour commenter, ou laissez un commentaire anonyme.',
	'Replying to <a href="[_1]" onclick="[_2]">comment from [_3]</a>' => 'En r√©ponse au <a href="[_1]" onclick="[_2]">commentaire de [_3]</a>',

## default_templates/author_archive_list.mtml
	'Authors' => 'Auteurs',

## default_templates/archive_index.mtml
	'Author Archives' => 'Archives par auteurs',

## default_templates/trackbacks.mtml
	'TrackBack URL: [_1]' => 'URL de Trackback : [_1]',
	'<a href="[_1]">[_2]</a> from [_3] on <a href="[_4]">[_5]</a>' => '<a href="[_1]">[_2]</a> depuis [_3] sur <a href="[_4]">[_5]</a>',
	'[_1] <a href="[_2]">Read More</a>' => '[_1] <a href="[_2]">Lire la suite</a>',

## default_templates/calendar.mtml
	'Monthly calendar with links to daily posts' => 'Calendrier mensuel avec des liens vers les notes du jour',
	'Sunday' => 'Dimanche',
	'Sun' => 'Dim',
	'Monday' => 'Lundi',
	'Mon' => 'Lun',
	'Tuesday' => 'Mar',
	'Tue' => 'Mar',
	'Wednesday' => 'Mercredi',
	'Wed' => 'Mer',
	'Thursday' => 'Jeudi',
	'Thu' => 'Jeu',
	'Friday' => 'Vendredi',
	'Fri' => 'Ven',
	'Saturday' => 'Samedi',
	'Sat' => 'Sam',

## default_templates/recent_entries.mtml

## default_templates/sidebar.mtml
	'2-column layout - Sidebar' => 'Mise en page √† 2 colonnes - Barre lat√©rale',
	'3-column layout - Primary Sidebar' => 'Mise en page √† 3 colonnes - Premi√®re barre lat√©rale',
	'3-column layout - Secondary Sidebar' => 'Mise en page √† 3 colonnes - Seconde barre lat√©rale',

## default_templates/openid.mtml
	'[_1] accepted here' => '[_1] est accept√©',
	'http://www.sixapart.com/labs/openid/' => 'http://www.sixapart.com/labs/openid/',
	'Learn more about OpenID' => 'Apprenez-en plus √† propos d\'OpenID',

## default_templates/powered_by.mtml
	'_MTCOM_URL' => 'http://www.movabletype.com/',

## default_templates/tag_cloud.mtml

## default_templates/commenter_confirm.mtml
	'Thank you registering for an account to comment on [_1].' => 'Merci de vous √™tre enregistr√© pour commenter sur [_1].',
	'For your own security and to prevent fraud, we ask that you please confirm your account and email address before continuing. Once confirmed you will immediately be allowed to comment on [_1].' => 'Pour votre propre s√©curit√© et pour √©viter les fraudes, nous vous demandons de confirmer votre compte et votre adresse email avant de continuer. Vous pourrez ensuite imm√©diatement commenter sur [_1].',
	'To confirm your account, please click on or cut and paste the following URL into a web browser:' => 'Pour confirmer votre compte, cliquez ou copiez-collez l\'adresse suivante dans un navigateur web:',
	'If you did not make this request, or you don\'t want to register for an account to comment on [_1], then no further action is required.' => 'Si vous n\'√™tes pas √† l\'origine de cette demande, ou si vous ne souhaitez pas vous enregistrer pour commenter sur [_1], alors aucune action n\'est n√©cessaire.',
	'Thank you very much for your understanding.' => 'Merci beaucoup pour votre compr√©hension.',
	'Sincerely,' => 'Cordialement,'

## default_templates/recent_assets.mtml

## default_templates/monthly_entry_listing.mtml

);

1;


