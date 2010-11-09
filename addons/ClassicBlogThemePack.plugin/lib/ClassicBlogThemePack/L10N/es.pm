package ClassicBlogThemePack::L10N::es;
use strict;
use ClassicBlogThemePack::L10N;
use ClassicBlogThemePack::L10N::en_us;
use vars qw( @ISA %Lexicon );
@ISA = qw( ClassicBlogThemePack::L10N::en_us );

## The following is the translation table.

%Lexicon = (
## default_templates/recover-password.mtml
    'A request has been made to change your password in Movable Type. To complete this process click on the link below to select a new password.' => 'Se ha hecho una petici√≥n para cambiar tu contrase√±a en Melody. Para terminar este proceso, has click en el siguiente link para usar una nueva contrase√±a.',
    'If you did not request this change, you can safely ignore this email.' => 'Si no solicit√≥ este cambio, ignore este mensaje.',

## default_templates/monthly_entry_listing.mtml
    'HTML Head' => 'HTML de la cabecera',
    '[_1] Archives' => 'Archivos [_1]',
    'Banner Header' => 'Logotipo de la cabecera',
    'Entry Summary' => 'Resumen de las entradas',
    'Main Index' => 'Inicio',
    'Archives' => 'Archivos',
    'Sidebar' => 'Barra lateral',
    'Banner Footer' => 'Logotipo del pie',

## default_templates/comment_throttle.mtml
    'If this was a mistake, you can unblock the IP address and allow the visitor to add it again by logging in to your Movable Type installation, going to Blog Config - IP Banning, and deleting the IP address [_1] from the list of banned addresses.' => 'Si esto ha sido un error, puede desbloquear la direcci√≥n IP y permitir al visitante registrarse nuevamente, eliminando la direcci√≥n IP [_1] en el listado de IP bloqueadas en Configuraci√≥n del Blog - Bloqueo de IP. ',
    'A visitor to your blog [_1] has automatically been banned by adding more than the allowed number of comments in the last [_2] seconds.' => 'Se bloque√≥ autom√°ticamente a una persona que visit√≥ su weblog [_1] debido a que insert√≥ m√°s comentarios de los permitidos en menos de [_2] segundos.',
    'This has been done to prevent a malicious script from overwhelming your weblog with comments. The banned IP address is' => 'Esto se hizo para impedir que nadie o nada desborde malintencionadamente su weblog con comentarios. La direcci√≥n bloqueada es',

## default_templates/search_results.mtml
    'Search Results' => 'Resultado de la b√∫squeda',
    'Results matching &ldquo;[_1]&rdquo;' => 'Resultados correspondiente a &ldquo;[_1]&rdquo;',
    'Results tagged &ldquo;[_1]&rdquo;' => 'Resultado de etiquetas &ldquo;[_1]&rdquo;',
    'Previous' => 'Anterior',
    'Next' => 'Siguiente',
    'No results found for &ldquo;[_1]&rdquo;.' => 'Ning√∫n resultado encontrado para &ldquo;[_1]&rdquo;.',
    'Instructions' => 'Instrucciones',
    'By default, this search engine looks for all words in any order. To search for an exact phrase, enclose the phrase in quotes:' => 'Por defecto, este motor de b√∫squeda comprueba todas las palabras sin tener en cuenta el orden. Para buscar una frase exacta, encierre la frase entre comillas:',
    'movable type' => 'movable type',
    'The search engine also supports AND, OR, and NOT keywords to specify boolean expressions:' => 'El motor de b√∫squeda tambi√©n soporta los operadores AND, OR y NOT para especificar expresiones l√≥gicas:',
    'personal OR publishing' => 'personal OR publicaci√≥n',
    'publishing NOT personal' => 'publicaci√≥n NOT personal',

## default_templates/commenter_notify.mtml
    'This email is to notify you that a new user has successfully registered on the blog \'[_1]\'. Listed below you will find some useful information about this new user.' => 'Este correo electr√≥nico es una notificai√≥n  para informarle que un nuevo usuario ha sido enregistrado con succeso en el blog \'[_1]\'. Abajo usted encontrat√° enumeradas algunas informaciones √∫tiles sobre este nuevo usuario.',
    'New User Information:' => 'Informaciones sobre el nuevo usuario:',
    'Username: [_1]' => 'Nombre de usuario: [_1]',
    'Full Name: [_1]' => 'Nombre Completo: [_1]',
    'Email: [_1]' => 'Correo Electr√≥nico: [_1]',
    'To view or edit this user, please click on or cut and paste the following URL into a web browser:' => 'Para ver o editar este usuario, por favor, haga clic en (o copie y pegue) la siguiente URL en un navegador:',

## default_templates/notify-entry.mtml
    'A new [lc,_3] entitled \'[_1]\' has been published to [_2].' => 'Un nuevo [lc,_3] titulado \'[_1]\' ha sido publicado en [_2].',
    'View entry:' => 'Ver entrada:',
    'View page:' => 'Ver p√°gina:',
    '[_1] Title: [_2]' => '[_1] T√≠tulo: [_2]',
    'Publish Date: [_1]' => 'Fecha de publicaci√≥n: [_1]',
    'Message from Sender:' => 'Mensaje del expeditor',
    'You are receiving this email either because you have elected to receive notifications about new content on [_1], or the author of the post thought you would be interested. If you no longer wish to receive these emails, please contact the following person:' => 'Ha recibido este correo porque seleccion√≥ recibir avisos sobre la publicaci√≥n de nuevos contenidos en [_1] o porque el autor de la entrada pens√≥ que podr√≠a serle de inter√©s. Si no quiere recibir m√°s avisos, por favor, contacte con esta persona:',

## default_templates/tag_cloud.mtml
    'Tag Cloud' => 'Nube de etiquetas',

## default_templates/search.mtml
    'Search' => 'Buscar',
    'Case sensitive' => 'Distinguir may√∫sculas y min√∫sculas',
    'Regex search' => 'Expresi√≥n regular',
    'Tags' => 'Etiquetas',
    '[_1] ([_2])' => '[_1] ([_2])',

## default_templates/creative_commons.mtml
    'This blog is licensed under a <a href="[_1]">Creative Commons License</a>.' => 'Este blog tiene una <a href="[_1]">Licencia Creative Commons</a>.',

## default_templates/powered_by.mtml
    '_MTCOM_URL' => '_MTCOM_URL',
    'Powered by Movable Type [_1]' => 'Powered by Melody [_1]',

## default_templates/recent_assets.mtml
    'Recent Assets' => 'Multimedia reciente',

## default_templates/entry.mtml
    'By [_1] on [_2]' => 'Por [_1] el [_2]',
    '1 Comment' => '1 comentario',
    '# Comments' => '# comentarios',
    'No Comments' => 'Sin comentarios',
    '1 TrackBack' => '1 TrackBack',
    '# TrackBacks' => '# TrackBacks',
    'No TrackBacks' => 'Sin trackbacks',
    'Categories' => 'Categor√≠as',
    'Trackbacks' => 'Trackbacks',
    'Comments' => 'Comentarios',

## default_templates/author_archive_list.mtml
    'Authors' => 'Autores',

## default_templates/new-ping.mtml
    'An unapproved TrackBack has been posted on your blog [_1], for entry #[_2] ([_3]). You need to approve this TrackBack before it will appear on your site.' => 'Se ha recibido un TrackBack en el blog [_1], en la entrada #[_2] ([_3]). Debe aprobarlo para que aparezca en el sitio.',
    'An unapproved TrackBack has been posted on your blog [_1], for category #[_2], ([_3]). You need to approve this TrackBack before it will appear on your site.' => 'Se ha recibido un TrackBack en el blog [_1], en la categor√≠a #[_2], ([_3]). Debe aprobar este TrackBack antes de que aparezca en su sitio.',
    'A new TrackBack has been posted on your blog [_1], on entry #[_2] ([_3]).' => 'Se ha recibido un nuevo TrackBack en el blog [_1], en la entrada #[_2] ([_3]).',
    'A new TrackBack has been posted on your blog [_1], on category #[_2] ([_3]).' => 'Se ha recibido un nuevo TrackBack en el blog [_1], en la categor√≠a #[_2] ([_3]).',
    'Excerpt' => 'Resumen',
    'URL' => 'URL',
    'Title' => 'T√≠tulo',
    'Blog' => 'Blog',
    'IP address' => 'Direcci√≥n IP',
    'Approve TrackBack' => 'Aprobar TrackBack',
    'View TrackBack' => 'Ver TrackBack',
    'Report TrackBack as spam' => 'Marcar TrackBack como spam',
    'Edit TrackBack' => 'Editar TrackBack',

## default_templates/new-comment.mtml
    'An unapproved comment has been posted on your blog [_1], for entry #[_2] ([_3]). You need to approve this comment before it will appear on your site.' => 'Se recibi√≥ un comentario en su blog [_1], en la entrada n¬∫[_2] ([_3]). Debe aprobar este comentario para que aparezca en su sitio.',
    'A new comment has been posted on your blog [_1], on entry #[_2] ([_3]).' => 'Se public√≥ un nuevo comentario en su weblog [_1], en la entrada n¬∫ [_2] ([_3]).',
    'Commenter name: [_1]' => 'Nombre del comentarista',
    'Commenter email address: [_1]' => 'Correo electr√≥nico del comentarista: [_1]',
    'Commenter URL: [_1]' => 'URL del comentarista: [_1]',
    'Commenter IP address: [_1]' => 'Direcci√≥n IP del comentarista: [_1]',
    'Approve comment:' => 'Comentario aceptado:',
    'View comment:' => 'Ver comentario:',
    'Edit comment:' => 'Editar comentario:',
    'Report comment as spam:' => 'Reportar el comentario como spam:',

## default_templates/comment_preview.mtml
    'Previewing your Comment' => 'Vista previa del comentario',
    '[_1] replied to <a href="[_2]">comment from [_3]</a>' => '[_1] respondi√≥ al <a href="[_2]">comentario de [_3]</a>',
    'Leave a comment' => 'Escribir un comentario',
    'Name' => 'Nombre',
    'Email Address' => 'Direcci√≥n de correo electr√≥nico',
    'Replying to comment from [_1]' => 'Respondiendo al comentario de [_1]',
    '(You may use HTML tags for style)' => '(Puede usar etiquetas HTML para el estilo)',
    'Preview' => 'Vista previa',
    'Submit' => 'Enviar',
    'Cancel' => 'Cancelar',

## default_templates/commenter_confirm.mtml
    'Thank you registering for an account to comment on [_1].' => 'Gracias por registrar una cuenta para comentar en [_1].',
    'For your own security and to prevent fraud, we ask that you please confirm your account and email address before continuing. Once confirmed you will immediately be allowed to comment on [_1].' => 'Para su propia seguridad, y para prevenir fraudes, antes de continuar le solicitamos que confirme su cuenta y direcci√≥n de correo. Tras confirmarlas, podr√° comentar en [_1].',
    'To confirm your account, please click on or cut and paste the following URL into a web browser:' => 'Para confirmar su cuenta, haga clic en (o copie y pegue) la URL en un navegador web:',
    'If you did not make this request, or you don\'t want to register for an account to comment on [_1], then no further action is required.' => 'Si no realiz√≥ esta petici√≥n, o no quiere registrar una cuenta para comentar en [_1], no se necesitan m√°s acciones.',
    'Thank you very much for your understanding.' => 'Gracias por su comprensi√≥n.',
    'Sincerely,' => 'Cordialmente,',

## default_templates/trackbacks.mtml
    'TrackBack URL: [_1]' => 'URL de TrackBack: [_1]',
    '<a href="[_1]">[_2]</a> from [_3] on <a href="[_4]">[_5]</a>' => '<a href="[_1]">[_2]</a> desde [_3] en <a href="[_4]">[_5]</a>',
    '[_1] <a href="[_2]">Read More</a>' => '[_1] <a href="[_2]">Leer m√°s</a>',

## default_templates/footer-email.mtml

## default_templates/calendar.mtml
    'Monthly calendar with links to daily posts' => 'Calendario mensual con enlaces a los archivos diarios',
    'Sunday' => 'Domingo',
    'Sun' => 'Dom',
    'Monday' => 'Lunes',
    'Mon' => 'Lun',
    'Tuesday' => 'Martes',
    'Tue' => 'Mar',
    'Wednesday' => 'Mi√©rcoles',
    'Wed' => 'Mi√©',
    'Thursday' => 'Jueves',
    'Thu' => 'Jue',
    'Friday' => 'Viernes',
    'Fri' => 'Vie',
    'Saturday' => 'S√°bado',
    'Sat' => 'S√°b',

## default_templates/date_based_category_archives.mtml
    'Category Yearly Archives' => 'Archivos anuales por categor√≠a',
    'Category Monthly Archives' => 'Archivos mensuales por categor√≠as',
    'Category Weekly Archives' => 'Archivos semanales por categor√≠a',
    'Category Daily Archives' => 'Archivos diarios por categor√≠a',

## default_templates/comment_listing_dynamic.mtml
    'Comment Detail' => 'Detalle del comentario',

## default_templates/current_category_monthly_archive_list.mtml
    '[_1]: Monthly Archives' => '[_1]: Archivos mensuales',
    '[_1]' => '[_1]',

## default_templates/comment_response.mtml
    'Confirmation...' => 'Confirmaci√≥n...',
    'Your comment has been submitted!' => '¬°El comentario se ha recibido!',
    'Thank you for commenting.' => 'Gracias por comentar.',
    'Your comment has been received and held for approval by the blog owner.' => 'El comentario que envi√≥ fue recibido y est√° retenido para su aprobaci√≥n por parte del administrador del weblog.',
    'Comment Submission Error' => 'Error en el env√≠o de comentarios',
    'Your comment submission failed for the following reasons: [_1]' => 'El env√≠o del comentario fall√≥ por alguna de las siguientes razones: [_1]',
    'Return to the <a href="[_1]">original entry</a>.' => 'Volver a la <a href="[_1]">entrada original</a>.',

## default_templates/about_this_page.mtml
    'About this Entry' => 'Sobre esta entrada',
    'About this Archive' => 'Sobre este archivo',
    'About Archives' => 'Sobre los archivos',
    'This page contains links to all the archived content.' => 'Esta p√°gina contiene enlaces a todos los contenidos archivados.',
    'This page contains a single entry by [_1] published on <em>[_2]</em>.' => 'Esta p√°gina contiene una sola entrada realizada por [_1] y publicada el <em>[_2]</em>.',
    '<a href="[_1]">[_2]</a> was the previous entry in this blog.' => '<a href="[_1]">[_2]</a> es la entrada anterior en este blog.',
    '<a href="[_1]">[_2]</a> is the next entry in this blog.' => '<a href="[_1]">[_2]</a> es la entrada siguiente en este blog.',
    'This page is an archive of entries in the <strong>[_1]</strong> category from <strong>[_2]</strong>.' => 'Esta p√°gina es un archivo de las entradas en la categor√≠a <strong>[_1]</strong> de <strong>[_2]</strong>.',
    '<a href="[_1]">[_2]</a> is the previous archive.' => '<a href="[_1]">[_2]</a> es el archivo anterior.',
    '<a href="[_1]">[_2]</a> is the next archive.' => '<a href="[_1]">[_2]</a> es el siguiente archivo.',
    'This page is an archive of recent entries in the <strong>[_1]</strong> category.' => 'Esta p√°gina es un archivo de las √∫ltimas entradas en la categor√≠a <strong>[_1]</strong>.',
    '<a href="[_1]">[_2]</a> is the previous category.' => '<a href="[_1]">[_2]</a> es la categor√≠a anterior.',
    '<a href="[_1]">[_2]</a> is the next category.' => '<a href="[_1]">[_2]</a> es la siguiente categor√≠a.',
    'This page is an archive of recent entries written by <strong>[_1]</strong> in <strong>[_2]</strong>.' => 'Esta p√°gina es un archivo de las √∫ltimas entradas escritas por <strong>[_1]</strong> en <strong>[_2]</strong>.',
    'This page is an archive of recent entries written by <strong>[_1]</strong>.' => 'Esta p√°gina es un archivo de las √∫ltimas entradas escritas por <strong>[_1]</strong>.',
    'This page is an archive of entries from <strong>[_2]</strong> listed from newest to oldest.' => 'Esta p√°gina es un archivo de las entradas de <strong>[_2]</strong>, ordenadas de nuevas a antiguas.',
    'Find recent content on the <a href="[_1]">main index</a>.' => 'Encontrar√° los contenidos recientes en la <a href="[_1]">p√°gina principal</a>.',
    'Find recent content on the <a href="[_1]">main index</a> or look in the <a href="[_2]">archives</a> to find all content.' => 'Encontrar√° los contenidos recientes en la <a href="[_1]">p√°gina principal</a>. Consulte los <a href="[_2]">archivos</a> para ver todos los contenidos.',

## default_templates/javascript.mtml
    'moments ago' => 'hace unos momentos',
    '[quant,_1,hour,hours] ago' => 'hace [quant,_1,hora,horas]',
    '[quant,_1,minute,minutes] ago' => 'hace [quant,_1,minute,minutes]',
    '[quant,_1,day,days] ago' => 'hace [quant,_1,d√≠a,d√≠as]',
    'Edit' => 'Editar',
    'Your session has expired. Please sign in again to comment.' => 'La sesi√≥n ha caducado. Por favor, identif√≠quese de nuevo para comentar.',
    'Signing in...' => 'Iniciando sesi√≥n...',
    'You do not have permission to comment on this blog. ([_1]sign out[_2])' => 'No tiene permisos para comentar en este blog ([_1]cerrar sesi√≥n[_2])',
    'Thanks for signing in, __NAME__. ([_1]sign out[_2])' => 'Gracias por identificarse, __NAME__. ([_1]salir[_2])',
    '[_1]Sign in[_2] to comment.' => '[_1]Iniciar una sesi√≥n[_2].',
    '[_1]Sign in[_2] to comment, or comment anonymously.' => 'Para comentar [_1]inicie una sesi√≥n[_2] o h√°galo de forma an√≥nima.',
    'Replying to <a href="[_1]" onclick="[_2]">comment from [_3]</a>' => 'Respondiendo al <a href="[_1]" onclick="[_2]">comentario de [_3]</a>',

## default_templates/comments.mtml
    'Older Comments' => 'M√°s antiguos',
    'Newer Comments' => 'M√°s recientes',
    'The data is modified by the paginate script' => 'Los datos est√°n modificados por el script de paginaci√≥n',
    'Remember personal info?' => '¬øRecordar datos personales?',

## default_templates/dynamic_error.mtml
    'Page Not Found' => 'P√°gina no encontrada',

## default_templates/recent_comments.mtml
    'Recent Comments' => 'Comentarios recientes',
    '<strong>[_1]:</strong> [_2] <a href="[_3]" title="full comment on: [_4]">read more</a>' => '<strong>[_1]:</strong> [_2] <a href="[_3]" title="comentario completo en: [_4]">m√°s</a>',

## default_templates/current_author_monthly_archive_list.mtml

## default_templates/comment_detail.mtml

## default_templates/archive_widgets_group.mtml
    'This is a custom set of widgets that are conditioned to serve different content based upon what type of archive it is included. More info: [_1]' => 'Conjunto personalizado de widgets creado para mostrar contenidos diferentes seg√∫n el tipo de archivo que incluye. M√°s informaci√≥n: [_1]',
    'Current Category Monthly Archives' => 'Archivos mensuales de la categor√≠a actual',
    'Category Archives' => 'Archivos por categor√≠a',
    'Monthly Archives' => 'Archivos mensuales',

## default_templates/category_archive_list.mtml

## default_templates/sidebar.mtml
    '2-column layout - Sidebar' => 'Disposici√≥n a 2 columnas - Barra lateral',
    '3-column layout - Primary Sidebar' => 'Disposici√≥n a 3 columnas - Barra lateral principal',
    '3-column layout - Secondary Sidebar' => 'Disposici√≥n a 3 columnas - Barra lateral secundaria',

## default_templates/monthly_archive_list.mtml
    '[_1] <a href="[_2]">Archives</a>' => '<a href="[_2]">Archivos</a> [_1]',

## default_templates/monthly_archive_dropdown.mtml
    'Select a Month...' => 'Seleccione un mes...',

## default_templates/category_entry_listing.mtml
    'Recently in <em>[_1]</em> Category' => 'Novedades en la categor√≠a <em>[_1]</em>',

## default_templates/openid.mtml
    '[_1] accepted here' => '[_1] aceptado aqu√≠',
    'http://www.sixapart.com/labs/openid/' => 'http://www.sixapart.com/labs/openid/',
    'Learn more about OpenID' => 'M√°s informaci√≥n sobre OpenID',

## default_templates/verify-subscribe.mtml
    'Thanks for subscribing to notifications about updates to [_1]. Follow the link below to confirm your subscription:' => 'Gracias por suscribirse a las notificaciones sobre actualizaciones en [_1]. Siga el enlace de abajo para confirmar su suscripci√≥n:',
    'If the link is not clickable, just copy and paste it into your browser.' => 'Si no puede hacer clic en el enlace, copie y p√©guelo en su navegador.',

## default_templates/main_index_widgets_group.mtml
    'This is a custom set of widgets that are conditioned to only appear on the homepage (or "main_index"). More info: [_1]' => 'Este es un conjunto personalizado de widgets creados para aparecer solo en la p√°gina de inicio (o "main_index"). M√°s informaci√≥n: [_1]',
    'Recent Entries' => 'Entradas recientes',

## default_templates/signin.mtml
    'Sign In' => 'Registrarse',
    'You are signed in as ' => 'Se identific√≥ como ',
    'sign out' => 'salir',
    'You do not have permission to sign in to this blog.' => 'No tiene permisos para identificarse en este blog.',

## default_templates/date_based_author_archives.mtml
    'Author Yearly Archives' => 'Archivos anuales por autor',
    'Author Monthly Archives' => 'Archivos mensuales por autores',
    'Author Weekly Archives' => 'Archivos semanales por autor',
    'Author Daily Archives' => 'Archivos diarios por autor',

## default_templates/technorati_search.mtml
    'Technorati' => 'Technorati',
    '<a href=\'http://www.technorati.com/\'>Technorati</a> search' => 'B√∫squeda en <a href=\'http://www.technorati.com/\'>Technorati</a>',
    'this blog' => 'este blog',
    'all blogs' => 'todos los blogs',
    'Blogs that link here' => 'Blogs que enlazan aqu√≠',

## default_templates/page.mtml

## default_templates/pages_list.mtml
    'Pages' => 'P√°ginas',

## default_templates/main_index.mtml

## default_templates/comment_listing.mtml

## default_templates/recent_entries.mtml

## default_templates/entry_summary.mtml
    'Continue reading <a href="[_1]" rel="bookmark">[_2]</a>.' => 'Contin√∫e leyendo <a href="[_1]" rel="bookmark">[_2]</a>.',

## default_templates/banner_footer.mtml
    '_POWERED_BY' => 'Powered by<br /><a href="http://www.movabletype.org/sitees/"><MTProductName></a>',

## default_templates/archive_index.mtml
    'Author Archives' => 'Archivos por autor',

## default_templates/syndication.mtml
    'Subscribe to feed' => 'Suscribirse a la fuente de sindicaci√≥n',
    'Subscribe to this blog\'s feed' => 'Suscribirse a este blog (XML)',
    'Subscribe to a feed of all future entries tagged &ldquo;[_1]&ldquo;' => 'Suscribirse a las entradas etiquetadas con &ldquo;[_1]&ldquo;',
    'Subscribe to a feed of all future entries matching &ldquo;[_1]&ldquo;' => 'Subscribirse a las entradas que coinciden con &ldquo;[_1]&ldquo;',
    'Feed of results tagged &ldquo;[_1]&ldquo;' => 'Sindicaci√≥n de los resultados etiquetados con &ldquo;[_1]&ldquo;',
    'Feed of results matching &ldquo;[_1]&ldquo;' => 'Sindicaci√≥n de los resultados que coinciden con &ldquo;[_1]&ldquo;'
);

1;


