#	Русский локализационный файл для Movable Type 4.32
#
#	Автор перевода: Андрей Серебряков <http://saahov.ru/>
#
#	Благодарности:
#	 — Тихон (Mscreen) — за помощь в переводе
#	 — Владимир Замятин — за помощь в переводе
#
#	Отдельное спасибо Алексею Демидову <http://alexd.vinf.ru>
#	за автоматизацию процесса перевода
#	и доработку функции, отвечающей за множественное число.
#
#	Дата публикации файла: 14 октября 2009 года.
#	Последнее изменение: см. последнюю строку комментариев.
#
#	Перевод распространяется по лицензии GNU General Public License v2
#	http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
#
# $Id:$

package MT::L10N::ru;
use strict;
use MT::L10N;
use MT::L10N::en_us;
use vars qw( @ISA %Lexicon );
@ISA = qw( MT::L10N::en_us );

sub quant {
    my ( $handle, $num, @forms ) = @_;

    return $num if @forms == 0;    # what should this mean?

    # Note that the formatting of $num is preserved.
    return ( $handle->numf($num) . ' ' . $handle->numerate( $num, @forms ) );

    # Most human languages put the number phrase before the qualified phrase.
}

sub numerate {

    # return this lexical item in a form appropriate to this number
    my ( $handle, $num, @forms ) = @_;
    my $s = ( $num == 1 );

    return '' unless @forms;

    return $forms[0] if $num =~ /^([0-9]*?[02-9])?1$/;
    return $forms[0] if ( @forms == 1 );

    return $forms[1] if $num =~ /^([0-9]*?[02-9])?[234]$/;
    return $forms[1] if ( @forms == 2 );
    return $forms[2];
}

## The following is the translation table.

%Lexicon = (

## php/mt.php.pre
    'Page not found - [_1]' => 'Страница не найдена',

## php/lib/captcha_lib.php
    'Captcha' => 'Captcha',
    'Type the characters you see in the picture above.' =>
      'Введите изображённые на картинке символы.',

## php/lib/function.mtwidgetmanager.php
    'Error: widgetset [_1] is empty.' =>
      'Ошибка: связка виджетов [_1] пустая.',
    'Error compiling widgetset [_1]' =>
      'Ошибка при компиляции связки виджетов [_1]',

## php/lib/function.mtsetvar.php
    'You used a [_1] tag without a valid name attribute.' =>
      'Вы использовали тег [_1] без допустимого имени атрибута.',
    '\'[_1]\' is not a hash.'   => '«[_1]» — это не хэш.',
    'Invalid index.'            => 'Неправильный индекс.',
    '\'[_1]\' is not an array.' => '«[_1]» — это не массив.',
    '[_1] [_2] [_3] is illegal.' =>
      '[_1] [_2] [_3] — это недопустимо.',
    '\'[_1]\' is not a valid function.' =>
      '«[_1]» — это неправильная функция.',

## php/lib/function.mtremotesigninlink.php
    'TypePad authentication is not enabled in this blog.  MTRemoteSignInLink can\'t be used.'
      => 'Авторизация через TypePad не включена в этом блоге. MTRemoteSignInLink не может быть использована',

## php/lib/function.mtvar.php
    '\'[_1]\' is not a valid function for a hash.' =>
      '«[_1]» — это неправильная функция для хэша.',
    '\'[_1]\' is not a valid function for an array.' =>
      '«[_1]» — это неправильная функция для массива.',

## php/lib/block.mtauthorhasentry.php
    'No author available' => 'Нет такого автора',

## php/lib/thumbnail_lib.php
    'GD support has not been available. Please install GD support.' =>
      'Поддержка GD недоступна. Пожалуйста, установите её.',

## php/lib/function.mtauthordisplayname.php
    '(Display Name not set)' =>
      '(Отображаемое имя не указано)',

## php/lib/function.mtentryclasslabel.php
    'page'  => 'страница',
    'entry' => 'запись',
    'Page'  => 'Страница',
    'Entry' => 'Запись',

## php/lib/block.mtentries.php
    'sort_by="score" must be used in combination with namespace.' =>
      'sort_by="score" должен использоваться в сочетании с namespace.',

## php/lib/archive_lib.php
    'Individual'       => 'Индивидуальный',
    'Yearly'           => 'Годовой',
    'Monthly'          => 'Месячный',
    'Daily'            => 'Дневной',
    'Weekly'           => 'Недельный',
    'Author'           => 'Авторский',
    'Author Yearly'    => 'Авторский за год',
    'Author Monthly'   => 'Авторский за месяц',
    'Author Daily'     => 'Авторский за день',
    'Author Weekly'    => 'Авторский за неделю',
    'Category Yearly'  => 'Категория за год',
    'Category Monthly' => 'Категория за месяц',
    'Category Daily'   => 'Категория за день',
    'Category Weekly'  => 'Категория за неделю',

## php/lib/function.mtcommentauthorlink.php
    'Anonymous' => 'Аноним',

## php/lib/function.mtproductname.php
    '[_1] [_2]' => '[_1] [_2]',

## php/lib/block.mtauthorhaspage.php

## php/lib/function.mtassettype.php
    'image' => 'изображение',
    'Image' => 'Изображение',
    'file'  => 'файл',
    'File'  => 'Файл',
    'audio' => 'аудио',
    'Audio' => 'Аудио',
    'video' => 'видео',
    'Video' => 'Видео',

## php/lib/block.mtassets.php

## php/lib/function.mtcommentauthor.php

## php/lib/MTUtil.php
    'userpic-[_1]-%wx%h%x' => 'userpic-[_1]-%wx%h%x',

## php/lib/block.mtif.php

## php/lib/block.mtsetvarblock.php

## php/lib/function.mtcommentreplytolink.php
    'Reply' => 'Ответить',

## php/lib/block.mtsethashvar.php

## default_templates/creative_commons.mtml
    'This blog is licensed under a <a href="[_1]">Creative Commons License</a>.'
      => 'Содержимое блога распространяется в соответствии с лицензией <a href="[_1]">Creative Commons</a>.',

## default_templates/tag_cloud.mtml
    'Tag Cloud' => 'Облако тегов',

## default_templates/commenter_notify.mtml
    'This email is to notify you that a new user has successfully registered on the blog \'[_1]\'. Listed below you will find some useful information about this new user.'
      => 'На вашем сайте «[_1]» зарегистрировался новый пользователь. Ниже представлена некоторая информация о нём:',
    'New User Information:' =>
      'Информация о новом пользователе:',
    'Username: [_1]'  => 'Логин: [_1]',
    'Full Name: [_1]' => 'Полное имя: [_1]',
    'Email: [_1]'     => 'Email: [_1]',
    'To view or edit this user, please click on or cut and paste the following URL into a web browser:'
      => 'Для просмотра или редактирования пользователя, перейдите по следующей ссылке:',

## default_templates/about_this_page.mtml
    'About this Entry'   => 'Об этой записи',
    'About this Archive' => 'Об архиве',
    'About Archives'     => 'Об архивах',
    'This page contains links to all the archived content.' =>
      'Эта страница содержит ссылки на все архивы.',
    'This page contains a single entry by [_1] published on <em>[_2]</em>.' =>
      'Сообщение опубликовано <em>[_2]</em>. Автор — [_1].',
    '<a href="[_1]">[_2]</a> was the previous entry in this blog.' =>
      'Предыдущая запись — <a href="[_1]">[_2]</a>',
    '<a href="[_1]">[_2]</a> is the next entry in this blog.' =>
      'Следующая запись — <a href="[_1]">[_2]</a>',
    'This page is an archive of entries in the <strong>[_1]</strong> category from <strong>[_2]</strong>.'
      => 'Эта страница содержит записи из категории <strong>[_1]</strong> за <strong>[_2]</strong>.',
    '<a href="[_1]">[_2]</a> is the previous archive.' =>
      '<a href="[_1]">[_2]</a> — предыдущий архив.',
    '<a href="[_1]">[_2]</a> is the next archive.' =>
      '<a href="[_1]">[_2]</a> — следующий архив.',
    'This page is an archive of recent entries in the <strong>[_1]</strong> category.'
      => 'Эта страница содержит последние записи категории <strong>[_1]</strong>.',
    '<a href="[_1]">[_2]</a> is the previous category.' =>
      'Предыдущая категория — <a href="[_1]">[_2]</a>.',
    '<a href="[_1]">[_2]</a> is the next category.' =>
      'Следующая категория — <a href="[_1]">[_2]</a>.',
    'This page is an archive of recent entries written by <strong>[_1]</strong> in <strong>[_2]</strong>.'
      => 'Эта страница содержит последние записи, созданные автором <strong>[_1]</strong> (<strong>[_2]</strong>).',
    'This page is an archive of recent entries written by <strong>[_1]</strong>.'
      => 'Эта страница содержит последние записи, созданные автором <strong>[_1]</strong>.',
    'This page is an archive of entries from <strong>[_2]</strong> listed from newest to oldest.'
      => 'Страница содержит архив записей за <strong>[_2]</strong>, расположенных по убыванию.',
    'Find recent content on the <a href="[_1]">main index</a>.' =>
      'Смотрите новые записи <a href="[_1]">главной странице</a>.',
    'Find recent content on the <a href="[_1]">main index</a> or look in the <a href="[_2]">archives</a> to find all content.'
      => 'Смотрите новые записи на <a href="[_1]">главной странице</a> или загляните в <a href="[_2]">архив</a>, где есть ссылки на все сообщения.',

## default_templates/technorati_search.mtml
    'Technorati' => 'Technorati',
    '<a href=\'http://www.technorati.com/\'>Technorati</a> search' =>
      'Поиск <a href=\'http://www.technorati.com/\'>Technorati</a> ',
    'this blog'            => 'в этом блоге',
    'all blogs'            => 'во всех блогах',
    'Search'               => 'Найти',
    'Blogs that link here' => 'Ссылающиеся блоги',

## default_templates/monthly_archive_dropdown.mtml
    'Archives'          => 'Архивы',
    'Select a Month...' => 'Выберите месяц…',

## default_templates/comments.mtml
    '1 Comment'      => '1 комментарий',
    '# Comments'     => 'Комментариев: #',
    'No Comments'    => 'Нет комментариев',
    'Older Comments' => 'Предыдущие комментарии',
    'Newer Comments' => 'Следующие комментарии',
    'Comment Detail' => 'Детали комментария',
    'The data is modified by the paginate script' =>
      'Данные изменены скриптом пейджинации',
    'Leave a comment'         => 'Комментировать',
    'Name'                    => 'Имя',
    'Email Address'           => 'Email',
    'URL'                     => 'Сайт',
    'Remember personal info?' => 'Запомнить меня?',
    'Comments'                => 'Комментарии',
    '(You may use HTML tags for style)' =>
      '(Можно использовать некоторые HTML теги для форматирования)',
    'Preview' => 'Просмотр',
    'Submit'  => 'Отправить',

## default_templates/notify-entry.mtml
    'A new [lc,_3] entitled \'[_1]\' has been published to [_2].' =>
      'В блоге «[_2]» опубликована новая [lc,_3] «[_1]».',
    'View entry:'        => 'Посмотреть запись:',
    'View page:'         => 'Посмотреть страницу:',
    '[_1] Title: [_2]'   => 'Заголовок: [_2]',
    'Publish Date: [_1]' => 'Дата публикации: [_1]',
    'Message from Sender:' =>
      'Сообщение от отправителя:',
    'You are receiving this email either because you have elected to receive notifications about new content on [_1], or the author of the post thought you would be interested. If you no longer wish to receive these emails, please contact the following person:'
      => 'Вы получили это письмо, так как подписались на получение уведомлений о новом контенте на сайте «[_1]», или автор посчитал, что вам будет это интересно. Если вы не желаете получать подобные уведомления, пожалуйста, свяжитесь с отправителем:',

## default_templates/footer-email.mtml
    'Powered by Melody [_1]' => 'Работает на Melody [_1]',

## default_templates/date_based_author_archives.mtml
    'Author Yearly Archives' =>
      'Ежегодные архивы авторов',
    'Author Monthly Archives' =>
      'Архивы авторов по месяцам',
    'Author Weekly Archives' =>
      'Еженедельные архивы авторов',
    'Author Daily Archives' =>
      'Ежедневные архивы авторов',

## default_templates/entry_summary.mtml
    'By [_1] on [_2]' => 'Автор: [_1] — [_2]',
    '1 TrackBack'     => '1 трекбэк',
    '# TrackBacks'    => 'Трекбэков: #',
    'No TrackBacks'   => 'Нет трекбэков',
    'Tags'            => 'Теги',
    'Continue reading <a href="[_1]" rel="bookmark">[_2]</a>.' =>
      'Читать дальше «<a href="[_1]" rel="bookmark">[_2] &rarr;</a>»',

## default_templates/calendar.mtml
    'Monthly calendar with links to daily posts' =>
      'Календарь на месяц со ссылками на отдельные сообщения',
    'Sunday'    => 'Воскресенье',
    'Sun'       => 'Вс',
    'Monday'    => 'Понедельник',
    'Mon'       => 'Пн',
    'Tuesday'   => 'Вторник',
    'Tue'       => 'Вт',
    'Wednesday' => 'Среда',
    'Wed'       => 'Ср',
    'Thursday'  => 'Четверг',
    'Thu'       => 'Чт',
    'Friday'    => 'Пятница',
    'Fri'       => 'Пт',
    'Saturday'  => 'Суббота',
    'Sat'       => 'Сб',

## default_templates/category_entry_listing.mtml
    'HTML Head'     => 'HTML Head',
    '[_1] Archives' => 'Архив [_1]',
    'Banner Header' => 'Шапка сайта',
    'Recently in <em>[_1]</em> Category' =>
      'Последнее в категории <em>[_1]</em>',
    'Entry Summary' => 'Общий вид записи',
    'Main Index'    => 'Главная страница',
    'Sidebar'       => 'Боковое меню',
    'Banner Footer' => 'Подвал',

## default_templates/pages_list.mtml
    'Pages' => 'Страницы',

## default_templates/archive_index.mtml
    'Monthly Archives' => 'Архивы по месяцам',
    'Categories'       => 'Категории',
    'Author Archives'  => 'Архивы авторов',
    'Category Monthly Archives' =>
      'Архивы категорий по месяцам',

## default_templates/search.mtml
    'Case sensitive' => 'Учитывать регистр',
    'Regex search'   => 'С регулярными выражениями',
    '[_1] ([_2])'    => '[_1] ([_2])',

## default_templates/trackbacks.mtml
    'TrackBack URL: [_1]' => 'URL для трекбэков: [_1]',
    '<a href="[_1]">[_2]</a> from [_3] on <a href="[_4]">[_5]</a>' =>
      '<a href="[_1]">[_2]</a> от «[_3]» — <a href="[_4]">[_5]</a>',
    '[_1] <a href="[_2]">Read More</a>' =>
      '[_1] <a href="[_2]">Читать дальше</a>',

## default_templates/recent_assets.mtml
    'Recent Assets' => 'Последнее медиа',

## default_templates/openid.mtml
    '[_1] accepted here' => '[_1] принимается здесь',
    'http://www.sixapart.com/labs/openid/' =>
      'http://www.sixapart.com/labs/openid/',
    'Learn more about OpenID' => 'Узнать больше об OpenID',

## default_templates/recent_comments.mtml
    'Recent Comments' => 'Последние комментарии',
    '<strong>[_1]:</strong> [_2] <a href="[_3]" title="full comment on: [_4]">read more</a>'
      => '<strong>[_1]:</strong> [_2] <a href="[_3]" title="полный комментарий: [_4]">читать дальше</a>',

## default_templates/dynamic_error.mtml
    'Page Not Found' => 'Страница не найдена',

## default_templates/monthly_entry_listing.mtml

## default_templates/main_index_widgets_group.mtml
    'This is a custom set of widgets that are conditioned to only appear on the homepage (or "main_index"). More info: [_1]'
      => 'Это произвольный набор виджетов, что обуславливает его включение только на домашней странице (или «main_index»). Дополнительная информация: [_1]',
    'Recent Entries' => 'Последние записи',

## default_templates/banner_footer.mtml
    '_POWERED_BY' =>
      'Работает на<br /><a href="http://www.movabletype.org/"><$MTProductName$></a>',

## default_templates/page.mtml
    'Trackbacks' => 'Трекбэки',

## default_templates/comment_throttle.mtml
    'If this was a mistake, you can unblock the IP address and allow the visitor to add it again by logging in to your Melody installation, going to Blog Config - IP Banning, and deleting the IP address [_1] from the list of banned addresses.'
      => 'Если произошла ошибка, вы можете разблокировать IP адрес. Для этого зайдите в Melody, перейдите к настройке блога — Блокировка IP, а затем удалите адрес [_1] из списка заблокированных.',
    'A visitor to your blog [_1] has automatically been banned by adding more than the allowed number of comments in the last [_2] seconds.'
      => 'Посетитель вашего блога «[_1]» был автоматически заблокирован, так как пытался добавить больше позволенного количества комментариев за [quant,_2,секунду,секунды,секунд].',
    'This has been done to prevent a malicious script from overwhelming your weblog with comments. The banned IP address is'
      => 'Это сделано для того, чтобы предотвратить засорение блога комментариями, добавляемыми автоматически с помощью специальных программ (спам-ботов).',

## default_templates/current_category_monthly_archive_list.mtml
    '[_1]: Monthly Archives' => '[_1]: архив за месяц',
    '[_1]'                   => '[_1]',

## default_templates/main_index.mtml

## default_templates/monthly_archive_list.mtml
    '[_1] <a href="[_2]">Archives</a>' =>
      '<a href="[_2]">Архивы</a> [_1]',

## default_templates/powered_by.mtml
    '_MTCOM_URL' => 'http://openmelody.org/',

## default_templates/category_archive_list.mtml

## default_templates/comment_response.mtml
    'Confirmation...' => 'Подтверждение…',
    'Your comment has been submitted!' =>
      'Ваш комментарий добавлен!',
    'Thank you for commenting.' =>
      'Спасибо за комментарий.',
    'Your comment has been received and held for approval by the blog owner.'
      => 'Ваш комментарий добавлен, но прежде, чем он будет опубликован, он должен быть проверен владельцем блога.',
    'Comment Submission Error' =>
      'Ошибка при добавлении комментария',
    'Your comment submission failed for the following reasons: [_1]' =>
      'Ваш комментарий не добавлен по следующим причинам: [_1]',
    'Return to the <a href="[_1]">original entry</a>.' =>
      'Вернуться к <a href="[_1]">записи</a>.',

## default_templates/current_author_monthly_archive_list.mtml

## default_templates/date_based_category_archives.mtml
    'Category Yearly Archives' =>
      'Архивы категорий по месяцам',
    'Category Weekly Archives' =>
      'Архивы категорий по неделям',
    'Category Daily Archives' =>
      'Архивы категорий по дням',

## default_templates/new-ping.mtml
    'An unapproved TrackBack has been posted on your blog [_1], for entry #[_2] ([_3]). You need to approve this TrackBack before it will appear on your site.'
      => 'На блог «[_1]» прислан трекбэк, к записи #[_2] ([_3]). Чтобы он появился в вашем блоге, необходимо его одобрить.',
    'An unapproved TrackBack has been posted on your blog [_1], for category #[_2], ([_3]). You need to approve this TrackBack before it will appear on your site.'
      => 'На блог «[_1]» прислан трекбэк, к категории #[_2], ([_3]). Чтобы он появился в вашем блоге, его необходимо одобрить.',
    'A new TrackBack has been posted on your blog [_1], on entry #[_2] ([_3]).'
      => 'На блог «[_1]» прислан новый трекбэк, к записи #[_2] ([_3]).',
    'A new TrackBack has been posted on your blog [_1], on category #[_2] ([_3]).'
      => 'На блог «[_1]» прислан новый трекбэк, к категории #[_2] ([_3]).',
    'Excerpt'           => 'Выдержка',
    'Title'             => 'Заголовок',
    'Blog'              => 'Блог',
    'IP address'        => 'IP адрес',
    'Approve TrackBack' => 'Одобрить трекбэк',
    'View TrackBack'    => 'Посмотреть трекбэк',
    'Report TrackBack as spam' =>
      'Пометить трекбэк как спам',
    'Edit TrackBack' => 'Редактировать трекбэк',

## default_templates/sidebar.mtml
    '2-column layout - Sidebar' =>
      '2-колончатый — Боковое меню',
    '3-column layout - Primary Sidebar' =>
      '3-колончатый — Главное боковое меню',
    '3-column layout - Secondary Sidebar' =>
      '3-колончатый — Вторичное боковое меню',

## default_templates/new-comment.mtml
    'An unapproved comment has been posted on your blog [_1], for entry #[_2] ([_3]). You need to approve this comment before it will appear on your site.'
      => 'В блоге [_1] появился новый комментарий, оставленный к записи #[_2] ([_3]). Вам необходимо одобрить комментарий, прежде чем он появится в блоге.',
    'A new comment has been posted on your blog [_1], on entry #[_2] ([_3]).'
      => 'В блоге [_1] появился новый комментарий, оставленный к записи [_2] ([_3]). ',
    'Commenter name: [_1]' => 'Имя комментатора: [_1]',
    'Commenter email address: [_1]' => 'Email: [_1]',
    'Commenter URL: [_1]'           => 'URL: [_1]',
    'Commenter IP address: [_1]'    => 'IP адрес: [_1]',
    'Approve comment:' => 'Одобрить комментарий:',
    'View comment:'    => 'Посмотреть комментарий:',
    'Edit comment:' => 'Редактировать комментарий:',
    'Report comment as spam:' =>
      'Пометить комментарий как спам:',

## default_templates/search_results.mtml
    'Search Results' => 'Результат поиска',
    'Results matching &ldquo;[_1]&rdquo;' =>
      'Записи, в которых присутствует «[_1]»',
    'Results tagged &ldquo;[_1]&rdquo;' =>
      'Записи, связанные с тегом «[_1]»',
    'Previous' => 'Предыдущий',
    'Next'     => 'Следующий',
    'No results found for &ldquo;[_1]&rdquo;.' =>
      'По вашему запросу «[_1]» ничего не найдено.',
    'Instructions' => 'Инструкции',
    'By default, this search engine looks for all words in any order. To search for an exact phrase, enclose the phrase in quotes:'
      => 'По умолчанию поисковый механизм ищет все слова, расположенные в любом порядке. Чтобы искать точную фразу, заключите её в кавычки: ',
    'movable type' => 'movable type',
    'The search engine also supports AND, OR, and NOT keywords to specify boolean expressions:'
      => 'Также обратите внимание, что поисковый механизм поддерживает операторы AND, OR и NOT:',
    'personal OR publishing'  => 'собака OR животное',
    'publishing NOT personal' => 'животное NOT кошка',

## default_templates/author_archive_list.mtml
    'Authors' => 'Авторы',

## default_templates/syndication.mtml
    'Subscribe to feed' => 'Подписаться на обновления',
    'Subscribe to this blog\'s feed' =>
      'Подписаться на обновления этого блога',
    'Subscribe to a feed of all future entries tagged &ldquo;[_1]&ldquo;' =>
      'Подписаться на обновления, связанные с тегом «[_1]»',
    'Subscribe to a feed of all future entries matching &ldquo;[_1]&ldquo;' =>
      'Подписаться на обновления, содержащие «[_1]»',
    'Feed of results tagged &ldquo;[_1]&ldquo;' =>
      'Обновления по тегу «[_1]»',
    'Feed of results matching &ldquo;[_1]&ldquo;' =>
      'Обновления, содержащие «[_1]»',

## default_templates/comment_preview.mtml
    'Previewing your Comment' => 'Просмотр комментария',
    '[_1] replied to <a href="[_2]">comment from [_3]</a>' =>
      '[_1] ответил на <a href="[_2]">комментарий от [_3]</a>',
    'Replying to comment from [_1]' =>
      'Ответ на комментарий от [_1]',
    'Cancel' => 'Отмена',

## default_templates/archive_widgets_group.mtml
    'This is a custom set of widgets that are conditioned to serve different content based upon what type of archive it is included. More info: [_1]'
      => 'Это произвольный набор виджетов, что обуславливает его включении на основе того, в какой архив он включён. Дополнительная информация: [_1]',
    'Current Category Monthly Archives' =>
      'Текущий архив категории по месяцам',
    'Category Archives' => 'Архивы категорий',

## default_templates/javascript.mtml
    'moments ago' => 'только что',
    '[quant,_1,hour,hours] ago' =>
      '[quant,_1,час,часа,часов] назад',
    '[quant,_1,minute,minutes] ago' =>
      '[quant,_1,минуту,минуты,минут] назад',
    '[quant,_1,day,days] ago' =>
      '[quant,_1,день,дня,дней] назад',
    'Edit' => 'Редактировать',
    'Your session has expired. Please sign in again to comment.' =>
      'Ваша сессия истекла. Пожалуйста, авторизуйтесь ещё раз.',
    'Signing in...' => 'Авторизация…',
    'You do not have permission to comment on this blog. ([_1]sign out[_2])'
      => 'У вас нет прав для комментирования в этом блоге. ([_1]выйти[_2])',
    'Thanks for signing in, __NAME__. ([_1]sign out[_2])' =>
      'Привет! Сегодня вы — __NAME__.',
    '[_1]Sign in[_2] to comment.' =>
      'Необходимо [_1]авторизоваться[_2] для комментирования.',
    '[_1]Sign in[_2] to comment, or comment anonymously.' =>
      '[_1]Авторизуйтесь[_2], чтобы прокомментировать эту запись, либо комментируйте анонимно.',
    'Replying to <a href="[_1]" onclick="[_2]">comment from [_3]</a>' =>
      'Ответ на комментарий от <a href="[_1]" onclick="[_2]">[_3]</a>',

## default_templates/comment_detail.mtml

## default_templates/recent_entries.mtml

## default_templates/verify-subscribe.mtml
    'Thanks for subscribing to notifications about updates to [_1]. Follow the link below to confirm your subscription:'
      => 'Благодарим за подписку на уведомления о новых записях на ваш адрес [_1]. Для подтверждения подписки перейдите по следующей ссылке:',
    'If the link is not clickable, just copy and paste it into your browser.'
      => 'Если ссылка не открывается, просто скопируйте её и вставьте в адресную строку браузера.',

## default_templates/signin.mtml
    'Sign In'               => 'Авторизация',
    'You are signed in as ' => 'Вы авторизовались как ',
    'sign out'              => 'выйти',
    'You do not have permission to sign in to this blog.' =>
      'Вы не можете авторизовываться в этом блоге.',

## default_templates/commenter_confirm.mtml
    'Thank you registering for an account to comment on [_1].' =>
      'Спасибо за регистрацию аккаунта для комментирования «[_1]».',
    'For your own security and to prevent fraud, we ask that you please confirm your account and email address before continuing. Once confirmed you will immediately be allowed to comment on [_1].'
      => 'Для подтверждения email адреса, вам необходимо активировать ваш аккаунт. После этого вы сможете незамедлительно комментировать «[_1]».',
    'To confirm your account, please click on or cut and paste the following URL into a web browser:'
      => 'Перейдите по следующей ссылке или вставьте её в адресную строку браузера:',
    'If you did not make this request, or you don\'t want to register for an account to comment on [_1], then no further action is required.'
      => 'Если же регистрацию за вас выполнил кто-то другой, наглым образом воспользовавшись вашим адресом, и вы не хотите оставлять комментарии на сайте «[_1]», просто проигнорируйте это письмо.',
    'Thank you very much for your understanding.' =>
      'Если вы всё же перейдёте по ссылке, значит робот, отправивший это письмо, старался не зря.',
    'Sincerely,' => 'С уважением,',

## default_templates/comment_listing.mtml

## default_templates/recover-password.mtml
    'A request has been made to change your password in Melody. To complete this process click on the link below to select a new password.'
      => 'Сделан запрос на изменение пароля в Melody. Для завершения процесса, перейдите по ссылке, расположенной ниже:',
    'If you did not request this change, you can safely ignore this email.' =>
      'Если вы не запрашивали изменение пароля, проигнорируйте это письмо.',

## default_templates/entry.mtml

## lib/MT/AtomServer.pm
    '[_1]: Entries' => '[_1]: записи',
    'PreSave failed [_1]' =>
      'Ошибка предварительного сохранения [_1]',
    'User \'[_1]\' (user #[_2]) added [lc,_4] #[_3]' =>
      'Пользователь «[_1]» (ID #[_2]) добавил [lc,_4] #[_3]',
    'User \'[_1]\' (user #[_2]) edited [lc,_4] #[_3]' =>
      'Пользователь «[_1]» (ID #[_2]) отредактировал [lc,_4] #[_3]',
    'Perl module Image::Size is required to determine width and height of uploaded images.'
      => 'Для указания ширины и высоты загружаемыех файлов необходим модуль Perl Image::Size.',

## lib/MT/Page.pm
    'Folder' => 'Директория',
    'Load of blog failed: [_1]' =>
      'Не удалось загрузить блог: [_1]',

## lib/MT/Component.pm
    'Loading template \'[_1]\' failed: [_2]' =>
      'Не удалось загрузить шаблон «[_1]» по следующей причине: [_2]',

## lib/MT/Template.pm
    'Template'             => 'Шаблон',
    'Templates'            => 'Шаблоны',
    'File not found: [_1]' => 'Файл не найден: [_1]',
    'Error reading file \'[_1]\': [_2]' =>
      'Ошибка при чтении файла «[_1]»: [_2]',
    'Load of blog \'[_1]\' failed: [_2]' =>
      'Не удалось загрузить блог [_1]»: [_2]',
    'Publish error in template \'[_1]\': [_2]' =>
      'Ошибка публикации в шаблоне «[_1]»: [_2]',
    'Template with the same name already exists in this blog.' =>
      'Шаблон с таким именем уже существует в этом блоге.',
    'You cannot use a [_1] extension for a linked file.' =>
      'Вы не можете использовать расширение [_1] для связанного файла.',
    'Opening linked file \'[_1]\' failed: [_2]' =>
      'Не удалось открыть связанный файл «[_1]»: [_2]',
    'Index'            => 'Индексный',
    'Archive'          => 'Архив',
    'Category Archive' => 'Архив категории',
    'Comment Listing'  => 'Список комментариев',
    'Ping Listing'     => 'Список пингов',
    'Comment Preview'  => 'Предпросмотр комментария',
    'Comment Error'    => 'Ошибка комментирования',
    'Comment Pending'  => 'Комментарий на проверке',
    'Dynamic Error' =>
      'Ошибка на динамических страницах',
    'Uploaded Image' => 'Загруженное изображение',
    'Module'         => 'Модуль',
    'Widget'         => 'Виджет',

## lib/MT/PluginData.pm
    'Plugin Data' => 'Данные о плагине',

## lib/MT/Session.pm
    'Session' => 'Сессия',

## lib/MT/App/Viewer.pm
    'Loading blog with ID [_1] failed' =>
      'Не удалось загрузить блог с ID [_1]',
    'Template publishing failed: [_1]' =>
      'Не удалось опубликовать шаблон: [_1]',
    'Invalid date spec' => 'Неверный формат даты',
    'Can\'t load templatemap' =>
      'Не удалось загрузить карту шаблонов',
    'Can\'t load template [_1]' =>
      'Не удалось загрузить шаблон [_1]',
    'Archive publishing failed: [_1]' =>
      'Не удалось опубликовать архив: [_1]',
    'Invalid entry ID [_1]' => 'Неверный ID записи: [_1]',
    'Entry [_1] is not published' =>
      'Запись [_1] не опубликована',
    'Invalid category ID \'[_1]\'' =>
      'Неверный ID категории: [_1]',

## lib/MT/App/ActivityFeeds.pm
    'Error loading [_1]: [_2]' =>
      'Ошибка при загрузке [_1]: [_2]',
    'An error occurred while generating the activity feed: [_1].' =>
      'Произошла ошибка при генерации фида с последней активностью: [_1].',
    'No permissions.'        => 'Недостаточно прав.',
    '[_1] Weblog TrackBacks' => 'Трекбэки блога [_1] ',
    'All Weblog TrackBacks'  => 'Все трекбэки блога',
    '[_1] Weblog Comments'   => 'Комментарии блога [_1] ',
    'All Weblog Comments'    => 'Все комментарии блога',
    '[_1] Weblog Entries'    => 'Записи блога [_1] ',
    'All Weblog Entries'     => 'Все записи блога',
    '[_1] Weblog Activity'   => 'Активность в блоге [_1] ',
    'All Weblog Activity' =>
      'Активность во всех блогах',
    'Melody System Activity' =>
      'Активность — системный уровень',
    'Melody Debug Activity' =>
      'Активность — отладочная информация',
    '[_1] Weblog Pages' => 'Страницы блога [_1]',
    'All Weblog Pages'  => 'Все страницы блога',

## lib/MT/App/Search/Legacy.pm
    'You are currently performing a search. Please wait until your search is completed.'
      => 'В данный момент осуществляется поиск. Пожалуйста, дождитесь завершения поиска.',
    'Search failed. Invalid pattern given: [_1]' =>
      'Поиск не удался. Представлены недопустимые данные: [_1]',
    'Search failed: [_1]' => 'Поиск не удался: [_1]',
    'Invalid request.'    => 'Неверный запрос.',
    'No alternate template is specified for the Template \'[_1]\'' =>
      'Не указан альтернативный шаблон для шаблона «[_1]»',
    'Opening local file \'[_1]\' failed: [_2]' =>
      'Не удалось открыть локальный файл «[_1]»: [_2]',
    'Publishing results failed: [_1]' =>
      'Публикация результатов не удалась: [_1]',
    'Search: query for \'[_1]\'' => 'Поиск: запрос «[_1]»',
    'Search: new comment search' =>
      'Поиск: новые коментарии',

## lib/MT/App/Search/TagSearch.pm
    'TagSearch works with MT::App::Search.' =>
      'TagSearch работает с MT::App::Search.',

## lib/MT/App/Search.pm
    'Invalid [_1] parameter.' =>
      'Неправильный [_1] параметр',
    'Invalid type: [_1]' => 'Неверный тип: [_1]',
    'Search: failed storing results in cache.  [_1] is not available: [_2]' =>
      'Поиск: не удалось сохранить результат в кеш. [_1] — не доступна: [_2]',
    'Invalid format: [_1]' => 'Неверный формат: [_1]',
    'Unsupported type: [_1]' =>
      'Неподдерживаемый тип: [_1]',
    'Invalid query: [_1]'  => 'Неверный запрос: [_1]',
    'Invalid archive type' => 'Неверный тип архива',
    'Invalid value: [_1]'  => 'Неверное значение: [_1]',
    'No column was specified to search for [_1].' =>
      'Нет колонки, указанной для поиска по [_1]',
    'No such template' => 'Нет такого шаблона',
    'template_id cannot be a global template' =>
      'template_id не может быть глобальным шаблоном',
    'Output file cannot be asp or php' =>
      'Конечный файл не может быть PHP или ASP',
    'You must pass a valid archive_type with the template_id' =>
      'Необходимо передать действительный archive_type с template_id',
    'Template must have identifier entry_listing for non-Index archive types'
      => 'У шаблона должен быть идентификатор для неиндексных типов архивов',
    'Blog file extension cannot be asp or php for these archives' =>
      'Для этих архивов расширение публикуемых файлов блога не может быть php или asp',
    'Template must have identifier main_index for Index archive type' =>
      'У шаблона должен быть индентификатор main_index для индексного типа архива',
    'The search you conducted has timed out.  Please simplify your query and try again.'
      => 'Поиск по вашему запросу занимает слишком продолжительное время. Пожалуйста, упростите ваш запрос и повторите попытку.',

## lib/MT/App/Wizard.pm
    'The [_1] database driver is required to use [_2].' =>
      'Для использования [_2] необходим драйвер базы данных [_1].',
    'The [_1] driver is required to use [_2].' =>
      'Для использования [_2] необходим драйвер [_1].',
    'An error occurred while attempting to connect to the database.  Check the settings and try again.'
      => 'Не удалось соединиться с базой данных. Пожалуйста, проверьте параметры и попробуйте ещё раз.',
    'SMTP Server' => 'SMTP сервер',
    'Sendmail'    => 'Sendmail',
    'Test email from Melody Configuration Wizard' =>
      'Тестовое письмо от Melody',
    'This is the test email sent by your new installation of Melody.' =>
      'Это тестовое письмо, отправленное во время установки Melody.',
    'This module is needed to encode special characters, but this feature can be turned off using the NoHTMLEntities option in config.cgi.'
      => 'Модуль необходим для кодирования специальных символов. Но вы можете отключить эту возможность, используя опцию NoHTMLEntities в config.cgi.',
    'This module is needed if you wish to use the TrackBack system, the weblogs.com ping, or the MT Recently Updated ping.'
      => 'Модуль необходим, если вы хотите использовать трекбэки и пинги сервисов (weblogs.com, technorati.com, blogs.google.com, и т.д.).',
    'HTML::Parser is optional; It is needed if you wish to use the TrackBack system, the weblogs.com ping, or the MT Recently Updated ping.'
      => 'HTML::Parser не обязателен, но он необходим, если вы хотите использовать функцию трекбэков и отправлять уведомления на сервера типа weblogs.com или Яндекс.Блоги',
    'This module is needed if you wish to use the MT XML-RPC server implementation.'
      => 'Модуль необходим, если вы хотите использовать MT XML-RPC (для работы с блогами через сторонние интерфейсы, например, через блогинг-редакторы).',
    'This module is needed if you would like to be able to overwrite existing files when you upload.'
      => 'Модуль необходим для перезаписи файлов после загрузки.',
    'List::Util is optional; It is needed if you want to use the Publish Queue feature.'
      => 'List:Util не обязателен, но он необходим, если вы хотите использовать очередь публикации.',
    'Scalar::Util is optional; It is needed if you want to use the Publish Queue feature.'
      => 'Scalar::Util необязателен; он необходим, если вы хотите использовать функцию очереди публикации.',
    'This module is needed if you would like to be able to create thumbnails of uploaded images.'
      => 'Модуль необходим, если вы хотите иметь возможность делать миниатюры загружаемых изображений.',
    'This module is needed if you would like to be able to use NetPBM as the image driver for MT.'
      => 'Модуль необходим, если вы хотите использовать в качестве обработчика картинок драйвер NetPBM.',
    'This module is required by certain MT plugins available from third parties.'
      => 'Модуль обязателен для некоторых плагинов MT.',
    'This module accelerates comment registration sign-ins.' =>
      'Модуль ускоряет регистрацию комментаторов.',
    'This module and its dependencies are required in order to allow commenters to be authenticated by OpenID providers such as AOL and Yahoo! which require SSL support.'
      => 'Модуль необходим для авторизации комментаторов через OpenID с использованием протокола HTTPS (AOL, Yahoo).',
    'This module is needed to enable comment registration.' =>
      'Модуль необходим для включения возможности регистрации комментаторов.',
    'This module enables the use of the Atom API.' =>
      'Модуль позволяет использовать Atom API.',
    'This module is required in order to archive files in backup/restore operation.'
      => 'Модуль необходим для добавления в архив файлов во время операции резервного копирования/восстановления.',
    'This module is required in order to compress files in backup/restore operation.'
      => 'Модуль необходим для сжатия файлов во время операции резервного копирования/восстановления.',
    'This module is required in order to decompress files in backup/restore operation.'
      => 'Модуль необходим для распаковки файлов во время операции резервного копирования/восстановления.',
    'This module and its dependencies are required in order to restore from a backup.'
      => 'Этот модуль и зависимости от него необходимы для восстановления из резервной копии.',
    'This module and its dependencies are required in order to allow commenters to be authenticated by OpenID providers including Vox and LiveJournal.'
      => 'Это модуль и зависимости от него необходимы для авторизации комментаторов через OpenID, включая LiveJournal и Vox.',
    'This module is required for sending mail via SMTP Server.' =>
      'Модуль необходим для отправки почты посредством SMTP сервера.',
    'This module is used in test attribute of MTIf conditional tag.' =>
      'Модуль используется для тестирования тега MTIf.',
    'This module is used by the Markdown text filter.' =>
      'Модуль используется в текстовом фильтре Markdown.',
    'This module is required in search.cgi if you are running Melody on Perl older than Perl 5.8.'
      => 'Модуль необходим для search.cgi, если ваш Melody работает на Perl версии старше 5.8.',
    'This module required for action streams.' =>
      'Модуль необходим для Action Streams',
    'This module is required for file uploads (to determine the size of uploaded images in many different formats).'
      => 'Модуль необходим для загрузки файлов (чтобы определить размер загруженных изображений в различных форматах).',
    'This module is required for cookie authentication.' =>
      'Модуль необходим для авторизации через куки (cookie).',
    'DBI is required to store data in database.' =>
      'Для хранения данных в базе данных обязателен DBI.',
    'CGI is required for all Melody application functionality.' =>
      'Для работы Melody необходим CGI.',
    'File::Spec is required for path manipulation across operating systems.'
      => 'File::Spec обязателен для работы с файлами.',

## lib/MT/App/Upgrader.pm
    'Invalid login.' => 'Неверный логин.',
    'Failed to authenticate using given credentials: [_1].' =>
      'Ошибка авторизации с представленными данными: [_1].',
    'You failed to validate your password.' =>
      'Вы неправильно ввели проверочный пароль.',
    'You failed to supply a password.' =>
      'Вы не указали пароль.',
    'The e-mail address is required.' =>
      'Email адрес обязателен.',
    'The path provided below is not writable.' =>
      'Указанный ниже путь не перезаписываемый.',
    'Invalid session.' => 'Неверная сессия.',
    'No permissions. Please contact your administrator for upgrading [_1].' =>
      'Недостаточно прав для выполнения этого действия. Пожалуйста, свяжитесь с администратором для обновления [_1].',
    '[_1] has been upgraded to version [_1].' =>
      '[_1] обновлён до версии [_1].',

## lib/MT/App/CMS.pm
    'Invalid request' => 'Неверный запрос',
    '_WARNING_PASSWORD_RESET_MULTI' =>
      'Вы собираетесь отправить выбранным пользователям, чтобы они смогли сбросить пароль. Продолжить?',
    '_WARNING_DELETE_USER_EUM' =>
      'Удаление пользователя — окончательное действие, которое приведёт к отсутствию авторов у некорых записей. Вместо этого вы можете просто деактивировать его или лишить всех прав в системе. Вы всё равно хотите удалить пользователя? Обратите внимание, что он сможет получить новый доступ, если был зарегистрирован через внешние ресурсы.',
    '_WARNING_DELETE_USER' =>
      'Удаление пользователя — окончательное действие, которое приведёт к отсутствию авторов у некорых записей. Вместо это рекомендуется деактивировать пользователя или лишить его всех прав в системе. Вы уверены, что хотите удалить выбранных пользователей?',
    '_WARNING_REFRESH_TEMPLATES_FOR_BLOGS' =>
      'Это действие заменит шаблоны в выбранных блогах на стандартные. Вы уверены?',
    'Published [_1]'   => 'Опубликованные [_1]',
    'Unpublished [_1]' => 'Неопубликованные [_1]',
    'Scheduled [_1]'   => 'Запланированные [_1]',
    'My [_1]'          => 'Мои [_1]',
    '[_1] with comments in the last 7 days' =>
      '[_1] с комментариями за последние 7 дней',
    '[_1] posted between [_2] and [_3]' =>
      '[_1], опубликованные между [_2] и [_3]',
    '[_1] posted since [_2]' => '[_1], опубликованные с [_2]',
    '[_1] posted on or before [_2]' =>
      '[_1], добавленные не позднее [_2]',
    'All comments by [_1] \'[_2]\'' =>
      'Все комментарии от [_1] «[_2]»',
    'Commenter' => 'Комментатор',
    'All comments for [_1] \'[_2]\'' =>
      'Все комментарии к [_1] «[_2]»',
    'Comments posted between [_1] and [_2]' =>
      'Комментарии, добавленные между [_1] и [_2]',
    'Comments posted since [_1]' =>
      'Комментарии, добавленные с [_1]',
    'Comments posted on or before [_1]' =>
      'Комментарии, добавленные не позднее [_1]',
    'You are not authorized to log in to this blog.' =>
      'Вам не разрешено авторизовываться в этом блоге.',
    'No such blog [_1]' => 'Нет такого блога [_1]',
    'Edit Template'     => 'Редактирование шаблона',
    'Go Back'           => 'Вернуться',
    'Unknown object type [_1]' =>
      'Неизвестный тип объекта [_1]',
    'None' => 'Ничего',
    'Error during publishing: [_1]' =>
      'Ошибка во время публикации: [_1]',
    'This is You'     => 'Это вы',
    'Handy Shortcuts' => 'Быстрый доступ',
    'Melody News'     => 'Новости Melody',
    'Blog Stats'      => 'Статистика',
    'Entries'         => 'Записи',
    'Refresh Blog Templates' =>
      'Восстановить шаблоны блога',
    'Refresh Global Templates' =>
      'Восстановить глобальные шаблоны',
    'Use Publishing Profile' =>
      'Использовать профиль публикации',
    'Unpublish Entries' => 'Неопубликованные записи',
    'Add Tags...'       => 'Добавить теги…',
    'Tags to add to selected entries' =>
      'Теги, которые необходимо добавить к выбранным записям',
    'Remove Tags...' => 'Удалить теги…',
    'Tags to remove from selected entries' =>
      'Теги, которые необходимо удалить у выбранных записей',
    'Batch Edit Entries' =>
      'Массовое редактирование записей',
    'Unpublish Pages' =>
      'Отменить публикацию страниц',
    'Tags to add to selected pages' =>
      'Теги, которые необходимо добавить к выбранным страницам',
    'Tags to remove from selected pages' =>
      'Теги, которые необходимо удалить у выбранных страниц',
    'Batch Edit Pages' =>
      'Массовое редактирование страниц',
    'Tags to add to selected assets' =>
      'Теги, которые необходимо добавить к выбранному медиа',
    'Tags to remove from selected assets' =>
      'Теги, которые необходимо удалить у выбранного медиа',
    'Unpublish TrackBack(s)' =>
      'Отменить публикацию трекбэков',
    'Unpublish Comment(s)' =>
      'Отменить публикацию комментариев',
    'Trust Commenter(s)' =>
      'Сделать комментатора доверенным',
    'Untrust Commenter(s)' =>
      'Убрать статус доверенного у комментатора',
    'Ban Commenter(s)' =>
      'Заблокировать комментаторов',
    'Unban Commenter(s)' =>
      'Снять блокировку у комментаторов',
    'Recover Password(s)' => 'Восстановить пароли',
    'Delete'              => 'Удалить',
    'Refresh Template(s)' => 'Восстановить шаблоны',
    'Clone Blog'          => 'Клонировать блог',
    'Publish Template(s)' => 'Опубликовать шаблоны',
    'Clone Template(s)'   => 'Клонировать шаблоны',
    'Non-spam TrackBacks' => 'Трекбэки без спама',
    'TrackBacks on my entries' =>
      'Трекбэки к моим записям',
    'Published TrackBacks' => 'Опубликованные трекбэки',
    'Unpublished TrackBacks' =>
      'Неопубликованные трекбэки',
    'TrackBacks marked as Spam' =>
      'Трекбэки, помеченные как спам',
    'All TrackBacks in the last 7 days' =>
      'Все трекбэки за последние 7 дней',
    'Non-spam Comments' => 'Комментарии без спама',
    'Comments on my entries' =>
      'Комментарии к моим записям',
    'Pending comments' => 'Ожидающие комментарии',
    'Spam Comments' =>
      'Комментарии, помеченные как спам',
    'Published comments' =>
      'Опубликованные комментарии',
    'Comments in the last 7 days' =>
      'Комментарии за последние 7 дней',
    'Tags with entries'  => 'Теги записей',
    'Tags with pages'    => 'Теги страниц',
    'Tags with assets'   => 'Теги медиа объектов',
    'Enabled Users'      => 'Активные пользователи',
    'Disabled Users'     => 'Отключенные пользователи',
    'Pending Users'      => 'Ожидающие пользователи',
    'Commenters'         => 'Комментаторы',
    'Create'             => 'Создать',
    'Manage'             => 'Управление',
    'Design'             => 'Дизайн',
    'Preferences'        => 'Параметры',
    'Tools'              => 'Инструменты',
    'User'               => 'Пользователь',
    'Upload File'        => 'Загрузка файла',
    'Blogs'              => 'Блоги',
    'Users'              => 'Пользователи',
    'Assets'             => 'Медиа',
    'TrackBacks'         => 'Трекбэки',
    'Folders'            => 'Директории',
    'Address Book'       => 'Адресная книга',
    'Widgets'            => 'Виджеты',
    'General'            => 'Общие',
    'Feedback'           => 'Обратная связь',
    'Publishing'         => 'Публикация',
    'Comment'            => 'Комментарий',
    'TrackBack'          => 'Трекбэк',
    'Registration'       => 'Регистрация',
    'Spam'               => 'Спам',
    'Web Services'       => 'Веб-сервисы',
    'IP Banning'         => 'Бан IP',
    'Plugins'            => 'Плагины',
    'Activity Log'       => 'Журнал активности',
    'Import'             => 'Импорт',
    'Export'             => 'Экспорт',
    'Backup'             => 'Бэкап',
    'Restore'            => 'Восстановление',
    'System Information' => 'Информация о системе',
    'System Overview'    => 'Обзор',
    'Global Templates'   => 'Глобальные шаблоны',
    'Settings'           => 'Настройка',

## lib/MT/App/NotifyList.pm
    'Please enter a valid email address.' =>
      'Пожалуйста, введите правильный email адрес.',
    'Missing required parameter: blog_id. Please consult the user manual to configure notifications.'
      => 'Пропущен обязательный параметр: blog_id. Пожалуйста, ознакомьтесь с руководством пользователя для настройки уведомлений.',
    'An invalid redirect parameter was provided. The weblog owner needs to specify a path that matches with the domain of the weblog.'
      => 'Предоставлен неверный параметр для переадресации. Владелец блога должен определить путь, соответствующий домену блога.',
    'The email address \'[_1]\' is already in the notification list for this weblog.'
      => 'Адрес «[_1]» уже присутствует в списке уведомлений этого блога.',
    'Please verify your email to subscribe' =>
      'Пожалуйста, подтвердите ваш email для подписки',
    '_NOTIFY_REQUIRE_CONFIRMATION' =>
      'На адрес [_1] отправлено письмо. Перейдите по ссылке из этого письма, чтобы подтвердить подписку.',
    'The address [_1] was not subscribed.' =>
      'Адрес [_1] не был подписан.',
    'The address [_1] has been unsubscribed.' =>
      'Адрес [_1] отписан от уведомлений.',

## lib/MT/App/Comments.pm
    'Error assigning commenting rights to user \'[_1] (ID: [_2])\' for weblog \'[_3] (ID: [_4])\'. No suitable commenting role was found.'
      => 'Ошибка при назначении прав комментирования для пользователя «[_1]» (ID: [_2]), блог «[_3]» (ID: [_4]). Подходящая роль комментатора не нашлась.',
    'Can\'t load blog #[_1].' =>
      'Не удалось загрузить блог #[_1].',
    'Invalid commenter login attempt from [_1] to blog [_2](ID: [_3]) which does not allow Melody native authentication.'
      => 'Неудавшаяся попытка входа комментатора от [_1] в блоге «[_2]» (ID: [_3]), в котором отключена возможность авторизовываться через Melody.',
    'Invalid login' => 'Неверный логин',
    'Successfully authenticated but signing up is not allowed.  Please contact system administrator.'
      => 'Авторизация прошла успешно, но, к сожалению, она запрещена в этом блоге. Пожалуйста, свяжитесь с администратором блога.',
    'You need to sign up first.' =>
      'Для начала необходимо авторизоваться.',
    'Permission denied.' => 'Доступ запрещён.',
    'Login failed: permission denied for user \'[_1]\'' =>
      'Авторизация не удалась: для пользователя «[_1]» доступ закрыт',
    'Login failed: password was wrong for user \'[_1]\'' =>
      'Авторизация не удалась: неправильно указан пароль для пользователя «[_1]»',
    'Failed login attempt by disabled user \'[_1]\'' =>
      'Авторизация не удалась, потому что пользователь «[_1]» не активен.',
    'Failed login attempt by unknown user \'[_1]\'' =>
      'Неудачная попытка входа, используя неизвестный логин «[_1]»',
    'Signing up is not allowed.' =>
      'Авторизация запрещена.',
    'Melody Account Confirmation' =>
      'Активация аккаунта Melody',
    'System Email Address is not configured.' =>
      'Системный email не указан в параметрах.',
    'Commenter \'[_1]\' (ID:[_2]) has been successfully registered.' =>
      'Комментатор «[_1]» (ID:[_2]) успешно зарегистрировался.',
    'Thanks for the confirmation.  Please sign in to comment.' =>
      'Активация прошла успешно, спасибо. Пожалуйста, авторизуйтесь для комментирования.',
    '[_1] registered to the blog \'[_2]\'' =>
      'Пользователь [_1] зарегистрирован в блоге «[_2]»',
    'No id'           => 'Не указан ID',
    'No such comment' => 'Нет такого комментария',
    'IP [_1] banned because comment rate exceeded 8 comments in [_2] seconds.'
      => 'IP [_1] заблокирован, потому что превышен предел 8 комментариев за [quant,_2,секунду,секунды,секунд].',
    'IP Banned Due to Excessive Comments' =>
      'IP заблокирован из-за массовых отправки комментариев',
    'No entry_id'             => 'Не указан entry_id',
    'No such entry \'[_1]\'.' => 'Нет такой записи «[_1]».',
    '_THROTTLED_COMMENT' =>
      'Вы попытались добавить слишком много комментариев за короткий период времени. В народе это называется «флуд». Подождите, пожалуйста, некоторое время.',
    'Comments are not allowed on this entry.' =>
      'Комментирование этой записи запрещено.',
    'Comment text is required.' =>
      'Комментарий должен содержать текст.',
    'An error occurred: [_1]' => 'Произошла ошибка: [_1]',
    'Registration is required.' =>
      'Необходима регистрация.',
    'Name and email address are required.' =>
      'Поля «Имя» и «Email» обязательны для заполнения.',
    'Invalid email address \'[_1]\'' =>
      'Неправильный email адрес: [_1]',
    'Invalid URL \'[_1]\'' => 'Неправильный URL: [_1]',
    'Text entered was wrong.  Try again.' =>
      'Текст введён неправильно. Попробуйте ещё раз.',
    'Comment save failed with [_1]' =>
      'Не удалось сохранить комментарий с [_1]',
    'Comment on "[_1]" by [_2].' =>
      'Комментарий к «[_1]» от [_2].',
    'Publish failed: [_1]' =>
      'Публикация не удалась: [_1]',
    'Can\'t load template' =>
      'Не удалось загрузить шаблон',
    'Failed comment attempt by pending registrant \'[_1]\'' =>
      'Неудавшаяся попытка размещения комментария неподтверждённым пользователем  «[_1]»',
    'Registered User' =>
      'Зарегистрированный пользователь',
    'The sign-in attempt was not successful; please try again.' =>
      'Авторизация не удалась. Пожалуйста, попробуйте снова.',
    'Can\'t load entry #[_1].' =>
      'Не удалось загрузить запись #[_1].',
    'No entry was specified; perhaps there is a template problem?' =>
      'Запись не определена. Возможно, есть проблема с шаблоном?',
    'Somehow, the entry you tried to comment on does not exist' =>
      'Как-то так произошло, но записи, которую вы пытаетесь комментировать, не существует',
    'Invalid entry ID provided' =>
      'Представленный ID записи — неверный',
    'All required fields must have valid values.' =>
      'Все обязательные поля должны быть заполнены правильно.',
    '[_1] contains an invalid character: [_2]' =>
      '[_1] содержит недопустимые символы: [_2]',
    'Display Name'            => 'Отображаемое имя',
    'Passwords do not match.' => 'Пароли не идентичны.',
    'Email Address is invalid.' =>
      'Неправильный email адрес.',
    'URL is invalid.' => 'Неправильный URL.',
    'Commenter profile has successfully been updated.' =>
      'Профиль комментатора обновлён.',
    'Commenter profile could not be updated: [_1]' =>
      'Не удалось обновить профиль комментатора: [_1]',

## lib/MT/App/Trackback.pm
    'Invalid entry ID \'[_1]\'' =>
      'Неправильный ID записи - \'[_1]\'',
    'You must define a Ping template in order to display pings.' =>
      'Для отображения пингов необходимо задать для них шаблон.',
    'Trackback pings must use HTTP POST' =>
      'При отправке трекбэков нужно использовать HTTP POST',
    'Need a TrackBack ID (tb_id).' =>
      'Необходим ID трекбэка (tb_id).',
    'Invalid TrackBack ID \'[_1]\'' =>
      'Неверный ID трекбэка: [_1]',
    'You are not allowed to send TrackBack pings.' =>
      'У вас нет прав на отправку трекбэков.',
    'You are pinging trackbacks too quickly. Please try again later.' =>
      'Вы отправляете трекбэки слишком часто. Пожалуйста, попробуйте ещё раз чуть позже.',
    'Need a Source URL (url).' =>
      'Необходим источник (url).',
    'This TrackBack item is disabled.' =>
      'Этот элемент трекбэка заблокирован.',
    'This TrackBack item is protected by a passphrase.' =>
      'Этот элемент трекбэка защищен паролем.',
    'TrackBack on "[_1]" from "[_2]".' =>
      'Трекбэк к «[_1]» от «[_2]».',
    'TrackBack on category \'[_1]\' (ID:[_2]).' =>
      'Трекбэк к категории «[_1]» (ID:[_2]).',
    'Can\'t create RSS feed \'[_1]\': ' =>
      'Не удалось создать RSS канал «[_1]»: ',
    'New TrackBack Ping to Entry [_1] ([_2])' =>
      'Новый трекбэк к записи «[_1]» ([_2])',
    'New TrackBack Ping to Category [_1] ([_2])' =>
      'Новый трекбэк к категории «[_1]» ([_2])',

## lib/MT/BackupRestore.pm
    'Backing up [_1] records:' => 'Сохранение записей [_1]:',
    '[_1] records backed up...' => 'Сохрание [_1] записей…',
    '[_1] records backed up.'   => '[_1] записей сохранено.',
    'There were no [_1] records to be backed up.' =>
      'В [_1] нет записей для сохранения.',
    'Can\'t open directory \'[_1]\': [_2]' =>
      'Не удалось открыть директорию «[_1]» : [_2]',
    'No manifest file could be found in your import directory [_1].' =>
      'В директории импорта [_1] не найдено необходимого файла.',
    'Can\'t open [_1].' => 'Не удалось открыть [_1].',
    'Manifest file [_1] was not a valid Melody backup manifest file.' =>
      'Содержимое указанного файла в неправильном для импорта формате.',
    'Manifest file: [_1]' => 'Файл импорта: [_1]',
    'Path was not found for the file ([_1]).' =>
      'Путь для файла указан неверно ([_1]).',
    '[_1] is not writable.' =>
      '[_1] — не доступно для записи.',
    'Error making path \'[_1]\': [_2]' =>
      'Ошибка при создании пути «[_1]\» : [_2]',
    'Copying [_1] to [_2]...' => 'Копирование [_1] в [_2]...',
    'Failed: '                => 'Ошибка: ',
    'Done.'                   => 'Успешно.',
    'Restoring asset associations ... ( [_1] )' =>
      'Восстановление ассоциаций медиа… ([_1])',
    'Restoring asset associations in entry ... ( [_1] )' =>
      'Восстановление ассоциаций медиа в записях… ([_1])',
    'Restoring asset associations in page ... ( [_1] )' =>
      'Восстановление ассоциаций медиа в страницах… ([_1])',
    'Restoring url of the assets ( [_1] )...' =>
      'Восстановление адресов для медиа… ([_1])',
    'Restoring url of the assets in entry ( [_1] )...' =>
      'Восстановление адресов для медиа в записях… ([_1])',
    'Restoring url of the assets in page ( [_1] )...' =>
      'Восстановление адресов для медиа в страницах… ([_1])',
    'ID for the file was not set.' =>
      'Не был указан ID для файла.',
    'The file ([_1]) was not restored.' =>
      'Файл ([_1]) не восстановлен.',
    'Changing path for the file \'[_1]\' (ID:[_2])...' =>
      'Изменение пути для файла «[_1]» (ID:[_2])…',
    'failed' => 'не удалось',
    'ok'     => 'ok',

## lib/MT/Association.pm
    'Association'  => 'Ассоциация',
    'Associations' => 'Ассоциации',
    'association'  => 'ассоциация',
    'associations' => 'ассоциация',

## lib/MT/TBPing.pm

## lib/MT/Template/Context.pm
    'The attribute exclude_blogs cannot take \'all\' for a value.' =>
      'Атрибут exclude_blogs не может иметь значение «all».',
    'You used an \'[_1]\' tag outside of the context of a author; perhaps you mistakenly placed it outside of an \'MTAuthors\' container?'
      => 'Вы использовали тег «[_1]» вне контекста (автор); возможно, вы поместили его вне контейнера «MTAuthors» ?',
    'You used an \'[_1]\' tag outside of the context of an entry; perhaps you mistakenly placed it outside of an \'MTEntries\' container?'
      => 'Вы использовали тег «[_1]» вне контекста записей; возможно, вы поместили его вне контейнера «MTEntries»?',
    'You used an \'[_1]\' tag outside of the context of a comment; perhaps you mistakenly placed it outside of an \'MTComments\' container?'
      => 'Вы использовали тег «[_1]» вне контекста (комментарий); возможно, вы поместили его вне контейнера «MTComments» ?',
    'You used an \'[_1]\' tag outside of the context of a ping; perhaps you mistakenly placed it outside of an \'MTPings\' container?'
      => 'Вы использовали тег «[_1]» вне контекста (пинг); возможно, вы поместили его вне контейнера «MTPings»?',
    'You used an \'[_1]\' tag outside of the context of an asset; perhaps you mistakenly placed it outside of an \'MTAssets\' container?'
      => 'Вы использовали тег «[_1]» вне контекста (медиа объекты); возможно, вы поместили его вне контейнера «MTAssets»?',
    'You used an \'[_1]\' tag outside of the context of a page; perhaps you mistakenly placed it outside of a \'MTPages\' container?'
      => 'Вы использовали тег «[_1]» вне контекста страницы; возможно, вы по ошибке поместили его вне контейнера MTPages?',

## lib/MT/Template/ContextHandlers.pm
    'All About Me'       => 'Всё обо мне',
    'Remove this widget' => 'Удалить этот виджет',
    '[_1]Publish[_2] your site to see these changes take effect.' =>
      '[_1]Опубликуйте[_2] ваш сайт, чтобы увидеть изменения.',
    'Actions' => 'Действия',
    'Warning' => 'Предупреждение',
    'http://www.movabletype.org/documentation/appendices/tags/%t.html' =>
      'http://www.movabletype.org/documentation/appendices/tags/%t.html',
    'No [_1] could be found.' => 'Не удалось найти [_1].',
    'records'                 => 'записи',
    'Invalid tag [_1] specified.' =>
      'Тег [_1] указан неверно.',
    'No template to include specified' =>
      'Нет шаблонов для включения указанного',
    'Recursion attempt on [_1]: [_2]' =>
      'Попытка рекурсии [_1]: [_2]',
    'Can\'t find included template [_1] \'[_2]\'' =>
      'Не удалось найти включённый шаблон [_1] «[_2]»',
    'Writing to \'[_1]\' failed: [_2]' =>
      'Запись в «[_1]» не удалась: [_2]',
    'Can\'t find blog for id \'[_1]' =>
      'Не удалось найти блог с ID\'[_1]',
    'Can\'t find included file \'[_1]\'' =>
      'Не удалось найти включённый файл «[_1]»',
    'Error opening included file \'[_1]\': [_2]' =>
      'Ошибка при открытии включённого файла «[_1]» : [_2]',
    'Recursion attempt on file: [_1]' =>
      'Попытка рекурсии с файлом: [_1]',
    'Unspecified archive template' =>
      'Неопределённый шаблон архива',
    'Error in file template: [_1]' =>
      'Ошибка в файле шаблона: [_1]',
    'Can\'t find template \'[_1]\'' =>
      'Не удалось найти шаблон «[_1]»',
    'Can\'t find entry \'[_1]\'' =>
      'Не удалось найти запись «[_1]»',
    '[_1] is not a hash.' => '[_1] — это не хэш.',
    'The \'[_2]\' attribute will only accept an integer: [_1]' =>
      'В атрибуте «[_2]» допустимо только целое значение: [_1]',
    'You have an error in your \'[_2]\' attribute: [_1]' =>
      'Обнаружена ошибка атрибута «[_2]»: [_1]',
    'No such user \'[_1]\'' =>
      'Пользователь «[_1]» не существует',
    'You used <$MTEntryFlag$> without a flag.' =>
      'Вы использовали <$MTEntryFlag$> без флага.',
    'You used an [_1] tag for linking into \'[_2]\' archives, but that archive type is not published.'
      => 'Вы использовали тег [_1] для связки с архивом «[_2]», который не публикуется.',
    'Could not create atom id for entry [_1]' =>
      'Не удалось создать Atom для записи [_1]',
    'To enable comment registration, you need to add a TypePad token in your weblog config or user profile.'
      => 'Для включения регистрации в комментариях необходимо добавить TypePad-токен для вашего блога или профиля пользователя.',
    'The MTCommentFields tag is no longer available; please include the [_1] template module instead.'
      => 'Тег MTCommentFields больше не доступен; пожалуйста, используйте вместо этого модульный шаблон [_1].',
    'Comment Form' => 'Форма для комментариев',
    'You used an [_1] tag without a date context set up.' =>
      'Вы использовали тег [_1] вне контекста (дата).',
    '[_1] can be used only with Daily, Weekly, or Monthly archives.' =>
      '[_1] может быть использован только в архивах по дням, неделям или месяцам.',
    'Group iterator failed.' =>
      'Не удалось сгруппировать итератор.',
    'You used an [_1] tag outside of the proper context.' =>
      'Вы использовали тег [_1] вне контекста.',
    'Could not determine entry' =>
      'Невозможно определить запись',
    'Invalid month format: must be YYYYMM' =>
      'Неправильный формат даты: должно быть ГГГГММ',
    'No such category \'[_1]\'' =>
      'Категория «[_1]» не найдена',
    '[_1] cannot be used without publishing Category archive.' =>
      '[_1] не может быть использована без публикации архива категории.',
    '<\$MTCategoryTrackbackLink\$> must be used in the context of a category, or with the \'category\' attribute to the tag.'
      => '<\$MTCategoryTrackbackLink\$> должен использоваться в контексте категории или с атрибутом \'category\' в теге',
    '[_1] used outside of [_2]' => '[_1] использован вне [_2]',
    'MT[_1] must be used in a [_2] context' =>
      'MT[_1] должен использоваться в контексте с [_2]',
    'Cannot find package [_1]: [_2]' =>
      'Не удалось найти пакет [_1]: [_2]',
    'Error sorting [_2]: [_1]' =>
      'Ошибка сортировки [_2]: [_1]',
    'You used an [_1] without a author context set up.' =>
      'Вы использовали тег [_1] без контекста (автор).',
    'Can\'t load user.' =>
      'Не удалось загрузить пользователя.',
    'Division by zero.' => 'Деление на ноль',
    'name is required.' => 'имя обязательно.',
    'Specified WidgetSet \'[_1]\' not found.' =>
      'Указанная связка виджетов не найдена.',
    'Can\'t find included template widget \'[_1]\'' =>
      'Не удалось найти включённый шаблон виджета «[_1]»',

## lib/MT/Bootstrap.pm
    'Got an error: [_1]' => 'Получена ошибка: [_1]',

## lib/MT/ImportExport.pm
    'No Blog' => 'Нет блога',
    'You need to provide a password if you are going to create new users for each user listed in your blog.'
      => 'Вам необходимо указать пароли для каждого пользователя, если вы собираетесь их создать.',
    'Need either ImportAs or ParentAuthor' =>
      'Необходим или ImportAs или ParentAuthor',
    'Importing entries from file \'[_1]\'' =>
      'Импорт записей из файла «[_1]»',
    'Creating new user (\'[_1]\')...' =>
      'Создание нового пользователя («[_1]»)…',
    'Saving user failed: [_1]' =>
      'Не удалось сохранить пользователя: [_1]',
    'Assigning permissions for new user...' =>
      'Установка прав для пользователя…',
    'Saving permission failed: [_1]' =>
      'Не удалось сохранить права доступа: [_1]',
    'Creating new category (\'[_1]\')...' =>
      'Создание новой категории («[_1]»)…',
    'Saving category failed: [_1]' =>
      'Не удалось сохранить категорию: [_1]',
    'Invalid status value \'[_1]\'' =>
      'Статус указан неверно «[_1]»',
    'Invalid allow pings value \'[_1]\'' =>
      'Неверно указаны разрешения для пингов [_1]',
    'Can\'t find existing entry with timestamp \'[_1]\'... skipping comments, and moving on to next entry.'
      => 'Не удалось найти запись с временем «[_1]»… пропускаем комментарии и переходим к следующей записи.',
    'Importing into existing entry [_1] (\'[_2]\')' =>
      'Импорт в существующую запись [_1] («[_2]»)',
    'Saving entry (\'[_1]\')...' =>
      'Сохранение записи (\'[_1]\')…',
    'ok (ID [_1])' => 'ok (ID [_1])',
    'Saving entry failed: [_1]' =>
      'Не удалось сохранить запись: [_1]',
    'Saving placement failed: [_1]' =>
      'Не удалось сохранить размещение: [_1]',
    'Creating new comment (from \'[_1]\')...' =>
      'Создание нового комментария (от \'[_1]\')…',
    'Saving comment failed: [_1]' =>
      'Не удалось сохранить комментарий: [_1]',
    'Entry has no MT::Trackback object!' =>
      'Запись не содержит MT::Trackback!',
    'Creating new ping (\'[_1]\')...' =>
      'Создание нового пинга («[_1]»)…',
    'Saving ping failed: [_1]' =>
      'Не удалось сохранить пинг: [_1]',
    'Export failed on entry \'[_1]\': [_2]' =>
      'Экспорт записи «[_1]\» не удался: [_2]',
    'Invalid date format \'[_1]\'; must be \'MM/DD/YYYY HH:MM:SS AM|PM\' (AM|PM is optional)'
      => 'Неверно указан формат времени «[_1]»; должно быть так: «MM/DD/YYYY HH:MM:SS AM|PM» (AM|PM по желанию)',

## lib/MT/ObjectScore.pm
    'Object Score'  => 'Счёт объекта',
    'Object Scores' => 'Счёт объектов',

## lib/MT/Permission.pm
    'Permission'  => 'Права',
    'Permissions' => 'Права',

## lib/MT/FileMgr/DAV.pm
    'DAV connection failed: [_1]' =>
      'Не удалось установить DAV соединение: [_1]',
    'DAV open failed: [_1]' =>
      'Не удалось открыть по DAV: [_1]',
    'DAV get failed: [_1]' =>
      'Не удалось получить по DAV: [_1]',
    'DAV put failed: [_1]' =>
      'Не удалось отправить по DAV: [_1]',
    'Deleting \'[_1]\' failed: [_2]' =>
      'Не удалось удалить «[_1]», потому что: [_2]',
    'Creating path \'[_1]\' failed: [_2]' =>
      'Не удалось создать путь «[_1]»: [_2]',
    'Renaming \'[_1]\' to \'[_2]\' failed: [_3]' =>
      'Не удалось переименовать «[_1]» в «[_2]», потому что: [_3]',

## lib/MT/FileMgr/SFTP.pm
    'SFTP connection failed: [_1]' =>
      'Не удалось установить соединение SFTP: [_1]',
    'SFTP get failed: [_1]' =>
      'Не удалось получить по SFTP: [_1]',
    'SFTP put failed: [_1]' =>
      'Не удалось отправить по SFTP: [_1]',

## lib/MT/FileMgr/FTP.pm

## lib/MT/FileMgr/Local.pm

## lib/MT/TaskMgr.pm
    'Unable to secure lock for executing system tasks. Make sure your TempDir location ([_1]) is writable.'
      => 'Не удаётся выполнить блокировку для выполнения системных задач. Разрешите запись в директории TempDir ([_1]).',
    'Error during task \'[_1]\': [_2]' =>
      'Ошибка при выполнении задачи «[_1]» : [_2]',
    'Scheduled Tasks Update' =>
      'Запланированное задание обновлено',
    'The following tasks were run:' =>
      'Выполнены следующие задания:',

## lib/MT/Asset/Image.pm
    'Images'             => 'Изображения',
    'Actual Dimensions'  => 'Реальные размеры',
    '[_1] x [_2] pixels' => '[_1] x [_2] пикселей',
    'Error cropping image: [_1]' =>
      'Ошибка при обрезке изображения: [_1]',
    'Error scaling image: [_1]' =>
      'Ошибка при изменении изображения: [_1]',
    'Error converting image: [_1]' =>
      'Ошибка при конвертации изображения: [_1]',
    'Error creating thumbnail file: [_1]' =>
      'Ошибка при создании миниатюры изображения: [_1]',
    '%f-thumb-%wx%h-%i%x' => '%f-thumb-%wx%h-%i%x',
    'Can\'t load image #[_1]' =>
      'Не удалось загрузить изображение #[_1]',
    'View image' => 'Просмотр изображения',
    'Permission denied setting image defaults for blog #[_1]' =>
      'Недостаточно прав для сохранения настроек по умолчанию для изображений в блоге #[_1]',
    'Thumbnail image for [_1]' =>
      'Миниатюра изображения для [_1]',
    'Invalid basename \'[_1]\'' =>
      'Неправильное базовое имя «[_1]»',
    'Error writing to \'[_1]\': [_2]' =>
      'Ошибка при записи в «[_1]»: [_2]',
    'Popup Page for [_1]' =>
      'Страница всплывающего окна для [_1]',

## lib/MT/Asset/Video.pm
    'Videos' => 'Видео',

## lib/MT/Asset/Audio.pm

## lib/MT/Builder.pm
    '<[_1]> at line [_2] is unrecognized.' =>
      '<[_1]> в строке [_2] не распознано.',
    '<[_1]> with no </[_1]> on line #' =>
      '<[_1]> нет </[_1]> в строке #',
    '<[_1]> with no </[_1]> on line [_2].' =>
      '<[_1]> нет </[_1]> в строке [_2].',
    '<[_1]> with no </[_1]> on line [_2]' =>
      '<[_1]> нет </[_1]> в строке [_2]',
    'Error in <mt[_1]> tag: [_2]' =>
      'Ошибка в теге <mt[_1]>: [_2]',
    'Unknown tag found: [_1]' =>
      'Найден неизвестный тег: [_1]',

## lib/MT/BackupRestore/ManifestFileHandler.pm
    'Uploaded file was not a valid Melody backup manifest file.' =>
      'Загруженный файл не соответствует формату Melody.',

## lib/MT/BackupRestore/BackupFileHandler.pm
    'Uploaded file was backed up from Melody but the different schema version ([_1]) from the one in this system ([_2]).  It is not safe to restore the file to this version of Melody.'
      => 'Загруженный файл — резервная копия Melody, но его версия схемы базы данных ([_1]) отличается от текущей версии ([_2]). Восстановление данных из этого файла может быть небезопасно.',
    '[_1] is not a subject to be restored by Melody.' =>
      '[_1] — не является причиной для восстановления Melody.',
    '[_1] records restored.' =>
      '[_1] записей восстановлено.',
    'Restoring [_1] records:' =>
      'Восстановление [_1] записей:',
    'User with the same name as the name of the currently logged in ([_1]) found.  Skipped the record.'
      => 'Пользователь с тем же самым именем уже авторизован ([_1]). Пропуск отчёта.',
    'User with the same name \'[_1]\' found (ID:[_2]).  Restore replaced this user with the data backed up.'
      => 'Найден пользователь с тем же самым именем  — «[_1]» (ID:[_2]). При восстановлении была произведена замена этого пользователя полученными данными.',
    'Tag \'[_1]\' exists in the system.' =>
      'Тег «[_1]» уже есть в системе.',
    '[_1] records restored...' =>
      '[_1] записей восстанавливаются…',
    'The role \'[_1]\' has been renamed to \'[_2]\' because a role with the same name already exists.'
      => 'Роль «[_1]» была переименована в «[_2]», потому что роль с таким именем уже существует.',

## lib/MT/Util.pm
    'moments from now' => 'только что',
    '[quant,_1,hour,hours] from now' =>
      '[quant,_1,час,часа,часов] назад',
    '[quant,_1,minute,minutes] from now' =>
      '[quant,_1,минуту,минуты,минут] назад',
    '[quant,_1,day,days] from now' =>
      '[quant,_1,день,дня,дней] назад',
    'less than 1 minute from now' => 'около минуты назад',
    'less than 1 minute ago'      => 'минуту назад',
    '[quant,_1,hour,hours], [quant,_2,minute,minutes] from now' =>
      'прошло [quant,_1,час,часа,часов], [quant,_2,минута,минуты,минут]',
    '[quant,_1,hour,hours], [quant,_2,minute,minutes] ago' =>
      '[quant,_1,час,часа,часов], [quant,_2,минута,минуты,минут]',
    '[quant,_1,day,days], [quant,_2,hour,hours] from now' =>
      'прошло [quant,_1,день,дня,дней], [quant,_2,час,часа,часов]',
    '[quant,_1,day,days], [quant,_2,hour,hours] ago' =>
      '[quant,_1,день,дня,дней], [quant,_2,час,часа,часов] назад',
    '[quant,_1,second,seconds] from now' =>
      '[quant,_1,секунду,секунды,секунд] назад',
    '[quant,_1,second,seconds]' =>
      '[quant,_1,секунда,секунды,секунд]',
    '[quant,_1,minute,minutes], [quant,_2,second,seconds] from now' =>
      '[quant,_1,минуту,минуты,минут] и [quant,_2,секунду,секунды,секунд] назад',
    '[quant,_1,minute,minutes], [quant,_2,second,seconds]' =>
      '[quant,_1,минута,минуты,минут] и [quant,_2,секунда,секунды,секунд]',
    '[quant,_1,minute,minutes]' =>
      '[quant,_1,минута,минуты,минут]',
    '[quant,_1,hour,hours], [quant,_2,minute,minutes]' =>
      '[quant,_1,час,часа,часов] и [quant,_2,минута,минуты,минут]',
    '[quant,_1,hour,hours]' => '[quant,_1,час,часа,часов]',
    '[quant,_1,day,days], [quant,_2,hour,hours]' =>
      '[quant,_1,день,дня,дней] и [quant,_2,час,часа,часов]',
    '[quant,_1,day,days]' => '[quant,_1,день,дня,дней]',
    'Invalid domain: \'[_1]\'' =>
      'Неправильный домен: «[_1]»',

## lib/MT/Compat/v3.pm
    'uses: [_1], should use: [_2]' =>
      'использовано: [_1], а должно быть: [_2]',
    'uses [_1]'          => 'использовано [_1]',
    'No executable code' => 'Нет кода для выполнения',
    'Publish-option name must not contain special characters' =>
      'В параметрах имени публикации не должны содержаться специальные символы.',

## lib/MT/Entry.pm
    'Category'               => 'Категория',
    'record does not exist.' => 'объект не существует.',
    'Draft'                  => 'Черновик',
    'Review'                 => 'Обзор',
    'Future'                 => 'Запланировано',

## lib/MT/XMLRPC.pm
    'No WeblogsPingURL defined in the configuration file' =>
      'WeblogsPingURL не определён в файле настроек (config.cgi)',
    'No MTPingURL defined in the configuration file' =>
      'MTPingURL не определён в файле настроек (config.cgi)',
    'HTTP error: [_1]' => 'Ошибка HTTP: [_1]',
    'Ping error: [_1]' => 'Ошибка пинга: [_1]',

## lib/MT/ObjectDriver/Driver/DBD/SQLite.pm
    'Can\'t open \'[_1]\': [_2]' =>
      'Не удалось открыть «[_1]» : [_2]',

## lib/MT/Asset.pm
    'Asset' => 'Медиа',
    'Could not remove asset file [_1] from filesystem: [_2]' =>
      'Не удалось удалить медиа-файл [_1] с файловой системы: [_2]',
    'Description' => 'Описание',
    'Location'    => 'Размещение',

## lib/MT/BasicAuthor.pm
    'authors' => 'авторы',

## lib/MT/Placement.pm
    'Category Placement' => 'Управление категориями',

## lib/MT/Author.pm
    'The approval could not be committed: [_1]' =>
      'Одобрение не может быть совершено: [_1]',

## lib/MT/Scorable.pm
    'Object must be saved first.' =>
      'Сначала объект должен быть сохранён.',
    'Already scored for this object.' =>
      'Этот объект уже был отмечен',
    'Could not set score to the object \'[_1]\'(ID: [_2])' =>
      'Не удалось установить вес для объекта «[_1]» (ID: [_2])',

## lib/MT/JunkFilter.pm
    'Action: Junked (score below threshold)' =>
      'Действие: В корзину (счёт ниже допустимого)',
    'Action: Published (default action)' =>
      'Действие: Опубликовать (действие по умолчанию)',
    'Junk Filter [_1] died with: [_2]' =>
      'Фильтр корзины [_1] недействителен с: [_2]',
    'Unnamed Junk Filter' =>
      'Безымянный фильтр корзины',
    'Composite score: [_1]' => 'Суммарный подсчёт: [_1]',

## lib/MT/Plugin.pm
    'Publish'        => 'Публикация',
    'My Text Format' => 'Мой формат текста',

## lib/MT/ArchiveType/Page.pm
    'PAGE_ADV' => 'страниц',
    'folder-path/page-basename.html' =>
      'путь-директории/имя-страницы.html',
    'folder-path/page-basename/index.html' =>
      'путь-директории/имя-страницы/index.html',
    'folder_path/page_basename.html' =>
      'путь_директории/имя_страницы.html',
    'folder_path/page_basename/index.html' =>
      'путь_директории/имя_страницы/index.html',

## lib/MT/ArchiveType/Daily.pm
    'DAILY_ADV'             => 'по дням',
    'yyyy/mm/dd/index.html' => 'гггг/мм/дд/index.html',

## lib/MT/ArchiveType/AuthorMonthly.pm
    'AUTHOR-MONTHLY_ADV' => 'авторов по месяцам',

## lib/MT/ArchiveType/Monthly.pm
    'MONTHLY_ADV'        => 'по месяцам',
    'yyyy/mm/index.html' => 'гггг/мм/index.html',

## lib/MT/ArchiveType/Yearly.pm
    'YEARLY_ADV'      => 'по годам',
    'yyyy/index.html' => 'гггг/index.html',

## lib/MT/ArchiveType/Individual.pm
    'INDIVIDUAL_ADV'              => 'записей',
    'yyyy/mm/entry-basename.html' => 'гггг/мм/имя-записи.html',
    'yyyy/mm/entry_basename.html' => 'гггг/мм/имя_записи.html',
    'yyyy/mm/entry-basename/index.html' =>
      'гггг/мм/имя-записи/index.html',
    'yyyy/mm/entry_basename/index.html' =>
      'гггг/мм/имя_записи/index.html',
    'yyyy/mm/dd/entry-basename.html' =>
      'гггг/мм/дд/имя-записи.html',
    'yyyy/mm/dd/entry_basename.html' =>
      'гггг/мм/дд/nomdebase_note.html',
    'yyyy/mm/dd/entry-basename/index.html' =>
      'гггг/мм/дд/имя-записи/index.html',
    'yyyy/mm/dd/entry_basename/index.html' =>
      'гггг/мм/дд/имя_записи/index.html',
    'category/sub-category/entry-basename.html' =>
      'категория/под-категория/имя-записи.html',
    'category/sub-category/entry-basename/index.html' =>
      'категория/под-категория/имя-записи/index.html',
    'category/sub_category/entry_basename.html' =>
      'категория/под_категория/имя_записи.html',
    'category/sub_category/entry_basename/index.html' =>
      'категория/под_категория/имя_записи/index.html',

## lib/MT/ArchiveType/CategoryYearly.pm
    'CATEGORY-YEARLY_ADV' => 'категорий по годам',
    'category/sub-category/yyyy/index.html' =>
      'категория/под-категория/гггг/index.html',
    'category/sub_category/yyyy/index.html' =>
      'категория/под_категория/гггг/index.html',

## lib/MT/ArchiveType/CategoryWeekly.pm
    'CATEGORY-WEEKLY_ADV' => 'категорий по неделям',
    'category/sub-category/yyyy/mm/day-week/index.html' =>
      'категория/под-категория/гггг/мм/день-недели/index.html',
    'category/sub_category/yyyy/mm/day-week/index.html' =>
      'категория/под_категория/гггг/мм/день-недели/index.html',

## lib/MT/ArchiveType/Author.pm
    'AUTHOR_ADV' => 'авторов',

## lib/MT/ArchiveType/AuthorYearly.pm
    'AUTHOR-YEARLY_ADV' => 'авторов по годам',

## lib/MT/ArchiveType/Weekly.pm
    'WEEKLY_ADV' => 'по неделям',
    'yyyy/mm/day-week/index.html' =>
      'гггг/мм/день-недели/index.html',

## lib/MT/ArchiveType/AuthorWeekly.pm
    'AUTHOR-WEEKLY_ADV' => 'авторов по неделям',

## lib/MT/ArchiveType/CategoryMonthly.pm
    'CATEGORY-MONTHLY_ADV' => 'категорий по месяцам',
    'category/sub-category/yyyy/mm/index.html' =>
      'категория/под-категория/гггг/мм/index.html',
    'category/sub_category/yyyy/mm/index.html' =>
      'категория/под_категория/гггг/мм/index.html',

## lib/MT/ArchiveType/Category.pm
    'CATEGORY_ADV' => 'категорий',
    'category/sub-category/index.html' =>
      'категория/под-категория/index.html',
    'category/sub_category/index.html' =>
      'категория/под_категория/index.html',

## lib/MT/ArchiveType/CategoryDaily.pm
    'CATEGORY-DAILY_ADV' => 'категорий по дням',
    'category/sub-category/yyyy/mm/dd/index.html' =>
      'категория/под-категория/гггг/мм/дд/index.html',
    'category/sub_category/yyyy/mm/dd/index.html' =>
      'категория/под_категория/гггг/мм/дд/index.html',

## lib/MT/ArchiveType/AuthorDaily.pm
    'AUTHOR-DAILY_ADV' => 'авторов по дням',

## lib/MT/Config.pm
    'Configuration' => 'Конфигурация',

## lib/MT/CMS/Export.pm
    'Please select a blog.' =>
      'Пожалуйста, выберите блог.',
    'You do not have export permissions' =>
      'У вас недостаточно прав для экспорта',

## lib/MT/CMS/Template.pm
    'index'   => 'индексный',
    'archive' => 'архивный',
    'module'  => 'модульный',
    'widget'  => 'виджет',
    'email'   => 'email',
    'system'  => 'система',
    'One or more errors were found in this template.' =>
      'В шаблоне найдена одна или несколько ошибок.',
    'Create template requires type' =>
      'Для создания шаблонов требуется тип',
    'Entry or Page'     => 'Запись или Страница',
    'New Template'      => 'Новый шаблон',
    'Index Templates'   => 'Индексные шаблоны',
    'Archive Templates' => 'Шаблоны архивов',
    'Template Modules'  => 'Модули шаблонов',
    'System Templates'  => 'Системные шаблоны',
    'Email Templates'   => 'Почтовые шаблоны',
    'Template Backups'  => 'Резервные копии шаблонов',
    'Can\'t locate host template to preview module/widget.' =>
      'Не удалось найти хост, чтобы посмотреть модуль/виджет.',
    'Publish error: [_1]' => 'Ошибка публикации: [_1]',
    'Unable to create preview file in this location: [_1]' =>
      'Не удалось создать файл для предварительного просмотра в этом месте: [_1]',
    'Lorem ipsum'          => 'Lorem ipsum',
    'LOREM_IPSUM_TEXT'     => 'LOREM_IPSUM_TEXT',
    'LORE_IPSUM_TEXT_MORE' => 'LORE_IPSUM_TEXT_MORE',
    'sample, entry, preview' =>
      'образец, запись, предпросмотр',
    'No permissions' => 'Недостаточно прав',
    'Populating blog with default templates failed: [_1]' =>
      'Не удалось создать блог со стандартными шаблонами: [_1]',
    'Setting up mappings failed: [_1]' =>
      'Не удалось настроить карту: [_1]',
    'Saving map failed: [_1]' =>
      'Не удалось сохранить карту: [_1]',
    'You should not be able to enter 0 as the time.' =>
      'Вы не можете указать 0 в качестве времени.',
    'You must select at least one event checkbox.' =>
      'Необходимо отметить хотя бы один пункт.',
    'Template \'[_1]\' (ID:[_2]) created by \'[_3]\'' =>
      'Шаблон «[_1]» (ID:[_2]) создан пользователем «[_3]»',
    'Template \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' =>
      'Шаблон «[_1]» (ID:[_2]) удалён пользователем «[_3]»',
    'No Name'             => 'Без имени',
    'Orphaned'            => 'Осиротевшие',
    ' (Backup from [_1])' => ' (Резервная копия от [_1])',
    'Error creating new template: ' =>
      'Ошибка при создании нового шаблона: ',
    'Skipping template \'[_1]\' since it appears to be a custom template.' =>
      'Пропуск шаблона «[_1]», так как, кажется, это созданный вами шаблон.',
    'Refreshing template <strong>[_3]</strong> with <a href="?__mode=view&amp;blog_id=[_1]&amp;_type=template&amp;id=[_2]">backup</a>'
      => 'Обновлён шаблон <strong>[_3]</strong>, создана <a href="?__mode=view&amp;blog_id=[_1]&amp;_type=template&amp;id=[_2]">резервная копия</a>.',
    'Skipping template \'[_1]\' since it has not been changed.' =>
      'Пропуск шаблона «[_1]», так как он не изменялся.',
    'Copy of [_1]' => 'Копирование [_1]',
    'Cannot publish a global template.' =>
      'Не удалось опубликовать глобальный шаблон.',
    'Permission denied: [_1]' => 'В доступе отказано: [_1]',
    'Save failed: [_1]' => 'Не удалось сохранить: [_1]',
    'Invalid ID [_1]'   => 'Неверный ID [_1]',
    'Saving object failed: [_1]' =>
      'Не удалось сохранить объект: [_1]',
    'Load failed: [_1]' => 'Ошибка загрузки: [_1]',
    '(no reason given)' => '(без указанной причины)',
    'Removing [_1] failed: [_2]' =>
      'Не удалось удалить [_1]: [_2]',
    'template' => 'шаблон',
    'Restoring widget set [_1]... ' =>
      'Восстановление связки виджетов [_1]…',
    'Failed.' => 'Неуспешно.',

## lib/MT/CMS/Entry.pm
    'Invalid parameter' => 'Недопустимый параметр',
    '(untitled)'        => '(безымянный)',
    'New Entry'         => 'Новая запись',
    'New Page'          => 'Новая страница',
    'pages'             => 'страницы',
    'Tag'               => 'Тег',
    'Entry Status'      => 'Статус записи',
    '[_1] Feed'         => '[_1]',
    'Can\'t load template.' =>
      'Не удалось загрузить шаблон.',
    'New [_1]'      => 'Новый [_1]',
    'No such [_1].' => 'Нет таких [_1].',
    'Same Basename has already been used. You should use an unique basename.'
      => 'Это базовое имя уже использовано. Необходимо использовать уникальные базовые имена.',
    'Your blog has not been configured with a site path and URL. You cannot publish entries until these are defined.'
      => 'У вашего блога не настроены URL и путь публикации. Без этой информации публикация невозможна.',
    'Invalid date \'[_1]\'; authored on dates must be in the format YYYY-MM-DD HH:MM:SS.'
      => 'Неправильная дата «[_1]»; формат даты должен быть следующим: ГГГГ-ММ-ДД ЧЧ:ММ:СС.',
    'Invalid date \'[_1]\'; authored on dates should be real dates.' =>
      'Неправильная дата «[_1]»; должны быть указаны реальные сроки.',
    'Saving [_1] failed: [_2]' =>
      'Не удалось сохранить [_1]: [_2]',
    '[_1] \'[_2]\' (ID:[_3]) added by user \'[_4]\'' =>
      '[_1] «[_2]» (ID:[_3]) добавлена пользователем «[_4]»',
    '[_1] \'[_2]\' (ID:[_3]) edited and its status changed from [_4] to [_5] by user \'[_6]\''
      => '[_1] «[_2]» (ID:[_3]), отредактирована пользователем [_6], а также у неё изменён статус с [_4] на [_5].',
    '[_1] \'[_2]\' (ID:[_3]) edited by user \'[_4]\'' =>
      '[_1] «[_2]» (ID:[_3]) отредактирована пользователем «[_4]»',
    'Saving entry \'[_1]\' failed: [_2]' =>
      'Не удалось сохранить запись «[_1]»: [_2]',
    'Removing placement failed: [_1]' =>
      'Не удалось удалить размещение: [_1]',
    'Ping \'[_1]\' failed: [_2]' =>
      'Отправка пинга «[_1]» не удалась: [_2]',
    'Saving permissions failed: [_1]' =>
      'Не удалось сохранить права: [_1]',
    '(user deleted)' => '(пользователь удалён)',
    '(user deleted - ID:[_1])' =>
      '(пользователь удалён — ID:[_1])',
    '<a href="[_1]">QuickPost to [_2]</a> - Drag this link to your browser\'s toolbar then click it when you are on a site you want to blog about.'
      => '<a href="[_1]">Опубликовать в блоге [_2]</a> — Перетащите эту ссылку на панель закладок браузера. Находясь на странице, о которой вы хотите написать, выделите текст и нажмите на эту ссылку — некоторые поля редактора заполнятся автоматически.',
    'Entry \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' =>
      'Запись «[_1]» (ID:[_2]) удалена пользователем «[_3]»',
    'Need a status to update entries' =>
      'Необходим статус, чтобы обновить записи',
    'Need entries to update status' =>
      'Необходимы записи, чтобы обновить стутус',
    'One of the entries ([_1]) did not actually exist' =>
      'Одна из записей ([_1]) не существует',
    '[_1] \'[_2]\' (ID:[_3]) status changed from [_4] to [_5]' =>
      '[_1] «[_2]» (ID:[_3]) изменён статус с [_4] на [_5]',
    '/' => '/',

## lib/MT/CMS/Asset.pm
    'Files' => 'Файлы',
    'Extension changed from [_1] to [_2]' =>
      'Расширение изменено с [_1] на [_2]',
    'Can\'t load file #[_1].' =>
      'Не удалось загрузить файл #[_1].',
    'File \'[_1]\' uploaded by \'[_2]\'' =>
      'Файл «[_1]» загружен пользователем «[_2]»',
    'File \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' =>
      'Файл «[_1]» (ID:[_2]) удалён пользователем «[_3]»',
    'All Assets'   => 'Всё медиа объекты',
    'Untitled'     => 'Безымянный',
    'Archive Root' => 'Папка архива',
    'Site Root'    => 'Папка сайта',
    'Please select a file to upload.' =>
      'Пожалуйста, выберите файл для загрузки.',
    'Invalid filename \'[_1]\'' =>
      'Неверное имя файла «[_1]\»',
    'Please select an audio file to upload.' =>
      'Пожалуйста, выберите аудио файл для загрузки.',
    'Please select an image to upload.' =>
      'Пожалуйста, выберите изображение для загрузки.',
    'Please select a video to upload.' =>
      'Пожалуйста, выберите видео для загрузки.',
    'Before you can upload a file, you need to publish your blog.' =>
      'Прежде чем вы сможете загрузить файл, необходимо опубликовать блог.',
    'Invalid extra path \'[_1]\'' =>
      'Неправильный дополнительный путь «[_1]»',
    'Can\'t make path \'[_1]\': [_2]' =>
      'Не удалось создать путь «[_1]» : [_2]',
    'Invalid temp file name \'[_1]\'' =>
      'Неправильное имя временного файла «[_1]»',
    'Error opening \'[_1]\': [_2]' =>
      'Ошибка при открытии «[_1]»: [_2]',
    'Error deleting \'[_1]\': [_2]' =>
      'Ошибка при удалении «[_1]»: [_2]',
    'File with name \'[_1]\' already exists. (Install File::Temp if you\'d like to be able to overwrite existing uploaded files.)'
      => 'Файл с именем «[_1]» уже существует. (Установите File::Temp, если вы хотите перезаписывать уже загруженные файлы.)',
    'Error creating temporary file; please check your TempDir setting in your coniguration file (currently \'[_1]\') this location should be writable.'
      => 'Ошибка при создании временного файла; пожалуйста, проверьте параметр TempDir в вашем конфигурационном файле (сейчас там указано «[_1]»). Эта папка должна быть доступна для записи.',
    'unassigned' => 'не определено',
    'File with name \'[_1]\' already exists; Tried to write to tempfile, but open failed: [_2]'
      => 'Файл с именем «[_1]» уже существует. Была осуществлена попытка записи временного файла, но не удалось открыть: [_2]',
    'Could not create upload path \'[_1]\': [_2]' =>
      'Не удалось создать путь загрузки «[_1]»: [_2]',
    'Error writing upload to \'[_1]\': [_2]' =>
      'Ошибка записи файла при загрузке в «[_1]»: [_2]',
    'Uploaded file is not an image.' =>
      'Загруженный файл — не изображение.',
    '<' => '<',

## lib/MT/CMS/AddressBook.pm
    'No entry ID provided'   => 'Не указан ID записи',
    'No such entry \'[_1]\'' => 'Нет такой записи: «[_1]»',
    'No email address for user \'[_1]\'' =>
      'У пользователя «[_1]» нет email адреса',
    'No valid recipients found for the entry notification.' =>
      'Нет доступных получателей для уведомления о записи.',
    '[_1] Update: [_2]' => '[_1] обновлено: [_2]',
    'Error sending mail ([_1]); try another MailTransfer setting?' =>
      'Не удалось отправить почту ([_1]); попробовать настроить MailTransfer?',
    'The value you entered was not a valid email address' =>
      'Представленная вами информация не является email адресом',
    'The value you entered was not a valid URL' =>
      'Вы ввели данные, которые не соответствуют URL',
    'The e-mail address you entered is already on the Notification List for this blog.'
      => 'Email, который вы ввели, уже присутствует в списке подписчиков этого блога.',
    'Subscriber \'[_1]\' (ID:[_2]) deleted from address book by \'[_3]\'' =>
      'Подписчик «[_1]» (ID:[_2]) удалён из адресной книги пользователем «[_3]»',

## lib/MT/CMS/Common.pm
    'Cloning blog \'[_1]\'...' =>
      'Клонирование блога «[_1]»…',
    'Error' => 'Ошибка',
    'Finished! You can <a href="javascript:void(0);" onclick="closeDialog(\'[_1]\');">return to the blog listing</a> or <a href="javascript:void(0);" onclick="closeDialog(\'[_2]\');">configure the Site root and URL of the new blog</a>.'
      => 'Готово! Вы можете <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_1]\');\">вернуться к списку блогов</a> или <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_2]\');\">настроить URL и путь публикации</a> нового блога.',
    'Close'              => 'Закрыть',
    'Permisison denied.' => 'В доступе отказано.',
    'The Template Name and Output File fields are required.' =>
      'Необходимо указать имя шаблона и имя публикуемого файла.',
    'Invalid type [_1]' => 'Недопустимый тип [_1]',
    '\'[_1]\' edited the template \'[_2]\' in the blog \'[_3]\'' =>
      '«[_1]» отредактировал шаблон «[_2]» в блоге «[_3]»',
    '\'[_1]\' edited the global template \'[_2]\'' =>
      '«[_1]» отредактировал глобальный шаблон «[_2]»',
    'Notification List' => 'Список подписчиков',
    'Removing tag failed: [_1]' =>
      'Не удалось удалить тег: [_1]',
    'Loading MT::LDAP failed: [_1].' =>
      'Загрузка MT::LDAP не удалась: [_1]',
    'System templates can not be deleted.' =>
      'Системные шаблоны не могут быть удалены.',
    'No blog was selected to clone.' =>
      'Не выбран блог для клонирования',
    'This action can only be run on a single blog at a time.' =>
      'В настоящее время это действие может быть выполнено только в одном блоге.',
    'Invalid blog_id' => 'Неверный ID блога',
    'You need to specify a Site URL' =>
      'Необходимо указать URL сайта',
    'You need to specify a Site Path' =>
      'Необходимо указать путь сайта',
    'Entries must be cloned if comments and trackbacks are cloned' =>
      'Записи будут склонированы, если будут склонированы комментарии и трекбэки',
    'Entries must be cloned if comments are cloned' =>
      'Записи будут склонированы, если будут склонированы комментарии',
    'Entries must be cloned if trackbacks are cloned' =>
      'Записи будут склонированы, если будут склонированы трекбэки',

## lib/MT/CMS/Plugin.pm
    'Plugin Settings'    => 'Настройка плагинов',
    'Plugin Set: [_1]'   => 'Комплект плагинов: [_1]',
    'Individual Plugins' => 'Индивидуальные плагины',

## lib/MT/CMS/Search.pm
    'No [_1] were found that match the given criteria.' =>
      'Нет [_1], удовлетворяющих вашим критериям.',
    'Entry Body'       => 'Основной текст записи',
    'Extended Entry'   => 'Продолжение',
    'Keywords'         => 'Ключевые слова',
    'Basename'         => 'Базовое имя',
    'Comment Text'     => 'Текст комментария',
    'IP Address'       => 'IP адрес',
    'Source URL'       => 'URL источника',
    'Blog Name'        => 'Имя блога',
    'Page Body'        => 'Содержание страницы',
    'Extended Page'    => 'Продолжение',
    'Template Name'    => 'Имя шаблона',
    'Text'             => 'Текст',
    'Linked Filename'  => 'Имя связанного файла',
    'Output Filename'  => 'Имя публикуемого файла',
    'Filename'         => 'Имя файла',
    'Label'            => 'Имя',
    'Log Message'      => 'Журнал сообщений',
    'Username'         => 'Имя пользователя',
    'Site URL'         => 'URL сайта',
    'Search & Replace' => 'Поиск и замена',
    'Invalid date(s) specified for date range.' =>
      'Неправильная дата для промежутка дат.',
    'Error in search expression: [_1]' =>
      'Ошибка при поиске слова: [_1]',
    'Saving object failed: [_2]' =>
      'Не удалось сохранить объект: [_2]',

## lib/MT/CMS/RptLog.pm
    'RPT Log'         => 'Журнал RPT',
    'System RPT Feed' => 'Системный поток RPT',

## lib/MT/CMS/Comment.pm
    'Edit Comment' => 'Редактирование комментария',
    'Orphaned comment' => 'Осиротевшие комментарии',
    'Comments Activity Feed' =>
      'Фид с последними комментариями',
    '*User deleted*' => '*Пользователь удалён*',
    'Authenticated Commenters' =>
      'Авторизованные комментаторы',
    'No such commenter [_1].' =>
      'Нет такого комментатора [_1].',
    'User \'[_1]\' trusted commenter \'[_2]\'.' =>
      'Пользователь «[_1]» предоставил комментатору «[_2]» статус доверенного комментатора.',
    'User \'[_1]\' banned commenter \'[_2]\'.' =>
      'Пользователь «[_1]» заблокировал комментатора «[_2]».',
    'User \'[_1]\' unbanned commenter \'[_2]\'.' =>
      'Пользователь «[_1]»  разблокировал комментатора «[_2]».',
    'User \'[_1]\' untrusted commenter \'[_2]\'.' =>
      'Пользователь «[_1]» снял статус доверенного комментатора у «[_2]».',
    'Feedback Settings' => 'Настройка обратной связи',
    'Parent comment id was not specified.' =>
      'id родительского комментария не определён.',
    'Parent comment was not found.' =>
      'Не найден родительский комментарий.',
    'You can\'t reply to unapproved comment.' =>
      'Вы не можете ответить на неутверждённый комментарий.',
    'Comment (ID:[_1]) by \'[_2]\' deleted by \'[_3]\' from entry \'[_4]\'' =>
      'Комментарий (ID:[_1]), оставленный читателем «[_2]» удалён пользователем «[_3]» из записи «[_4]»',
    'You don\'t have permission to approve this comment.' =>
      'Вы не имеете достаточно полномочий для одобрения этого комментария.',
    'Comment on missing entry!' =>
      'Комментарий для несуществующей записи!',
    'You can\'t reply to unpublished comment.' =>
      'Вы не можете ответить на неопубликованный комментарий.',

## lib/MT/CMS/TrackBack.pm
    'Junk TrackBacks' => 'Трекбэки-спам',
    'TrackBacks where <strong>[_1]</strong> is &quot;[_2]&quot;.' =>
      'Трекбэки, у которых <strong>[_1]</strong> — «[_2]».',
    'TrackBack Activity Feed' =>
      'Фид с последними трекбэками',
    '(Unlabeled category)' => '(Категория без описания)',
    'Ping (ID:[_1]) from \'[_2]\' deleted by \'[_3]\' from category \'[_4]\''
      => 'Пинг (ID:[_1]) от «[_2]» удалён пользователем «[_3]» из категории «[_4]»',
    '(Untitled entry)' => '(Безымянная запись)',
    'Ping (ID:[_1]) from \'[_2]\' deleted by \'[_3]\' from entry \'[_4]\'' =>
      'Пинг (ID:[_1]) от «[_2]» удалён пользователем «[_3]» из записи «[_4]»',
    'No Excerpt'         => 'Нет выдержки',
    'No Title'           => 'Нет заголовка',
    'Orphaned TrackBack' => 'Осиротевшие трекбэки',
    'category'           => 'категория',

## lib/MT/CMS/Tag.pm
    'Invalid type' => 'Недопустимый тип',
    'New name of the tag must be specified.' =>
      'Должно быть определено новое имя тега.',
    'No such tag' => 'Нет такого тега',
    'Error saving entry: [_1]' =>
      'Ошибка при сохранении записи: [_1]',
    'Error saving file: [_1]' =>
      'Ошибка сохранения файла: [_1]',
    'Tag \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' =>
      'Тег «[_1]» (ID:[_2]) удалён пользователм «[_3]»',


## lib/MT/CMS/Tools.pm
    'Password Recovery' => 'Восстановление пароля',
    'Email Address is required for password recovery.' =>
      'Необходимо указать email, иначе вы не сможете восстановить пароль в случае его утери.',
    'User not found' => 'Пользователя не существует',
    'Error sending mail ([_1]); please fix the problem, then try again to recover your password.'
      => 'Ошибка при отправке почты ([_1]); пожалуйста, устраните проблему и попробуйте восстановить пароль снова.',
    'Password reset token not found' =>
      'Ключ сброса пароля не существует',
    'Email address not found' => 'Нет такого адреса',
    'Your request to change your password has expired.' =>
      'У запроса на изменение пароля истёк срок действия.',
    'Invalid password reset request' =>
      'Неверный запрос изменения пароля',
    'Please confirm your new password' =>
      'Подтвердите новый пароль',
    'Passwords do not match' => 'Пароли не совпадают',
    'That action ([_1]) is apparently not implemented!' =>
      'Это действие ([_1]) не осуществлено!',
    'General Settings' => 'Общая настройка',
    'You don\'t have a system email address configured.  Please set this first, save it, then try the test email again.'
      => 'Вы не сконфигурировали email-адрес. Пожалуйста, укажите системный email, сохраните изменения и попробуйте отправить тестовое письмо ещё раз.',
    'Please enter a valid email address' =>
      'Пожалуйста, укажите правильный email',
    'Test email from Melody' => 'Тестовое письмо от Melody',
    'This is the test email sent by your installation of Melody.' =>
      'Это тестовое письмо, отправленное вам из Melody.',
    'Mail was not properly sent' => 'Письмо не отправлено',
    'Test e-mail was successfully sent to [_1]' =>
      'Тестовое письмо успешно отправлено на адрес [_1]',
    'These setting(s) are overridden by a value in the MT configuration file: [_1]. Remove the value from the configuration file in order to control the value on this page.'
      => 'Этот параметр переопределён в конфигурационном файле: [_1]. Удалите это значение из конфигурационного файла, если хотите управлять этим параметром с этой страницы.',
    'Email address is [_1]' => 'Текущий email — [_1]',
    'Debug mode is [_1]'    => 'Режим отладки — [_1]',
    'Performance logging is on' =>
      'Журналирование производительности включено',
    'Performance logging is off' =>
      'Журналирование производительности отключено',
    'Performance log path is [_1]' =>
      'Журнал производительности сохраняется в [_1]',
    'Performance log threshold is [_1]' =>
      'Журналирование ведётся для событий, продолжительностью от [_1] сек.',
    'System Settings Changes Took Place' =>
      'Изменены системные параметры',
    'Invalid password recovery attempt; can\'t recover password in this configuration'
      => 'Попытка восстановления пароля не удалась; невозможно восстановить пароль при текущей настройке',
    'Invalid author_id' => 'Неверный author_id',
    'Backup & Restore'  => 'Бэкап и восстановление',
    'Temporary directory needs to be writable for backup to work correctly.  Please check TempDir configuration directive.'
      => 'Для резервного копирования данных (бекапа) необходимо, чтобы временная директория была перезаписываемой. Проверьте параметры TempDir в конфигурационном файле.',
    'Temporary directory needs to be writable for restore to work correctly.  Please check TempDir configuration directive.'
      => 'Для восстановления данных необходимо, чтобы временная директория была перезаписываемой. Проверьте параметры TempDir в конфигурационном файле.',
    '[_1] is not a number.' => '[_1] — не число.',
    'Copying file [_1] to [_2] failed: [_3]' =>
      'Не удалось скопировать файл [_1] в [_2]: [_3]',
    'Specified file was not found.' =>
      'Указанный файл не найден.',
    '[_1] successfully downloaded backup file ([_2])' =>
      '[_1] успешно загрузил файл бекапа ([_2])',
    'MT::Asset#[_1]: ' => 'MT::Asset#[_1]: ',
    'Some of the actual files for assets could not be restored.' =>
      'Некоторые из медиа объектов не были восстановлены.',
    'Please use xml, tar.gz, zip, or manifest as a file extension.' =>
      'Пожалуйста, используйте файлы с расширением xml, tar.gz, zip или manifest.',
    'Unknown file format' => 'Неизвестный формат файла',
    'Some objects were not restored because their parent objects were not restored.'
      => 'Некоторые объекты не были восстановлены, так как не были восстановлены их родительские объекты.',
    'Detailed information is in the <a href=\'javascript:void(0)\' onclick=\'closeDialog(\"[_1]\")\'>activity log</a>.'
      => 'Подробная информация содержится в <a href=\'javascript:void(0)\' onclick=\'closeDialog(\"[_1]\")\'>журнале активности</a>.',
    '[_1] has canceled the multiple files restore operation prematurely.' =>
      '[_1] преждевременно отменил операцию мульти-восстановления файлов.',
    'Changing Site Path for the blog \'[_1]\' (ID:[_2])...' =>
      'Изменение пути публикации у блога «[_1]» (ID:[_2])…',
    'Removing Site Path for the blog \'[_1]\' (ID:[_2])...' =>
      'Удаление пути публикации у блога «[_1]» (ID:[_2])…',
    'Changing Archive Path for the blog \'[_1]\' (ID:[_2])...' =>
      'Изменение пути публикации архива у блога «[_1]» (ID:[_2])…',
    'Removing Archive Path for the blog \'[_1]\' (ID:[_2])...' =>
      'Удаление пути публикации архива у блога «[_1]» (ID:[_2])…',
    'Changing file path for the asset \'[_1]\' (ID:[_2])...' =>
      'Изменение пути файла для медиа объекта «[_1]» (ID:[_2])…',
    'Please upload [_1] in this page.' =>
      'Пожалуйста, загрузите [_1] на этой странице.',
    'File was not uploaded.' => 'Файл не загружен.',
    'Restoring a file failed: ' =>
      'Не удалось восстановить файл: ',
    'Some of the files were not restored correctly.' =>
      'Некоторые из файлов восстановлены некорректно.',
    'Successfully restored objects to Melody system by user \'[_1]\'' =>
      'Объекты успешно восстановлены в Melody пользователем «[_1]»',
    'Can\'t recover password in this configuration' =>
      'Невозможно восстановить пароль при текущей настройке',
    'Invalid user name \'[_1]\' in password recovery attempt' =>
      'Имя пользователя «[_1]», указанное при восстановлении пароля, указано неверно',
    'User name or password hint is incorrect.' =>
      'Имя пользователя или слово/фраза для восстановления пароля указаны неверно.',
    'User has not set pasword hint; cannot recover password' =>
      'Пользователь не указал слово/фразу для восстановления пароль; пароль не может быть восстановлен',
    'Invalid attempt to recover password (used hint \'[_1]\')' =>
      'Неудачная попытка восстановления пароля (использована фраза «[_1]»)',
    'User does not have email address' =>
      'У пользователя нет email адреса',
    'A password reset link has been sent to [_3] for user  \'[_1]\' (user #[_2]).'
      => 'Ссылка для сброса пароля пользователя [_1] (#[_2]) была отправлена по адресу [_3].',
    'Some objects were not restored because their parent objects were not restored.  Detailed information is in the <a href="javascript:void(0);" onclick="closeDialog(\'[_1]\');">activity log</a>.'
      => 'Некоторые объекты не были восстановлены, так как не были восстановлены их родительские объекты. Подробная информация содержится в <a href=\"javascript:void(0);\" onclick=\"closeDialog(\'[_1]\');\">журнале активности</a>.',
    '[_1] is not a directory.' => '[_1] — не директория.',
    'Error occured during restore process.' =>
      'В процессе восстановления произошла ошибка.',
    'Some of files could not be restored.' =>
      'Не удалось восстановить некоторые файлы.',
    'Blog(s) (ID:[_1]) was/were successfully backed up by user \'[_2]\'' =>
      'Бэкап блога(ов) (ID:[_1]) был успешно сделан пользователем «[_2]»',
    'Melody system was successfully backed up by user \'[_1]\'' =>
      'Полный бекап Melody был успешно сделан пользователем «[_1]»',
    'Some [_1] were not restored because their parent objects were not restored.'
      => 'Некоторые объекты (приблизительно [_1]) не были восстановлены, так как не были восстановлены их родительские объекты.',

## lib/MT/CMS/Dashboard.pm
    'Better, Stronger, Faster' => 'Лучше, мощнее, быстрее',
    'Melody has undergone a significant overhaul in all aspects of performance. Memory utilization has been reduced, publishing times have been increased significantly and search is now 100x faster!'
      => 'Melody подвергся существенной перестройке, связанной со всеми аспектами работы. Было уменьшено использование памяти, значительно сокращено время публикации, а поиск стал быстрее в 100 раз!',
    'Module Caching' => 'Модуль кэширования',
    'Template module and widget content can now be cached in the database to dramatically speed up publishing.'
      => 'Модули шаблонов и виджеты теперь могут кэшироваться в базе данных, что существенно ускоряется процесс публикации.',
    'Improved Template and Design Management' =>
      'Улучшенное управление шаблонами и дизайном',
    'The template editing interface has been enhanced to make designers more efficient at updating their site\'s design. The default templates have also been dramatically simplified to make it easier for you to edit and create the site you want.'
      => 'Интерфейс редактора шаблонов был перепроектирован, чтобы работа дизайнеров была более эффективной. Кроме того, были упрощены стандартные шаблоны, чтобы вы с лёгкостью смогли отредактировать их и создать такой сайт, какой хотите.',
    'Threaded Comments' => 'Ветвистые комментарии',
    'Allow commenters on your blog to reply to each other increasing user engagement and creating more dynamic conversations.'
      => 'Теперь вы можете позволить вашим комментаторам отвечать на комментарии друг друга. Это не только создаёт более динамическую беседу, но и красиво выглядит.',

## lib/MT/CMS/User.pm
    'Create User' => 'Создать пользователя',
    'Can\'t load role #[_1].' =>
      'Не удалось загрузить роль #[_1].',
    'Roles'       => 'Роли',
    'Create Role' => 'Создать роль',
    '(newly created user)' =>
      '(недавно созданный пользователь)',
    'User Associations' =>
      'Пользовательские ассоциации',
    'Role Users & Groups' =>
      'Роли пользователей и группы',
    '(Custom)' => '(Собственное)',
    'The user' => 'Пользователь',
    'Role name cannot be blank.' =>
      'Необходимо указать имя роли.',
    'Another role already exists by that name.' =>
      'Роль с таким именем уже существует.',
    'You cannot define a role without permissions.' =>
      'Невозможно сделать роль без прав.',
    'Invalid ID given for personal blog clone source ID.' =>
      'Указан неправильный ID блога, с которого необходимо сделать клон.',
    'If personal blog is set, the default site URL and root are required.' =>
      'Если создание персональных блогов включено, то необходимо указать URL и путь публикации по умолчанию.',
    'Select a entry author' => 'Выбрать автора записи',
    'Selected author'       => 'Выбранный автор',
    'Type a username to filter the choices below.' =>
      'Напечатайте имя, чтобы отфильтровать представленные ниже.',
    'Entry author' => 'Автор записи',
    'Select a System Administrator' =>
      'Выберите администратора системы',
    'Selected System Administrator' =>
      'Выбранный администратор системы',
    'System Administrator' => 'Администратор системы',
    'represents a user who will be created afterwards' =>
      'представляет пользователя, который будет впоследствии создан',
    'Select Blogs'   => 'Выберите блоги',
    'Blogs Selected' => 'Выбранные блоги',
    'Search Blogs'   => 'Найти блоги',
    'Select Users'   => 'Выберите пользователя',
    'Users Selected' => 'Выбранные пользователи',
    'Search Users'   => 'Поиск пользователей',
    'Select Roles'   => 'Выберите роль',
    'Role Name'      => 'Имя роли',
    'Roles Selected' => 'Выбранные роли',
    ''                  => '',                               # Translate - New
    'Grant Permissions' => 'Назначить права',
    'You cannot delete your own association.' =>
      'Вы не можете удалить собственную ассоциацию.',
    'You cannot delete your own user record.' =>
      'Вы не можете удалить себя.',
    'You have no permission to delete the user [_1].' =>
      'У вас недостаточно прав для удаления пользователя [_1].',
    'User requires username' =>
      'Необходимо указать имя пользователя',
    'User requires display name' =>
      'Необходимо указать отображаемое имя пользователя',
    'A user with the same name already exists.' =>
      'Пользователь с таким именем уже существует.',
    'User requires password' =>
      'Необходимо указать пароль для пользователя',
    'Email Address is required for password recovery' =>
      'Для восстановления пароля необходим email адрес',
    'User \'[_1]\' (ID:[_2]) created by \'[_3]\'' =>
      'Пользователь «[_1]» (ID:[_2]) создан пользователем «[_3]»',
    'User \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' =>
      'Пользователь «[_1]» (ID:[_2]) удалён пользователем \'[_3]\'',

## lib/MT/CMS/Log.pm
    'All Feedback'         => 'Все отзывы читателей',
    'System Activity Feed' => 'Активность в системе',
    'Activity log for blog \'[_1]\' (ID:[_2]) reset by \'[_3]\'' =>
      'Журнал активности для блога «[_1]» (ID:[_2]) очищен пользователем «[_3]»',
    'Activity log reset by \'[_1]\'' =>
      'Журнал активности очищен пользователем «[_1]»',

## lib/MT/CMS/Import.pm
    'Import/Export' => 'Импорт/Экспорт',
    'You do not have import permissions' =>
      'У вас недостаточно прав для импорта',
    'You do not have permission to create users' =>
      'У вас недостаточно прав для создания пользователей',
    'Importer type [_1] was not found.' =>
      'Импортёр типа [_1] не найден.',

## lib/MT/CMS/Folder.pm
    'The folder \'[_1]\' conflicts with another folder. Folders with the same parent must have unique basenames.'
      => 'Папка «[_1]» конфликтует с другой папкой. У папок с одной и той же родительской папкой должны быть уникальные базовые имена.',
    'Folder \'[_1]\' created by \'[_2]\'' =>
      'Папка «[_1]» создана пользователем «[_2]»',
    'The name \'[_1]\' is too long!' =>
      'Имя «[_1]» слишком длинное.',
    'Folder \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' =>
      'Папка «[_1]» (ID:[_2]) удалена пользователем «[_3]»',

## lib/MT/CMS/Category.pm
    'Subfolder'   => 'Подпапка',
    'Subcategory' => 'Подкатегория',
    'The [_1] must be given a name!' =>
      'У [_1] должно быть указано имя!',
    'Add a [_1]' => 'Добавить [_1]',
    'No label'   => 'Нет имени',
    'Category name cannot be blank.' =>
      'Имя категории не может быть пустым.',
    'The category name \'[_1]\' conflicts with another category. Top-level categories and sub-categories with the same parent must have unique names.'
      => 'Имя категории «[_1]» конфликтует с другой категорией. У основных категорий и подкатегорий с одной родительской категорией должны быть уникальные имена.',
    'The category basename \'[_1]\' conflicts with another category. Top-level categories and sub-categories with the same parent must have unique basenames.'
      => 'Базовое имя категории «[_1]» конфликтует с другой категорией. У основных категорий и подкатегорий с одной родительской категорией должны быть уникальные базовые имена.',
    'Category \'[_1]\' created by \'[_2]\'' =>
      'Категория «[_1]» создана пользователем «[_2]»',
    'Category \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' =>
      'Категория «[_1]» (ID:[_2]) удалена пользователем «[_3]»',

## lib/MT/CMS/Blog.pm
    'Publishing Settings' => 'Настройка публикации',
    'New Blog'            => 'Новый блог',
    'Blog Activity Feed'  => 'Активность блога',
    'Can\'t load template #[_1].' =>
      'Не удалось загрузить шаблон #[_1]',
    'index template \'[_1]\'' => 'индексный шаблон «[_1]»',
    '[_1] \'[_2]\''           => '[_1] «[_2]»',
    'Publish Site'            => 'Опубликовать сайт',
    'Invalid blog'            => 'Недоспустимый блог',
    'Select Blog'             => 'Выберите блог',
    'Selected Blog'           => 'Выбранный блог',
    'Type a blog name to filter the choices below.' =>
      'Напечатайте имя блога, чтобы отфильтровать представленные ниже.',
    '[_1] changed from [_2] to [_3]' =>
      '[_1] изменено с [_2] на [_3]',
    'Saved Blog Changes' =>
      'Сохранённые изменения блога',
    'Blog \'[_1]\' (ID:[_2]) created by \'[_3]\'' =>
      'Блог «[_1]» (ID:[_2]) создан пользователем «[_3]»',
    'You did not specify a blog name.' =>
      'Вы не указали имя блога.',
    'Site URL must be an absolute URL.' =>
      'Необходимо указать абсолютный URL.',
    'Archive URL must be an absolute URL.' =>
      'Необходимо указать абсолютный URL архивов.',
    'You did not specify an Archive Root.' =>
      'Вы не указали путь публикации архивов.',
    'Blog \'[_1]\' (ID:[_2]) deleted by \'[_3]\'' =>
      'Блог «[_1]» (ID:[_2]) удалён пользователем «[_3]»',
    'Saving blog failed: [_1]' =>
      'Не удалось сохранить блог: [_1]',
    'Error: Melody cannot write to the template cache directory. Please check the permissions for the directory called <code>[_1]</code> underneath your blog directory.'
      => 'Ошибка: Melody не удалось записать файлы в папку с кешом шаблонов. Пожалуйста, проверьте права доступа для вызываемой директории <code>[_1]</code>, расположенной в папке блога.',
    'Error: Melody was not able to create a directory to cache your dynamic templates. You should create a directory called <code>[_1]</code> underneath your blog directory.'
      => 'Ошибка: Melody не удалось создать директорию для кеширования динамических шаблонов. Вам необходимо создать директорию <code>[_1]</code>, расположенную в папке блога.',

## lib/MT/TemplateMap.pm
    'Archive Mapping'  => 'Путь публикации архивов',
    'Archive Mappings' => 'Пути публикации архивов',

## lib/MT/XMLRPCServer.pm
    'Invalid timestamp format' =>
      'Неверный формат времени',
    'No web services password assigned.  Please see your user profile to set it.'
      => 'Для веб-сервисов создаётся другой пароль. Перейдите к настройке профиля, чтобы узнать эту информацию.',
    'Requested permalink \'[_1]\' is not available for this page' =>
      'Запрошенная постоянная ссылка недоступна для этой страницы',
    'Saving folder failed: [_1]' =>
      'Не удалось сохранить папку: [_1]',
    'No blog_id' => 'Не указан blog_id',
    'Invalid blog ID \'[_1]\'' =>
      'ID «[_1]» для блога указан неверно',
    'Value for \'mt_[_1]\' must be either 0 or 1 (was \'[_2]\')' =>
      'В поле «mt_[_1]» могуть быть только значения 1 или 0 (was \'[_2]\')',
    'Not privileged to edit entry' =>
      'Недостаточно прав для редактирования этой записи',
    'Entry \'[_1]\' ([lc,_5] #[_2]) deleted by \'[_3]\' (user #[_4]) from xml-rpc'
      => 'Запись «[_1]» ([lc,_5] #[_2]) удалена пользователем «[_3]» (ID #[_4]) через xml-rpc',
    'Not privileged to get entry' =>
      'Недостаточно прав для получения этой записи',
    'Not privileged to set entry categories' =>
      'Недостаточно прав для указания категории у записи',
    'Not privileged to upload files' =>
      'Недостаточно прав для загрузки файлов',
    'No filename provided' => 'Не указано имя файла',
    'Error writing uploaded file: [_1]' =>
      'Ошибки при записи загружаемого файла: [_1]',
    'Template methods are not implemented, due to differences between the Blogger API and the Melody API.'
      => 'Из-за различий в Blogger API и Melody API методы шаблона не реализованы.',

## lib/MT/Auth/MT.pm
    'Failed to verify current password.' =>
      'Неверно указан текущий пароль.',

## lib/MT/Auth/OpenID.pm
    'Couldn\'t save the session' =>
      'Не удалось сохранить сессию',
    'Could not load Net::OpenID::Consumer.' =>
      'Не удалось загрузить Net::OpenID::Consumer.',
    'The address entered does not appear to be an OpenID' =>
      'Указанный адрес не может быть использован в качестве OpenID',
    'The text entered does not appear to be a web address' =>
      'Введённый текст не является веб-адресом',
    'Unable to connect to [_1]: [_2]' =>
      'Не удалось соединиться с [_1]: [_2]',
    'Could not verify the OpenID provided: [_1]' =>
      'Не удалось проверить OpenID: [_1]',

## lib/MT/Auth/TypeKey.pm
    'Sign in requires a secure signature.' =>
      'Авторизация требует безопасной подписи.',
    'The sign-in validation failed.' =>
      'Проверка авторизации не удалась.',
    'This weblog requires commenters to pass an email address. If you\'d like to do so you may log in again, and give the authentication service permission to pass your email address.'
      => 'В этом блоге необходимо указать email адрес. Пожалуйста, авторизуйтесь заново, но перед этим укажите в параметрах авторизационного сервиса, чтобы он по запросу передавал ваш email.',
    'Couldn\'t get public key from url provided' =>
      'Не удалось получить публичный ключ.',
    'No public key could be found to validate registration.' =>
      'Публичный ключ, необходимый для проверки регистрации, не найден.',
    'TypePad signature verif\'n returned [_1] in [_2] seconds verifying [_3] with [_4]'
      => 'Проверка подписи TypePad возвратила [_1] за [_2] сек. проверив [_3] с [_4]',
    'The TypePad signature is out of date ([_1] seconds old). Ensure that your server\'s clock is correct'
      => 'Подпись TypePad устарела ([_1] сек. назад). Убедитесь, что часы вашего сервера установлены правильно.',

## lib/MT/Worker/Publish.pm
    '-- set complete ([quant,_1,file,files] in [_2] seconds)' =>
      '-- полный набор ([quant,_1,файл,файла,файлов] за [_2] секунд)',

## lib/MT/Worker/Sync.pm
    'Synchrnizing Files Done' =>
      'Синхронизация файлов завершена',
    'Done syncing files to [_1] ([_2])' =>
      'Синхронизация файлов совершена в [_1] ([_2])',

## lib/MT/Upgrade.pm
    'Comment Posted' => 'Комментарий отправлен',
    'Your comment has been posted!' =>
      'Ваш комментарий получен!',
    'Your comment submission failed for the following reasons:' =>
      'Ваш комментарий не добавлен по следующим причинам:',
    '[_1]: [_2]' => '[_1]: [_2]',
    'Moving metadata storage for categories...' =>
      'Перемещение хранилища метаданных для категорий…',
    'Upgrading metadata storage for [_1]' =>
      'Обновление метаданных для категорий…',
    'Updating password recover email template...' =>
      'Обновление шаблона восстановления пароля…',
    'Migrating Nofollow plugin settings...' =>
      'Миграция настроек плагина Nofollow…',
    'Updating system search template records...' =>
      'Обновление элементов системного шаблона поиска…',
    'Custom ([_1])' => '([_1]) Выборочный',
    'This role was generated by Melody upon upgrade.' =>
      'Эта роль будет обновлена Melody.',
    'Migrating permission records to new structure...' =>
      'Миграция прав пользователей на новую структуру…',
    'Migrating role records to new structure...' =>
      'Миграция ролей на новую структуру…',
    'Migrating system level permissions to new structure...' =>
      'Перемещение прав системного уровня на новую структуру…',
    'Invalid upgrade function: [_1].' =>
      'Неверная функция обновления: [_1].',
    'Error loading class [_1].' =>
      'Ошибка при загрузке класса [_1].',
    'Creating initial blog and user records...' =>
      'Создание первоначального блога и записей пользователя…',
    'Error saving record: [_1].' =>
      'Ошибка сохранения записи: [_1].',
    'First Blog' => 'Первый блог',
    'I just finished installing Melody [_1]!' =>
      'Я установил Melody [_1]!',
    'Welcome to my new blog powered by Melody. This is the first post on my blog and was created for me automatically when I finished the installation process. But that is ok, because I will soon be creating posts of my own!'
      => 'Добро пожаловать в мой новый блог, созданный на платформе Melody. Это первая запись, она была создана для меня автоматически, когда закончился процесс установки. Уже скоро я создам собственные записи!',
    'Melody also created a comment for me as well so that I could see what a comment will look like on my blog once people start submitting comments on all the posts I will write.'
      => 'Melody также создал для меня комментарий, что бы я мог видеть, как он будет выглядеть в моем блоге.',
    'Blog Administrator' => 'Администратор блога',
    'Can administer the blog.' =>
      'Может управлять блогом.',
    'Editor' => 'Редактор',
    'Can upload files, edit all entries/categories/tags on a blog and publish the blog.'
      => 'Может загружать файлы, редактировать все записи, категории, теги блога, а также осуществлять публикацию блога.',
    'Can create entries, edit their own, upload files and publish.' =>
      'Может создавать записи, редактировать свои записи, загружать файлы, также осуществлять публикацию блога.',
    'Designer' => 'Дизайнер',
    'Can edit, manage and publish blog templates.' =>
      'Может управлять шаблонами блога: редактировать и публиковать их.',
    'Webmaster' => 'Вебмастер',
    'Can manage pages and publish blog templates.' =>
      'Может управлять страницами и публиковать шаблоны блога.',
    'Contributor' => 'Участник',
    'Can create entries, edit their own and comment.' =>
      'Может создавать записи, редактировать их и оставлять комментарии.',
    'Moderator' => 'Модератор',
    'Can comment and manage feedback.' =>
      'Может комментировать и управлять отзывами.',
    'Can comment.' => 'Может комментировать.',
    'Removing Dynamic Site Bootstrapper index template...' =>
      'Удаление индексного шаблона Dynamic Site Bootstrapper',
    'Creating new template: \'[_1]\'.' =>
      'Создание нового шаблона: «[_1]».',
    'Mapping templates to blog archive types...' =>
      'Установка соответствий шаблонов типам архива блога…',
    'Renaming PHP plugin file names...' =>
      'Изменение имен файлов PHP плагина…',
    'Error renaming PHP files. Please check the Activity Log.' =>
      'Ошибка при переименовании PHP файлов. Пожалуйста, проверьте журнал активности.',
    'Cannot rename in [_1]: [_2].' =>
      'Не удалось переименовать [_1]: [_2].',
    'Removing unnecessary indexes...' =>
      'Удаление ненужных индексов…',
    'Upgrading table for [_1] records...' =>
      'Обновление таблицы типа «[_1]»…',
    'Upgrading database from version [_1].' =>
      'Обновление базы данных из версии [_1].',
    'Database has been upgraded to version [_1].' =>
      'База данных обновлена до версии [_1].',
    'User \'[_1]\' upgraded database to version [_2]' =>
      'Пользователь «[_1]» обновил базу данных до версии [_2]',
    'Plugin \'[_1]\' upgraded successfully to version [_2] (schema version [_3]).'
      => 'Плагин «[_1]» успешно обновлён до версии [_2] (schema version [_3]).',
    'User \'[_1]\' upgraded plugin \'[_2]\' to version [_3] (schema version [_4]).'
      => 'Пользователь «[_1]» обновил плагин «[_2]» до версии [_3] (schema version [_4]).',
    'Plugin \'[_1]\' installed successfully.' =>
      'Плагин «[_1]» успешно установлен.',
    'User \'[_1]\' installed plugin \'[_2]\', version [_3] (schema version [_4]).'
      => 'Пользователь «[_1]» установил плагин «[_2]», версия [_3] (schema version [_4]).',
    'Setting your permissions to administrator.' =>
      'Установка ваших прав администратора.',
    'Comment Response' =>
      'Уведомление о добавленном комментарие',
    'Creating configuration record.' =>
      'Создание элемента конфигурации.',
    'Creating template maps...' =>
      'Создание карт шаблонов…',
    'Mapping template ID [_1] to [_2] ([_3]).' =>
      'Связывание шаблона ID [_1]с [_2] ([_3]).',
    'Mapping template ID [_1] to [_2].' =>
      'Связывание шаблона ID [_1] с [_2].',
    'Error loading class: [_1].' =>
      'Ошибка загрузки класса: [_1].',
    'Assigning entry comment and TrackBack counts...' =>
      'Назначение комментариев записи и счётчика трекбэков…',
    'Error saving [_1] record # [_3]: [_2]...' =>
      'Ошибка при сохранении объекта [_1] # [_3]: [_2]…',
    'Creating entry category placements...' =>
      'Создание размещений категории записи…',
    'Updating category placements...' =>
      'Обновление размещений категории…',
    'Assigning comment/moderation settings...' =>
      'Установка настроек комментариев/модерации…',
    'Setting blog basename limits...' =>
      'Установка ограничений базового имени в блоге…',
    'Setting default blog file extension...' =>
      'Установка расширения файлов, используем при публикации блога…',
    'Updating comment status flags...' =>
      'Обновление статуса комментария…',
    'Updating commenter records...' =>
      'Обновление элементов комментатора…',
    'Assigning blog administration permissions...' =>
      'Добавление администраторских полномочий…',
    'Setting blog allow pings status...' =>
      'Настройка разрешений пингов в блоге…',
    'Updating blog comment email requirements...' =>
      'Обновление требований email для комментаторов…',
    'Assigning entry basenames for old entries...' =>
      'Назначение базового имени для прошлых записей…',
    'Updating user web services passwords...' =>
      'Обновление паролей для веб-сервисов пользователя…',
    'Updating blog old archive link status...' =>
      'Обновление статуса ссылок блога на предыдущие архивы…',
    'Updating entry week numbers...' =>
      'Обновление количества записей за неделю…',
    'Updating user permissions for editing tags...' =>
      'Обновление полномочий пользователя для редактирования тегов…',
    'Setting new entry defaults for blogs...' =>
      'Установка настроек по умолчанию для новых записей в блоге…',
    'Migrating any "tag" categories to new tags...' =>
      'Перемещение любых "tag" категорий в новые теги…',
    'Assigning custom dynamic template settings...' =>
      'Назначение собственных настроек для динамических шаблонов…',
    'Assigning user types...' =>
      'Назначение пользовательских типов…',
    'Assigning category parent fields...' =>
      'Назначение родительских полей категорий…',
    'Assigning template build dynamic settings...' =>
      'Назначение сборки шаблонов для динамической публикации…',
    'Assigning visible status for comments...' =>
      'Назначение статуса видимости для комментариев…',
    'Assigning junk status for comments...' =>
      'Назначение статуса спамп для комментариев…',
    'Assigning visible status for TrackBacks...' =>
      'Назначение статуса видимости для трекбэков…',
    'Assigning junk status for TrackBacks...' =>
      'Назначение статуса спама для трекбэков…',
    'Assigning basename for categories...' =>
      'Назначение базового имени для категорий…',
    'Assigning user status...' =>
      'Назначение статуса пользователей…',
    'Migrating permissions to roles...' =>
      'Миграция от разрешений к ролям…',
    'Populating authored and published dates for entries...' =>
      'Заполнение авторских и опубликованных дат для записей…',
    'Updating widget template records...' =>
      'Обновление элементов шаблонов виджетов…',
    'Classifying category records...' =>
      'Классификация элементов категорий…',
    'Classifying entry records...' =>
      'Классификация элементов записей…',
    'Merging comment system templates...' =>
      'Объединение системных шаблонов комментариев…',
    'Populating default file template for templatemaps...' =>
      'Заполнение файла шаблона для карты шаблонов…',
    'Removing unused template maps...' =>
      'Удаление неиспользуемых карт шаблона…',
    'Assigning user authentication type...' =>
      'Назначение типов идентификации пользователей',
    'Adding new feature widget to dashboard...' =>
      'Добавление новых виджетов на обзорную панель…',
    'Moving OpenID usernames to external_id fields...' =>
      'Перемещение имён пользователей OpenID в поля external_id…',
    'Assigning blog template set...' =>
      'Назначение связки шаблонов блога…',
    'Assigning blog page layout...' =>
      'Назначение макета страниц блога…',
    'Assigning author basename...' =>
      'Назначение базового имени для авторов…',
    'Assigning embedded flag to asset placements...' =>
      'Установка флага встроенности для медиа…',
    'Updating template build types...' =>
      'Обновление типов шаблонов…',
    'Replacing file formats to use CategoryLabel tag...' =>
      'Перезапись формата файлов для использования тега CategoryLabel…',

## lib/MT/Core.pm
    'Create Blogs'     => 'Создать блог',
    'Manage Plugins'   => 'Управление плагинами',
    'Manage Templates' => 'Управление шаблонами',
    'View System Activity Log' =>
      'Просмотр системного журнала действий',
    'Configure Blog'       => 'Настройка блога',
    'Set Publishing Paths' => 'Указать путь публикации',
    'Manage Categories'    => 'Управление категориями',
    'Manage Tags'          => 'Управление тегами',
    'Manage Address Book' =>
      'Управлениe адресной книгой',
    'View Activity Log' => 'Просмотр журнала действий',
    'Manage Users'    => 'Управление пользователями',
    'Create Entries'  => 'Создание записей',
    'Publish Entries' => 'Публикация записей',
    'Send Notifications' => 'Отправка уведомлений',
    'Edit All Entries'   => 'Редактировать все записи',
    'Manage Pages'       => 'Управление страницами',
    'Publish Blog'       => 'Публикация блога',
    'Save Image Defaults' =>
      'Сохранить параметры по умолчанию для картинок',
    'Manage Assets'   => 'Управление медиа объектами',
    'Post Comments'   => 'Отправить комментарий',
    'Manage Feedback' => 'Управление обратной связью',
    'Error creating performance logs directory, [_1]. Please either change the permissions to make it writable or specify an alternate using the PerformanceLoggingPath configuration directive: [_2]'
      => 'Не удалось создать директорию для журнала производительности ([_1]). Пожалуйста, сделайте директорию перезаписываемой, либо используйте альтернативный путь в конфигурациии PerformanceLoggingPath: [_2]',
    'Error creating performance logs: PerformanceLoggingPath setting must be a directory path, not a file: [_1]'
      => 'Ошибка при создании журнала производительности: параметр PerformanceLoggingPath должнен указывать на директорию, а не на файл: [_1]',
    'Error creating performance logs: PerformanceLoggingPath directory exists but is not writeable: [_1]'
      => 'Ошибка при создании журнала производительности: директория PerformanceLoggingPath существует, но она не перезаписываемая: [_1]',
    'MySQL Database'       => 'База данных MySQL',
    'PostgreSQL Database'  => 'База данных PostgreSQL',
    'SQLite Database'      => 'База данных SQLite',
    'SQLite Database (v2)' => 'База данных SQLite (v2)',
    'Convert Line Breaks' =>
      'Автоматический разрыв строк',
    'Rich Text'          => 'Визуальный редактор',
    'Melody Default'     => 'Melody по умолчанию',
    'weblogs.com'        => 'weblogs.com',
    'technorati.com'     => 'technorati.com',
    'google.com'         => 'google.com',
    'Classic Blog'       => 'Классический блог',
    'Publishes content.' => 'Публикация контента.',
    'Synchronizes content to other server(s).' =>
      'Синхронизация контента с другим сервером.',
    'Refreshes object summaries.' =>
      'Обновление объекта с суммарной информацией.',
    'Adds Summarize workers to queue.' =>
      'Добавление в очередь процессов по суммированию информации.',
    'zip'           => 'zip',
    'tar.gz'        => 'tar.gz',
    'Entries List'  => 'Список записей',
    'Blog URL'      => 'URL блога',
    'Blog ID'       => 'ID блога',
    'Entry Excerpt' => 'Выдержка записи',
    'Entry Link'    => 'Ссылка записи',
    'Entry Extended Text' =>
      'Дополнительный текст записи',
    'Entry Title'             => 'Заголовок записи',
    'If Block'                => 'Блок If',
    'If/Else Block'           => 'Блок If/Else',
    'Include Template Module' => 'Подключить модуль',
    'Include Template File'   => 'Подключить файл',
    'Get Variable'            => 'Получить переменную',
    'Set Variable'            => 'Установить переменную',
    'Set Variable Block' =>
      'Установить блок переменной',
    'Widget Set' => 'Связка виджетов',
    'Publish Scheduled Entries' =>
      'Публикация запланированных записей',
    'Add Summary Watcher to queue' =>
      'Добавление в очередь Summary Watcher',
    'Junk Folder Expiration' => 'Срок хранения спама',
    'Remove Temporary Files' =>
      'Удалить временные файлы',
    'Remove Expired User Sessions' =>
      'Удалить истёкшие сессии пользователей',
    'Remove Expired Search Caches' =>
      'Удалить истёкший поисковый кэш',

## lib/MT/ConfigMgr.pm
    'Alias for [_1] is looping in the configuration.' =>
      'Псевдоним для [_1] повторяется в конфигурационном файле.',
    'Error opening file \'[_1]\': [_2]' =>
      'Ошибка при открытии файла «[_1]»: [_2]',
    'Config directive [_1] without value at [_2] line [_3]' =>
      'Директива в конфигурации [_1] не содержит значения [_2] (строка [_3])',
    'No such config variable \'[_1]\'' =>
      'В конфигурации не найдено такой переменной «[_1]»',

## lib/MT/Comment.pm
    'Load of entry \'[_1]\' failed: [_2]' =>
      'Не удалось загрузить запись «[_1]»: [_2]',

## lib/MT/Role.pm
    'Role' => 'Роль',

## lib/MT/Util/Captcha.pm
    'Melody default CAPTCHA provider requires Image::Magick.' =>
      'Для работы CAPTCHA необходим модуль Image::Magick.',
    'You need to configure CaptchaSourceImageBase.' =>
      'Необходимо настроить CaptchaSourceImagebase.',
    'Image creation failed.' =>
      'Не удалось создать картинку.',
    'Image error: [_1]' => 'Ошибка изображения: [_1]',

## lib/MT/Util/Archive.pm
    'Type must be specified' => 'Необходимо указать тип',
    'Registry could not be loaded' =>
      'Не удалось загрузить регистрацию',

## lib/MT/Util/Archive/Tgz.pm
    'Type must be tgz.' => 'Тип должен быть tgz.',
    'Could not read from filehandle.' =>
      'Не удалось прочитать из дескриптора файла.',
    'File [_1] is not a tgz file.' =>
      'Файл [_1] не в формате tgz.',
    'File [_1] exists; could not overwrite.' =>
      'Файл [_1] уже существует; перезапись не удалась.',
    'Can\'t extract from the object' =>
      'Не удалось извлечь из объекта',
    'Can\'t write to the object' =>
      'Не удалось записать в объект',
    'Both data and file name must be specified.' =>
      'Необходимо указать данные и имя файла.',

## lib/MT/Util/Archive/Zip.pm
    'Type must be zip' => 'Тип должен быть zip.',
    'File [_1] is not a zip file.' =>
      'Файл [_1] не в формате zip.',

## lib/MT/Tag.pm
    'Tag must have a valid name' =>
      'Тег должен иметь допустимое имя',
    'This tag is referenced by others.' =>
      'На этот тег ссылаются другие.',

## lib/MT/Plugin/JunkFilter.pm
    '[_1]: [_2][_3] from rule [_4][_5]' =>
      '[_1]: [_2][_3] согласно правилу [_4][_5]',
    '[_1]: [_2][_3] from test [_4]' =>
      '[_1]: [_2][_3] согласно тесту [_4]',

## lib/MT/App.pm
    'Invalid request: corrupt character data for character set [_1]' =>
      'Недопустимый запрос: неверный символ для кодировки [_1]',
    'First Weblog' => 'Первый блог',
    'Error loading blog #[_1] for user provisioning. Check your NewUserTemplateBlogId setting.'
      => 'Ошибка при загрузке блога #[_1]. Проверьте параметр NewUserTemplateBlogId.',
    'Error provisioning blog for new user \'[_1]\' using template blog #[_2].'
      => 'Ошибка при создании блога для нового пользователя «[_1]», используя шаблоны блога #[_2].',
    'Error creating directory [_1] for blog #[_2].' =>
      'Не удалось создать директорию [_1] для блога #[_2].',
    'Error provisioning blog for new user \'[_1] (ID: [_2])\'.' =>
      'Не удалось создать блог для нового пользователя «[_1]» (ID: [_2]).',
    'Blog \'[_1] (ID: [_2])\' for user \'[_3] (ID: [_4])\' has been created.'
      => 'Блог «[_1]» (ID: [_2]) для пользователя «[_3]» (ID: [_4]) успешно создан.',
    'Error assigning blog administration rights to user \'[_1] (ID: [_2])\' for blog \'[_3] (ID: [_4])\'. No suitable blog administrator role was found.'
      => 'Ошибка при назначении администраторских прав для пользователя «[_1]» (ID: [_2]), блог «[_3]» (ID: [_4]) — не найдено подходящей роли администратора блога.',
    'The login could not be confirmed because of a database error ([_1])' =>
      'Вход с систему не может быть осуществлён из-за ошибки в базе данных ([_1])',
    'Our apologies, but you do not have permission to access any blogs within this installation. If you feel you have reached this message in error, please contact your Melody system administrator.'
      => 'Приносим извинения, но у вас нет разрешения для доступа к блогам в этой системе. Если вы считаете, что произошла ошибка, свяжитесь с администратором Melody.',
    'This account has been disabled. Please see your system administrator for access.'
      => 'Эта учётная запись заблокирована. Пожалуйста, свяжитесь с администратором для получения доступа.',
    'Failed login attempt by pending user \'[_1]\'' =>
      'Ошибка авторизации: попытка входа от ожидающего пользователя «[_1]»',
    'This account has been deleted. Please see your system administrator for access.'
      => 'Эта учётная запись удалена. Пожалуйста, свяжитесь с администратором для получения доступа.',
    'User cannot be created: [_1].' =>
      'Пользователь не может быть создан: [_1].',
    'User \'[_1]\' has been created.' =>
      'Пользователь «[_1]» создан.',
    'User \'[_1]\' (ID:[_2]) logged in successfully' =>
      'Пользователь «[_1]» (ID:[_2]) авторизовался',
    'Invalid login attempt from user \'[_1]\'' =>
      'Неудавшаяся попытка авторизации, используя логин «[_1]»',
    'User \'[_1]\' (ID:[_2]) logged out' =>
      'Пользователь «[_1]» (ID:[_2]) вышел из системы',
    'User requires password.' =>
      'Необходимо указать пароль.',
    'User requires display name.' =>
      'Необходимо указать отображаемое имя (оно будет видно для всех).',
    'User requires username.' =>
      'Необходимо указать логин.',
    'Something wrong happened when trying to process signup: [_1]' =>
      'Что-то пошло не так, пока вы регистрировались: [_1]',
    'New Comment Added to \'[_1]\'' =>
      'Добавлен новый комментарий к «[_1]»',
    'The file you uploaded is too large.' =>
      'Загружаемый файл слишком большой.',
    'Unknown action [_1]' => 'Неизвестное действие [_1]',
    'Warnings and Log Messages' =>
      'Предупреждения и журнал записей',
    'Removed [_1].' => 'Удалено: [_1].',

## lib/MT/Image.pm
    'File size exceeds maximum allowed: [_1] > [_2]' =>
      'Размер файла превышает максимально допустимый: [_1] > [_2]',
    'Can\'t load Image::Magick: [_1]' =>
      'Не удалось загрузить Image::Magick : [_1]',
    'Reading file \'[_1]\' failed: [_2]' =>
      'Ошибка при чтении файла «[_1]»: [_2]',
    'Reading image failed: [_1]' =>
      'Ошибка при чтении изображения: [_1]',
    'Scaling to [_1]x[_2] failed: [_3]' =>
      'Мастштабирование к [_1]x[_2] не удалось: [_3]',
    'Cropping a [_1]x[_1] square at [_2],[_3] failed: [_4]' =>
      'Обрезка [_2],[_3] до размеров [_1]x[_1] не удалась: [_4]',
    'Converting image to [_1] failed: [_2]' =>
      'Конвертация изображения в [_1] не удалась: [_2]',
    'Can\'t load IPC::Run: [_1]' =>
      'Не удалось загрузить IPC::Run : [_1]',
    'Unsupported image file type: [_1]' =>
      'Неподдерживаемый тип изображения: [_1]',
    'Cropping to [_1]x[_1] failed: [_2]' =>
      'Обрезка до [_1]x[_1] не удалась: [_2]',
    'Converting to [_1] failed: [_2]' =>
      'Конвертация в [_1] не удалась: [_2]',
    'You do not have a valid path to the NetPBM tools on your machine.' =>
      'Путь к местоположению NetPBM на сервере указан неверно.',
    'Can\'t load GD: [_1]' =>
      'Не удалось загрузить GD: [_1]',

## lib/MT/WeblogPublisher.pm
    'Archive type \'[_1]\' is not a chosen archive type' =>
      'Тип архива «[_1]» не доступен для выбранного архива.',
    'Parameter \'[_1]\' is required' =>
      'Параметр «[_1]» обязателен.',
    'You did not set your blog publishing path' =>
      'Вы не указали путь публикации для блога',
    'The same archive file exists. You should change the basename or the archive path. ([_1])'
      => 'Точно такой же файл архива уже существует. Попробуйте изменить базовое имя или путь публикации архива ([_1])',
    'An error occurred publishing [_1] \'[_2]\': [_3]' =>
      'Произошла ошибка во время публикации [_1] «[_2]»: [_3]',
    'An error occurred publishing date-based archive \'[_1]\': [_2]' =>
      'Произошла ошибка при публикации архивов по датам «[_1]»: [_2]',
    'Renaming tempfile \'[_1]\' failed: [_2]' =>
      'Не удалось переименовать временный файл «[_1]»: [_2]',
    'Blog, BlogID or Template param must be specified.' =>
      'Должны быть указаны параметры Blog, BlogID или Template.',
    'Template \'[_1]\' does not have an Output File.' =>
      'Для шаблона «[_1]» не найден связанный с ним файл.',
    'An error occurred while publishing scheduled entries: [_1]' =>
      'Возникли ошибки при публикации запланированных записей: [_1]',

## lib/MT/Log.pm
    'Log message'  => 'Сообщение журнала',
    'Log messages' => 'Сообщения журнала',
    'Page # [_1] not found.' =>
      'Страница # [_1] не найдена.',
    'Entry # [_1] not found.' => 'Запись # [_1] не найдена.',
    'Comment # [_1] not found.' =>
      'Комментарий # [_1] не найден.',
    'TrackBack # [_1] not found.' =>
      'Трекбэк # [_1] не найден.',

## lib/MT/Auth.pm
    'Bad AuthenticationModule config \'[_1]\': [_2]' =>
      'Неудачная конфигурация модуля идентификации «[_1]»: [_2]',
    'Bad AuthenticationModule config' =>
      'Неверная конфигурация модуля идентификации',

## lib/MT/DefaultTemplates.pm
    'Archive Index' => 'Список архивов',
    'Stylesheet'    => 'Таблица стилей',
    'JavaScript'    => 'JavaScript',
    'Feed - Recent Entries' =>
      'Лента последних записей (Atom)',
    'RSD' => 'RSD',
    'Monthly Entry Listing' =>
      'Ежемесячный список записей',
    'Category Entry Listing' =>
      'Список записей категории',
    'Improved listing of comments.' =>
      'Улучшенное отображение комментариев',
    'Displays error, pending or confirmation message for comments.' =>
      'Сообщение об ошибке, помещение на модерацию или подтвеждающее сообщение для комментариев.',
    'Displays preview of comment.' =>
      'Предпросмотр для комментария.',
    'Displays errors for dynamically published templates.' =>
      'Отображение ошибок на динамических страницах.',
    'Popup Image' =>
      'Изображение во всплывающем окне',
    'Displays image when user clicks a popup-linked image.' =>
      'Отображение изображения, когда посетитель нажмёт на соответствующую ссылку.',
    'Displays results of a search.' =>
      'Отображение результатов поиска.',
    'About This Page' => 'Об этой странице',
    'Archive Widgets Group' =>
      'Архивные связки виджетов',
    'Current Author Monthly Archives' =>
      'Текущий архив автора по месяцам',
    'Calendar'         => 'Календарь',
    'Creative Commons' => 'Creative Commons',
    'Home Page Widgets Group' =>
      'Связка виджетов домашней страницы',
    'Monthly Archives Dropdown' =>
      'Архивы по месяцам - выпадающий список',
    'Page Listing'      => 'Список страниц',
    'Powered By'        => 'Работает на',
    'Syndication'       => 'Синдикация',
    'Technorati Search' => 'Поиск Technorati',
    'Date-Based Author Archives' =>
      'Архив авторов по датам',
    'Date-Based Category Archives' =>
      'Архив категория по датам',
    'OpenID Accepted'  => 'OpenID принимается',
    'Mail Footer'      => 'Подвал сообщения',
    'Comment throttle' => 'Задержка комментария',
    'Commenter Confirm' =>
      'Подтверждение регистрации комментатора',
    'Commenter Notify' =>
      'Уведомление о новом комментаторе',
    'New Comment'      => 'Новый комментарий',
    'New Ping'         => 'Новый пинг',
    'Entry Notify'     => 'Уведомление о записи',
    'Subscribe Verify' => 'Подтверждение подписки',

## lib/MT/Import.pm
    'Can\'t rewind' => 'Невозможно вернуть',
    'No readable files could be found in your import directory [_1].' =>
      'В директории [_1] не найдено читаемых файлов для импорта.',
    'Couldn\'t resolve import format [_1]' =>
      'Не удалось определить формат импорта [_1]',
    'Melody' => 'Melody',
    'Another system (Melody format)' =>
      'Другие системы (формат Melody)',

## lib/MT/Folder.pm

## lib/MT/ObjectAsset.pm
    'Asset Placement' =>
      'Расположение медиа объектов',

## lib/MT/Category.pm
    'Categories must exist within the same blog' =>
      'Категории должны существовать в пределах одного и того же блога',
    'Category loop detected' =>
      'Обнаружен цикл категорий',

## lib/MT/Blog.pm
    'No default templates were found.' =>
      'Не найдены стандартные шаблоны.',
    'Clone of [_1]' => 'Клон [_1]',
    'Cloned blog... new id is [_1].' =>
      'Клонирование блога… новый ID — [_1].',
    'Cloning permissions for blog:' =>
      'Клонирование прав для блога:',
    '[_1] records processed...' =>
      '[_1] элементов обработано…',
    '[_1] records processed.' =>
      '[_1] элементов обработано.',
    'Cloning associations for blog:' =>
      'Клонирование ассоциаций блога:',
    'Cloning entries and pages for blog...' =>
      'Клонирование записей и страниц блога…',
    'Cloning categories for blog...' =>
      'Клонирование категорий блога…',
    'Cloning entry placements for blog...' =>
      'Клонирование расположения записей блога…',
    'Cloning comments for blog...' =>
      'Клонирование комментариев блога…',
    'Cloning entry tags for blog...' =>
      'Клонирование тегов записей…',
    'Cloning TrackBacks for blog...' =>
      'Клонирование трекбэков блога…',
    'Cloning TrackBack pings for blog...' =>
      'Клонирование отправленных трекбэков блога…',
    'Cloning templates for blog...' =>
      'Клонирование шаблонов блога…',
    'Cloning template maps for blog...' =>
      'Клонирование карт шаблонов блога…',
    'blog'  => 'блог',
    'blogs' => 'блоги',

## lib/MT/TheSchwartz/Error.pm
    'Job Error' => 'Ошибка задачи',

## lib/MT/TheSchwartz/FuncMap.pm
    'Job Function' => 'Функция задачи',

## lib/MT/TheSchwartz/ExitStatus.pm
    'Job Exit Status' => 'Статус задачи выхода',

## lib/MT/TheSchwartz/Job.pm
    'Job' => 'Задача',

## lib/MT/Trackback.pm

## lib/MT/Mail.pm
    'Unknown MailTransfer method \'[_1]\'' =>
      'Неизвестный метод отправки почты — «[_1]»',
    'Sending mail via SMTP requires that your server have Mail::Sendmail installed: [_1]'
      => 'Отправка почты через SMTP требует установленного Mail::Sendmail: [_1]',
    'Error sending mail: [_1]' =>
      'Ошибка при отправке почты: [_1]',
    'You do not have a valid path to sendmail on your machine. Perhaps you should try using SMTP?'
      => 'Путь к sendmail указан неверно. Может быть, попробовать воспользоваться SMTP?',
    'Exec of sendmail failed: [_1]' =>
      'При выполнении sendmail произошла ошибка: [_1]',

## lib/MT/Notification.pm
    'Contact'  => 'Контакт',
    'Contacts' => 'Контакты',

## lib/MT/ObjectTag.pm
    'Tag Placement'  => 'Управление тегами',
    'Tag Placements' => 'Управление тегами',

## lib/MT.pm.pre
    'Powered by [_1]' => 'Работает на [_1]',
    'Version [_1]'    => 'Версия [_1]',
    'http://www.sixapart.com/movabletype/' =>
      'http://www.sixapart.com/movabletype/',
    'OpenID URL' => 'OpenID URL',
    'Sign in using your OpenID identity.' =>
      'Авторизации при помощи идентификатора OpenID.',
    'OpenID is an open and decentralized single sign-on identity system.' =>
      'OpenID — это открытая и децентрализованная система идентификации.',
    'Sign in'                   => 'Авторизуйтесь',
    'Learn more about OpenID.'  => 'Узнать больше об OpenID.',
    'Your LiveJournal Username' => 'Ваш логин в LiveJournal',
    'Learn more about LiveJournal.' =>
      'Узнать больше о LiveJournal.',
    'Your Vox Blog URL'     => 'Адрес вашего блога на Vox',
    'Learn more about Vox.' => 'Узнать больше о Vox.',
    'Sign in using your Gmail account' =>
      'Авторизоваться через GMail-аккаунт',
    'Sign in to Melody with your[_1] Account[_2]' =>
      'Авторизоваться в Melody, используя ваш [_1] аккаунт [_2]',
    'Turn on OpenID for your Yahoo! account now' =>
      'Активировать OpenID для своего аккаунта Yahoo!',
    'Your AIM or AOL Screen Name' =>
      'Отображаемое имя в AIM или AOL (Screen Name)',
    'Sign in using your AIM or AOL screen name. Your screen name will be displayed publicly.'
      => 'Авторизоваться с помощью отображаемого имени AIM или AOL. Отображаемое имя будет доступно публично.',
    'Your Wordpress.com Username' =>
      'Имя пользователя Wordpress.com',
    'Sign in using your WordPress.com username.' =>
      'Авторизоваться с помощью логина на Wordpress.com',
    'TypePad is a free, open system providing you a central identity for posting comments on weblogs and logging into other websites. You can register for free.'
      => 'TypePad — это бесплатная, открытая система, предоставляющая возможность централизованной идентификации для комментирования различных сайтов. Регистрация бесплатна.',
    'Sign in or register with TypePad.' =>
      'Авторизоваться или зарегистрироваться в TypePad.',
    'Turn on OpenID for your Yahoo! Japan account now' =>
      'ктивировать OpenID для своего Yahoo! Japan',
    'Your Hatena ID' => 'Ваш ID в Hatena',
    'Hello, world'   => 'Привет мир',
    'Hello, [_1]'    => 'Привет! Сегодня вы — [_1].',
    'Message: [_1]'  => 'Сообщение: [_1]',
    'If present, 3rd argument to add_callback must be an object of type MT::Component or MT::Plugin'
      => 'Если есть, 3-й параметр для add_callback должен быть объектом типа MT::Component или MT:Plugin',
    '4th argument to add_callback must be a CODE reference.' =>
      '4-й параметр для add_callback должен быть ссылкой CODE.',
    'Two plugins are in conflict' =>
      'Конфликт двух плагинов',
    'Invalid priority level [_1] at add_callback' =>
      'Неверный уровень приоритета [_1] в add_callback',
    'Unnamed plugin'       => 'Безымянный плагин',
    '[_1] died with: [_2]' => '[_1] не работает с: [_2]',
    'Bad ObjectDriver config' =>
      'Неверная конфигурация ObjectDriver',
    'Bad CGIPath config' =>
      'Неверная конфигурация CGIPath',
    'Missing configuration file. Maybe you forgot to move config.cgi-original to config.cgi?'
      => 'Файл конфигурации не найден. Возможно вы забыли переименовать config.cgi-original в  config.cgi?',
    'Plugin error: [_1] [_2]' => 'Ошибка плагина: [_1] [_2]',
    'Loading template \'[_1]\' failed.' =>
      'Не удалось загрузить шаблон «[_1]»',
    '__PORTAL_URL__' => '__PORTAL_URL__',
    'http://www.movabletype.org/documentation/' =>
      'http://www.movabletype.org/documentation/',
    'OpenID'         => 'OpenID',
    'LiveJournal'    => 'LiveJournal',
    'Vox'            => 'Vox',
    'Google'         => 'Google',
    'Yahoo!'         => 'Yahoo!',
    'AIM'            => 'AIM',
    'WordPress.com'  => 'WordPress.com',
    'TypePad'        => 'TypePad',
    'Yahoo! JAPAN'   => 'Yahoo! JAPAN',
    'livedoor'       => 'livedoor',
    'Hatena'         => 'Hatena',
    'Melody default' => 'Melody по умолчанию',

## mt-static/js/dialog.js
    '(None)' => '(Нет)',

## mt-static/js/assetdetail.js
    'No Preview Available' =>
      'Предпросмотр не доступен',
    'View uploaded file' =>
      'Посмотреть загруженный файл',

## mt-static/mt.js
    'delete'  => 'удалить',
    'remove'  => 'переместить',
    'enable'  => 'включить',
    'disable' => 'отключить',
    'You did not select any [_1] to [_2].' =>
      'Вы не выбрали [_1] для [_2].',
    'Are you sure you want to [_2] this [_1]?' =>
      'Вы уверены, что хотите [_2] этот [_1]?',
    'Are you sure you want to [_3] the [_1] selected [_2]?' =>
      'Вы уверены, что хотите [_3] [_1] выбранный [_2]?',
    'Are you certain you want to remove this role? By doing so you will be taking away the permissions currently assigned to any users and groups associated with this role.'
      => 'Вы уверены, что хотите переместить или убрать эту роль? Таким образом вы снимаете ассоциации, приписанные на данный момент пользователям и группам, связанным с этой ролью.',
    'Are you certain you want to remove these [_1] roles? By doing so you will be taking away the permissions currently assigned to any users and groups associated with these roles.'
      => 'Вы уверены, что хотите переместить или убрать эти роли ([_1])? Таким образом вы снимаете ассоциации, приписанные на данный момент пользователям и группам, связанными с этими ролями.',
    'You did not select any [_1] [_2].' =>
      'Вы не выбрали [_1] [_2].',
    'You can only act upon a minimum of [_1] [_2].' =>
      'Вы можете действовать только по минимуму [_1] [_2].',
    'You can only act upon a maximum of [_1] [_2].' =>
      'Вы можете действовать только по максимому [_1] [_2].',
    'You must select an action.' =>
      'Необходимо выбрать действие.',
    'to mark as spam'       => 'пометить как спам',
    'to remove spam status' => 'убрать пометку спам',
    'Enter email address:' =>
      'Ввведите адрес электронной почты:',
    'Enter URL:' => 'Введите URL:',
    'The tag \'[_2]\' already exists. Are you sure you want to merge \'[_1]\' with \'[_2]\'?'
      => 'Тег  «[_2]» уже существует. Вы уверены, что хотите объединить «[_1]» с «[_2]»?',
    'The tag \'[_2]\' already exists. Are you sure you want to merge \'[_1]\' with \'[_2]\' across all weblogs?'
      => 'Тег «[_2]» уже существует. Вы уверены, что хотите объеденить «[_1]» с «[_2]» во всех блогах?',
    'Loading...'                => 'Загрузка…',
    '[_1] &ndash; [_2] of [_3]' => '[_1] — [_2] из [_3]',
    '[_1] &ndash; [_2]'         => '[_1] — [_2]',

## search_templates/default.tmpl
    'SEARCH FEED AUTODISCOVERY LINK PUBLISHED ONLY WHEN A SEARCH HAS BEEN EXECUTED'
      => 'ССЫЛКА ПОИСКА  AUTODISCOVERY ОПУБЛИКОВАНА ТОЛЬКО ТОГДА, КОГДА ПОИСК ОСУЩЕСТВЛЕН.',
    'Blog Search Results' =>
      'Результаты поиска в блоге',
    'Blog search' => 'Поиск по блогу',
    'STRAIGHT SEARCHES GET THE SEARCH QUERY FORM' =>
      'ПРЯМЫЕ ПОИСКИ ПОЛУЧАЮТ ФОРМУ ЗАПРОСОВ',
    'Search this site' => 'Поиск по сайту',
    'Match case'       => 'С учётом регистра',
    'SEARCH RESULTS DISPLAY' =>
      'ОТОБРАЖЕНИЕ РЕЗУЛЬТАТОВ ПОИСКА',
    'Matching entries from [_1]' =>
      'Сопоставление записи из [_1]',
    'Entries from [_1] tagged with \'[_2]\'' =>
      'Записи блога «[_1]», связанные с тегом «[_2]»',
    'Posted <MTIfNonEmpty tag="EntryAuthorDisplayName">by [_1] </MTIfNonEmpty>on [_2]'
      => 'Автор: <MTIfNonEmpty tag="EntryAuthorDisplayName">[_1]</MTIfNonEmpty> — [_2]',
    'Showing the first [_1] results.' =>
      'Показ первые [_1] результатов.',
    'NO RESULTS FOUND MESSAGE' =>
      'СООБЩЕНИЕ ОБ ОТСУТСТВИИ НАЙДЕННЫХ РЕЗУЛЬТАТОВ',
    'Entries matching \'[_1]\'' =>
      'Записи, в которых присутствует «[_1]»',
    'Entries tagged with \'[_1]\'' =>
      'Записи, связанные с тегом «[_1]»',
    'No pages were found containing \'[_1]\'.' =>
      'По запросу «[_1]» ничего не найдено.',
    'By default, this search engine looks for all words in any order. To search for an exact phrase, enclose the phrase in quotes'
      => 'По умолчанию механизм поиска ищет все слова, расположенные в любом порядке. Чтобы искать точную фразу, заключите её в кавычки.',
    'The search engine also supports AND, OR, and NOT keywords to specify boolean expressions'
      => 'Поисковый механизм также поддерживает логические операторы AND, OR и NOT',
    'END OF ALPHA SEARCH RESULTS DIV' =>
      'ОКОНЧАНИЕ ПОИСКА  ALPHA РЕЗУЛЬТАТОВ DIV',
    'BEGINNING OF BETA SIDEBAR FOR DISPLAY OF SEARCH INFORMATION' =>
      'НАЧАЛО BETA SIDEBAR ДЛЯ ОТОБРАЖЕНИЯ ИНФОРМАЦИИ ПОИСКА ',
    'SET VARIABLES FOR SEARCH vs TAG information' =>
      'УСТАНОВИТЕ ПЕРЕМЕННЫЕ ВЕЛИЧИНЫ ДЛЯ ПОИСКА vs TAG информация',
    'If you use an RSS reader, you can subscribe to a feed of all future entries tagged \'[_1]\'.'
      => 'Вы можете подписаться на фид, в котором будут присутствовать новые сообщения этого блога, связанные с тегом «[_1]».',
    'If you use an RSS reader, you can subscribe to a feed of all future entries matching \'[_1]\'.'
      => 'Вы можете подписаться на фид, в котором будут присутствовать новые сообщения этого блога, соответствующие запросу «[_1]».',
    'SEARCH/TAG FEED SUBSCRIPTION INFORMATION' =>
      'ПОИСК/ТЕГ — ИНФОРМАЦИЯ О ПОДПИСКЕ',
    'Feed Subscription' => 'Подписка на обновления',
    'http://www.sixapart.com/about/feeds' =>
      'http://ru.wikipedia.org/wiki/RSS',
    'What is this?' => 'Что это?',
    'TAG LISTING FOR TAG SEARCH ONLY' =>
      'СПИСОК ТЕГОВ  ТОЛЬКО ДЛЯ ПОИСКА ТЕГОВ',
    'Other Tags' => 'Другие теги',
    'END OF PAGE BODY' =>
      'КОНЕЦ ОСНОВНОЙ ЧАСТИ СТРАНИЦЫ',
    'END OF CONTAINER' => 'КОНЕЦ КОНТЕЙНЕРА',

## search_templates/results_feed.tmpl
    'Search Results for [_1]' =>
      'Результат поиска по «[_1]»',

## search_templates/results_feed_rss2.tmpl

## search_templates/comments.tmpl
    'Search for new comments from:' =>
      'Поиск новых комментариев от:',
    'the beginning'     => 'начало',
    'one week back'     => 'неделю назад',
    'two weeks back'    => 'две недели назад',
    'one month back'    => 'месяц назад',
    'two months back'   => '2 месяца назад',
    'three months back' => '3 месяца назад',
    'four months back'  => '4 месяца назад',
    'five months back'  => '5 месяцев назад',
    'six months back'   => '6 месяцев назад',
    'one year back'     => 'год назад',
    'Find new comments' => 'Найти новые комментарии',
    'Posted in [_1] on [_2]' => 'Опубликовано в [_1] — [_2]',
    'No results found'       => 'Нет результатов',
    'No new comments were found in the specified interval.' =>
      'Не найдено новых комментариев за указанный период.',
    'Select the time interval that you\'d like to search in, then click \'Find new comments\''
      => 'Выберите период времени, в котором будет осуществлён поиск, а затем нажмите «Найти новые комментарии»',

## tmpl/include/chromeless_footer.tmpl
    '<a href="[_1]">Melody</a> version [_2]' =>
      '<a href="[_1]">Melody</a> версии [_2]',

## tmpl/cms/edit_category.tmpl
    'Edit Category' => 'Редактировать категорию',
    'Your category changes have been made.' =>
      'Изменения в категории сохранены.',
    'Useful links' => 'Полезные ссылки',
    'Manage entries in this category' =>
      'Управление записями в этой категории',
    'You must specify a label for the category.' =>
      'Необходимо указать имя категории.',
    '_CATEGORY_BASENAME' => 'Базовое имя',
    'This is the basename assigned to your category.' =>
      'Это — базовое имя категории.',
    'Unlock this category&rsquo;s output filename for editing' =>
      'Разблокировать эту категорию, чтобы можно было изменить имя генерируемого файла',
    'Warning: Changing this category\'s basename may break inbound links.' =>
      'Внимание: если вы измените базовое имя категории, то потеряете входящие ссылки на неё.',
    'Inbound TrackBacks' => 'Входящие трекбэки',
    'Accept Trackbacks'  => 'Принимать трекбэки',
    'If enabled, TrackBacks will be accepted for this category from any source.'
      => 'Если эта опция активна, трекбэки для этой категории будут приниматься от любого источника.',
    'View TrackBacks' => 'Просмотр трекбэков',
    'TrackBack URL for this category' =>
      'URL трекбэка для этой категории',
    '_USAGE_CATEGORY_PING_URL' =>
      'Имеется в виду URL, который читатели используют для отправки трекбэков к записям вашего блога. Если вы желаете позволить всем вашим читателям отправлять трекбэки, опубликуйте этот URL. Если вы хотите, чтобы только избранные читатели могли отправлять трекбэки, сообщите им URL в частном порядке. И, наконец, чтобы включить список поступивших трекбэков на главной странице, ознакомьтесь с документацией по тегам шаблонов, связанных с трекбэками.',
    'Passphrase Protection' => 'Passphrase Protection',
    'Optional'              => 'По желанию',
    'Outbound TrackBacks'   => 'Исходящие трекбэки',
    'Trackback URLs'        => 'URL-ы трекбэков',
    'Enter the URL(s) of the websites that you would like to send a TrackBack to each time you create an entry in this category. (Separate URLs with a carriage return.)'
      => 'Перечислите адреса сайтов, на которые вы хотите отправить трекбэки, каждый раз, когда вы создаёте запись. (К качестве разделителя используйте перевод строки.)',
    'Save changes to this category (s)' =>
      'Сохранить изменения категории (s)',
    'Save Changes' => 'Сохранить изменения',

## tmpl/cms/list_blog.tmpl
    'You have successfully deleted the blogs from the Melody system.' =>
      'Блоги успешно удалены из системы Melody.',
    'You have successfully refreshed your templates.' =>
      'Шаблоны успешно обновлены.',
    'You can not refresh templates: [_1]' =>
      'Вы не можете восстановить ваши шалоны: [_1]',
    'Create Blog' => 'Создать блог',

## tmpl/cms/cfg_archives.tmpl
    'Error: Melody was not able to create a directory for publishing your blog. If you create this directory yourself, assign sufficient permissions that allow Melody to create files within it.'
      => 'Ошибка: система Melody не смогла создать каталог для публикации блога. Если Вы создаёте этот каталог самостоятельно, установите права доступа, позволяющие Melody создавать файлы в нем.',
    'Your blog\'s archive configuration has been saved.' =>
      'Конфигурация архива блога сохранена.',
    'You have successfully added a new archive-template association.' =>
      'Ассоциация архив-шаблон успешно добавлена.',
    'You may need to update your \'Master Archive Index\' template to account for your new archive configuration.'
      => 'Возможно требуется обновление шаблона «Master Archive Index» с учетом изменений в конфигурации архива.',
    'The selected archive-template associations have been deleted.' =>
      'Выбранная ассоциация архив-шаблон удалена.',
    'Warning: one or more of your templates is set to publish dynamically using PHP, however your server side include method may not be compatible with dynamic publishing.'
      => 'Предупреждение: один или несколько ваших шаблонов настроены на динамическую публикацию с использованием PHP, но следует учесть, что включение на стороне сервера (SSI) не совместимы с динамической публикацией.',
    'You must set your Local Site Path.' =>
      'Необходимо ввести локальный путь на сайте.',
    'You must set a valid Site URL.' =>
      'Необходимо ввести корректный URL сайта.',
    'You must set a valid Local Site Path.' =>
      'Необходимо установить локальный путь на сайте.',
    'You must set Local Archive Path.' =>
      'Необходимо указать локальный путь архива.',
    'You must set a valid Archive URL.' =>
      'Необходимо указать правильный URL архива.',
    'You must set a valid Local Archive Path.' =>
      'Необходимо указать правильный локальный путь архива.',
    'Publishing Paths' => 'Пути для публикации',
    'The URL of your website. Do not include a filename (i.e. exclude index.html). Example: http://www.example.com/blog/'
      => 'URL вашего сайта. Не включайте имя файла (например, исключите index.html). Пример : http://www.example.com/blog/',
    'Unlock this blog&rsquo;s site URL for editing' =>
      'Разблокировать URL сайта для редактирования',
    'Warning: Changing the site URL can result in breaking all the links in your blog.'
      => 'Внимание : если вы измените URL сайта, входящие ссылки на него будут утеряны.',
    'The path where your index files will be published. An absolute path (starting with \'/\') is preferred, but you can also use a path relative to the Melody directory. Example: /home/melody/public_html/blog'
      => 'Путь публикации индексных файлов. Рекомендуется использовать абсолютный путь (начинающийся с «/»), но можно также указать путь относительно каталога Melody. Пример абсолютного пути: /home/melody/public_html/blog',
    'Unlock this blog&rsquo;s site path for editing' =>
      'Разблокировать путь сайта этого блога для редактирования',
    'Note: Changing your site root requires a complete publish of your site.'
      => 'Замечание: При изменении корневого пути требуется полная публикация сайта.',
    'Advanced Archive Publishing' =>
      'Дополнительные параметры публикации архивов',
    'Select this option only if you need to publish your archives outside of your Site Root.'
      => 'Выберите эту опцию только в том случае, если вы желаете публиковать архивы вне корневого каталога сайта.',
    'Publish archives outside of Site Root' =>
      'Публиковать архивы вне корневого каталога сайта',
    'Archive URL' => 'URL архива',
    'Enter the URL of the archives section of your website. Example: http://archives.example.com/'
      => 'Введите URL для архива вашего сайта. Например: http://archives.example.com/',
    'Unlock this blog&rsquo;s archive url for editing' =>
      'Разблокировать URL архива сайта для редактирования',
    'Warning: Changing the archive URL can result in breaking all the links in your blog.'
      => 'Внимание: если вы измените URL архива, то потеряете входящие ссылки на него.',
    'Enter the path where your archive files will be published. Example: /home/melody/public_html/archives'
      => 'Введите путь для публикации архивов. Пример: /home/melody/public_html/archives',
    'Warning: Changing the archive path can result in breaking all the links in your blog.'
      => 'Внимание: если вы измените путь к архивам, то потеряете входящие ссылки на него.',
    'Asynchronous Job Queue' =>
      'Асинхронная задача очереди',
    'Use Publishing Queue' =>
      'Использовать очередь публикации (нужен CRON)',
    'Requires the use of a cron job to publish pages in the background.' =>
      'Публикация страниц в фоновом режиме требует использования cron (запланированных заданий).',
    'Use background publishing queue for publishing static pages for this blog'
      => 'Использовать очередь для фоновой публикации статических страниц блога',
    'Dynamic Publishing Options' =>
      'Опции динамической публикации',
    'Enable dynamic cache' =>
      'Включить кеширование динамических страниц',
    'Enable conditional retrieval' =>
      'Включить условный поиск',
    'Archive Options' => 'Опции архивов',
    'File Extension'  => 'Расширение файлов',
    'Enter the archive file extension. This can take the form of \'html\', \'shtml\', \'php\', etc. Note: Do not enter the leading period (\'.\').'
      => 'Введите расширение файлов архива. Например: html, shtml, php, и.т.д. Внимание: не вводите стартовую точку («.»).',
    'Preferred Archive' => 'Предпочтительный архив',
    'Used for creating links to an archived entry (permalink). Select from the archive types used in this blogs archive templates.'
      => 'Используется для создания ссылок на архивную запись (постоянная ссылка записи). Выберите один из типов архивов, используемых в шаблонах блога.',
    'No archives are active' => 'Нет активных архивов',
    'Module Options'         => 'Опции модуля',
    'Enable template module caching' =>
      'Включить модуль кэширования шаблонов',
    'Server Side Includes' =>
      'Включении на стороне сервера (SSI)',
    'None (disabled)' => 'Нет (отключено)',
    'PHP Includes'    => 'PHP-включение',
    'Apache Server-Side Includes' =>
      'Apache - включение на стороне сервера',
    'Active Server Page Includes' => 'ASP-включение',
    'Java Server Page Includes'   => 'JSP-включение',
    'Save changes to these settings (s)' =>
      'Сохранить изменения этих настроек',

## tmpl/cms/list_notification.tmpl
    'You have added [_1] to your address book.' =>
      'Вы успешно добавили [_1] в адресную книгу.',
    'You have successfully deleted the selected contacts from your address book.'
      => 'Выбранные контакты удалены из адресной книги.',
    'Download Address Book (CSV)' =>
      'Скачать адресную книгу (CSV)',
    'contact'                  => 'контакт',
    'contacts'                 => 'контакты',
    'Delete selected [_1] (x)' => 'Удалить выбранные [_1]',
    'Create Contact'           => 'Создать контакт',
    'Email'                    => 'Email',
    'Website URL'              => 'Адрес сайта (URL)',
    'Add Contact'              => 'Добавить контакт',

## tmpl/cms/cfg_comments.tmpl
    'Comment Settings' => 'Настройка комментариев',
    'Your preferences have been saved.' =>
      'Параметры сохранены.',
    'Note: Commenting is currently disabled at the system level.' =>
      'Примечание: в настоящее время комментарии отключены на системном уровне.',
    'Comment authentication is not available because one of the needed modules, MIME::Base64 or LWP::UserAgent is not installed. Talk to your host about getting this module installed.'
      => 'Авторизация в комментариях не активна, так как отсутствует модуль MIME::Base64 или LWP::UserAgent. Свяжитесь с администратором сервера для установки модуля.',
    'Accept Comments' => 'Принимать комментарии',
    'If enabled, comments will be accepted.' =>
      'Если активно, комментарии будут приниматься.',
    'Setup Registration' => 'Настройка регистрации',
    'Commenting Policy'  => 'Политика комментирования',
    'Immediately approve comments from' =>
      'Автоматически одобрять комментарии',
    'Specify what should happen to comments after submission. Unapproved comments are held for moderation.'
      => 'Укажите, что должно происходить после добавления комментариев. Не одобренные комментарии помещаются на модерацию.',
    'No one' => 'Ни от кого',
    'Trusted commenters only' =>
      'Только от доверенных комментаторов',
    'Any authenticated commenters' =>
      'От любого авторизованного комментатора',
    'Anyone'     => 'От всех',
    'Allow HTML' => 'Разрешить HTML',
    'If enabled, users will be able to enter a limited set of HTML in their comments. If not, all HTML will be stripped out.'
      => 'Если активно, автор комментария сможет использовать HTML-теги, разрешённые вами. В противном случае HTML не будет публиковаться.',
    'Limit HTML Tags' => 'Лимит HTML тегов',
    'Specifies the list of HTML tags allowed by default when cleaning an HTML string (a comment, for example).'
      => 'Укажите список разрешённых HTML тегов.',
    'Use defaults' =>
      'Использовать значения по умолчанию',
    '([_1])' => '([_1])',
    'Use my settings' =>
      'Использовать собственные параметры',
    'Apply \'nofollow\' to URLs' =>
      'Добавить «nofollow» и «noindex» к URL',
    'This preference affects both comments and TrackBacks.' =>
      'Эта опция затрагивает комментарии и трекбэки.',
    'If enabled, all URLs in comments and TrackBacks will be assigned a \'nofollow\' link relation.'
      => 'Если активно, то ко всем URL в комментариях и трекбэках будет добавлен атрибут «nofollow», а также они будут заключены в тег noindex.',
    'Disable \'nofollow\' for trusted commenters' =>
      'Отключить nofollow и noindex для доверенных комментаторов',
    'If enabled, the \'nofollow\' link relation will not be applied to any comments left by trusted commenters.'
      => 'Если активно, к ссылкам от доверенных комментаторов не будет добавлять атрибут nofollow и тег noindex.',
    'E-mail Notification' => 'Уведомление по email',
    'Specify when Melody should notify you of new comments if at all.' =>
      'Укажите, когда Melody должен уведомлять вас о новых комментариях.',
    'On' => 'Активно',
    'Only when attention is required' =>
      'Только, когда требуется проверка',
    'Off' => 'Отключено',
    'Comment Display Options' =>
      'Опции отображения комментариев',
    'Comment Order' => 'Порядок комментариев',
    'Select whether you want visitor comments displayed in ascending (oldest at top) or descending (newest at top) order.'
      => 'Выберите, каким образом должны отображаться комментарии на сайте: по возрастания (наиболее ранние вверху) или по убыванию (последние вверху).',
    'Ascending'  => 'По возрастанию',
    'Descending' => 'По убыванию',
    'Auto-Link URLs' =>
      'Автоматически создавать ссылку из URL',
    'If enabled, all non-linked URLs will be transformed into links to that URL.'
      => 'Если активно, то любой URL из текста комментария будет автоматически трансформирован в ссылку.',
    'Text Formatting' => 'Форматирование текста',
    'Specifies the Text Formatting option to use for formatting visitor comments.'
      => 'Укажите тип форматирования текста комментариев.',
    'CAPTCHA Provider' => 'Провайдер CAPTCHA',
    'none'             => 'никто',
    'No CAPTCHA provider available' =>
      'Нет доступного провайдера CAPTCHA',
    'No CAPTCHA provider is available in this system.  Please check to see if Image::Magick is installed, and CaptchaSourceImageBase directive points to captcha-source directory under mt-static/images.'
      => 'В этой системе не доступен ни один CAPTCHA провайдер. Пожалуйста, удостоверьтесь, что установлен Image::Magick, и директива CaptchaSourceImageBase расположена в mt-static/images.',
    'Use Comment Confirmation Page' =>
      'Использовать страницу подтверждения комментариев',
    'Use comment confirmation page' =>
      'Использовать страницу подтверждения комментариев',

## tmpl/cms/system_check.tmpl
    'User Counts' => 'Статистика пользователей',
    'Number of users in this system.' =>
      'Число пользователей системы',
    'Total Users'  => 'Всего пользователей',
    'Active Users' => 'Активных пользователей',
    'Users who have logged in within 90 days are considered <strong>active</strong> in Melody license agreement.'
      => 'Пользователи, выполнившие вход в систему в течение последних 90 дней, считаются <strong>активными</strong> по условиям лицензионного соглашения Melody.',
    'Memcache Status' => 'Стутус Memcache',
    'Server Model'    => 'Серверная модель',
    'Melody could not find the script named \'check.cgi\'. To resolve this issue, please ensure that the check.cgi script exists and/or the CheckScript configuration parameter references it properly.'
      => 'Melody не может найти скрипт «check.cgi». Убедитесь, что скрипт check.cgi существует, а также, что параметр CheckScript настроен правильно.',

## tmpl/cms/cfg_system_feedback.tmpl
    'System: Feedback Settings' =>
      'Настройка обратной связи: системный уровень',
    'Your feedback preferences have been saved.' =>
      'Параметры обратной связи сохранены',
    'Feedback: Master Switch' =>
      'Обратная связь: глобальная настройка',
    'This will override all individual blog settings.' =>
      'Эта опция переопределит все индивидуальные параметры блогов.',
    'Disable comments for all blogs' =>
      'Запретить комментарии во всех блогах',
    'Disable TrackBacks for all blogs' =>
      'Запретить трекбэки во всех блогах',
    'Outbound Notifications' => 'Исходящие уведомления',
    'Notification pings'     => 'Пинги',
    'This feature allows you to disable sending notification pings when a new entry is created.'
      => 'Эта опция позволяет отключить пингование при создании новой записи.',
    'Disable notification pings for all blogs' =>
      'Отключение пинги для всех блогов',
    'Limit outbound TrackBacks and TrackBack auto-discovery for the purposes of keeping your installation private.'
      => 'Ограничение исходящих трекбэков и автоматического поиска трекбэков на других сайтах.',
    'Allow to any site' =>
      'Разрешено для любого сайта',
    'Disabled' => 'Отключено',
    '(No outbound TrackBacks)' =>
      '(Нет исходящих трекбэков)',
    'Only allow to blogs on this installation' =>
      'Разрешить только блогам, обслуживаемым данной инсталляцией Melody.',
    'Only allow the sites on the following domains:' =>
      'Разрешить для сайтов на следующих доменах:',

## tmpl/cms/edit_widget.tmpl
    'Edit Widget Set' =>
      'Редактировать связку виджетов',
    'Create Widget Set' => 'Создание связки виджетов',
    'Please use a unique name for this widget set.' =>
      'Пожалуйста, используйте уникальное имя для связки виджетов.',
    'Your template changes have been saved.' =>
      'Шаблон сохранён.',
    'Set Name' => 'Имя связки',
    'Drag and drop the widgets you want into the Installed column.' =>
      'Перетащите необходимые вам виджеты в колонку используемых виджетов.',
    'Installed Widgets' => 'Используемые виджеты',
    'edit'              => 'редактировать',
    'Available Widgets' => 'Доступные виджеты',
    'Save changes to this widget set (s)' =>
      'Сохранить изменения этой связки виджетов (s)',

## tmpl/cms/preview_template_strip.tmpl
    'You are previewing the template named &ldquo;[_1]&rdquo;' =>
      'Вы просматриваете шаблон «[_1]»',
    '(Publish time: [_1] seconds)' =>
      '(Время публикации: [quant,_1,секунда,секунды,секунд])',
    'Save this template (s)' => 'Сохранить шаблон (s)',
    'Save this template'     => 'Сохранить шаблон',
    'Re-Edit this template (e)' =>
      'Повторное редактирование шаблона (e)',
    'Re-Edit this template' =>
      'Повторное редактирование шаблона',

## tmpl/cms/cfg_registration.tmpl
    'Registration Settings' => 'Настройка регистрации',
    'Your blog preferences have been saved.' =>
      'Параметры блога сохранены.',
    'User Registration' =>
      'Регистрация пользователей',
    'Allow registration for Melody.' =>
      'Разрешить регистрацию в Melody.',
    'Registration Not Enabled' => 'Регистрация запрещена',
    'Note: Registration is currently disabled at the system level.' =>
      'Внимание: регистрация запрещена на системном уровне.',
    'Allow Registration'     => 'Разрешить регистрацию',
    'Authentication Methods' => 'Методы авторизации',
    'Note: You have selected to accept comments from authenticated commenters only but authentication is not enabled. In order to receive authenticated comments, you must enable authentication.'
      => 'Внимание: вы разрешили комментарии только от авторизованных пользователей, но при этом авторизация отключена. Для получения авторизованных комментариев необходимо разрешить авторизацию.',
    'Native' => 'Встроенная',
    'Require E-mail Address for Comments via TypePad' =>
      'Требовать email для авторизовавшихся через TypePad',
    'If enabled, visitors must allow their TypePad account to share e-mail address when commenting.'
      => 'Если активно, то комментаторы должны разрешить в своём аккаунте TypePad передачу email адреса.',
    'One or more Perl modules may be missing to use this authentication method.'
      => 'Один или несколько Perl-модулей отсутствуют для этого метода авторизации',
    'Setup TypePad' => 'Настройка TypePad',
    'OpenID providers disabled' =>
      'Провайдеры OpenID отключены',
    'Required module (Digest::SHA1) for OpenID commenter authentication is missing.'
      => 'Модуль (Digest::SHA1), необходимый для авторизации через OpenID, не найден.',

## tmpl/cms/list_comment.tmpl
    'Manage Comments' => 'Управление комментариями',
    'Your changes have been saved.' =>
      'Изменения сохранены.',
    'The selected comment(s) has been approved.' =>
      'Выбранные комментарии успешно одобрены.',
    'All comments reported as spam have been removed.' =>
      'Все комментарии, помеченные как спам, были удалены.',
    'The selected comment(s) has been unapproved.' =>
      'У выбранных комментариев снято одобрение.',
    'The selected comment(s) has been reported as spam.' =>
      'Выбранные комментарии помечены как спам.',
    'The selected comment(s) has been recovered from spam.' =>
      'Выбранные комментарии восстановлены из спама.',
    'The selected comment(s) has been deleted from the database.' =>
      'Выбранные комментарии были удалены навсегда.',
    'One or more comments you selected were submitted by an unauthenticated commenter. These commenters cannot be Banned or Trusted.'
      => 'Один или несколько комментариев, которые вы выбрали, оставлены неавторизованными комментаторами. Поэтому вы не можете их заблокировать или добавить в список доверенных.',
    'No comments appeared to be spam.' =>
      'Нет спам-комментариев.',
    'Quickfilters'    => 'Быстрые фильтры',
    '[_1] (Disabled)' => '[_1] (деактивирован)',
    'Set Web Services Password' =>
      'Установить пароль для веб-сервисов',
    'All [_1]'           => 'Все [_1]',
    'change'             => 'изменить',
    'Showing only: [_1]' => 'Показаны: [_1]',
    '[_1] on entries created within the last [_2] days' =>
      '[_1] к записям, созданных за последние [_2] дн.',
    '[_1] on entries created more than [_2] days ago' =>
      '[_1] к записям, созданные более [_2] дн. назад',
    '[_1] where [_2] is [_3]' => '[_1], у которых [_2] — [_3]',
    'Remove filter'           => 'Убрать фильтр',
    'status'                  => 'статус',
    'is'                      => ' — ',
    'approved'                => 'принято',
    'pending'                 => 'ожидающий',
    'spam'                    => 'Спам',

## tmpl/cms/edit_asset.tmpl
    'Edit Asset' => 'Редактирование медиа',
    'Your asset changes have been made.' =>
      'Изменения в медиа сделаны',
    'Stats' => 'Статистика',
    '[_1] - Created by [_2]' =>
      '[_1] — создано пользователем [_2]',
    '[_1] - Modified by [_2]' =>
      '[_1] — изменено пользователем [_2]',
    'Appears in...'     => 'Используется в…',
    'Published on [_1]' => 'Опубликовано — [_1]',
    'Show all entries'  => 'Показать все записи',
    'Show all pages'    => 'Показать все страницы',
    'This asset has not been used.' =>
      'Этот объект ещё не был использован.',
    'Related Assets' => 'Похожее медиа',
    'No thumbnail image' =>
      'Нет миниатюры изображения',
    'You must specify a label for the asset.' =>
      'Необходимо указать имя для медиа',
    '[_1] is missing' => '[_1] не найдено',
    'View Asset'      => 'Просмотр медиа',
    'Embed Asset'     => 'Встроить медиа',
    'Type'            => 'Тип',
    'Save changes to this asset (s)' =>
      'Сохранить изменения этого медиа (s)',

## tmpl/cms/edit_author.tmpl
    'Edit Profile' => 'Редактировать профиль',
    'This profile has been updated.' => 'Профиль обновлён.',
    'A new password has been generated and sent to the email address [_1].' =>
      'Новый пароль был сгенеририрован и отправлен на email [_1].',
    'Your Web services password is currently' =>
      'Текущий пароль для веб-сервисов',
    '_WARNING_PASSWORD_RESET_SINGLE' =>
      'Вы собираетесь изменить пароль для пользователя «[_1]». Новый пароль будет сгенерирован автоматически и отправлен на адрес пользователя ([_2]). Продолжить?',
    'Error occurred while removing userpic.' =>
      'Произошло ошибка при удалении аватара.',
    'Profile'              => 'Профиль',
    '_USER_STATUS_CAPTION' => 'Статус пользователя',
    'Status of user in the system. Disabling a user removes their access to the system but preserves their content and history.'
      => 'Статус пользователя в системе. Если отключить пользователя, он потеряет доступ ко всем функциям системы, но вся его история и созданный им контент сохраняются.',
    '_USER_ENABLED' => 'Пользователь активен',
    '_USER_PENDING' =>
      'Неподтверждённый пользователь',
    '_USER_DISABLED' => 'Отключенный пользователь',
    'The username used to login.' =>
      'Имя пользователя используется для входа.',
    'External user ID' => 'Внешний ID пользователя',
    'The name used when published.' =>
      'Имя используемое при публикации.',
    'The email address associated with this user.' =>
      'Email, связанный с этим пользователем.',
    'The URL of the site associated with this user. eg. http://www.movabletype.com/'
      => 'Адрес сайта, связанный с этим пользователем. Например, http://movable-type.ru/',
    'Userpic' => 'Аватар',
    'The image associated with this user.' =>
      'Картинка, связанная с этим пользователем.',
    'Select Userpic'   => 'Выбрать аватар',
    'Remove Userpic'   => 'Удалить аватар',
    'Password'         => 'Пароль',
    'Change Password'  => 'Изменить пароль',
    'Current Password' => 'Текущий пароль',
    'Existing password required to create a new password.' =>
      'Для изменения пароля необходимо ввести текущий пароль.',
    'Initial Password' => 'Пароль',
    'Enter preferred password.' =>
      'Введите предпочтительный пароль.',
    'New Password'            => 'Новый пароль',
    'Enter the new password.' => 'Введите новый пароль.',
    'Confirm Password'        => 'Подтвердите пароль',
    'Repeat the password for confirmation.' =>
      'Введите пароль повторно.',
    'Password recovery word/phrase' =>
      'Слово или фраза для восстановления пароля',
    'This word or phrase is not used in the password recovery.' =>
      'Это слово или фраза не используется для восстановления пароля.',
    'Language' => 'Язык',
    'Preferred language of this user.' =>
      'Язык пользователя.',
    'Text Format' => 'Форматирование текста',
    'Preferred text format option.' =>
      'Предпочтительное форматирование текста.',
    '(Use Blog Default)' =>
      '(Использовать параметры блога)',
    'Tag Delimiter' => 'Разделитель тегов',
    'Preferred method of separating tags.' =>
      'Предпочтительный метод для разделения тегов.',
    'Comma'                 => 'Запятая',
    'Space'                 => 'Пробел',
    'Web Services Password' => 'Пароль для веб-сервисов',
    'For use by Activity feeds and with XML-RPC and Atom-enabled clients.' =>
      'Для использования XML-RPC или Atom клиентов (блогинг-редакторы, к примеру).',
    'Reveal' => 'Показать',
    'System Permissions' =>
      'Администраторские полномочия',
    'Options' => 'Опции',
    'Create personal blog for user' =>
      'Создать персональный блог для пользователя',
    'Create User (s)' => 'Создать пользователя (s)',
    'Save changes to this author (s)' =>
      'Сохранить изменения этого автора (s)',
    '_USAGE_PASSWORD_RESET' =>
      'Вы можете изменить пароль пользователя. Если вы это сделаете, пароль будет сгенерирован автоматически и отправлен пользователю на email [_1].',
    'Initiate Password Recovery' =>
      'Начать восстановление пароля',

## tmpl/cms/edit_comment.tmpl
    'The comment has been approved.' =>
      'Комментарий принят.',
    'Save changes to this comment (s)' =>
      'Сохранить изменения комментария (s)',
    'comment'                 => 'комментарий',
    'comments'                => 'комментарии',
    'Delete this comment (x)' => 'Удалить комментарий (x)',
    'Ban This IP'             => 'Заблокировать данный IP',
    'Previous Comment'      => 'Предыдущие комментарии',
    'Next Comment'          => 'Следующий комментарий',
    '_external_link_target' => '_blank',
    'View entry comment was left on' => 'Показать запись',
    'Reply to this comment' =>
      'Ответить на этот комментарий',
    'Status' => 'Статус',
    'Update the status of this comment' =>
      'Обновить статус этого комментария',
    'Approved'         => 'Принят',
    'Unapproved'       => 'Отклонен',
    'Reported as Spam' => 'Спам',
    'View all comments with this status' =>
      'Все комментарии с данным статусом',
    'Spam Details'                => 'Результаты проверки',
    'Total Feedback Rating: [_1]' => 'Общий рейтинг: [_1]',
    'Test'                        => 'Тест',
    'Score'                       => 'Баллы',
    'Results'                     => 'Результаты',
    'The name of the person who posted the comment' =>
      'Имя автора комментария',
    'Trusted'   => 'Доверенный',
    '(Trusted)' => '(Доверенный)',
    'Ban Commenter' =>
      'Заблокировать автора комментария',
    'Untrust Commenter' =>
      'Исключить автора из списка доверенных',
    'Banned'          => 'Заблокирован',
    '(Banned)'        => '(Заблокирован)',
    'Trust Commenter' => 'Занести в список надежных',
    'Unban Commenter' =>
      'Разблокировать автора комментария',
    'Pending' => 'Ожидающий',
    'View all comments by this commenter' =>
      'Посмотреть все комментарии этого автора',
    'Email address of commenter' =>
      'Email адрес автора комментария',
    'None given' => 'Не указано',
    'View all comments with this email address' =>
      'Показать все комментарии с этим email',
    'URL of commenter' => 'URL автора комментария',
    'Link'             => 'Ссылка',
    'View all comments with this URL' =>
      'Показать все комментарии с этого URL',
    '[_1] this comment was made on' =>
      '[_1] этот комментарий оставлен',
    '[_1] no longer exists' => '[_1] не существует',
    'View all comments on this [_1]' =>
      'Посмотреть все комментарии к [_1]',
    'Date' => 'Дата',
    'Date this comment was made' =>
      'Дата отправки комментария',
    'View all comments created on this day' =>
      'Показать все комментарии оставленные в этот день',
    'IP' => 'IP',
    'IP Address of the commenter' =>
      'IP адрес автора комментария',
    'View all comments from this IP address' =>
      'Показать все комментарии с этого IP',
    'Fulltext of the comment entry' =>
      'Полный текст комментария',
    'Responses to this comment' =>
      'Ответы на этот комментарий',

## tmpl/cms/list_author.tmpl
    'Users: System-wide' =>
      'Пользователи: системный уровень',
    'You have successfully disabled the selected user(s).' =>
      'Выбранные пользователи успешно деактивированы.',
    'You have successfully enabled the selected user(s).' =>
      'Выбранные пользователи успешно активированы.',
    'You have successfully deleted the user(s) from the Melody system.' =>
      'Выбранные пользователи были успешно удалены из Melody.',
    'The deleted user(s) still exist in the external directory. As such, they will still be able to login to Melody Enterprise.'
      => 'Удалённые пользователи всё ещё существуют во внешнем каталоге. Поэтому они по-прежнему имеют возможность авторизовываться в Melody Enterprise.',
    'You have successfully synchronized users\' information with the external directory.'
      => 'Информация о пользователяъ успешно синхронизирована с внешним каталогом.',
    'Some ([_1]) of the selected user(s) could not be re-enabled because they were no longer found in the external directory.'
      => 'Несколько ([_1])из выбранных пользователей не могут быть реактивированы, так как они больше не существуют во внешнем каталоге.',
    'An error occured during synchronization.  See the <a href=\'[_1]\'>activity log</a> for detailed information.'
      => 'При синхронизации произошла ошибка. Более подробная информация содержится в <a href=\'[_1]\'>журнале активности</a>.',
    'user'  => 'пользователь',
    'users' => 'пользователи',
    'Enable selected users (e)' =>
      'Активировать выбранных пользователей (e)',
    '_USER_ENABLE' => 'Активировать',
    '_NO_SUPERUSER_DISABLE' =>
      'Вы не можете отключить себя, так как являетесь администратором системы Melody.',
    'Disable selected users (d)' =>
      'Деактивировать выбранных пользователей (d)',
    '_USER_DISABLE' => 'Деактивировать',
    'Showing All Users' =>
      'Показать всех пользователей',

## tmpl/cms/edit_blog.tmpl
    'Your blog configuration has been saved.' =>
      'Конфигурация блога сохранена.',
    'You must set your Blog Name.' =>
      'Необходимо указать имя блога.',
    'You did not select a timezone.' =>
      'Вы не выбрали часовой пояс.',
    'You must set your Site URL.' =>
      'Необходимо указать URL сайта.',
    'Your Site URL is not valid.' =>
      'Указанный URL сайта неправильный.',
    'You can not have spaces in your Site URL.' =>
      'URL сайта не может содержать пробелов.',
    'You can not have spaces in your Local Site Path.' =>
      'Локальный путь сайта не может содержать пробелов.',
    'Your Local Site Path is not valid.' =>
      'Локальный путь сайта неправильный.',
    'Blog Details' => 'Детали блога',
    'Name your blog. The blog name can be changed at any time.' =>
      'Дайте имя вашему блогу. В дальнейшем оно может быть изменено в любой момент.',
    'Template Set' => 'Связка шаблонов',
    'Select the templates you wish to use for this new blog.' =>
      'Выберите шаблоны, которые вы хотите использовать в новом блоге.',
    'Enter the URL of your public website. Do not include a filename (i.e. exclude index.html). Example: http://www.example.com/weblog/'
      => 'Укажите URL вашего сайта. Не включайте имени файла (подобно index.html). Пример: http://www.example.com/blog/',
    'Enter the path where your main index file will be located. An absolute path (starting with \'/\') is preferred, but you can also use a path relative to the Melody directory. Example: /home/melody/public_html/weblog'
      => 'Укажите путь, где будут расположены индексные файла. Предпочтительнее указывать абсолютный путь (который начинается с знака «/»), но вы также можете использовать путь относительно каталога Melody. Пример абсолютного пути: /home/melody/public_html/blog',
    'Timezone' => 'Часовой пояс',
    'Select your timezone from the pulldown menu.' =>
      'Выберите часовой пояс из выпадающего меню.',
    'Time zone not selected' => 'Часовой пояс не выбрана',
    'UTC+13 (New Zealand Daylight Savings Time)' =>
      'UTC+13 (Камчатское летнее время)',
    'UTC+12 (International Date Line East)' =>
      'UTC+12 (Камчатский край, Чукотский АО)',
    'UTC+11' =>
      'UTC+11 (Восточная часть Якутии, Курильские острова)',
    'UTC+10 (East Australian Time)' =>
      'UTC+10 (Приморский край, Хабаровский край)',
    'UTC+9.5 (Central Australian Time)' =>
      'UTC+9,5 (Центральное австралийское время)',
    'UTC+9 (Japan Time)' =>
      'UTC+9 (Амурская область, Читинская область)',
    'UTC+8 (China Coast Time)' => 'UTC+8 (Иркутское время)',
    'UTC+7 (West Australian Time)' =>
      'UTC+7 (Красноярское время)',
    'UTC+6.5 (North Sumatra)' => 'UTC+6,5 (Северная Суматра)',
    'UTC+6 (Russian Federation Zone 5)' =>
      'UTC+6 (Омское, Екатеринбургское летнее время)',
    'UTC+5.5 (Indian)' => 'UTC+5.5 (Индия)',
    'UTC+5 (Russian Federation Zone 4)' =>
      'UTC+5 (Башкортостан, Пермский край, Оренбургская область)',
    'UTC+4 (Russian Federation Zone 3)' =>
      'UTC+4 (Самарское время)',
    'UTC+3.5 (Iran)' => 'UTC+3,5 (Иранское время)',
    'UTC+3 (Baghdad Time/Moscow Time)' =>
      'UTC+3 (Московское время)',
    'UTC+2 (Eastern Europe Time)' =>
      'UTC+2 (Восточноевропейское время)',
    'UTC+1 (Central European Time)' =>
      'UTC+1 (Центральноевропейское время)',
    'UTC+0 (Universal Time Coordinated)' =>
      'UTC+0 (Среднее время по Гринвичу)',
    'UTC-1 (West Africa Time)' =>
      'UTC-1 (Португальское время)',
    'UTC-2 (Azores Time)' =>
      'UTC-2 (Бразильское время — океанические острова)',
    'UTC-3 (Atlantic Time)' =>
      'UTC-3 (Атлантическое время)',
    'UTC-3.5 (Newfoundland)' =>
      'UTC-3,5 (Ньюфаундлендское время)',
    'UTC-4 (Atlantic Time)' =>
      'UTC-4 (Атлантическое стандартное время)',
    'UTC-5 (Eastern Time)' =>
      'UTC-5 (Североамериканское восточное время)',
    'UTC-6 (Central Time)' =>
      'UTC-6 (Центральное время США)',
    'UTC-7 (Mountain Time)' =>
      'UTC-7 (Горное время США и Канады)',
    'UTC-8 (Pacific Time)' => 'UTC-8 (Тихоокеанское время)',
    'UTC-9 (Alaskan Time)' => 'UTC-9 (Аляска)',
    'UTC-10 (Aleutians-Hawaii Time)' =>
      'UTC-10 (Время гавайских островов)',
    'UTC-11 (Nome Time)' => 'UTC-11 (Время Нома)',
    'Blog language.'     => 'Язык блога.',
    'Create Blog (s)'    => 'Создать блог (s)',

## tmpl/cms/view_rpt_log.tmpl
    'Schwartz Error Log' => 'Журнал ошибок Schwartz',
    'The activity log has been reset.' =>
      'Журнал активности очищен.',
    'All times are displayed in GMT[_1].' =>
      'Всё время отображено в GMT[_1].',
    'All times are displayed in GMT.' =>
      'Всё время отображено в GMT.',
    'Are you sure you want to reset the activity log?' =>
      'Вы уверены, что хотите очистить журнал активности?',
    'Showing all Schwartz errors' =>
      'Показать все ошибки Schwartz',

## tmpl/cms/popup/rebuild_confirm.tmpl
    'Publish [_1]'          => 'Публикация [_1]',
    'Publish <em>[_1]</em>' => 'Публикация <em>[_1]</em>',
    '_REBUILD_PUBLISH'      => 'Публикация',
    'All Files'             => 'Все файлы',
    'Index Template: [_1]'  => 'Индексный шаблон: [_1]',
    'Only Indexes'          => 'Только индексные',
    'Only [_1] Archives' =>
      'Публиковать только архивы [_1]',
    'Publish (s)' => 'Опубликовать (s)',
    'Cancel (x)'  => 'Отмена (x)',

## tmpl/cms/popup/pinged_urls.tmpl
    'Successful Trackbacks' => 'Усмешные трекбэки',
    'Failed Trackbacks'     => 'Неуспешные трекбэки',
    'To retry, include these TrackBacks in the Outbound TrackBack URLs list for your entry.'
      => 'Для повторной отправки включите эти трекбэки в список URL исходящих трекбэков.',
    'Close (x)' => 'Закрыть (x)',

## tmpl/cms/popup/rebuilt.tmpl
    'Success' => 'Готово',
    'The files for [_1] have been published.' =>
      'Файлы «[_1]» опубликованы.',
    'Your [_1] has been published.' =>
      'Шаблон «[_1]» опубликован.',
    'Your [_1] archives have been published.' =>
      'Архивы опубликованы ([_1])',
    'Your [_1] templates have been published.' =>
      'Шаблоны опубликованы ([_1]).',
    'Publish time: [_1].' => 'Время публикации: [_1]',
    'View your site.'     => 'Посмотреть сайт.',
    'View this page.'     => 'Посмотреть эту страницу.',
    'Publish Again (s)'   => 'Опубликовать ещё раз (s)',
    'Publish Again'       => 'Опубликовать ещё раз',

## tmpl/cms/list_member.tmpl
    'Are you sure you want to remove this role?' =>
      'Вы уверены, что хотите удалить эту роль?',
    'Add a user to this blog' =>
      'Добавить пользователя в блог',
    'Show only users where' =>
      'Показать пользователей, у которых',
    'role'     => 'роль',
    'enabled'  => 'активный',
    'disabled' => 'отключенный',
    'Filter'   => 'Отфильтровать',

## tmpl/cms/cfg_plugin.tmpl
    'System Plugin Settings' =>
      'Настройка плагинов: системный уровень',
    'http://plugins.movabletype.org/' => 'http://plugins.movabletype.org/',
    'Find Plugins'                    => 'Поиск плагинов',
    'Plugin System'                   => 'Системные плагины',
    'Manually enable or disable plugin-system functionality. Re-enabling plugin-system functionality, will return all plugins to their original state.'
      => 'Вы можете вручную включить или отключить плагины. Повторное включение плагинов вернёт их в то состояние, из которого они были отключены.',
    'Disable plugin functionality' =>
      'Отключить дополнительную функциональность за счёт плагинов',
    'Disable Plugins' => 'Отключить плагины',
    'Enable plugin functionality' =>
      'Активировать дополнительную функциональность за счёт плагинов',
    'Enable Plugins' => 'Активировать плагины',
    'Your plugin settings have been saved.' =>
      'Конфигурация плагинов сохранена.',
    'Your plugin settings have been reset.' =>
      'Конфигурация плагинов сброшена.',
    'Your plugins have been reconfigured. Since you\'re running mod_perl, you will need to restart your web server for these changes to take effect.'
      => 'Конфигурация плагинов изменена. Так как вы используете mod_perl, необходимо перезапустить веб-сервер, чтобы изменения вступили в силу.',
    'Your plugins have been reconfigured.' =>
      'Конфигурация плагинов изменена.',
    'Are you sure you want to reset the settings for this plugin?' =>
      'Вы действительно хотите сбросить параметры этого плагина? (Будут установлены параметры по умолчанию.)',
    'Are you sure you want to disable plugin functionality?' =>
      'Вы действительно хотите отключить функциональность плагина?',
    'Disable this plugin?' => 'Отключить этот плагин?',
    'Are you sure you want to enable plugin functionality? (This will re-enable any plugins that were not individually disabled.)'
      => 'Вы действительно хотите активировать плагины? (Это действие активирует все плагины, которые не были отключены индивидуально.)',
    'Enable this plugin?' =>
      'Активировать этот плагин?',
    'Failed to Load'    => 'Ошибка при загрузке',
    '(Disable)'         => '(Отключить)',
    'Enabled'           => 'Работает',
    '(Enable)'          => '(Активировать)',
    'Settings for [_1]' => 'Настройки для [_1]',
    'This plugin has not been upgraded to support Melody [_1]. As such, it may not be 100% functional. Furthermore, it will require an upgrade once you have upgraded to the next Melody major release (when available).'
      => 'Этот плагин не был обновлён для совместимости с Melody [_1]. Это значит, что он может работать с ошибками или с частичной функциональностью. Кроме того, плагину потребуется обновление, когда вы будете обновлять Melody до следующей версии (когда она будет доступна).',
    'Plugin error:'          => 'Ошибка плагина:',
    'Info'                   => 'Информация',
    'Resources'              => 'Ресурсы',
    'Run [_1]'               => 'Запустить [_1]',
    'Documentation for [_1]' => 'Документация по [_1]',
    'Documentation'          => 'Документация',
    'More about [_1]' => 'Подробная информация об [_1]',
    'Plugin Home'     => 'Страница плагина',
    'Author of [_1]'  => 'Автор плагина [_1]',
    'Tags:'           => 'Теги:',
    'Tag Attributes:' => 'Атрибуты тегов:',
    'Text Filters'    => 'Фильтры для текста',
    'Junk Filters:'   => 'Фильтры для спама:',
    'Reset to Defaults' => 'Сбросить параметры',
    'No plugins with blog-level configuration settings are installed.' =>
      'Нет плагинов, которыми можно управлять на уровне блога.',
    'No plugins with configuration settings are installed.' =>
      'Не установлено настраиваемых плагинов.',

## tmpl/cms/list_template.tmpl
    'Blog Templates'     => 'Шаблоны блога',
    'Show All Templates' => 'Показать все шаблоны',
    'Blog Publishing Settings' =>
      'Настройка публикации блога',
    'You have successfully deleted the checked template(s).' =>
      'Выбранные шаблоны удалены.',
    'Your settings have been saved.' =>
      'Ваши параметры сохранены.',
    'Your templates have been published.' =>
      'Ваши шаблоны опубликованы.',
    'Selected template(s) has been copied.' =>
      'Выбранные шаблоны скопированы',

## tmpl/cms/upgrade.tmpl
    'Time to Upgrade!' => 'Пришло время обновиться!',
    'Upgrade Check'    => 'Проверка обновлений',
    'The version of Perl installed on your server ([_1]) is lower than the minimum supported version ([_2]).'
      => 'Версия Perl, установленная на Вашем сервере ([_1]), ниже минимально поддерживаемой версии ([_2]).',
    'While Melody may run, it is an <strong>untested and unsupported environment</strong>.  We strongly recommend upgrading to at least Perl [_1].'
      => 'Несмотря на то, что Melody может работать на данной версии Perl, <strong>эта версия не тестируется и не поддерживается</strong>.  Мы настоятельно рекоммендуем установить версию Perl не ниже [_1].',
    'Do you want to proceed with the upgrade anyway?' =>
      'Хотите продолжить обновление?',
    'Yes (s)'           => 'Да (s)',
    'Yes'               => 'Да',
    'View MT-Check (x)' => 'Посмотреть MT-Check (x)',
    'No'                => 'Нет',
    'A new version of Melody has been installed.  We\'ll need to complete a few tasks to update your database.'
      => 'Новая версия Melody установлена. Для завершения операции необходимо выполнить несколько задач по обновлению базы данных.',
    'Information about this upgrade can be found <a href=\'[_1]\' target=\'_blank\'>here</a>.'
      => 'Информация об этом обновлении содержится на <a href=\'[_1]\' target=\'_blank\'>специальной странице</a>.',
    'In addition, the following Melody components require upgrading or installation:'
      => 'Кроме того, необходимо обновить или установить следующие компоненты Melody:',
    'The following Melody components require upgrading or installation:' =>
      'Необходимо обновить или установить следующие компоненты Melody:',
    'Begin Upgrade' => 'Обновление',
    'Congratulations, you have successfully upgraded to Melody [_1].' =>
      'Поздравляем, вы успешно обновили Melody до версии [_1].',
    'Return to Melody' => 'Продолжить работу с Melody',
    'Your Melody installation is already up to date.' =>
      'Ваш Melody не нуждается в обновлении.',

## tmpl/cms/restore_end.tmpl
    'All data restored successfully!' =>
      'Все данные восстановлены успешно!',
    'Make sure that you remove the files that you restored from the \'import\' folder, so that if/when you run the restore process again, those files will not be re-restored.'
      => 'Не забудьте удалить файлы, которые находятся в папке «import», иначе, если вы повторно запустите процесс восстановления, эти файлы буду повторно импортированы.',
    'An error occurred during the restore process: [_1] Please check activity log for more details.'
      => 'В процессе восстановления произошла ошибка: [_1] Пожалуйста, проверьте журнал активности для получения подробной информации.',

## tmpl/cms/backup.tmpl
    'What to backup' => 'Что нужно включить в бекап',
    'This option will backup Users, Roles, Associations, Blogs, Entries, Categories, Templates and Tags.'
      => 'Эта опция позволяет выбрать для бекапа пользователей, роли, ассоциации, блоги, записи, категории, шаблоны и теги.',
    'Everything'      => 'Всё',
    'Reset'           => 'Очистить',
    'Choose blogs...' => 'Выбрать блоги…',
    'Archive Format'  => 'Формат архива',
    'The type of archive format to use.' =>
      'Тип архива, который будет использован.',
    'Don\'t compress' => 'Не сжимать',
    'Target File Size' =>
      'Ограничивать размер получаемого файла',
    'Approximate file size per backup file.' =>
      'Приблизительный размер файла бекапа.',
    'Don\'t Divide'   => 'Без ограничений',
    'Make Backup (b)' => 'Сделать бекап (b)',
    'Make Backup'     => 'Сделать бекап',

## tmpl/cms/list_tag.tmpl
    'Your tag changes and additions have been made.' =>
      'Ваши изменения и дополнения тега добавлены.',
    'You have successfully deleted the selected tags.' =>
      'Выбранные теги удалены.',
    'tag'  => 'тег',
    'tags' => 'теги',
    'Specify new name of the tag.' =>
      'Укажите новое имя тега',
    'Tag Name'               => 'Имя тега',
    'Click to edit tag name' => 'Редактировать имя тега',
    'Rename [_1]'            => 'Переименовать [_1]',
    'Rename'                 => 'Переименовать',
    'Show all [_1] with this tag' =>
      'Показать все [_1] с этим тегом',
    '[quant,_1,_2,_3]' => '[quant,_1,_2,_3]',
    '[quant,_1,entry,entries]' =>
      '[quant,_1,запись,записи,записей]',
    'The tag \'[_2]\' already exists. Are you sure you want to merge \'[_1]\' with \'[_2]\' across all blogs?'
      => 'Тег «[_2]» уже существует. Вы действительно хотите объединить «[_1]» и «[_2]» во всех блогах?',
    'An error occurred while testing for the new tag name.' =>
      'Произошла ошибка при тестировании с новым именем тега.',

## tmpl/cms/view_log.tmpl
    'Show only errors'    => 'Показать только ошибки',
    'System Activity Log' => 'Журнал активности',
    'Filtered'            => 'Отфильтрованное',
    'Filtered Activity Feed' =>
      'Отфильтрованная активность',
    'Download Filtered Log (CSV)' =>
      'Скачать отфильтрованный журнал активности (CSV)',
    'Download Log (CSV)' => 'Скачать журнал (CSV)',
    'Clear Activity Log' =>
      'Очистить журнал активности',
    'Showing all log records' =>
      'Показаны все записи журнала',
    'Showing log records where' =>
      'Показаны записи журнала, у которых',
    'Show log records where' =>
      'Показать записи, у которых',
    'level'             => 'статус',
    'classification'    => 'классификация',
    'Security'          => 'Безопасность',
    'Information'       => 'Информация',
    'Debug'             => 'Отладка',
    'Security or error' => 'Безопасность или ошибка',
    'Security/error/warning' =>
      'Безопасность/ошибка/предупреждение',
    'Not debug'   => 'Не отладка',
    'Debug/error' => 'Отладка/ошибка',

## tmpl/cms/include/archetype_editor.tmpl
    'Decrease Text Size' => 'Уменьшить размер шрифта',
    'Increase Text Size' => 'Увеличить размер шрифта',
    'Bold'               => 'Жирный',
    'Italic'             => 'Курсив',
    'Underline'          => 'Подчеркнутый',
    'Strikethrough'      => 'Зачеркнутый',
    'Text Color'         => 'Цвет текста',
    'Email Link'         => 'Ссылка на email',
    'Begin Blockquote'   => 'Цитата',
    'End Blockquote'     => 'Закончить цитату',
    'Bulleted List'      => 'Маркированный список',
    'Numbered List'      => 'Нумерованый список',
    'Left Align Item'    => 'Выровнять по левому краю',
    'Center Item'        => 'Выровнять по центру',
    'Right Align Item'   => 'Выровнять по правому краю',
    'Left Align Text'    => 'Выровнять по левому краю',
    'Center Text'        => 'Выровнять по центру',
    'Right Align Text'   => 'Выровнять по правому краю',
    'Insert Image'       => 'Вставить изображение',
    'Insert File'        => 'Вставить файл',
    'WYSIWYG Mode'       => 'Визуальный режим',
    'HTML Mode'          => 'Режим HTML',

## tmpl/cms/include/anonymous_comment.tmpl
    'Anonymous Comments' => 'Анонимные комментарии',
    'Require E-mail Address for Anonymous Comments' =>
      'Обязать анонимных комментаторов указывать e-mail',
    'If enabled, visitors must provide a valid e-mail address when commenting.'
      => 'Если эта опция активна, посетителю нужно будет ввести реальный e-mail, чтобы оставить комментарий.',

## tmpl/cms/include/cfg_content_nav.tmpl

## tmpl/cms/include/login_mt.tmpl

## tmpl/cms/include/member_table.tmpl
    'Are you sure you want to remove the selected user from this blog?' =>
      'Вы уверены, что хотите удалить выбранного пользователя из этого блога?',
    'Are you sure you want to remove the [_1] selected users from this blog?'
      => 'Вы уверены, что хотите удалить [_1] выбранных пользователей из этого блога?',
    'Remove selected user(s) (r)' =>
      'Удалить выбранных пользователей (r)',
    'Remove'            => 'Удалить',
    'Trusted commenter' => 'Доверенный комментатор',
    'Remove this role'  => 'Удалить эту роль',

## tmpl/cms/include/backup_start.tmpl
    'Backing up Melody' =>
      'Старт резервного копирования Melody',

## tmpl/cms/include/listing_panel.tmpl
    'Step [_1] of [_2]' => 'Шаг [_1] из [_2]',
    'Go to [_1]'        => 'Перейти к [_1]',
    'Sorry, there were no results for your search. Please try searching again.'
      => 'К сожалению, по вашему запросу ничего не найдено. Попробуйте уточнить запрос и повторите поиск.',
    'Sorry, there is no data for this object set.' =>
      'К сожалению, пока ничего нет по этому набору объектов.',
    'Confirm (s)'  => 'Подтвердить (s)',
    'Confirm'      => 'Подтвердить',
    'Continue (s)' => 'Продолжить (s)',
    'Continue'     => 'Продолжить',
    'Back (b)'     => 'Вернуться (b)',
    'Back'         => 'Вернуться',

## tmpl/cms/include/template_table.tmpl
    'Create Archive Template:' => 'Создать шаблон архива',
    'Entry Listing'            => 'Список записей',
    'Create template module' =>
      'Создать модульный шаблон',
    'Create index template' =>
      'Создать индексный шаблон',
    'templates'  => 'шаблоны',
    'to publish' => 'публиковать',
    'Publish selected templates (a)' =>
      'Опубликовать выбранные шаблоны (a)',
    'Output File'  => 'Имя файла',
    'Archive Path' => 'Путь архива',
    'Cached'       => 'Кэшированный',
    'Linked Template' =>
      'Шаблон связан с другим файлом',
    'View Published Template' =>
      'Посмотреть опубликованный шаблон',
    '-'             => '-',
    'Manual'        => 'Вручную',
    'Dynamic'       => 'Динамический',
    'Publish Queue' => 'Очередь публикации',
    'Scheduled'     => 'Запланировано',
    'Static'        => 'Статика',

## tmpl/cms/include/comment_detail.tmpl

## tmpl/cms/include/import_end.tmpl
    'All data imported successfully!' =>
      'Всё содержимое успешно импортировано!',
    'Make sure that you remove the files that you imported from the \'import\' folder, so that if/when you run the import process again, those files will not be re-imported.'
      => 'Убедитесь, что вы удалили файлы, импортированные из папки «import». Если вы снова запустите процесс импорта, эти файлы не будут импортированы повторно.',
    'An error occurred during the import process: [_1]. Please check your import file.'
      => 'Произошла ошибка в процессе импорта: [_1]. Пожалуйста, проверьте файл импорта.',

## tmpl/cms/include/category_selector.tmpl
    'Add sub category' => 'Добавить подкатегорию',
    'Add new'          => 'Добавить',

## tmpl/cms/include/notification_table.tmpl
    'Date Added'            => 'Добавлено',
    'Click to edit contact' => 'Редактировать контакт',
    'Save changes'          => 'Сохранить изменения',
    'Save'                  => 'Сохранить',

## tmpl/cms/include/comment_table.tmpl
    'Publish selected comments (a)' =>
      'Опубликовать выбранные комментарии (a)',
    'Delete selected comments (x)' =>
      'Удалить выбранные комментарии (x)',
    'Report selected comments as Spam (j)' =>
      'Пометить выбранные комментарии как спам (j)',
    'Report selected comments as Not Spam and Publish (j)' =>
      'Пометить выбранные комментарии как не спам и опубликовать их (j)',
    'Not Spam' => 'Не спам',
    'Are you sure you want to remove all comments reported as spam?' =>
      'Вы уверены, что хотите удалить все комментарии, помеченные как спам?',
    'Delete all comments reported as Spam' =>
      'Удалить все комментарии, помеченные как спам',
    'Empty'      => 'Очистить',
    'Entry/Page' => 'Запись/Страница',
    'Only show published comments' =>
      'Показать только опубликованные комментарии',
    'Published' => 'Опубликовано',
    'Only show pending comments' =>
      'Показать только ожидающие комментарии',
    'Edit this comment' =>
      'Редактировать этот комментарий',
    '([quant,_1,reply,replies])' =>
      '([quant,_1,ответ,ответа,ответов])',
    'Blocked'       => 'Заблокированные',
    'Authenticated' => 'Авторизованные',
    'Edit this [_1] commenter' =>
      'Редактировать комментатора со статусом «[_1]»',
    'Search for comments by this commenter' =>
      'Найти комментарии от этого комментатора',
    'View this entry' => 'Посмотреть эту запись',
    'View this page'  => 'Посмотреть эту страницу',
    'Search for all comments from this IP address' =>
      'Найти все комментарии, оставленные с этого IP адреса',

## tmpl/cms/include/ping_table.tmpl
    'Publish selected [_1] (p)' =>
      'Опубликовать выбранные [_1] (p)',
    'Report selected [_1] as Spam (j)' =>
      'Отметить выбранные [_1] как спам (j)',
    'Report selected [_1] as Not Spam and Publish (j)' =>
      'Отметить выбранные [_1] как не спам и опубликовать (j)',
    'Are you sure you want to remove all TrackBacks reported as spam?' =>
      'Вы увеерны, что хотите удалить все трекбэки, отмеченные как спам?',
    'Deletes all [_1] reported as Spam' =>
      'Удаление всех [_1], отмеченных как спам',
    'From'   => 'От',
    'Target' => 'К записи',
    'Only show published TrackBacks' =>
      'Показать только опубликованные трекбэки',
    'Only show pending TrackBacks' =>
      'Показать только неопубликованные трекбэки',
    'Edit this TrackBack' => 'Редактировать трекбэк',
    'Go to the source entry of this TrackBack' =>
      'Перейти к записи, с которой отправлен трекбэк',
    'View the [_1] for this TrackBack' =>
      'Открыть [_1], к которой оставлен этот трекбэк',

## tmpl/cms/include/import_start.tmpl
    'Importing...' => 'Импортирование',
    'Importing entries into blog' =>
      'Импортирование записей в блог',
    'Importing entries as user \'[_1]\'' =>
      'Импортирование записей как пользователем «[_1]»',
    'Creating new users for each user found in the blog' =>
      'Создание новых пользователей, соответствующих пользователям, найденных в блоге',

## tmpl/cms/include/commenter_table.tmpl
    'Identity' => 'Идентификатор',
    'Last Commented' =>
      'Последний прокомментировавший',
    'Only show trusted commenters' =>
      'Показать только доверенных комментаторов',
    'Only show banned commenters' =>
      'Показать только заблокированных комментаторов',
    'Only show neutral commenters' =>
      'Показать только нейтральных комментаторов',
    'Edit this commenter' =>
      'Редактировать комментатора',
    'View this commenter&rsquo;s profile' =>
      'Посмотреть профиль комментатора',

## tmpl/cms/include/users_content_nav.tmpl
    'Details' => 'Детали',

## tmpl/cms/include/author_table.tmpl
    'Created By' => 'Создан',
    'System'     => 'Система',

## tmpl/cms/include/feed_link.tmpl
    'Activity Feed' => 'Активность',

## tmpl/cms/include/archive_maps.tmpl
    'Path'      => 'Путь',
    'Custom...' => 'Свой путь…',
    'Statically (default)' =>
      'Статически (по умолчанию)',
    'Via Publish Queue' =>
      'С использованием очереди публикации',
    'On a schedule'  => 'По графику',
    ': every '       => ': каждый ',
    'minutes'        => 'минуты',
    'hours'          => 'часы',
    'days'           => 'дни',
    'Dynamically'    => 'Динамически',
    'Manually'       => 'Вручную',
    'Do Not Publish' => 'Не публиковать',

## tmpl/cms/include/blog_table.tmpl
    'Delete selected blogs (x)' =>
      'Удалить выбранные блоги (x)',

## tmpl/cms/include/cfg_system_content_nav.tmpl

## tmpl/cms/include/tools_content_nav.tmpl

## tmpl/cms/include/log_table.tmpl
    'No log records could be found.' =>
      'Нет записей для журнала активности.',
    '_LOG_TABLE_BY' => 'Пользователь',
    'IP: [_1]'      => 'IP: [_1]',

## tmpl/cms/include/rpt_log_table.tmpl
    'Schwartz Message' => 'Сообщение Schwartz',

## tmpl/cms/include/display_options.tmpl
    'Display Options'       => 'Опции отображения',
    '_DISPLAY_OPTIONS_SHOW' => 'Показать',
    '[quant,_1,row,rows]' =>
      '[quant,_1,элемент,элемента,элементов]',
    'View'        => 'Просмотр',
    'Compact'     => 'Компактный',
    'Expanded'    => 'Расширенный',
    'Action Bar'  => 'Панель задач',
    'Top'         => 'Сверху',
    'Both'        => 'Сверху и снизу',
    'Bottom'      => 'Снизу',
    'Date Format' => 'Формат дат',
    'Relative'    => 'Относительный',
    'Full'        => 'Полный',
    'Save display options' =>
      'Сохранить параметры отображения',
    'Close display options' =>
      'Закрыть параметры отображения',

## tmpl/cms/include/footer.tmpl
    'This is a beta version of Melody and is not recommended for production use.'
      => 'Это бета-версия Melody, не рекомендуется использовать как рабочую версию.',
    'http://www.movabletype.org'   => 'http://www.movabletype.org',
    'MovableType.org'              => 'MovableType.org',
    'http://wiki.movabletype.org/' => 'http://wiki.movabletype.org/',
    'Wiki'                         => 'Wiki',
    'http://www.movabletype.com/support/' =>
      'http://www.movabletype.com/support/',
    'Support' => 'Поддержка',
    'http://www.movabletype.org/feedback.html' =>
      'http://www.movabletype.org/feedback.html',
    'Send us Feedback' => 'Обратная связь',
    '<a href="[_1]"><mt:var name="mt_product_name"></a> version [_2]' =>
      '<a href="[_1]"><mt:var name="mt_product_name"></a>, версия [_2]',
    'with' => 'с',

## tmpl/cms/include/calendar.tmpl
    '_LOCALE_WEEK_START'         => '1',
    'S|M|T|W|T|F|S'              => 'В|П|В|С|Ч|П|С',
    'January'                    => 'Январь',
    'Febuary'                    => 'Февраль',
    'March'                      => 'Март',
    'April'                      => 'Апрель',
    'May'                        => 'Май',
    'June'                       => 'Июнь',
    'July'                       => 'Июль',
    'August'                     => 'Август',
    'September'                  => 'Сентябрь',
    'October'                    => 'Октябрь',
    'November'                   => 'Ноябрь',
    'December'                   => 'Декабрь',
    'Jan'                        => 'Янв',
    'Feb'                        => 'Фев',
    'Mar'                        => 'Март',
    'Apr'                        => 'Апр',
    '_SHORT_MAY'                 => 'Май',
    'Jun'                        => 'Июнь',
    'Jul'                        => 'Июль',
    'Aug'                        => 'Авг',
    'Sep'                        => 'Сен',
    'Oct'                        => 'Окт',
    'Nov'                        => 'Ноя',
    'Dec'                        => 'Дек',
    'OK'                         => 'OK',
    '[_1:calMonth] [_2:calYear]' => '[_1:calMonth] [_2:calYear]',

## tmpl/cms/include/header.tmpl
    'Help'                   => 'Помощь',
    'Hi [_1],'               => 'Привет [_1] —',
    'Logout'                 => 'выйти',
    'Select another blog...' => 'Выбрать другой блог',
    'Create a new blog'      => 'Создать новый блог',
    'Write Entry'            => 'Создать запись',
    'Blog Dashboard'         => 'Обзорная панель блога',
    'View Site'              => 'Посмотреть сайт',
    'Search (q)'             => 'Поиск (q)',

## tmpl/cms/include/asset_upload.tmpl
    'Before you can upload a file, you need to publish your blog. [_1]Configure your blog\'s publishing paths[_2] and rebuild your blog.'
      => 'Перед загрузкой файла необходимо опубликовать блог. [_1]Настройте пути для публикации[_2], а затем полностью опубликуйте блог.',
    'Your system or blog administrator needs to publish the blog before you can upload files. Please contact your system or blog administrator.'
      => 'Администратор системы или администратор блога должен выполнить публикацию блога перед загрузкой файла. Обратитесь к администратору.',
    'Select File to Upload' =>
      'Выберите файл для загрузки',
    '_USAGE_UPLOAD' =>
      'Вы можете загрузить файл в подкаталог. Если подкаталог не найден, он будет автоматически создан.',
    'Upload Destination' => 'Загрузить в',
    'Choose Folder'      => 'Выбрать папку',
    'Upload (s)'         => 'Загрузить (s)',
    'Upload'             => 'Загрузить',

## tmpl/cms/include/overview-left-nav.tmpl
    'List Weblogs' => 'Список блогов',
    'Weblogs'      => 'Блоги',
    'List Users and Groups' =>
      'Список пользователей и групп',
    'Users &amp; Groups' => 'Пользователи и группы',
    'List Associations and Roles' =>
      'Список ассоциаций и ролей',
    'Privileges'   => 'Права',
    'List Plugins' => 'Список плагинов',
    'Aggregate'    => 'Совокупно',
    'List Entries' => 'Список записей',
    'List uploaded files' =>
      'Список загруженных файлов',
    'List Tags'       => 'Список тегов',
    'List Comments'   => 'Список комментариев',
    'List TrackBacks' => 'Список трекбэков',
    'Configure'       => 'Конфигурация',
    'Edit System Settings' =>
      'Изменить параметры системы',
    'Utilities'            => 'Утилиты',
    'Search &amp; Replace' => 'Поиск и замена',
    '_SEARCH_SIDEBAR'      => 'Поиск',
    'Show Activity Log' =>
      'Показать журнал активности',

## tmpl/cms/include/pagination.tmpl

## tmpl/cms/include/backup_end.tmpl
    'All of the data has been backed up successfully!' =>
      'Все данные были успешно сохранены!',
    'Download This File' => 'Скачать этот файл',
    '_BACKUP_TEMPDIR_WARNING' =>
      'Указанные данные были успешно сохранены в директории [_1]. Удостоверьтесь, что вы скачали, а затем <strong>удалили</strong> перечисленные выше файлы с [_1] <strong>сразу</strong>, так как файл резервной копиии содержит конфиденциальную информацию.',
    '_BACKUP_DOWNLOAD_MESSAGE' =>
      'Скачивание файла резервной копии начнётся автоматически через несколько секунд. Если этого не произойдёт, вы можете <a href="javascript:(void)" onclick="submit_form()">начать скачивание</a> самостоятельно. Имейте ввиду, что вы можете скачать этот файл только один раз за сессию.',
    'An error occurred during the backup process: [_1]' =>
      'Во время операции бекапа произошла ошибка: [_1]',

## tmpl/cms/include/list_associations/page_title.tmpl
    'Permissions for [_1]' => 'Права доступа для [_1]',
    'Permissions: System-wide' =>
      'Права доступа: системный уровень',
    'Users for [_1]' => 'Пользователи для [_1]',

## tmpl/cms/include/asset_table.tmpl
    'asset'  => 'Медиа',
    'assets' => 'Медиа',
    'Delete selected assets (x)' =>
      'Удалить выбранное медиа (x)',
    'Size'          => 'Размер',
    'Created On'    => 'Дата',
    'Asset Missing' => 'Медиа не найдено',

## tmpl/cms/include/copyright.tmpl
    'Copyright &copy; 2001-[_1] Six Apart. All Rights Reserved.' =>
      '&copy; 2001-[_1] Six Apart. Все права защищены.',

## tmpl/cms/include/blog-left-nav.tmpl
    'Creating'        => 'Создание',
    'Create Entry'    => 'Создание новой записи',
    'Community'       => 'Сообщество',
    'List Commenters' => 'Список комментаторов',
    'Edit Address Book' =>
      'Редактировать адресную книгу',
    'List Users &amp; Groups' =>
      'Список пользователей и групп',
    'List &amp; Edit Templates' =>
      'Список шаблонов и их редактирование',
    'Edit Categories' => 'Редактирование категорий',
    'Edit Tags'       => 'Редактирование тегов',
    'Edit Weblog Configuration' =>
      'Изменить параметры блога',
    'Backup this weblog' => 'Бэкап этого блога',
    'Import &amp; Export Entries' =>
      'Импорт и экспорт записей',
    'Import / Export' => 'Импорт / Эскпорт',
    'Rebuild Site'    => 'Опубликовать сайт',

## tmpl/cms/include/entry_table.tmpl
    'Save these entries (s)' => 'Сохранить записи (s)',
    'Republish selected entries (r)' =>
      'Опубликовать повторно (r)',
    'Delete selected entries (x)' =>
      'Удалить выбранные записи (x)',
    'Save these pages (s)' => 'Сохранить страницы (s)',
    'Republish selected pages (r)' =>
      'Опубликовать повторно (r)',
    'Delete selected pages (x)' =>
      'Удалить выбранные страницы (x)',
    'to republish'        => 'для повторной публикации',
    'Last Modified'       => 'Последнее изменение',
    'Created'             => 'Создано',
    'Unpublished (Draft)' => 'Черновик',
    'Unpublished (Review)' => 'Черновик (на проверке)',
    'Only show unpublished entries' =>
      'Показать только неопубликованные записи',
    'Only show unpublished pages' =>
      'Показать только неопубликованные страницы',
    'Only show published entries' =>
      'Показать только опубликованные записи',
    'Only show published pages' =>
      'Показать только опубликованные страницы',
    'Only show entries for review' =>
      'Показать только записи для проверки',
    'Only show pages for review' =>
      'Показать только страницы для проверки',
    'Only show scheduled entries' =>
      'Показать только запланированные записи',
    'Only show scheduled pages' =>
      'Показать только запланированные страницы',
    'Only show spam entries' =>
      'Показать только спам-записи',
    'Only show spam pages' =>
      'Показать только спам-страницы',
    'Edit Entry' => 'Редактирование записи',
    'Edit Page'  => 'Редактирование страницы',
    'View entry' => 'Посмотреть запись →',
    'View page'  => 'Посмотреть страницу',
    'No entries could be found. <a href="[_1]">Create an entry</a> now.' =>
      'Записей не найдено. <a href="[_1]">Создать новую</a>?',
    'No page could be found. <a href="[_1]">Create a page</a> now.' =>
      'Страницы не найдены. <a href="[_1]">Создать новую</a>?',

## tmpl/cms/include/itemset_action_widget.tmpl
    'More actions...' => 'Дополнительные опции…',
    'Plugin Actions'  => 'Опции плагинов',
    'to act upon'     => 'действует в соответствии с',
    'Go'              => 'OK',

## tmpl/cms/list_role.tmpl
    'Roles: System-wide' => 'Роли: системный уровень',
    'You have successfully deleted the role(s).' =>
      'Роли успешно удалены.',
    'roles'               => 'роли',
    'Members'             => 'Пользователи',
    'Role Is Active'      => 'Роль активна',
    'Role Not Being Used' => 'Роль не используется',

## tmpl/cms/dialog/new_password.tmpl
    'Choose New Password' => 'Выберите новый пароль',

## tmpl/cms/dialog/asset_options_image.tmpl
    'Display image in entry' =>
      'Показать изображение в записи',
    'Alignment' => 'Выравнивание',
    'Left'      => 'По левому краю',
    'Center'    => 'По центру',
    'Right'     => 'По правому краю',
    'Use thumbnail' =>
      'Использовать уменьшенное изображение',
    'width:' => 'ширина:',
    'pixels' => 'px',
    'Link image to full-size version in a popup window.' =>
      'Ссылка на полноразмерное изображение в новом окне',
    'Remember these settings' =>
      'Запомнить эти параметры',

## tmpl/cms/dialog/restore_upload.tmpl
    'Restore: Multiple Files' =>
      'Восстановить : Несколько файлов',
    'Canceling the process will create orphaned objects.  Are you sure you want to cancel the restore operation?'
      => 'Отмена процесса приведет к возникновению объектов-сирот. Вы уверены, что хотите остановить процесс восстановления?',
    'Please upload the file [_1]' =>
      'Пожалуйста, загрузите файл [_1]',

## tmpl/cms/dialog/recover.tmpl
    'The email address provided is not unique.  Please enter your username.'
      => 'Email-адрес не является уникальным. Пожалуйста, введите своё имя пользователя.',
    'An email with a link to reset your password has been sent to your email address ([_1]).'
      => 'На адрес [_1] отправлено письмо, содержащее ссылку для сброса пароля.',
    'Go Back (x)'           => 'Назад (x)',
    'Sign in to Melody (s)' => 'Авторизация в Melody (s)',
    'Sign in to Melody'     => 'Авторизация в Melody',
    'Recover (s)'           => 'Восстановить (s)',
    'Recover'               => 'Восстановить',

## tmpl/cms/dialog/restore_end.tmpl
    'An error occurred during the restore process: [_1] Please check your restore file.'
      => 'Ошибка в процессе восстановления: [_1] Пожалуйста, проверьте файл.',
    'View Activity Log (v)' =>
      'Посмотреть журнал активности (v)',
    'Close (s)' => 'Закрыть (s)',
    'Next Page' => 'Следующая страница',
    'The page will redirect to a new page in 3 seconds. [_1]Stop the redirect.[_2]'
      => 'Через 3 секунды вы будете перенаправлены на новую страницу. [_1]Остановить переход.[_2]',

## tmpl/cms/dialog/asset_options.tmpl
    'File Options' => 'Опции файла',
    'Create entry using this uploaded file' =>
      'Создать запись с загруженным файлом',
    'Create a new entry using this uploaded file.' =>
      'Создать новую запись с загруженным файлом.',
    'Finish (s)' => 'Завершить (s)',
    'Finish'     => 'Завершить',

## tmpl/cms/dialog/asset_insert.tmpl

## tmpl/cms/dialog/refresh_templates.tmpl
    'Refresh Template Set' =>
      'Обновить связку шаблонов',
    'Refresh [_1] template set' =>
      'Обновить связку шаблонов «[_1]»',
    'Refresh global templates' =>
      'Восстановить глобальные шаблоны',
    'Updates current templates while retaining any user-created templates.' =>
      'Обновление текущих шаблонов с сохранением любых шаблонов, созданных пользователем.',
    'Apply a new template set' =>
      'Применить новую связку шаблонов',
    'Deletes all existing templates and install the selected template set.' =>
      'Удаление всех существующих шаблонов и установка выбранной связки шаблонов.',
    'Reset to factory defaults' =>
      'Возврат к установкам по умолчанию',
    'Deletes all existing templates and installs factory default template set.'
      => 'Удаление всех существующих шаблонов и установка стандартной связки шаблонов.',
    'Make backups of existing templates first' =>
      'Сделать резервную копию существующих шаблонов',
    'You have requested to <strong>refresh the current template set</strong>. This action will:'
      => 'Вы хотите <strong>обновить текущую связку шаблонов</strong>. Это действие выполнит:',
    'You have requested to <strong>refresh the global templates</strong>. This action will:'
      => 'Вы хотите <strong>обновить глобальные шаблоны</strong>. Это действие выполнит:',
    'make backups of your templates that can be accessed through your backup filter'
      => 'будет сделана резервная копия шаблонов, которые можно будет посмотреть в специальном разделе',
    'potentially install new templates' =>
      'возможно, будут установлены новые шаблоны',
    'overwrite some existing templates with new template code' =>
      'перезаписать некоторые существующие шаблоны новыми',
    'You have requested to <strong>apply a new template set</strong>. This action will:'
      => 'Вы хотите <strong>применить новую связку шаблонов</strong>. Это действие выполнит:',
    'You have requested to <strong>reset to the default global templates</strong>. This action will:'
      => 'Вы хотите <strong>вернуться к стандартным глобальным шаблонам</strong>. Это действие выполнит:',
    'delete all of the templates in your blog' =>
      'удалит все шаблоны вашего блога',
    'install new templates from the selected template set' =>
      'установит новые шаблоны из выбранной связки шаблонов',
    'delete all of your global templates' =>
      'удалит все глобальные глобальные шаблоны',
    'install new templates from the default global templates' =>
      'установит новые, используя стандартные глобальные шаблоны',
    'Are you sure you wish to continue?' =>
      'Вы уверены, что хотите продолжить?',

## tmpl/cms/dialog/comment_reply.tmpl
    'Reply to comment' => 'Ответить на комментарий',
    'On [_1], [_2] commented on [_3]' =>
      '[_1], [_2] комментировал(а) [_3]',
    'Preview of your comment' => 'Просмотр комментария',
    'Your reply:'             => 'Ваш ответ:',
    'Submit reply (s)'        => 'Отправить ответ (s)',
    'Preview reply (v)'       => 'Просмотр ответа (v)',
    'Re-edit reply (r)'       => 'Изменить ответ (r)',
    'Re-edit'                 => 'Изменить',

## tmpl/cms/dialog/create_association.tmpl
    'No roles exist in this installation. [_1]Create a role</a>' =>
      'В данной инсталляции нет ролей. [_1]Создать роль</a>',
    'No groups exist in this installation. [_1]Create a group</a>' =>
      'В данной инсталляции нет групп. [_1]Создать группу</a>',
    'No users exist in this installation. [_1]Create a user</a>' =>
      'В данной инсталляции нет пользователей [_1]Создать пользователя</a>',
    'No blogs exist in this installation. [_1]Create a blog</a>' =>
      'В данной инсталляции нет блогов. [_1]Создать блог</a>',

## tmpl/cms/dialog/adjust_sitepath.tmpl
    'Confirm Publishing Configuration' =>
      'Подтверждение настроек публикации',
    'URL is not valid.' => 'Некорректный URL.',
    'You can not have spaces in the URL.' =>
      'Пробелы в URL недопустимы.',
    'You can not have spaces in the path.' =>
      'Путь не должен содержать пробелов.',
    'Path is not valid.' => 'Недопустимый путь.',
    'Site Path'          => 'Путь сайта',

## tmpl/cms/dialog/publishing_profile.tmpl
    'Publishing Profile' => 'Профиль публикации',
    'Choose the profile that best matches the requirements for this blog.' =>
      'Выберите профиль, наиболее подходящий вашему блогу.',
    'Static Publishing' => 'Статическая публикация',
    'Immediately publish all templates statically.' =>
      'Немедленная публикация всех шаблонов на сервере.',
    'Background Publishing' => 'Фоновая публикация',
    'All templates published statically via Publish Que.' =>
      'Все шаблоны публикуются на сервере с использованием очереди публикации.',
    'High Priority Static Publishing' =>
      'Высокоприоритетная статическая публикация',
    'Immediately publish Main Index template, Entry archives, and Page archives statically. Use Publish Queue to publish all other templates statically.'
      => 'На сервере немедленно публикуются главная страница, архивы записей и индивидуальные страницы. Чтобы опубликовать другие шаблоны, необходимо использовать очередь публикации.',
    'Dynamic Publishing' => 'Динамическая публикация',
    'Publish all templates dynamically.' =>
      'Публиковать все шаблоны динамически',
    'Dynamic Archives Only' =>
      'Только динамические архивы',
    'Publish all Archive templates dynamically. Immediately publish all other templates statically.'
      => 'Все шаблоны архивов публикуются динамически. Все остальные шаблоны немедленно публикуются на сервере.',
    'This new publishing profile will update all of your templates.' =>
      'Этот новый профиль публикации обновит все ваши шаблоны.',

## tmpl/cms/dialog/restore_start.tmpl
    'Restoring...' => 'Восстановление…',

## tmpl/cms/dialog/entry_notify.tmpl
    'Send a Notification' => 'Отправить по почте',
    'You must specify at least one recipient.' =>
      'Вы должны указать как минимум одного адресата.',
    'Your blog\'s name, this entry\'s title and a link to view it will be sent in the notification.  Additionally, you can add a  message, include an excerpt of the entry and/or send the entire entry.'
      => 'В письмо будут включены: имя блога, заголовок и ссылка на полный текст записи. Вы также можете добавить дополнительное сообщение, включить текст выдержки или полный текст записи.',
    'Recipients' => 'Адресаты',
    'Enter email addresses on separate lines, or comma separated.' =>
      'Введите email адреса (по одному на строке или через запятую).',
    'All addresses from Address Book' =>
      'Все адреса из адресной книги',
    'Optional Message' => 'Дополнительное сообщение',
    'Optional Content' => 'Дополнительное содержание',
    '(Entry Body will be sent without any text formatting applied)' =>
      '(Основной текст записи будет отправлен без форматирования)',
    'Send notification (s)' =>
      'Отправить уведомление (s)',
    'Send' => 'Отправить',

## tmpl/cms/dialog/asset_replace.tmpl
    'A file named \'[_1]\' already exists. Do you want to overwrite this file?'
      => 'Файл с именем «[_1]» уже существует. Хотите перезаписать файл?',

## tmpl/cms/dialog/asset_upload.tmpl
    'You need to configure your blog.' =>
      'Вам необходимо сконфигурировать блог.',
    'Your blog has not been published.' =>
      'Ваш блог не был опубликован.',

## tmpl/cms/dialog/clone_blog.tmpl
    'Verify Blog Settings' =>
      'Проверить параметры блога',
    'This is set to the same URL as the original blog.' =>
      'Это значение взято из первоначального блога',
    'This will overwrite the original blog.' =>
      'Это перезапишет оригинальный блог',
    'Exclusions' => 'Исключения',
    'Exclude Entries/Pages' =>
      'Исключить записи/страницы',
    'Exclude Comments'   => 'Исключить комментарии',
    'Exclude Trackbacks' => 'Исключить трекбэки',
    'Exclude Categories' => 'Исключить категории',
    'Clone'              => 'Клонировать',
    'Enter the new URL of your public website. Example: http://www.example.com/weblog/'
      => 'Введите новый адрес вашего сайта. Пример: http://www.example.com/weblog/',
    'Enter a new path where your main index file will be located. Example: /home/melody/public_html/weblog'
      => 'Введите новый путь, где будут располагаться файлы сайта. Пример: /home/username/public_html/weblog',
    'Clone Settings' => 'Параметры клонирования',
    'Mark the settings that you want cloning to skip' =>
      'Выберите элементы, которые вы хотите исключить из клонирования',
    'Entries/Pages' => 'Записи/Страницы',

## tmpl/cms/dialog/asset_list.tmpl
    'Insert Asset'    => 'Вставить медиа',
    'Upload New File' => 'Загрузить новый файл',
    'Upload New Image' =>
      'Загрузить новое изображение',
    'Asset Name' => 'Имя медиа',
    'Next (s)'   => 'Следующий (s)',
    'Insert (s)' => 'Вставить (s)',
    'Insert'     => 'Вставить',
    'No assets could be found.' =>
      'Медиа объекты не найдены.',

## tmpl/cms/cfg_entry.tmpl
    'Entry Settings'   => 'Настройка записей',
    'Display Settings' => 'Опции отображения',
    'Entry Listing Default' =>
      'Список записей по умолчанию',
    'Select the number of days of entries or the exact number of entries you would like displayed on your blog.'
      => 'Выберите количество дней или точное количество записей, которые вы хотите отобразить в своём блоге.',
    'Days'        => 'Дни',
    'Entry Order' => 'Сортировка записей',
    'Select whether you want your entries displayed in ascending (oldest at top) or descending (newest at top) order.'
      => 'Выберите, как должны отображаться записи: по убыванию (новые вверху; обычный метод) или по возрастанию (старые вверху).',
    'Excerpt Length' => 'Длина выдержки',
    'Enter the number of words that should appear in an auto-generated excerpt.'
      => 'Введите количество слов, которые будут использоваться при автоматической генерации выдержки.',
    'Date Language' => 'Язык дат',
    'Select the language in which you would like dates on your blog displayed.'
      => 'Выберите язык, на котором будут отображаться даты в блоге.',
    'Czech'      => 'Чешский',
    'Danish'     => 'Датский',
    'Dutch'      => 'Голландский',
    'English'    => 'Английский',
    'Estonian'   => 'Эстонский',
    'French'     => 'Французский',
    'German'     => 'Немецкий',
    'Icelandic'  => 'Исландский',
    'Italian'    => 'Итальянский',
    'Japanese'   => 'Японский',
    'Norwegian'  => 'Норвежский',
    'Polish'     => 'Польский',
    'Portuguese' => 'Португальский',
    'Russian'    => 'Русский',
    'Slovak'     => 'Словацкий',
    'Slovenian'  => 'Словенский',
    'Spanish'    => 'Испанский',
    'Suomi'      => 'Финский',
    'Swedish'    => 'Шведский',
    'Basename Length' =>
      'Длина базового имени (имени файла при публикации записей)',
    'Specifies the default length of an auto-generated basename. The range for this setting is 15 to 250.'
      => 'Определите значение автоматически генерируемого базового имени. Диапозон: от 15 до 250.',
    'New Entry Defaults' =>
      'Предпочтения для новых записей',
    'Specifies the default Entry Status when creating a new entry.' =>
      'Определите статус новой записи по умолчанию.',
    'Unpublished' => 'Черновик',
    'Specifies the default Text Formatting option when creating a new entry.'
      => 'Определите, какой вид форматирования текста будет новых записей по умолчанию.',
    'Specifies the default Accept Comments setting when creating a new entry.'
      => 'Определите значение по умолчанию для комментариев при создании новой записи.',
    'Setting Ignored' => 'Игнорируемые параметры',
    'Note: This option is currently ignored since comments are disabled either blog or system-wide.'
      => 'Примечание: эта опция в настоящее время игнорируется, так как комментарии отключены в блоге или на системном уровне.',
    'Accept TrackBacks' => 'Принимать трекбэки',
    'Specifies the default Accept TrackBacks setting when creating a new entry.'
      => 'Определите значение по умолчанию для трекбэков при создании новой записи.',
    'Note: This option is currently ignored since TrackBacks are disabled either blog or system-wide.'
      => 'Примечание: эта опция в настоящее время игнорируется, так как трекбэки отключены в блоге или на системном уровне.',
    'Replace Word Chars' => 'Заменять символы Word',
    'Smart Replace'      => 'Заменять',
    'Replace UTF-8 characters frequently used by word processors with their more common web equivalents.'
      => 'Заменять символы UTF-8, часто использующиеся текстовыми редакторами, их эквивалентом, наиболее подходящим для web.',
    'No substitution' => 'Не осуществлять замену',
    'Character entities (&amp#8221;, &amp#8220;, etc.)' =>
      'Специальные символы (&amp#8221;, &amp#8220;, и другие.)',
    'ASCII equivalents (&quot;, \', ..., -, --)' =>
      'Эквиваленты ASCII (&quot;, \', ..., -, --)',
    'Replace Fields' => 'Заменять символы в полях',
    'Extended entry' => 'Расширенная часть',
    'Default Editor Fields' =>
      'Поля редактора по умолчанию',
    'Editor Fields' => 'Поля редактора',
    '_USAGE_ENTRYPREFS' =>
      'Конфигурация полей определяет поля, которые появятся при добавлении или редактировании записей. Вы можете выбрать базовую или продвинутую конфигурацию, или выполнить персональную настройку.',
    'Body'        => 'Текст',
    'Action Bars' => 'Панель задач',
    'Select the location of the entry editor&rsquo;s action bar.' =>
      'Выберите расположение панели задач в редакторе записей.',

## tmpl/cms/list_ping.tmpl
    'Manage Trackbacks' => 'Управление трекбэками',
    'The selected TrackBack(s) has been approved.' =>
      'Выбранные трекбэки приняты.',
    'All TrackBacks reported as spam have been removed.' =>
      'Все трекбэки, отмеченные как спам, были удалены.',
    'The selected TrackBack(s) has been unapproved.' =>
      'Выбранные трекбэки были отклонены',
    'The selected TrackBack(s) has been reported as spam.' =>
      'Выбранные трекбэки помечены как спам.',
    'The selected TrackBack(s) has been recovered from spam.' =>
      'Выбранные трекбэки восстановлены из спама.',
    'The selected TrackBack(s) has been deleted from the database.' =>
      'Выбранные трекбэки удалены из базы данных.',
    'No TrackBacks appeared to be spam.' =>
      'Среди трекбэков не обнаружено спама.',
    'Show only [_1] where' => 'Все [_1], у которых',
    'unapproved'           => 'отклонено',

## tmpl/cms/search_replace.tmpl
    'You must select one or more item to replace.' =>
      'Для замены необходимо выбрать один или несколько объектов.',
    'Search Again'      => 'Повторный поиск',
    'Submit search (s)' => 'Начать поиск (s)',
    'Replace'           => 'Замена',
    'Replace Checked'   => 'Заменить в выделенных',
    'Case Sensitive' =>
      'Чувствительность к регистру',
    'Regex Match'       => 'Регулярные выражения',
    'Limited Fields'    => 'Ограничение областями',
    'Date Range'        => 'Период',
    'Reported as Spam?' => 'Помеченный как спам?',
    'Search Fields:'    => 'Искать в областях:',
    '_DATE_FROM'        => 'С',
    '_DATE_TO'          => 'до',
    'Successfully replaced [quant,_1,record,records].' =>
      'Замена успешно осуществлена в [quant,_1,объекте,объектах,объектах].',
    'Showing first [_1] results.' =>
      'Показано [_1] найденных объектов.',
    'Show all matches' => 'Показать все',
    '[quant,_1,result,results] found' =>
      'найдено [quant,_1,соответствие,соответствия,соответствий]',

## tmpl/cms/widget/blog_stats_entry.tmpl
    'Most Recent Entries' => 'Последние записи',
    '...'                 => '…',
    'Posted by [_1] [_2] in [_3]' =>
      'Добавил [_1], категории: [_3], [_2]',
    'Posted by [_1] [_2]'   => 'Добавил [_1] [_2]',
    'Tagged: [_1]'          => 'Теги: [_1]',
    'View all entries'      => 'Посмотреть все записи',
    'No entries available.' => 'Нет доступных записей.',

## tmpl/cms/widget/blog_stats.tmpl
    'Error retrieving recent entries.' =>
      'Ошибка при получении последних записей.',
    'Loading recent entries...' =>
      'Загрузка последних записей…',
    'Jan.'  => '&#1071;&#1085;&#1074;.',
    'Feb.'  => '&#1060;&#1077;&#1074;.',
    'July.' => '&#1048;&#1102;&#1083;&#1100;',
    'Aug.'  => '&#1040;&#1074;&#1075.',
    'Sept.' => '&#1057;&#1077;&#1085;&#1090;.',
    'Oct.'  => '&#1054;&#1082;&#1090;.',
    'Nov.'  => '&#1053;&#1086;&#1103;.',
    'Dec.'  => '&#1044;&#1077;&#1082;.',
    'Melody was unable to locate your \'mt-static\' directory. Please configure the \'StaticFilePath\' configuration setting in your config.cgi file, and create a writable \'support\' directory underneath your \'mt-static\' directory.'
      => 'Melody не удалось определить местонахождение вашего каталога «mt-static». Пожалуйста, проверьте параметр «StaticFilePath» в файле config.cgi. Также необходимо убедиться, чтобы каталог находящаяся в mt-static папка «support» была перезаписываема.',
    'Melody was unable to write to its \'support\' directory. Please create a directory at this location: [_1], and assign permissions that will allow the web server write access to it.'
      => 'Melody не удалось записать файлы в в папку «support». Пожалуйста, создайте эту папку в этой директории: [_1]. После этого сделайте папку support перезаписываемой.',
    '[_1] [_2] - [_3] [_4]' => '[_1] [_2] — [_3] [_4]',
    'You have <a href=\'[_3]\'>[quant,_1,comment,comments] from [_2]</a>' =>
      'У вас <a href=\'[_3]\'>[quant,_1,комментарий,комментария,комментариев] в [_2]</a>',
    'You have <a href=\'[_3]\'>[quant,_1,entry,entries] from [_2]</a>' =>
      'У вас <a href=\'[_3]\'>[quant,_1,запись,записи,записей] в [_2]</a>',

## tmpl/cms/widget/new_user.tmpl
    'Welcome to Melody' => 'Добро пожаловать в Melody',
    'Welcome to Melody, the world\'s most powerful blogging, publishing and social media platform. To help you get started we have provided you with links to some of the more common tasks new users like to perform:'
      => 'Добро пожаловать в Melody — наиболее мощную блогинг-платформу в мире, с помощью которой вы сможете публиковать материалы и создать собственное социальное медиа. Для начала предлагаем воспользоваться слудующими ссылками — они помогут справиться с задачами, которые часто возникают у новых пользователей:',
    'Write your first post' =>
      'Создать первое сообщение',
    'What would a blog be without content? Start your Melody experience by creating your very first post.'
      => 'Что за блог без содержания? Начните знакомиться с Melody прямо сейчас, создавая своё первое сообщение.',
    'Design your blog' =>
      'Настроить оформление блога',
    'Customize the look and feel of your blog quickly by selecting a design from one of our professionally designed themes.'
      => 'Персонализируйте ваш блог, используя дизайн, созданный профессионалами.',
    'Explore what\'s new in Melody' =>
      'Узнайте, что нового появилось в Melody',
    'Whether you\'re new to Melody or using it for the first time, learn more about what this tool can do for you.'
      => 'Вы только что установили Melody и, возможно, пока не знаете, на что способна эта платформа. Посмотрите, что этот инструмент может сделать для вас.',

## tmpl/cms/widget/blog_stats_comment.tmpl
    'Most Recent Comments'    => 'Последние комментарии',
    '[_1] [_2], [_3] on [_4]' => '[_1] [_2], [_3] — [_4]',
    'View all comments'       => 'Все комментарии',
    'No comments available.' =>
      'Пока что нет комментариев.',

## tmpl/cms/widget/blog_stats_recent_entries.tmpl
    '[quant,_1,entry,entries] tagged &ldquo;[_2]&rdquo;' =>
      '[quant,_1,запись,записи,записей], связанных с тегом «[_2]»',
    'View all entries tagged &ldquo;[_1]&rdquo;' =>
      'Посмотреть все записи, связанные с тегом «[_1]»',

## tmpl/cms/widget/custom_message.tmpl
    'This is you'      => 'Это вы',
    'Welcome to [_1].' => 'Добро пожаловать в [_1].',
    'You can manage your blog by selecting an option from the menu located to the left of this message.'
      => 'Вы можете управлять вашим блогом, выбирая различный опции из меню, расположенного в левом углу от этого сообщения.',
    'If you need assistance, try:' =>
      'Если вам необходима помощь, вы можете проконсультироваться у:',
    'Melody User Manual' =>
      'Руководство пользователя Melody',
    'http://www.sixapart.com/movabletype/support' =>
      'http://www.sixapart.com/movabletype/support',
    'Melody Technical Support' =>
      'Техническая поддержка Melody',
    'Melody Community Forums' => 'Форум сообщества Melody',
    'Save Changes (s)'        => 'Сохранить изменения',
    'Change this message.' => 'Изменить это сообщение.',
    'Edit this message.' =>
      'Редактировать это сообщение.',

## tmpl/cms/widget/this_is_you.tmpl
    'Your <a href="[_1]">last entry</a> was [_2] in <a href="[_3]">[_4]</a>.'
      => 'Ваша <a href="[_1]">последняя запись</a> создана [_2] в блоге <a href="[_3]">[_4]</a>.',
    'Your last entry was [_1] in <a href="[_2]">[_3]</a>.' =>
      'Ваша последняя запись создана [_1] в блоге <a href="[_2]">[_3]</a>.',
    'You have <a href="[_1]">[quant,_2,draft,drafts]</a>.' =>
      'Также у вас есть <a href="[_1]">[quant,_2,черновик,черновика,черновиков]</a>.',
    'You have [quant,_1,draft,drafts].' =>
      'Также у вас есть [quant,_1,черновик,черновика,черновиков]',
    'You\'ve written <a href="[_1]">[quant,_2,entry,entries]</a> with <a href="[_3]">[quant,_4,comment,comments]</a>.'
      => 'Всего вами создано <a href="[_1]">[quant,_2,запись,записи,записей]</a>, которые <a href="[_3]">прокомментировали</a> <nobr>[quant,_4,раз,раза,раз]</nobr>.',
    'You\'ve written [quant,_1,entry,entries] with <a href="[_2]">[quant,_3,comment,comments]</a>.'
      => 'Всего вами создано [quant,_1,запись,записи,записей], которые <a href="[_2]">прокомментировали</a> <nobr>[quant,_3,раз,раза,раз]</nobr>.',
    'You\'ve written [quant,_1,entry,entries] with [quant,_2,comment,comments].'
      => 'Всего вами создано [quant,_2,запись,записи,записей], которые прокомментировали <nobr>[quant,_3,раз,раза,раз]</nobr>.',
    'You\'ve written <a href="[_1]">[quant,_2,entry,entries]</a>.' =>
      'Всего вами создано <a href="[_1]">[quant,_2,запись,записи,записей]</a>.',
    'You\'ve written [quant,_1,entry,entries].' =>
      'Всего вами создано [quant,_2,запись,записи,записей].',
    'Edit your profile' => 'Редактировать профиль',

## tmpl/cms/widget/mt_shortcuts.tmpl
    'Import Content'   => 'Импорт контента',
    'Blog Preferences' => 'Настройка блога',

## tmpl/cms/widget/new_install.tmpl
    'Thank you for installing Melody' =>
      'Спасибо за установку Melody',
    'Congratulations on installing Melody, the world\'s most powerful blogging, publishing and social media platform. To help you get started we have provided you with links to some of the more common tasks new users like to perform:'
      => 'Поздравляем, вы успешно установили Melody — наиболее мощную блогинг-платформу в мире, с помощью которой вы сможете публиковать материалы и создать собственное социальное медиа. Для начала предлагаем воспользоваться слудующими ссылками — они помогут справиться с задачами, которые часто возникают у новых пользователей:',
    'Add more users to your blog' =>
      'Добавить пользователей в ваш блог',
    'Start building your network of blogs and your community now. Invite users to join your blog and promote them to authors.'
      => 'Начните создавать вашу сеть блогов или сообщество прямо сейчас. Пригласите пользователей присоединиться к вашему блогу и предоставьте им статус авторов.',

## tmpl/cms/widget/blog_stats_tag_cloud.tmpl

## tmpl/cms/widget/mt_news.tmpl
    'News'        => 'Новости',
    'MT News'     => 'Новости MT',
    'Learning MT' => 'Изучая Melody',
    'Hacking MT'  => 'Hacking MT',
    'Pronet'      => 'Pronet',
    'No Melody news available.' =>
      'Нет доступных новостей от Melody.',
    'No Learning Melody news available.' =>
      'Нет доступных новостей из блога «Изучая Melody».',

## tmpl/cms/widget/new_version.tmpl
    'What\'s new in Melody [_1]' => 'Что нового в Melody [_1]',
    'Congratulations, you have successfully installed Melody [_1]. Listed below is an overview of the new features found in this release.'
      => 'Поздравляем, вы успешно установили Melody [_1]. Ниже представлен обзор новых возможностей этого релиза.',

## tmpl/cms/edit_template.tmpl
    'Edit Widget'     => 'Редактировать виджет',
    'Create Widget'   => 'Создать виджет',
    'Create Template' => 'Создание шаблона',
    'A saved version of this [_1] was auto-saved [_3]. <a href="[_2]">Recover auto-saved content</a>'
      => 'Автоматически сохранился предыдущий контент, созданный вами [_3]. <a href="[_2]">Восстановить?</a>',
    'You have successfully recovered your saved [_1].' =>
      'Контент ([_1]) восстановлен.',
    'An error occurred while trying to recover your saved [_1].' =>
      'Ошибка при попытке восстановления [_1].',
    '<a href="[_1]" class="rebuild-link">Publish</a> this template.' =>
      '<a href="[_1]" class="rebuild-link">Опубликовать</a> его?',
    'Useful Links'        => 'Полезные ссылки',
    'List [_1] templates' => 'Список шаблонов ([_1])',
    'List all templates'  => 'Список всех шаблонов',
    'Included Templates'  => 'Включаемые шаблоны',
    'create'              => 'создать',
    'Template Tag Docs'   => 'Документация по тегам',
    'Unrecognized Tags'   => 'Неизвестные теги',
    'Save (s)'            => 'Сохранить (s)',
    'Save and Publish this template (r)' =>
      'Сохранить и опубликовать шаблон (r)',
    'Save &amp; Publish' => 'Сохранить и опубликовать',
    'You have unsaved changes to this template that will be lost.' =>
      'Изменения, внесённые в этот шаблон, будут утеряны.',
    'You must set the Template Name.' =>
      'Необходимо указать имя шаблона.',
    'You must set the template Output File.' =>
      'Необходимо указать имя файла шаблона.',
    'Processing request...' => 'Обработка запроса…',
    'Error occurred while updating archive maps.' =>
      'Ошибка при обновлении карты архива.',
    'Archive map has been successfully updated.' =>
      'Карта архива успешно обновлена',
    'Are you sure you want to remove this template map?' =>
      'Вы уверены, что хотите удалить карту шаблона?',
    'Module Body'   => 'Содержимое модуля',
    'Template Body' => 'Содержимое шаблона',
    'Syntax Highlight On' =>
      'Включить подсветку синтаксиса',
    'Syntax Highlight Off' =>
      'Выключить подсветку синтаксиса',
    'Insert...'        => 'Вставить…',
    'Template Options' => 'Опции шаблона',
    'Output file: <strong>[_1]</strong>' =>
      'Публикуемый файл: <strong>[_1]</strong>',
    'Enabled Mappings: [_1]' => 'Типы публикаций: [_1]',
    'Template Type'          => 'Тип шаблона',
    'Custom Index Template' =>
      'Обычный индексный шаблон',
    'Link to File' => 'Связать с файлом',
    'Learn more about <a href="http://www.movabletype.org/documentation/administrator/publishing/settings.html" target="_blank">publishing settings</a>'
      => 'Узнать больше о <a href="http://www.movabletype.org/documentation/administrator/publishing/settings.html" target="_blank">профилях публикации</a>',
    'Create Archive Mapping' => 'Создать путь архива',
    'Add'                    => 'Добавить',
    'Server Side Include' =>
      'Включение на стороне сервера (SSI)',
    'Process as <strong>[_1]</strong> include' =>
      'Обрабатывать как <strong>[_1]</strong> включение',
    'Include cache path' => 'Включить кэш-путь',
    'Disabled (<a href="[_1]">change publishing settings</a>)' =>
      'Отключено (<a href="[_1]">изменить параметры публикации</a>)',
    'No caching'   => 'Не кэшируется',
    'Expire after' => 'Истекает после',
    'Expire upon creation or modification of:' =>
      'Истечёт после создания или модификации:',
    'Auto-saving...' => 'Автосохранение…',
    'Last auto-save at [_1]:[_2]:[_3]' =>
      'Автоматически сохранено [_1]:[_2]:[_3]',

## tmpl/cms/login.tmpl
    'Your Melody session has ended.' =>
      'Ваша сессия Melody завершена.',
    'Your Melody session has ended. If you wish to sign in again, you can do so below.'
      => 'Ваша сессия Melody завершена. Если Вы хотите снова авторизоваться, используйте форму ниже.',
    'Your Melody session has ended. Please sign in again to continue this action.'
      => 'Ваша сессия Melody завершена. Пожалуйста, авторизуйтесь заново для продолжения работы.',
    'Forgot your password?' => 'Забыли пароль?',
    'Sign In (s)'           => 'Войти (s)',

## tmpl/cms/cfg_system_users.tmpl
    'System: User Settings' =>
      'Параметры пользователей',
    '(No blog selected)' => '(Блог не выбран)',
    'Select blog'        => 'Выбрать блог',
    'You must set a valid Default Site URL.' =>
      'Необходимо указать правильный URL для сайта по умолчанию.',
    'You must set a valid Default Site Root.' =>
      'Необходимо указать правильный путь публикации для сайта по умолчанию.',
    '(None selected)' => '(Ничего не выбрано)',
    'Select a system administrator you wish to notify when commenters successfully registered themselves.'
      => 'Выберите администратора, которого вы хотите уведомить о новых зарегистрированных комментаторах.',
    'Allow commenters to register to Melody' =>
      'Разрешить комментаторам регистрироваться в Melody',
    'Notify the following administrators upon registration:' =>
      'Уведомлять следующих администраторов о регистрации:',
    'Select Administrators' =>
      'Выбрать администраторов',
    'Clear' => 'Очистить',
    'Note: System Email Address is not set. Emails will not be sent.' =>
      'Примечание: не указан системный email адрес, поэтому почта не будет отправлена.',
    'New User Defaults' =>
      'Параметры по умолчанию для новых пользователей',
    'Personal blog' => 'Персональный блог',
    'Check to have the system automatically create a new personal blog when a user is created in the system. The user will be granted a blog administrator role on the blog.'
      => 'Система автоматически создаёт новый блог, когда создаётся новый пользователь. Такому пользователю будет предоставлена роль администратора в этом блоге.',
    'Automatically create a new blog for each new user' =>
      'Автоматически создавать новый блог для каждого нового пользователя',
    'Personal blog clone source' =>
      'Блог, который будет клонирован',
    'Select a blog you wish to use as the source for new personal blogs. The new blog will be identical to the source except for the name, publishing paths and permissions.'
      => 'Выберите блог, который будет служить источником для новых блогов. Таким образом, новый блог будет идентичен источнику, за исключением названия, пути публикации и прав пользователей.',
    'Change blog'      => 'Изменить блог',
    'Default Site URL' => 'URL по умолчанию',
    'Define the default site URL for new blogs. This URL will be appended with a unique identifier for the blog.'
      => 'Определите URL по умолчанию для новых блогов. Этот адрес будет использован как начало адреса для новых блогов.',
    'Default Site Root' =>
      'Путь публикации по умолчанию',
    'Define the default site root for new blogs. This path will be appended with a unique identifier for the blog.'
      => 'Укажите путь публикации по умолчанию для новых блогов. Новые блоги будут распологаться в подпапках этой директории.',
    'Default User Language' =>
      'Язык по умолчанию для пользователей',
    'Define the default language to apply to all new users.' =>
      'Укажите язык, который по умолчанию будет у всех новых пользователей.',
    'Default Timezone' => 'Часовой пояс по умолчанию',
    'Default Tag Delimiter' =>
      'Разделитель тегов по умолчанию',
    'Define the default delimiter for entering tags.' =>
      'Укажите разделитель тегов по умолчанию.',

## tmpl/cms/edit_folder.tmpl
    'Edit Folder' => 'Изменить папку',
    'Your folder changes have been made.' =>
      'Изменения папки сделаны.',
    'Manage Folders' => 'Управление папками',
    'Manage pages in this folder' =>
      'Управление страницами в этой папке',
    'You must specify a label for the folder.' =>
      'Необходимо указать имя для папки.',
    'Save changes to this folder (s)' =>
      'Сохранить изменения папки (s)',

## tmpl/cms/pinging.tmpl
    'Trackback'        => 'Трекбэк',
    'Pinging sites...' => 'Выполняем пинг сайтов…',

## tmpl/cms/cfg_trackbacks.tmpl
    'TrackBack Settings' => 'Настройка трекбэков',
    'Your TrackBack preferences have been saved.' =>
      'Параметры трекбэков сохранены.',
    'Note: TrackBacks are currently disabled at the system level.' =>
      'Примечание: в настоящее время трекбэки отключены на системном уровне.',
    'If enabled, TrackBacks will be accepted from any source.' =>
      'Если активно, трекбэки будут приниматься от любого сайта.',
    'TrackBack Policy' => 'Правила для трекбэков',
    'Moderation'       => 'Модерация',
    'Hold all TrackBacks for approval before they\'re published.' =>
      'Не публиковать трекбэки, пока они не будут проверены.',
    'Specify when Melody should notify you of new TrackBacks if at all.' =>
      'Укажите, когда Melody должен будет уведомить о новых трекбэках.',
    'TrackBack Options' => 'Опции трекбэков',
    'TrackBack Auto-Discovery' =>
      'Автоматическая отправка трекбэков',
    'If you turn on auto-discovery, when you write a new entry, any external links will be extracted and the appropriate sites automatically sent TrackBacks.'
      => 'Если вы активируете автоматическую отправку трекбэков, то при сохранении новой записи, Melody автоматически отправит трекбэки на сайты, ссылки на которые есть в записи.',
    'Enable External TrackBack Auto-Discovery' =>
      'Для записей в других блогах',
    'Setting Notice' => 'Настройка уведомлений',
    'Note: The above option may be affected since outbound pings are constrained system-wide.'
      => 'Примечание: вышеупомянутая опция может быть применена, если исходящие пинги ограничены на системном уровне.',
    'Note: The above option is currently ignored since outbound pings are disabled system-wide.'
      => 'Примечание: в настоящее время эта опция игнорируется, так как исходящие пинги запрещены на системном уровне.',
    'Enable Internal TrackBack Auto-Discovery' =>
      'Для записей в этом блоге',

## tmpl/cms/list_category.tmpl
    'Your category changes and additions have been made.' =>
      'Изменения категории применены.',
    'You have successfully deleted the selected category.' =>
      'Выбранная категория удалена.',
    'categories' => 'Категории',
    'Delete selected category (x)' =>
      'Удалить выбранные категории (x)',
    'Create top level category' =>
      'Создать основную категорию',
    'New Parent [_1]'    => 'Новая родительская [_1]',
    'Create Category'    => 'Создать категорию',
    'Top Level'          => 'Верхний уровень',
    'Collapse'           => 'Свернуть',
    'Expand'             => 'Развернуть',
    'Create Subcategory' => 'Создать подкатегорию',
    'Move Category'      => 'Переместить категорию',
    'Move'               => 'Переместить',
    '[quant,_1,TrackBack,TrackBacks]' =>
      '[quant,_1,трекбэк,трекбэка,трекбэков]',
    'No categories could be found.' =>
      'Не найдено категорий.',

## tmpl/cms/cfg_web_services.tmpl
    'Web Services Settings' => 'Настройка веб-сервисов',
    'Six Apart Services'    => 'Сервисы Six Apart',
    'Your TypePad token is used to access Six Apart services like its free Authentication service.'
      => 'TypePad-токен используется для доступа к службам Six Apart, например, к бесплатному сервису авторизации.',
    'TypePad is enabled.' => 'TypePad включен',
    'TypePad token:'      => 'TypePad-токен:',
    'Clear TypePad Token' => 'Сбросить TypePad-токен',
    'Please click the Save Changes button below to disable authentication.' =>
      'Пожалуйста, сохраните изменения, чтобы отключить авторизацию.',
    'TypePad is not enabled.' => 'TypePad не активирован',
    'or'                      => 'или',
    'Obtain TypePad token'    => 'Получить TypePad-токен',
    'Please click the Save Changes button below to enable TypePad.' =>
      'Пожалуйста, не забудьте нажать кнопку «Сохранить изменения», чтобы активировать TypePad.',
    'External Notifications' => 'Внешние уведомления',
    'Notify of blog updates' =>
      'Уведомлять об обновлениях в блоге:',
    'When this blog is updated, Melody will automatically notify the selected sites.'
      => 'Когда в этом блоге появится новое содержимое, Melody автоматически уведомит следующие сайты.',
    'Note: This option is currently ignored since outbound notification pings are disabled system-wide.'
      => 'Примечание: в настоящее время эта опция игнорируется, так как исходязие пинги отключены на системном уровне.',
    'Others:' => 'Другие:',
    '(Separate URLs with a carriage return.)' =>
      '(Разделяйте URL переводом строки.)',
    'Recently Updated Key' =>
      'Ключ для последних обновлений',
    'If you have received a recently updated key (by virtue of your purchase), enter it here.'
      => 'Если у вас ключ для уведомления об последних обновлениях сайта Six Apart, введите его здесь.',

## tmpl/cms/restore_start.tmpl
    'Restoring Melody' => 'Восстановление Melody',

## tmpl/cms/edit_role.tmpl
    'Edit Role'  => 'Изменить роль',
    'List Roles' => 'Список ролей',
    '[quant,_1,User,Users] with this role' =>
      '[quant,_1,пользователь,пользователя,пользователей] с данной ролью',
    'You have changed the privileges for this role. This will alter what it is that the users associated with this role will be able to do. If you prefer, you can save this role with a different name.  Otherwise, be aware of any changes to users with this role.'
      => 'Вы изменили параметры роли. Это повлияет на возможности всех пользователей с данной ролью. Чтобы избежать этого, вы можете сохранить роль под новым именем.',
    'Role Details'             => 'Настройка роли',
    'Created by'               => 'Создана',
    'Check All'                => 'Выделить все',
    'Uncheck All'              => 'Снять отметки',
    'Administration'           => 'Администрирование',
    'Authoring and Publishing' => 'Создание и публикация',
    'Designing'                => 'Дизайнер',
    'Commenting'               => 'Комментирование',
    'Duplicate Roles'          => 'Повторяющиеся роли',
    'These roles have the same privileges as this role' =>
      'Эти роли состоят из того же набора прав, что и данная роль',
    'Save changes to this role (s)' =>
      'Сохранить изменения этой роли',

## tmpl/cms/cfg_spam.tmpl
    'Spam Settings' => 'Настройка спам-защиты',
    'Your spam preferences have been saved.' =>
      'Ваши защиты от спама сохранены.',
    'Auto-Delete Spam' =>
      'Автоматическое удаление спама',
    'If enabled, feedback reported as spam will be automatically erased after a number of days.'
      => 'Если эта опция активна, комментарии и трекбэки, определенные как спам, будет автоматически удаляться через указанное количество дней.',
    'Delete Spam After' => 'Удалять спам после',
    'When an item has been reported as spam for this many days, it is automatically deleted.'
      => 'Когда объект определен как спам, он будет автоматически удалён после прошествия этого количества.',
    'Spam Score Threshold' => 'Границы шкалы спама',
    'Comments and TrackBacks receive a spam score between -10 (complete spam) and +10 (not spam). Feedback with a score which is lower than the threshold shown above will be reported as spam.'
      => 'Комментарии и трекбэки оцениваются по шкале от -10 (полный спам) до +10 (не спам). Элементы с уровнем меньше порогового определяются как спам.',
    'Less Aggressive' => 'Менее агрессивный',
    'Decrease'        => 'Уменьшить',
    'Increase'        => 'Увеличить',
    'More Aggressive' => 'Более агрессивный',

## tmpl/cms/list_widget.tmpl
    'Widget Sets' => 'Связки виджетов',
    'Delete selected Widget Sets (x)' =>
      'Удалить выбранные связки виджетов (x)',
    'Helpful Tips' => 'Полезные подсказки',
    'To add a widget set to your templates, use the following syntax:' =>
      'Чтобы добавить связку виджетов в ваши шаблоны, используйте следующий синтаксис:',
    '<strong>&lt;$MTWidgetSet name=&quot;Name of the Widget Set&quot;$&gt;</strong>'
      => '<strong>&lt;$MTWidgetSet name=&quot;Имя связки виджетов&quot;$&gt;</strong>',
    'Your changes to the widget set have been saved.' =>
      'Изменения в виджетах сохранены.',
    'You have successfully deleted the selected widget set(s) from your blog.'
      => 'Выбранные связки виджетов удалены из вашего блога.',
    'No Widget Sets could be found.' =>
      'Связки виджетов не найдены.',
    'Create widget template' => 'Создать шаблон виджета',
    'Widget Template'        => 'Шаблон виджета',
    'Widget Templates'       => 'Шаблоны виджетов',
    'widget templates'       => 'Шаблоны виджетов',

## tmpl/cms/cfg_system_general.tmpl
    'System: General Settings' => 'Общие параметры',
    'Test email was sent.' =>
      'Тестовое письмо отправлено',
    'System Email' => 'Системный email',
    'The email address used in the From: header of each email sent from the system.  The address is used in password recovery, commenter registration, comment, trackback notification and a few other minor events.'
      => 'Этот адрес будет использован в заголовке «От» в письмах, отправленных системой. Адрес также используется при восстановлении паролей, регистрации комментаторов, уведомлениях о комментариях, трекбэках и в некоторых других незначительных событиях.',
    'Debug Mode' => 'Режим отладки',
    'You can find an explanation of the various debug modes in the <a href="http://openmelody.org/docs/ref-debug">documentation</a>'
      => 'Вы можете найти описание различных режимов отладки в <a href="http://openmelody.org/docs/ref-debug">документации</a>.',
    'Performance Logging' =>
      'Журналирование производительности',
    'Turns on or off performance logging.' =>
      'Включить или выключить журналирование производительности.',
    'Log Paths' => 'Путь журнала',
    'Paths where logs are placed.' =>
      'Путь, где будет размещён журнал',
    'Logging Threshold' => 'Лимит журнала',
    'Logging threshold for the App' =>
      'Лимит в секундах и долях секунд для событий, которые будут отображены в журнале',
    'Send Email To' => 'Отправить сообщение на',
    'The email address where you want to send test email to.' =>
      'Адрес электронной почты, куда будет отправлено тестовое письмо.',
    'Send Test Email' => 'Отправить тестовое письмо',

## tmpl/cms/list_folder.tmpl
    'Your folder changes and additions have been made.' =>
      'Изменения папки и дополнений выполнены.',
    'You have successfully deleted the selected folder.' =>
      'Выбранная папка успешно удалена.',
    'Delete selected folders (x)' =>
      'Удалить выбранную папку (x)',
    'Create top level folder' => 'Создать корневую папку',
    'Create Folder'           => 'Создать папку',
    'Create Subfolder'        => 'Создать подпапку',
    'Move Folder'             => 'Переместить папку',
    '[quant,_1,page,pages]' =>
      '[quant,_1,страница,страницы,страниц]',
    'No folders could be found.' => 'Не найдено папок.',

## tmpl/cms/edit_commenter.tmpl
    'Commenter Details' => 'Информация о комментаторе',
    'The commenter has been trusted.' =>
      'Комментатор сделан доверенным.',
    'The commenter has been banned.' =>
      'Комментатор заблокирован.',
    'Comments from [_1]' => 'Комментарии от [_1]',
    'commenter'          => 'комментатор',
    'commenters'         => 'комментаторы',
    'Trust user (t)'     => 'Сделать доверенным (t)',
    'Trust'              => 'Доверенный',
    'Untrust user (t)'   => 'Перестать доверять (t)',
    'Untrust'            => 'Не доверенный',
    'Ban user (b)' =>
      'Заблокировать пользователя (b)',
    'Ban' => 'Заблокировать',
    'Unban user (b)' =>
      'Разблокировать пользователя (b)',
    'Unban'                     => 'Разблокировать',
    'The Name of the commenter' => 'Имя комментатора',
    'View all comments with this name' =>
      'Посмотреть все комментарии с этим именем',
    'The Identity of the commenter' =>
      'Идентификатор комментатора',
    'The Email of the commenter' => 'Email комментатора',
    'Withheld'                   => 'Не предоставлено',
    'The URL of the commenter'   => 'URL комментатора',
    'View all comments with this URL address' =>
      'Посмотреть все комментарии с этим URL',
    'The trusted status of the commenter' =>
      'Статус доверенного у комментатора',
    'View all commenters' =>
      'Посмотреть всех комментаторов',

## tmpl/cms/preview_entry.tmpl
    'Preview [_1]' => 'Предпросмотр [_1]',
    'Re-Edit this [_1]' =>
      'Повторное редактирование [_1]',
    'Re-Edit this [_1] (e)' =>
      'Повторное редактирование [_1] (e)',
    'Save this [_1]'     => 'Сохранить это [_1]',
    'Save this [_1] (s)' => 'Сохранить это [_1] (s)',
    'Cancel (c)'         => 'Отменить (c)',

## tmpl/cms/dashboard.tmpl
    'Dashboard'          => 'Обзорная панель',
    'Select a Widget...' => 'Выбрать виджет…',
    'Your Dashboard has been updated.' =>
      'Ваша обзорная панель обновлена.',
    'You have attempted to use a feature that you do not have permission to access. If you believe you are seeing this message in error contact your system administrator.'
      => 'Вы пытались выполнить действие, на которое не имеете полномочий. Если вы считаете, что эта ошибка случайна, обратитесь к администратору.',
    'The directory you have configured for uploading userpics is not writable. In order to enable users to upload userpics, please make the following directory writable by your web server: [_1]'
      => 'Директория, которую вы указали для загрузки аватаров, не перезаписываема. Если вы хотите, чтобы пользователи могли загружать аватары, пожалуйста, сделайте следующую директорию перезаписываемой: [_1]',
    'Image::Magick is either not present on your server or incorrectly configured. Due to that, you will not be able to use Melody\'s userpics feature. If you wish to use that feature, please install Image::Magick or use an alternative image driver.'
      => 'Image::Magick не установлен на вашем сервере или неправильно настроен. Поэтому вы не сможете использовать функцию аватаров. Если вы хотите использовать функции обработки изображений, пожалуйста, установите Image::Magick или используйте альтернативные обработчики изображений.',
    'Your dashboard is empty!' =>
      'Ваша обзорная панель пуста!',

## tmpl/cms/list_association.tmpl
    'permission'  => 'право',
    'permissions' => 'права',
    'Remove selected permissions (x)' =>
      'Удалить выбранные права',
    'Revoke Permission' => 'Отменить права',
    '[_1] <em>[_2]</em> is currently disabled.' =>
      '[_1] <em>[_2]</em> в настоящее время отключен.',
    'Grant Permission' => 'Назначить права',
    'You can not create permissions for disabled users.' =>
      'Вы не можете назначить права для отключенных пользователей.',
    'Assign Role to User' =>
      'Назначить роль для пользователя',
    'Grant permission to a user' =>
      'Назначить права для пользователя',
    'You have successfully revoked the given permission(s).' =>
      'Предоставленные права успешно отменены.',
    'You have successfully granted the given permission(s).' =>
      'Предоставленные права успешно назначены.',
    'No permissions could be found.' =>
      'Права доступа не найдены.',

## tmpl/cms/list_asset.tmpl
    'You have successfully deleted the asset(s).' =>
      'Вы успешно удалили медиа.',
    'Show only assets where' =>
      'Показать медиа, у которых',
    'type'              => 'тип',
    'tag (exact match)' => 'тег (точное совпадение)',
    'tag (fuzzy match)' => 'тег (нечёткое совпадение)',

## tmpl/cms/upgrade_runner.tmpl
    'Initializing database...' =>
      'Инициализация базы данных…',
    'Upgrading database...' =>
      'Обновление базы данных…',
    'Installation complete!'   => 'Установка завершена!',
    'Upgrade complete!'        => 'Обновление завершено!',
    'Starting installation...' => 'Старт установки…',
    'Starting upgrade...'      => 'Старт обновления…',
    'Error during installation:' =>
      'Ошибка в процессе установки:',
    'Error during upgrade:' =>
      'Ошибка в процессе обновления:',
    'Return to Melody (s)' => 'Вернуться в Melody',
    'Your database is already current.' =>
      'Ваша база данных не нуждается в обновлении.',

## tmpl/cms/export.tmpl
    'You must select a blog to export.' =>
      'Необходимо выбрать блог для экспорта.',
    '_USAGE_EXPORT_1' =>
      'Экспорт позволяет сделать резервную копию контента вашего блога. Впоследствии вы можете импортировать полученный файл, если вы желаете восстановить ваши записи.',
    'Blog to Export' => 'Блог для экспорта',
    'Select a blog for exporting.' =>
      'Выберите блог для экпорта.',
    'Export Blog (s)' => 'Экспорт блога(ов)',
    'Export Blog'     => 'Экспорт блога',

## tmpl/cms/import.tmpl
    'You must select a blog to import.' =>
      'Необходимо выбрать блог для импорта.',
    'Transfer weblog entries into Melody from other Melody installations or even other blogging tools or export your entries to create a backup or copy.'
      => 'Перенос в Melody записей из другой инсталляции Melody, из другой блог-платформы, или экспорт записей для резервного копирования.',
    'Import data into' => 'Импорт данных в',
    'Select a blog to import.' =>
      'Выберите блог для импорта.',
    'Importing from' => 'Импорт из',
    'Ownership of imported entries' =>
      'Владелец импортируемых записей',
    'Import as me' => 'Я',
    'Preserve original user' =>
      'Сохранить указанного пользователя',
    'If you choose to preserve the ownership of the imported entries and any of those users must be created in this installation, you must define a default password for those new accounts.'
      => 'Если вы сохраняете информацию о владельцах записей, и некоторые из этих пользователей должны создаваться в процессе импорта, необходимо указать пароль по умолчанию.',
    'Default password for new users:' =>
      'Пароль по умолчанию для новых пользователей:',
    'You will be assigned the user of all imported entries.  If you wish the original user to keep ownership, you must contact your MT system administrator to perform the import so that new users can be created if necessary.'
      => 'Вы станете владельцем всех импортированных записей. Если вы желаете сохранить исходную информацию о пользователях, обратитесь к администратору системы MT для выполнения импорта с созданием новых пользователей.',
    'Upload import file (optional)' =>
      'Загрузка файла импорта (опционально)',
    'If your import file is located on your computer, you can upload it here.  Otherwise, Melody will automatically look in the \'import\' folder of your Melody directory.'
      => 'Если импортируемый файл находится на вашем компьютере, вы можете загрузить его здесь. Иначе Melody будет искать файл в подкаталоге «import» инсталляционного каталога.',
    'More options'         => 'Дополнительные опции',
    'Import File Encoding' => 'Кодиковка файла импорта',
    'By default, Melody will attempt to automatically detect the character encoding of your import file.  However, if you experience difficulties, you can set it explicitly.'
      => 'По умолчанию Melody будет пытаться определить кодировку автоматически. Однако вы можете выбрать кодировку вручную.',
    '<mt:var name="display_name" escape="html">' =>
      '<mt:var name="display_name" escape="html">',
    'Default category for entries (optional)' =>
      'Категория по умолчанию (опционально)',
    'You can specify a default category for imported entries which have none assigned.'
      => 'Вы можете указать категорию по умолчанию для тех импортируемых записей, которые не имеют категории.',
    'Select a category'  => 'Выбрать категорию',
    'Import Entries (s)' => 'Импорт записей',
    'Import Entries'     => 'Импорт записей',

## tmpl/cms/setup_initial_blog.tmpl
    'Create Your First Blog' =>
      'Создание вашего первого блога',
    'The blog name is required.' =>
      'Необходимо указать имя блога.',
    'The blog URL is required.' =>
      'Необходимо указать URL блога.',
    'The publishing path is required.' =>
      'Необходимо указать путь публикации.',
    'The timezone is required.' =>
      'Необходимо указать часовой пояс.',
    'In order to properly publish your blog, you must provide Melody with your blog\'s URL and the path on the filesystem where its files should be published.'
      => 'Чтобы Melody смог обеспечить работу вашего блога, необходимо указать его URL и путь публикации (абсолютный путь на сервере).',
    'My First Blog'   => 'Мой первый блог',
    'Publishing Path' => 'Путь публикации',
    'Your \'Publishing Path\' is the path on your web server\'s file system where Melody will publish all the files for your blog. Your web server must have write access to this directory.'
      => 'Ваш путь публикации — это путь на веб-сервере, где будут располагаться сгенерированные Melody файлы. Эта директория должна быть перезаписываема.',
    'Finish install (s)' => 'Завершить установку (s)',
    'Finish install'     => 'Завершить установку',
    'Back (x)'           => 'Назад',

## tmpl/cms/install.tmpl
    'Create Your Account' => 'Создание вашего аккаунта',
    'The initial account name is required.' =>
      'Необходимо указать имя учетной записи.',
    'The display name is required.' =>
      'Необходимо указать отображаемое имя.',
    'Password recovery word/phrase is required.' =>
      'Необходимо ввести слово (или фразу) для восстановления пароля.',
    'Do you want to proceed with the installation anyway?' =>
      'Вы уверены, что все равно хотите продолжить инсталляцию?',
    'Before you can begin blogging, you must create an administrator account for your system. When you are done, Melody will then initialize your database.'
      => 'Перед тем как начать писать в блог, вам необходимо создать администраторский аккаунт. После этого Melody инициализирует базу данных.',
    'To proceed, you must authenticate properly with your LDAP server.' =>
      'Для продолжения вам необходимо авторизоваться при помощи LDAP-сервера.',
    'The name used by this user to login.' =>
      'Имя для входа в систему (login).',
    'The user&rsquo;s email address.' => 'Email адрес',
    'The email address used in the From: header of each email sent from the system.'
      => 'Этот email используется в заголовке From, содержащихся в письмах, отправляемых Melody.',
    'Use this as system email address' =>
      'Использовать как системный email',
    'The user&rsquo;s preferred language.' =>
      'Язык, предпочитаемый пользователем',
    'Select a password for your account.' =>
      'Выбрать пароль для учетной записи.',
    'Password Confirm' => 'Ещё раз',
    'Your LDAP username.' =>
      'Ваше имя пользователя в LDAP.',
    'Enter your LDAP password.' => 'Введите Ваш LDAP пароль.',

## tmpl/cms/cfg_prefs.tmpl
    'Blog Settings'                      => 'Настройка блога',
    'Enter a description for your blog.' => 'Опишите ваш блог.',
    'License'                            => 'Лицензия',
    'Your blog is currently licensed under:' =>
      'Содержимое блога распространяется в соответствии с лицензией:',
    'Change license' => 'Изменить лицензию',
    'Remove license' => 'Удалить лицензию',
    'Your blog does not have an explicit Creative Commons license.' =>
      'У вашего блога не определена лицензия Creative Commons.',
    'Select a license' => 'Выбрать лицензию',

## tmpl/cms/error.tmpl
    'An error occurred' => 'Произошла ошибка',

## tmpl/cms/restore.tmpl
    'Restore from a Backup' => 'Восстановить из бекапа',
    'Perl module XML::SAX and/or its dependencies are missing - Melody can not restore the system without it.'
      => 'Не хватает модуля Perl XML::SAX и/или зависимых от него — Melody не может восстановить данные без него.',
    'Backup file' => 'Файл бекапа',
    'If your backup file is located on your computer, you can upload it here.  Otherwise, Melody will automatically look in the \'import\' folder of your Melody directory.'
      => 'Если файл бекапа находится на вашем компьютере, вы можете загрузить его здесь.  В противном случае, Melody проверит наличие файла в папке «import», которая находится в папке со всеми скриптами.',
    'Check this and files backed up from newer versions can be restored to this system.  NOTE: Ignoring Schema Version can damage Melody permanently.'
      => 'Проверить это, и файлы бэкапа новых версий могут быть восстановлены в этой системе. ПРИМЕЧАНИЕ: игнорирование схемы версий базы данных может повредить Melody навсегда.',
    'Ignore schema version conflicts' =>
      'Игнорировать конфликты схем версий базы данных',
    'Check this and existing global templates will be overwritten from the backup file.'
      => 'Проверить это, и существующие глобальные шаблоны будут перезаписаны из файла резервной копии.',
    'Overwrite global templates.' =>
      'Перезаписать глобальные шаблоны.',
    'Restore (r)' => 'Восстановить (r)',

## tmpl/cms/edit_ping.tmpl
    'Edit Trackback' => 'Редактировать трекбэк',
    'The TrackBack has been approved.' => 'Трекбэк одобрен.',
    'List &amp; Edit TrackBacks' =>
      'Список и редактирование трекбэков',
    'View Entry' => 'Посмотреть запись →',
    'Save changes to this TrackBack (s)' =>
      'Сохранить изменения трекбэка (s)',
    'Delete this TrackBack (x)' => 'Удалить трекбэк (x)',
    'Update the status of this TrackBack' =>
      'Изменить статус этого трекбэка',
    'Junk' => 'Спам',
    'View all TrackBacks with this status' =>
      'Посмотреть все трекбэки с этим статусом',
    'Source Site' => 'Сайт источника',
    'Search for other TrackBacks from this site' =>
      'Найти другие трекбэки с этого сайта',
    'Source Title' => 'Заголовок',
    'Search for other TrackBacks with this title' =>
      'Найти другие трекбэки с таким же заголовком',
    'Search for other TrackBacks with this status' =>
      'Найти другие трекбэки с таким же статусом',
    'Target Entry' => 'К записи',
    'Entry no longer exists' =>
      'Записи больше не существует',
    'No title' => 'Без названия',
    'View all TrackBacks on this entry' =>
      'Посмотреть все трекбэки к этой записи',
    'Target Category' => 'К категории',
    'Category no longer exists' =>
      'Категории больше не существует',
    'View all TrackBacks on this category' =>
      'Посмотреть все трекбэки к этой категории',
    'View all TrackBacks created on this day' =>
      'Посмотреть все трекбэки, созданные в этот день',
    'View all TrackBacks from this IP address' =>
      'Посмотреть все трекбэки с этого IP адреса',
    'TrackBack Text' => 'Текст трекбэка',
    'Excerpt of the TrackBack entry' =>
      'Выдержка из трекбэка записи',

## tmpl/cms/import_others.tmpl
    'Start title HTML (optional)' =>
      'Начало заголовка HTML (опционально)',
    'End title HTML (optional)' =>
      'Окончание заголовка HTML (опционально)',
    'If the software you are importing from does not have title field, you can use this setting to identify a title inside the body of the entry.'
      => 'Если программа, из которой вы получаете информацию не имеет поля заголовка, вы можете использовать эту установку для идентификации заголовка в структуре записи.',
    'Default entry status (optional)' =>
      'Статус записи по умолчанию (опционально)',
    'If the software you are importing from does not specify an entry status in its export file, you can set this as the status to use when importing entries.'
      => 'Если среда, из которой вы получаете информацию, не указывает статус записи в экспортируемом файле, вы можете установить его самостоятельно.',
    'Select an entry status' => 'Выберите статус записи',

## tmpl/cms/preview_strip.tmpl
    'Save this entry'     => 'Сохранить эту запись',
    'Save this entry (s)' => 'Сохранить запись (s)',
    'Re-Edit this entry' =>
      'Повторное редактирование записи',
    'Re-Edit this entry (e)' =>
      'Повторное редактирование записи (e)',
    'Save this page'     => 'Сохранить эту страницу',
    'Save this page (s)' => 'Сохранить страницу (s)',
    'Re-Edit this page' =>
      'Повторное редактирование страницы',
    'Re-Edit this page (e)' =>
      'Повторное редактирование страницы (e)',
    'You are previewing the entry titled &ldquo;[_1]&rdquo;' =>
      'Вы просматриваете запись «[_1]»',
    'You are previewing the page titled &ldquo;[_1]&rdquo;' =>
      'Вы просматриваете страницу «[_1]»',

## tmpl/cms/refresh_results.tmpl
    'Template Refresh' => 'Обновить шаблоны',
    'No templates were selected to process.' =>
      'Не выбран шаблон для осуществления этого действия.',
    'Return to templates' => 'Вернуться к шаблонам',

## tmpl/cms/edit_entry.tmpl
    'Create Page'     => 'Создать страницу',
    'Add folder'      => 'Добавить папку',
    'Add folder name' => 'Добавить имя папки',
    'Add new folder parent' =>
      'Добавить новую родительскую папку',
    'Preview this page (v)' => 'Просмотр страницы (v)',
    'Delete this page (x)'  => 'Удалить страницу (x)',
    'View Page'             => 'Посмотреть страницу',
    'Add category'          => 'Добавить категорию',
    'Add category name'     => 'Добавить имя категории',
    'Add new category parent' =>
      'Добавить новую родительскую категорию',
    'Manage Entries'         => 'Управление записями',
    'Preview this entry (v)' => 'Просмотр записи (v)',
    'Delete this entry (x)'  => 'Удалить запись (x)',
    'A saved version of this entry was auto-saved [_2]. <a href="[_1]">Recover auto-saved content</a>'
      => 'Имеется автоматически сохранённая копия этой записи, созданная вами [_2]. <a href="[_1]">Восстановить?</a>',
    'A saved version of this page was auto-saved [_2]. <a href="[_1]">Recover auto-saved content</a>'
      => 'Имеется автоматически сохранённая копия этой страницы, созданная вами [_2]. <a href="[_1]">Восстановить?</a>',
    'This entry has been saved.' => 'Запись сохранена.',
    'This page has been saved.'  => 'Страница сохранена.',
    'One or more errors occurred when sending update pings or TrackBacks.' =>
      'Ошибки при выполнении пинга или отправке трекбэков.',
    '_USAGE_VIEW_LOG' =>
      'Сообщение об ошибке сохранено в <a href="[_1]">журнале активности</a>.',
    'Your customization preferences have been saved, and are visible in the form below.'
      => 'Ваши предпочтения сохранены.',
    'Your changes to the comment have been saved.' =>
      'Изменения комментария сохранены.',
    'Your notification has been sent.' =>
      'Ваше уведомление отправлено.',
    'You have successfully recovered your saved entry.' =>
      'Сохранённая запись успешно восстановлена.',
    'You have successfully recovered your saved page.' =>
      'Сохранённая страница успешно восстановлена.',
    'An error occurred while trying to recover your saved entry.' =>
      'Произошла ошибки при попытке восстановления сохранённой записи.',
    'An error occurred while trying to recover your saved page.' =>
      'Произошла ошибки при попытке восстановления сохранённой страницы.',
    'You have successfully deleted the checked comment(s).' =>
      'Выбранные комментарии удалены.',
    'You have successfully deleted the checked TrackBack(s).' =>
      'Выбранные трекбэки удалены.',
    'Change Folder'      => 'Изменить папку',
    'Unpublished (Spam)' => 'Неопубликованное (спам)',
    'Share'              => 'Отправить',
    '<a href="[_2]">[quant,_1,comment,comments]</a>' =>
      '<a href="[_2]">[quant,_1,комментарий,комментария,комментариев]</a>',
    '<a href="[_2]">[quant,_1,trackback,trackbacks]</a>' =>
      '<a href="[_2]">[quant,_1,трекбэк,трекбэка,трекбэков]</a>',
    'You must configure this blog before you can publish this entry.' =>
      'Прежде, чем вы сможете публиковать записи, необходимо настроить блог.',
    'You must configure this blog before you can publish this page.' =>
      'Прежде, чем вы сможете публиковать страницы, необходимо настроить блог.',
    '[_1] - Published by [_2]' => '[_1] — опубликовано, [_2]',
    '[_1] - Edited by [_2]' =>
      '[_1] — отредактировано, [_2]',
    'Publish On'        => 'Опубликовано',
    'Publish Date'      => 'Дата публикации',
    'Select entry date' => 'Выберите дату',
    'Unlock this entry&rsquo;s output filename for editing' =>
      'Разблокировать имя файла для редактирования',
    'Warning: If you set the basename manually, it may conflict with another entry.'
      => 'Внимание: при вводе имени файла вручную может возникнуть конфликт с другой записью.',
    'Warning: Changing this entry\'s basename may break inbound links.' =>
      'Внимание: если вы измените имя файла, то потеряете входящие ссылки.',
    'close'  => 'закрыть',
    'Accept' => 'Принять',
    'View Previously Sent TrackBacks' =>
      'Просмотреть ранее отправленные трекбэки',
    'Outbound TrackBack URLs' =>
      'Куда отправить трекбэки (URL)',
    'Add New' => 'Добавить',    # Translate - Case
    'No asset(s) associated with this [_1]' =>
      'Нет ассоциированного медиа'
    ,                                   # проверить
    'The published order of these assets can be changed using [_1]template tag modifiers[_2].'
      => 'Порядок публикации этих медиа может быть изменён при помощи [_1]модификаторов тегов[_2].',
    'You have unsaved changes to this entry that will be lost.' =>
      'У вас есть несохранённые изменения этой записи, которые будут утеряны.',
    'You have unsaved changes to this page that will be lost.' =>
      'У вас есть несохранённые изменения этой страницы, которые будут утеряны.',
    'Enter the link address:' => 'Введите адрес ссылки:',
    'Enter the text to link to:' =>
      'Ввведите текст для ссылки:',
    'Your entry screen preferences have been saved.' =>
      'Предпочтения страницы редактирования сохранены.',
    'Are you sure you want to use the Rich Text editor?' =>
      'Вы уверены, что хотите сменить редактор на визуальный?',
    'Make primary' => 'Сделать основной',
    'Fields'       => 'Поля',
    'Metadata'     => 'Метаданные',
    'Reset display options' =>
      'Сбросить параметры отображения',
    'Reset display options to blog defaults' =>
      'Сбросить параметры отображения к установкам по умолчанию',
    'Reset defaults' =>
      'Восстановить как было по умолчанию',
    'This post was held for review, due to spam filtering.' =>
      'Этот пост был отправлен на модерацию, потому что попал под условия спам-фильтра',
    'This post was classified as spam.' =>
      'Пост классифицирован как спам',
    'Extended'                => 'Продолжение',
    'Format:'                 => 'Формат:',
    '(comma-delimited list)'  => '(через запятую)',
    '(space-delimited list)'  => '(через пробел)',
    '(delimited by \'[_1]\')' => '(разделитель «[_1]»)',
    'Use <a href="http://blogit.typepad.com/">Blog It</a> to post to Melody from social networks like Facebook.'
      => 'Для публикации в Melody из социальных сетей можно использовать приложение <a href="http://blogit.typepad.com/">Blog It</a>.',
    'None selected' => 'Ничего не выбрано',

## tmpl/cms/list_entry.tmpl
    'Entries Feed' => 'Записи',
    'Pages Feed'   => 'Страницы',
    'The entry has been deleted from the database.' =>
      'Запись удалена из базы данных.',
    'The page has been deleted from the database.' =>
      'Страница удалена из базы данных.',
    'Show only entries where' =>
      'Показать записи, у которых',
    'Show only pages where' =>
      'Показать страницы, у которых',
    'published'       => 'опубликовано',
    'unpublished'     => 'не опубликовано',
    'review'          => 'Обзор',
    'scheduled'       => 'запланировано',
    'Select A User:'  => 'Выберите пользователя',
    'User Search...'  => 'Поиск пользователя…',
    'Recent Users...' => 'Новые пользователи…',

## tmpl/cms/rebuilding.tmpl
    'Publishing...'           => 'Публикация…',
    'Publishing [_1]...'      => 'Публикация [_1]…',
    'Publishing [_1] [_2]...' => 'Публикация ([_1] [_2])…',
    'Publishing [_1] dynamic links...' =>
      'Публикация динамических ссылок [_1]…',
    'Publishing [_1] archives...' =>
      'Публикация архивов [_1]…',
    'Publishing [_1] templates...' =>
      'Публикация шаблонов [_1]…',

## tmpl/cms/recover_password_result.tmpl
    'Recover Passwords' => 'Восстановить пароли',
    'No users were selected to process.' =>
      'Нет выбранных пользователей для процесса.',
    'Return' => 'Вернуться',

## tmpl/wizard/optional.tmpl
    'Mail Configuration' => 'Конфигурация почты',
    'Your mail configuration is complete.' =>
      'Почтовые параметры сконфигурированы.',
    'Check your email to confirm receipt of a test email from Melody and then proceed to the next step.'
      => 'Проверьте свой почтовый ящик, чтобы убедиться в получении тестового письма от Melody, а затем перейдите к следующему шагу.',
    'Show current mail settings' =>
      'Показать текущие параметры почты',
    'Periodically Melody will send email to inform users of new comments as well as other other events. For these emails to be sent properly, you must instruct Melody how to send email.'
      => 'Периодически Melody будет отправлять письма с информацией о новых пользователях, комментариях и других событиях. Чтобы эти письма могли быть отправлены, пожалуйста, укажите, с помощью чего будет отправлять почта.',
    'An error occurred while attempting to send mail: ' =>
      'Ошибка при попытке отправке письма: ',
    'Send email via:' => 'Отправлять почту через:',
    'Select One...'   => 'Выберите один…',
    'sendmail Path'   => 'Местонахождение sendmail',
    'The physical file path for your sendmail binary.' =>
      'Физический путь к программе sendmail.',
    'Outbound Mail Server (SMTP)' =>
      'Сервер исходящей почты (SMTP)',
    'Address of your SMTP Server.' => 'Адрес на вашем SMTP.',
    'Mail address for test sending' =>
      'Адрес для отправки тестового письма',

## tmpl/wizard/cfg_dir.tmpl
    'Temporary Directory Configuration' =>
      'Конфигурация временного каталога',
    'You should configure you temporary directory settings.' =>
      'Вам необходимо указать временный каталог в параметрах.',
    'Your TempDir has been successfully configured. Click \'Continue\' below to continue configuration.'
      => 'Временный каталог сконфигурирован. Нажмите «Продолжить» для дальнейшей настройки.',
    '[_1] could not be found.' => '[_1] отсутствует.',
    'TempDir is required.'     => 'TempDir обязательна.',
    'TempDir'                  => 'TempDir',
    'The physical path for temporary directory.' =>
      'Физический адрес временного каталога.',

## tmpl/wizard/complete.tmpl
    'Configuration File' => 'Файл конфигурации',
    'The [_1] configuration file can\'t be located.' =>
      'Файл конфигурации [_1] не найден',
    'Please use the configuration text below to create a file named \'config.cgi\' in the root directory of [_1] (the same directory in which index.cgi is found).'
      => 'Создайте файл «config.cgi», расположенный в корневой директории Melody [_1] (в этой директории находится скрипт index.cgi).',
    'The wizard was unable to save the [_1] configuration file.' =>
      'Помошнику не удалось создать файл конфигурации [_1].',
    'Confirm your [_1] home directory (the directory that contains index.cgi) is writable by your web server and then click \'Retry\'.'
      => 'Проверьте, является ли каталог [_1] (там находится index.cgi) доступным для записи и нажмите «Повторить».',
    'Congratulations! You\'ve successfully configured [_1].' =>
      'Поздравляем! Вы успешно настроили [_1].',
    'Your configuration settings have been written to the following file:' =>
      'Параметры сохранены в следующем файле:',
    'To reconfigure the settings, click the \'Back\' button below.' =>
      'Чтобы изменить найстройки, нажмите на кнопку «Вернуться», или же нажмите «Продолжить».',
    'Show the config.cgi file generated by the wizard' =>
      'Показать файл config.cgi, сгенерированный помошником',
    'The config.cgi file has been created manually.' =>
      'Файл config.cgi был создан вручную.',
    'Retry' => 'Повторить',

## tmpl/wizard/start.tmpl
    'Configuration File Exists' =>
      'Найден файл конфигурации',
    'A configuration (config.cgi) file already exists, <a href="[_1]">sign in</a> to Melody.'
      => 'Файл конфигурации (config.cgi) уже существует, <a href="[_1]">авторизуйтесь</a> в Melody.',
    'To create a new configuration file using the Wizard, remove the current configuration file and then refresh this page'
      => 'Чтобы создать новый файл конфигурации, удалите старый и обновите эту страницу.',
    'Melody requires that you enable JavaScript in your browser. Please enable it and refresh this page to proceed.'
      => 'Для работы с Melody необходимо, чтобы у вас был включен JavaScript. Вкючите его и обновите эту страницу.',
    'This wizard will help you configure the basic settings needed to run Melody.'
      => 'Этот помошник поможет вам указать базовые параметры, которые необходимы для запуска Melody.',
    '<strong>Error: \'[_1]\' could not be found.</strong>  Please move your static files to the directory first or correct the setting if it is incorrect.'
      => '<strong>Ошибка: «[_1]» не найден.</strong>  Пожалуйста, переместите статические файлы в первичную директорию или скорректируйте параметры.',
    'Configure Static Web Path' =>
      'Параметры адреса статических файлов',
    'Melody ships with directory named [_1] which contains a number of important files such as images, javascript files and stylesheets.'
      => 'Melody связан с каталогом [_1], в котором содержится множество важных файлов — графика, javascript файлы и таблицы стилей.',
    'The [_1] directory is in the main Melody directory which this wizard script resides, but due to your web server\'s configuration, the [_1] directory is not accessible in this location and must be moved to a web-accessible location (e.g., your web document root directory).'
      => 'Папка [_1] находится в основной директории Melody (здесь содержатся все скрипты, включая скрипт этого помошника). Параметры вашего сервера не позволяют просматривать статические файлы в этой директори, поэтому переместите папку [_1] в общедоступное место (например, вкорневой каталог вашего сайта). ',
    'This directory has either been renamed or moved to a location outside of the Melody directory.'
      => 'Этот каталог был переименован или перемещён в местоположение, распологающееся вне каталога Melody.',
    'Once the [_1] directory is in a web-accessible location, specify the location below.'
      => 'Можно просто переместить папку [_1] в другое место или создать символическую ссылку. После того, как это будет сделано, укажите необходимую информацию в следующие поля.',
    'This URL path can be in the form of [_1] or simply [_2]' =>
      'Этот URL может быть в форме [_1] или просто [_2]',
    'This path must be in the form of [_1]' =>
      'Этот путь может быть в форме [_1]',
    'Static web path' => 'Адрес статических файлов',
    'Static file path' =>
      'Путь на сервере к статическим файлам',
    'Begin' => 'Приступить',

## tmpl/wizard/blog.tmpl
    'Setup Your First Blog' =>
      'Настройка вашего первого блога',

## tmpl/wizard/configure.tmpl
    'Database Configuration' => 'Настройка базы данных',
    'You must set your Database Path.' =>
      'Необходимо указать расположение базы данных.',
    'You must set your Database Name.' =>
      'Необходимо указать имя базы данных.',
    'You must set your Username.' =>
      'Необходимо указать ваше имя пользователя.',
    'You must set your Database Server.' =>
      'Необходимо указать сервер базы данных.',
    'Your database configuration is complete.' =>
      'Настройка базы данных завершена.',
    'You may proceed to the next step.' =>
      'Вы можете приступить к следующему шагу.',
    'Please enter the parameters necessary for connecting to your database.'
      => 'Пожалуйста, укажите необходимые параметры для соединения с базой данных.',
    'Show Current Settings' =>
      'Показать текущие параметры',
    'Database Type' => 'Тип базы данных',
    'http://www.movabletype.org/documentation/[_1]' =>
      'http://www.movabletype.org/documentation/[_1]',
    'Is your preferred database not listed? View the <a href="[_1]" target="_blank">Melody System Check</a> see if additional modules are necessary.'
      => 'Вашей базы данных нет в списке? Попробуйте <a href="[_1]" target="_blank">проверку системы от Melody</a>, чтобы узнать, необходимы ли дополнительные модули.',
    'Once installed, <a href="javascript:void(0)" onclick="[_1]">click here to refresh this screen</a>.'
      => 'После установки <a href="javascript:void(0)" onclick="[_1]">нажмите здесь для обновления страницы</a>.',
    'Read more: <a href="[_1]" target="_blank">Setting Up Your Database</a>'
      => 'Узнать больше: <a href="[_1]" target="_blank">Настройка вашей базы данных</a>',
    'Database Path' => 'Путь к базе данных',
    'The physical file path for your SQLite database. ' =>
      'Физический путь к файлам вашей SQLite базы данных. ',
    'A default location of \'./db/mt.db\' will store the database file underneath your Melody directory.'
      => 'Расположение по умолчанию «./db/mt.db» — файл базы данных хранится в директории Melody.',
    'Database Server'                => 'Сервер базы данных',
    'This is usually \'localhost\'.' => 'Обычно это «localhost».',
    'Database Name'                  => 'Имя базы данных',
    'The name of your SQL database (this database must already exist).' =>
      'Имя SQL базы данных (она уже должна быть создана).',
    'The username to login to your SQL database.' =>
      'Имя пользователя для соединения с базой данных.',
    'The password to login to your SQL database.' =>
      'Пароль для соединения с базой данных.',
    'Show Advanced Configuration Options' =>
      'Показать дополнительные опции',
    'Database Port' => 'Порт сервера базы данных',
    'This can usually be left blank.' =>
      'Можно оставить пустым.',
    'Database Socket' => 'Сокет базы данных',
    'Publish Charset' => 'Кодировка публикации',
    'MS SQL Server driver must use either Shift_JIS or ISO-8859-1.  MS SQL Server driver does not support UTF-8 or any other character set.'
      => 'Драйвер сервера MS SQL должен использовать Shift_JIS или ISO-8859-1. Потому что MS SQL не поддерживает UTF-8 или другие кодировки.',
    'Test Connection' => 'Тестовое соединение',

## tmpl/wizard/packages.tmpl
    'Requirements Check' =>
      'Проверка необходимых компонентов',
    'The following Perl modules are required in order to make a database connection.  Melody requires a database in order to store your blog\'s data.  Please install one of the packages listed here in order to proceed.  When you are ready, click the \'Retry\' button.'
      => 'Следующие модули Perl необходимы для соединения с базой данных. База данных необходима для хранения информации из вашего блога. Прежде чем продолжить, установите, пожалуйста, один из следующих пакетов, указанных ниже.',
    'All required Perl modules were found.' =>
      'Все обязательные модули Perl найдены.',
    'You are ready to proceed with the installation of Melody.' =>
      'Вы можете приступить к установке Melody.',
    'Some optional Perl modules could not be found. <a href="javascript:void(0)" onclick="[_1]">Display list of optional modules</a>'
      => 'Некоторые опциональные модуль Perl не найдены. <a href="javascript:void(0)" onclick="[_1]">Показать список опциональных модулей</a>',
    'One or more Perl modules required by Melody could not be found.' =>
      'Один или несколько модулей Perl, необходимых для работы Melody, не найдены.',
    'The following Perl modules are required for Melody to run properly. Once you have met these requirements, click the \'Retry\' button to re-test for these packages.'
      => 'Следущие модули Perl необходимы для работы Melody. Как только эти модули будут установлены, нажмите кнопку «Повторить», чтобы повторно проверить их.',
    'Some optional Perl modules could not be found. You may continue without installing these optional Perl modules. They may be installed at any time if they are needed. Click \'Retry\' to test for the modules again.'
      => 'Некоторые опциональные модули Perl не найдены. Вы можете продолжить, не устанавливая их сейчас. Если же вы установили их, нажмите кнопку «Повторить».',
    'Missing Database Modules' =>
      'Отсутствует модуль базы данных',
    'Missing Optional Modules' =>
      'Отсутствуют опциональные модули',
    'Missing Required Modules' =>
      'Отсутствуют обязательные модули',
    'Minimal version requirement: [_1]' =>
      'Минимальная версия: [_1]',
    'Learn more about installing Perl modules.' =>
      'Узнать больше об установке модулей Perl.',
    'Your server has all of the required modules installed; you do not need to perform any additional module installations.'
      => 'На вашем сервере установлены все обязательные модули; вы не нуждаетесь в установке опциональных модулей.',

## tmpl/feeds/feed_page.tmpl
    'Unpublish'        => 'Отменить публикацию',
    'More like this'   => 'Ещё подобное этому',
    'From this blog'   => 'Из этого блога',
    'From this author' => 'От этого автора',
    'On this day'      => 'В течении этого дня',

## tmpl/feeds/login.tmpl
    'Melody Activity Log' => 'Журнал активности Melody',
    'This link is invalid. Please resubscribe to your activity feed.' =>
      'Неправильная ссылка. Пожалуйста, переподпишитесь на фид активности.',

## tmpl/feeds/feed_comment.tmpl
    'On this entry' => 'К этой записи',
    'By commenter identity' =>
      'От комментатора с таким идентификатором',
    'By commenter name' =>
      'От комментатора с таким именем',
    'By commenter email' =>
      'От комментатора с таким email',
    'By commenter URL' => 'От комментатора с таким URL',

## tmpl/feeds/feed_entry.tmpl

## tmpl/feeds/feed_ping.tmpl
    'Source blog'     => 'Блог-источник',
    'By source blog'  => 'С этого блога',
    'By source title' => 'С таким же названием',
    'By source URL'   => 'С таким же URL',

## tmpl/feeds/error.tmpl

## tmpl/comment/signup.tmpl
    'Create an account' => 'Регистрация пользователя',
    'The name appears on your comment.' =>
      'Это имя будет отображаться рядом с вашими комментариями.',
    'Your email address.' => 'Email',
    'Your login name.' =>
      'Логин (используется для входа)',
    'Select a password for yourself.' => 'Введите пароль.',
    'The URL of your website. (Optional)' =>
      'Адрес вашего сайта (по желанию).',
    'Register' => 'Зарегистрироваться',

## tmpl/comment/login.tmpl
    'Sign in to comment' => 'Авторизация',
    'Sign in using'      => 'Войти используя',
    'Remember me?'       => 'Запомнить меня',
    'Not a member?&nbsp;&nbsp;<a href="[_1]">Sign Up</a>!' =>
      'Вы можете <a href="[_1]">зарегистрироваться</a> на этом сайте!',

## tmpl/comment/profile.tmpl
    'Your Profile' => 'Ваш профиль',
    'Return to the <a href="[_1]">original page</a>.' =>
      'Вернуться на  <a href="[_1]">первоначальную страницу</a>.',

## tmpl/comment/signup_thanks.tmpl
    'Thanks for signing up' => 'Спасибо за регистрацию',
    'Before you can leave a comment you must first complete the registration process by confirming your account. An email has been sent to [_1].'
      => 'Перед тем, как вы сможете оставлять комментарии, вы должны завершить процесс регистрации путём активации своего аккаунта. Сообщение было отправлено на [_1].',
    'To complete the registration process you must first confirm your account. An email has been sent to [_1].'
      => 'Для завершения процесса регистрации необходимо активировать свой аккаунт. Вам было отправлено письмо на адрес [_1].',
    'To confirm and activate your account please check your inbox and click on the link found in the email we just sent you.'
      => 'Для подтверждения и активации вашего аккаунта, пожалуйста, проверьте почту и перейдите по ссылке в письме, которое мы вам отправили.',
    'Return to the original entry.' => 'Вернуться к записи.',
    'Return to the original page.' =>
      'Вернуться к странице.',

## tmpl/comment/register.tmpl

## tmpl/comment/error.tmpl
    'Go Back (s)' => 'Вернуться назад',

## tmpl/error.tmpl
    'Missing Configuration File' =>
      'Файл конфигурации не найден',
    '_ERROR_CONFIG_FILE' =>
      'Файл конфигурации Melody отсутствует или не может быть прочитан. Пожалуйста, ознакомьтесь с базой знаний.',
    'Database Connection Error' =>
      'Ошибка соединения с базой данных',
    '_ERROR_DATABASE_CONNECTION' =>
      'Параметры соединения с базой данных неверны, отсутствуют, либо не могут быть правильно прочитаны. Для получения большей информации ознакомьтесь с базой знаний.',
    'CGI Path Configuration Required' =>
      'Необходима указать путь CGI',
    '_ERROR_CGI_PATH' =>
      'Путь CGI, указанный в конфигурации, неправильный или вообще отсутствует в файле конфигурации. Пожалуйста, ознакомьтесь с базой знаний.',

## plugins/TypePadAntiSpam/TypePadAntiSpam.pl
    'TypePad AntiSpam is a free service from Six Apart that helps protect your blog from comment and TrackBack spam. The TypePad AntiSpam plugin will send every comment or TrackBack submitted to your blog to the service for evaluation, and Melody will filter items if TypePad AntiSpam determines it is spam. If you discover that TypePad AntiSpam incorrectly classifies an item, simply change its classification by marking it as "Spam" or "Not Spam" from the Manage Comments screen, and TypePad AntiSpam will learn from your actions. Over time the service will improve based on reports from its users, so take care when marking items as "Spam" or "Not Spam."'
      => 'TypePad AntiSpam — это бесплатный сервис от Six Apart, который помогает защищать блог от спама в комментариях и трекбэках. Плагин TypePad AntiSpam отправляет каждый комментарий или трекбэк на проверку, после которой Melody сможет пометить эти элементы как спам, если TypePad AntiSpam решит, что это — спам. Если вы заметите, что TypePad AntiSpam неправильно классифицирует какой-то элемент, просто измените его классификацию, пометив флагом «Спам» или, наоборот, «Не спам» со страницы управления комментариями, и в дальнейшем TypePad AntiSpam будет обучаться от ваших действий. Благодаря подобным действиям, сервис будет постоянно улучшаться и, соответственно, спама будет меньше.',
    'So far, TypePad AntiSpam has blocked [quant,_1,message,messages] for this blog, and [quant,_2,message,messages] system-wide.'
      => 'На данный момент TypePad AntiSpam заблокировал [quant,_1,сообщение,сообщения,сообщений] в этом блоге и [quant,_1,сообщение,сообщения,сообщений] во всех блогах.',
    'So far, TypePad AntiSpam has blocked [quant,_1,message,messages] system-wide.'
      => 'На данный момент TypePad AntiSpam заблокировал [quant,_1,сообщение,сообщения,сообщений].',
    'Failed to verify your TypePad AntiSpam API key: [_1]' =>
      'Ошибка при проверке вашего API-ключа для TypePad AntiSpam',
    'The TypePad AntiSpam API key provided is invalid.' =>
      'Указанный API-ключ для TypePad AntiSpam неверный.',
    'TypePad AntiSpam' => 'TypePad AntiSpam',

## plugins/TypePadAntiSpam/lib/MT/TypePadAntiSpam.pm
    'API key is a required parameter.' =>
      'Ключи API — обязательный параметр.',

## plugins/TypePadAntiSpam/tmpl/config.tmpl
    'Junk Score Weight' => 'Рейтинг спама',
    'Least Weight'      => 'Минимальный уровень',
    'Most Weight'       => 'Максимальный уровень',
    'Comments and TrackBacks receive a junk score between -10 (definitely spam) and +10 (definitely not spam). This setting allows you to control the weight of the TypePad AntiSpam rating relative to other filters you may have installed to help you filter comments and TrackBacks.'
      => 'Комментарии и трекбэки помечаются как спам между -10 (определённо спам) и +10 (определённо не спам). Эти настроки помогут более точно управлять оценкой TypePad AntiSpam.',

## plugins/TypePadAntiSpam/tmpl/system.tmpl
    'API Key' => 'API-ключ',
    'To enable this plugin, you\'ll need a free TypePad AntiSpam API key. You can <strong>get your free API key at [_1]antispam.typepad.com[_2]</strong>. Once you have your key, return to this page and enter it in the field below.'
      => 'Для включения этого плагина вам необходим бесплатный API-ключ для TypePad AntiSpam. Вы можете <strong>получить его на сайте [_1]antispam.typepad.com[_2]</strong>. Когда ключ будет у вас, вернитесь на эту страницу и укажите его в указанное ниже поле.',
    'Service Host' => 'Хост сервиса',
    'The default service host for TypePad AntiSpam is api.antispam.typepad.com. You should only change this if you are using a different service that is compatible with the TypePad AntiSpam API.'
      => 'По умолчанию, хост сервиса TypePad AntiSpam — api.antispam.typepad.com. Его не стоит изменять, если вы не используете сторонние сервисы, совместимые с TypePad AntiSpam API.',

## plugins/TypePadAntiSpam/tmpl/stats_widget.tmpl
    'widget_label_width'  => 'widget_label_width',
    'widget_totals_width' => 'widget_totals_width',
    'Spam Blocked'        => 'Заблокировано спама',
    'on this blog'        => 'в этом блоге',
    'on this system'      => 'во всей системе',

## plugins/Textile/textile2.pl
    'A humane web text generator.' =>
      'Обработчик текста для веб',
    'Textile 2' => 'Textile 2',

## plugins/WidgetManager/WidgetManager.pl
    'Widget Manager version 1.1; This version of the plugin is to upgrade data from older version of Widget Manager that has been shipped with Melody to the Melody core schema.  No other features are included.  You can safely remove this plugin after installing/upgrading Melody.'
      => 'Менеджер виджетов, версия 1.1; Эта версия плагина предназначена для обновления данных со старой версии менеджера виджетов. Поскольку менеджер виджетов теперь встроен в Melody, вы можете удалить этот плагин после установки/обновления MT.',
    'Moving storage of Widget Manager [_1]...' =>
      'Перемещение данных менеджера виджетов [_1]…',

## plugins/spamlookup/lib/spamlookup.pm
    'Failed to resolve IP address for source URL [_1]' =>
      'Не удалось проверить IP адрес для URL [_1]',
    'Moderating: Domain IP does not match ping IP for source URL [_1]; domain IP: [_2]; ping IP: [_3]'
      => 'Модерация: IP домена не соответствует IP адресу, с которого отправлен пинг: [_1]; IP домена: [_2]; IP пингующего: [_3]',
    'Domain IP does not match ping IP for source URL [_1]; domain IP: [_2]; ping IP: [_3]'
      => 'IP домена не соответствует IP адресу, с которого отправлен пинг: [_1]; IP домена: [_2]; IP пингующего: [_3]',
    'No links are present in feedback' =>
      'Не предоставлено ссылок',
    'Number of links exceed junk limit ([_1])' =>
      'Количество ссылок превысило допустимый лимит для спама ([_1])',
    'Number of links exceed moderation limit ([_1])' =>
      'Количество ссылок превысило допустимый лимит для модерации ([_1])',
    'Link was previously published (comment id [_1]).' =>
      'Ссылка уже была опубликована (id комментария [_1]).',
    'Link was previously published (TrackBack id [_1]).' =>
      'Ссылка уже была опубликована (id трекбэка [_1]).',
    'E-mail was previously published (comment id [_1]).' =>
      'Email уже был опубликован (id комментария [_1]).',
    'Word Filter match on \'[_1]\': \'[_2]\'.' =>
      'Фильтр по словам соответствует «[_1]»: «[_2]».',
    'Moderating for Word Filter match on \'[_1]\': \'[_2]\'.' =>
      'Модерация по фильтру слова «[_1]»: «[_2]».',
    'domain \'[_1]\' found on service [_2]' =>
      'домен «[_1]» присутствует в сервисе [_2]',
    '[_1] found on service [_2]' =>
      '[_1] присутствует в сервисе [_2]',

## plugins/spamlookup/spamlookup.pl
    'SpamLookup module for using blacklist lookup services to filter feedback.'
      => 'Плагин SpamLookup используется для фильтрации комментариев с использованием чёрного списка.',
    'SpamLookup IP Lookup' => 'SpamLookup — проверка IP',
    'SpamLookup Domain Lookup' =>
      'SpamLookup — проверка доменов',
    'SpamLookup TrackBack Origin' =>
      'SpamLookup — происхождение трекбэков',
    'Despam Comments'   => 'Комментарии не спам',
    'Despam TrackBacks' => 'Трекбэки не спам',
    'Despam'            => 'Не спам',

## plugins/spamlookup/spamlookup_urls.pl
    'SpamLookup - Link' => 'SpamLookup - Ссылки',
    'SpamLookup module for junking and moderating feedback based on link filters.'
      => 'Плагин SpamLookup используется для отправки на модерацию комментариев и трекбэков, отфильтрованных по ссылкам.',
    'SpamLookup Link Filter'  => 'Фильтр ссылок SpamLookup',
    'SpamLookup Link Memory'  => 'Политика ссылок SpamLookup',
    'SpamLookup Email Memory' => 'Политика email SpamLookup',

## plugins/spamlookup/spamlookup_words.pl
    'SpamLookup module for moderating and junking feedback using keyword filters.'
      => 'Плагин SpamLookup отправляет на модерацию и помечает как спам комментарии и трекбэки согласно фильтрам по ключевым словам.',
    'SpamLookup Keyword Filter' =>
      'Фильтр ключевых слов SpamLookup',

## plugins/spamlookup/tmpl/lookup_config.tmpl
    'Lookups monitor the source IP addresses and hyperlinks of all incoming feedback. If a comment or TrackBack comes from a blacklisted IP address or contains a blacklisted domain, it can be held for moderation or scored as junk and placed into the blog\'s Junk folder. Additionally, advanced lookups on TrackBack source data can be performed.'
      => 'Плагин Lookups отслеживает IP во всех комментариях и трекбэках. Если комментарий или трекбэк отправлен с IP, находящего в чёрном списке, или содержит доменное имя, также находящееся в чёрном списке, он может быть поставлен на модерирование, либо помечен как спам.',
    'IP Address Lookups' => 'Проверять IP адреса',
    'Moderate feedback from blacklisted IP addresses' =>
      'Отправлять на модерацию комментарии и трекбэки с IP из чёрного списка',
    'Junk feedback from blacklisted IP addresses' =>
      'Помечать как спам комментарии и трекбэки с IP из чёрного списка',
    'Adjust scoring' => 'Отрегулируйте значение',
    'Score weight:'  => 'Вес значения:',
    'Less'           => 'Меньше',
    'More'           => 'Больше',
    'block'          => 'заблокировать',
    'IP Blacklist Services' =>
      'Сервис, предоставляющий чёрный список IP',
    'Domain Name Lookups' => 'Проверять доменные имена',
    'Moderate feedback containing blacklisted domains' =>
      'Отправлять на модерацию сообщения с доменами из чёрного списка',
    'Junk feedback containing blacklisted domains' =>
      'Помечать как спам сообщения с доменами из чёрного списка',
    'Domain Blacklist Services' =>
      'Сервис, предоставляющий чёрный список доменов',
    'Advanced TrackBack Lookups' =>
      'Дополнительная проверка трекбэков',
    'Moderate TrackBacks from suspicious sources' =>
      'Отправлять на модерацию трекбэки с подозрительных сайтов',
    'Junk TrackBacks from suspicious sources' =>
      'Помечать как спам трекбэки с подозрительных сайтов',
    'Lookup Whitelist' => 'Проверять белый список',
    'To prevent lookups for specific IP addresses or domains, list each on a line by itself.'
      => 'Чтобы избежать проверки по конкретным IP-адресам или доменам, укажите их каждый на отдельной строке.',

## plugins/spamlookup/tmpl/url_config.tmpl
    'Link filters monitor the number of hyperlinks in incoming feedback. Feedback with many links can be held for moderation or scored as junk. Conversely, feedback that does not contain links or only refers to previously published URLs can be positively rated. (Only enable this option if you are sure your site is already spam-free.)'
      => 'Фильтр ссылок следит за количеством ссылок в комментариях. Комментарии с большим количеством ссылок могут быть отправлены на модерацию или помечены как спам. Или наоборот, комментариям, не содержащим ссылку или содержащим опубликованную ранее ссылку, может быть выставлен положительный рейтинг.',
    'Link Limits' => 'Лимит ссылок',
    'Credit feedback rating when no hyperlinks are present' =>
      'Повышать рейтинг, если нет ссылки',
    'Moderate when more than' =>
      'Модерировать, когда больше',
    'link(s) are given' => 'ссылок',
    'Junk when more than' =>
      'Помечать как спам, когда больше',
    'Link Memory' => 'Политика ссылок',
    'Credit feedback rating when &quot;URL&quot; element of feedback has been published before'
      => 'Повышать рейтинг, если URL уже был опубликован',
    'Only applied when no other links are present in message of feedback.' =>
      'Применять только, когда нет других ссылок в комментарии.',
    'Exclude URLs from comments published within last [_1] days.' =>
      'Исключать URL из комментариев, опубликованных за последние [_1] дн.',
    'Email Memory' => 'Политика email',
    'Credit feedback rating when previously published comments are found matching on the &quot;Email&quot; address'
      => 'Повышать рейтинг, если в уже опубликованных комментариях был использован тот же email адрес',
    'Exclude Email addresses from comments published within last [_1] days.'
      => 'Исключать email адреса из комментариев, опубликованных за последние [_1] дн.',

## plugins/spamlookup/tmpl/word_config.tmpl
    'Incomming feedback can be monitored for specific keywords, domain names, and patterns. Matches can be held for moderation or scored as junk. Additionally, junk scores for these matches can be customized.'
      => 'Комментарии и трекбэки могут быть проанализированы на наличие ключевых слов, доменных имён и специальных шаблонов. Элементы, в которых будут найдены запрещённые данные, могут быть отправлены на модерацию или помечены как спам.',
    'Keywords to Moderate' =>
      'Ключевые слова для отправки на модерацию',
    'Keywords to Junk' =>
      'Ключевые слова, чтобы пометить как спам',

## plugins/WXRImporter/WXRImporter.pl
    'Import WordPress exported RSS into MT.' =>
      'Импортировать экспортируемый WordPress RSS в MT',
    'WordPress eXtended RSS (WXR)' => 'WordPress eXtended RSS (WXR)',
    'Download WP attachments via HTTP.' =>
      'Загрузить файлы WP через HTTP.',

## plugins/WXRImporter/lib/WXRImporter/WXRHandler.pm
    'File is not in WXR format.' => 'Файл не в формате WXR.',
    'Creating new tag (\'[_1]\')...' =>
      'Создание нового тега («[_1]»)…',
    'Saving tag failed: [_1]' =>
      'Не удалось сохранить тег: [_1]',
    'Duplicate asset (\'[_1]\') found.  Skipping.' =>
      'Найдено повторяющееся медиа («[_1]»). Пропуск.',
    'Saving asset (\'[_1]\')...' =>
      'Сохранение медиа («[_1]»)…',
    ' and asset will be tagged (\'[_1]\')...' =>
      ' и медиа будет с тегом («[_1]»)…',
    'Duplicate entry (\'[_1]\') found.  Skipping.' =>
      'Найдена повторяющаяся запись («[_1]»). Пропуск.',
    'Saving page (\'[_1]\')...' =>
      'Сохранение страницы («[_1]»)…',

## plugins/WXRImporter/lib/WXRImporter/Import.pm

## plugins/WXRImporter/tmpl/options.tmpl
    'Before you import WordPress posts to Melody, we recommend that you <a href=\'[_1]\'>configure your blog\'s publishing paths</a> first.'
      => 'Прежде чем импортировать контент из Wordpress в Melody, рекомендуем <a href=\'[_1]\'>настроить путь публикации блога</a>.',
    'Upload path for this WordPress blog' =>
      'Путь к загруженным файлам этого WordPress блога',
    'Replace with'         => 'Заменять',
    'Download attachments' => 'Скачать файлы',
    'Requires the use of a cron job to download attachments from WordPress powered blog in the background.'
      => 'Предполагается использование запланированного задания (CRON) для скачивания файлов в фоновом режиме из блога, работающего на WordPress.',
    'Download attachments (images and files) from the imported WordPress powered blog.'
      => 'Скачать файлы (картинки и другие файлы) из импортируемого блога WordPress.',

## plugins/YandexOpenId/YandexOpenId.pl
    'Yandex' => 'Яндекс',

## plugins/Markdown/SmartyPants.pl
    'Easily translates plain punctuation characters into \'smart\' typographic punctuation.'
      => 'Позволяет преобразовать обычный текст в текст с правильно оформленной пунктуацией (например: кавычки, тире, и т.д.).',

## plugins/Markdown/Markdown.pl
    'A plain-text-to-HTML formatting plugin.' =>
      'Плагин для форматирования обычного текста в HTML',
    'Markdown'                  => 'Markdown',
    'Markdown With SmartyPants' => 'Markdown и SmartyPants',

## plugins/MultiBlog/multiblog.pl
    'MultiBlog allows you to publish content from other blogs and define publishing rules and access controls between them.'
      => 'MultiBlog позволяет публиковать содержимое из нескольких блогов в одном, определяя правила публикации и контроль доступа между ними.',
    'MultiBlog'      => 'MultiBlog',
    'Create Trigger' => 'Создать условие',
    'Weblog Name'    => 'Имя блога',
    'Search Weblogs' => 'Найти блоги',
    'When this'      => 'когда это',
    '* All Weblogs'  => '* Все блоги',
    'Select to apply this trigger to all weblogs' =>
      'Нажмите, чтобы применить это условие ко всем блогам',
    'saves an entry'      => 'сохраняется запись',
    'publishes an entry'  => 'публикуется запись',
    'publishes a comment' => 'публикуется комментарий',
    'publishes a TrackBack' => 'публикуется трекбэк',
    'rebuild indexes.' =>
      'публиковать индексные шаблоны.',
    'rebuild indexes and send pings.' =>
      'публиковать индексные шаблоны и отправлять пинги.',

## plugins/MultiBlog/lib/MultiBlog/Tags.pm
    'MTMultiBlog tags cannot be nested.' =>
      'Теги MTMultiBlog не могут быть вложенными.',
    'Unknown "mode" attribute value: [_1]. Valid values are "loop" and "context".'
      => 'Неизвестное значение атрибута "mode": [_1]. Правильные значения: "loop" и "context".',

## plugins/MultiBlog/lib/MultiBlog.pm
    'The include_blogs, exclude_blogs, blog_ids and blog_id attributes cannot be used together.'
      => 'Атрибуты include_blogs, exclude_blogs, blog_ids не могут быть использованы вместе.',
    'The attribute exclude_blogs cannot take "all" for a value.' =>
      'Атрибубут exclude_blogs не может содержать значение «all».',
    'The value of the blog_id attribute must be a single blog ID.' =>
      'Значение атрибута blog_id должно содержать единственный ID блога.',
    'The value for the include_blogs/exclude_blogs attributes must be one or more blog IDs, separated by commas.'
      => 'Значения атрибутов include_blogs/exclude_blogs должны содержать один несколько ID блогов, разделённых запятыми.',

## plugins/MultiBlog/tmpl/system_config.tmpl
    'Default system aggregation policy' =>
      'Системная политика агрегации по умолчанию',
    'Allow'    => 'Разрешить',
    'Disallow' => 'Запретить',
    'Cross-blog aggregation will be allowed by default.  Individual blogs can be configured through the blog-level MultiBlog settings to restrict access to their content by other blogs.'
      => 'Кросс-блоговая агрегация по умолчанию активна. В каждом блоге в параметрах MultiBlog можно запретить передачу контента в другие блоги.',
    'Cross-blog aggregation will be disallowed by default.  Individual blogs can be configured through the blog-level MultiBlog settings to allow access to their content by other blogs.'
      => 'Кросс-блоговая агрегация по умолчанию выключена. В каждом блоге в параметрах MultiBlog можно разрешить передачу контента в другие блоги.',

## plugins/MultiBlog/tmpl/blog_config.tmpl
    'When'            => 'Когда',
    'Any Weblog'      => 'Любой блог',
    'Weblog'          => 'Блог',
    'Trigger'         => 'Событие',
    'Action'          => 'Действие',
    'Content Privacy' => 'Политика приватности',
    'Specify whether other blogs in the installation may publish content from this blog. This setting takes precedence over the default system aggregation policy found in the system-level MultiBlog configuration.'
      => 'Укажите, могут ли другие блоги получать контент с этого блога. Эта опция приоритетнее указанных настроек MultiBlog на системном уровне.',
    'Use system default' =>
      'Использовать параметры по умолчанию',
    'MTMultiBlog tag default arguments' =>
      'Аргументы тега MTMultiBlog по умолчанию',
    'Enables use of the MTMultiBlog tag without include_blogs/exclude_blogs attributes. Comma-separated BlogIDs or \'all\' (include_blogs only) are acceptable values.'
      => 'Разрешить использование тега MTMultiBlog без атрибутов include_blogs/exclude_blogs. Правильные значения здесь — ID блогов, разделённые запятыми, или значение «all» (только для include_blogs).',
    'Include blogs'    => 'Включить блоги',
    'Exclude blogs'    => 'Исключить блоги',
    'Rebuild Triggers' => 'Условия публикации',
    'Create Rebuild Trigger' =>
      'Создать условие публикации',
    'You have not defined any rebuild triggers.' =>
      'У вас ещё не создано условия для публикации.',

## plugins/MultiBlog/tmpl/dialog_create_trigger.tmpl
    'Create MultiBlog Trigger' => 'Создать условие MultiBlog',

## plugins/StyleCatcher/config.yaml
    'StyleCatcher lets you easily browse through styles and then apply them to your blog in just a few clicks. To find out more about Melody styles, or for new sources for styles, visit the <a href=\'http://www.sixapart.com/movabletype/styles\'>Melody styles</a> page.'
      => 'StyleCatcher позволяет быстро найти и установить стили для вашего блога. Чтобы узнать больше о стилях Melody или получить новые стили, посетите <a href=\'http://www.sixapart.com/movabletype/styles\'>специальную страницу</a>.',
    'MT 4 Style Library' => 'Стили MT4',
    'A collection of styles compatible with Melody 4 default templates.' =>
      'Коллекция стилей, совместимых с Melody 4.',
    'Styles' => 'Стили',

## plugins/StyleCatcher/lib/StyleCatcher/CMS.pm
    'Your mt-static directory could not be found. Please configure \'StaticFilePath\' to continue.'
      => 'Ваша директория mt-static не найдена. Пожалуйста, настройте StaticFilePath в config.cgi для продолжения.',
    'Could not create [_1] folder - Check that your \'themes\' folder is webserver-writable.'
      => 'Не удалось создать каталог [_1] - удостоверьте, что папка «themes», находящаяся в папке со статическими файлами, доступна для записи.',
    'Successfully applied new theme selection.' =>
      'Новый стиль успешно применён.',
    'Invalid URL: [_1]' => 'Неверный URL: [_1]',

## plugins/StyleCatcher/tmpl/view.tmpl
    'Select a Style' => 'Выбрать стиль',
    '3-Columns, Wide, Thin, Thin' =>
      '3-колончатый, широкая, узкая, узкая',
    '3-Columns, Thin, Wide, Thin' =>
      '3-колончатый, узкая, широкая, узкая',
    '3-Columns, Thin, Thin, Wide' =>
      '3-колончатый, узкая, узкая, широкая',
    '2-Columns, Thin, Wide' =>
      '2-колончатый, узкая, широкая',
    '2-Columns, Wide, Thin' =>
      '2-колончатая, широкая, узкая',
    '2-Columns, Wide, Medium' =>
      '2-колончатая, широкая, средняя',
    '2-Columns, Medium, Wide' =>
      '2-колончатый, средняя, широкая',
    '1-Column, Wide, Bottom' =>
      '1-колончатый, широкая, подвал',
    'None available'         => 'Ничего не доступно',
    'Applying...'            => 'Применение…',
    'Apply Design'           => 'Использовать дизайн',
    'Error applying theme: ' => 'Ошибка установке стиля:',
    'The selected theme has been applied, but as you have changed the layout, you will need to republish your blog to apply the new layout.'
      => 'Выбранный стиль установлен. Теперь вам необходимо полностью опубликовать ваш блог, чтобы изменения вступили в силу. Если шаблоны стилей не публикуются автоматически с публикацией индексных шаблонов, опубликуйте их вручную.',
    'The selected theme has been applied!' =>
      'Выбранный стиль установлен!',
    'Error loading themes! -- [_1]' =>
      'Ошибка при загрузке стиля! — [_1]',
    'Stylesheet or Repository URL' =>
      'URL таблицы стилей или репозитория',
    'Stylesheet or Repository URL:' =>
      'URL таблицы стилей или репозитория:',
    'Download Styles' => 'Скачать стиль',
    'Current theme for your weblog' =>
      'Текущий стилья вашего блога',
    'Current Style' => 'Текущий стиль',
    'Locally saved themes' =>
      'Локально сохранённые стили',
    'Saved Styles'   => 'Сохранённые стили',
    'Default Styles' => 'Стиль по умолчанию',
    'Single themes from the web' =>
      'Отдельные стили из веб',
    'More Styles'     => 'Больше стилей',
    'Selected Design' => 'Выбранный дизайн',
    'Layout'          => 'Расположение',

);

## New words: 9

1;

__END__

=head1 NAME

MT::L10N::ru

=head1 METHODS

=head2 numerate

=head2 quant

=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
