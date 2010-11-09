package ClassicBlogThemePack::L10N::ru;
use strict;
use ClassicBlogThemePack::L10N;
use ClassicBlogThemePack::L10N::en_us;
use vars qw( @ISA %Lexicon );
@ISA = qw( ClassicBlogThemePack::L10N::en_us );

## The following is the translation table.

%Lexicon = (
## default_templates/creative_commons.mtml
	'This blog is licensed under a <a href="[_1]">Creative Commons License</a>.' => '–°–æ–¥–µ—Ä–∂–∏–º–æ–µ –±–ª–æ–≥–∞ —Ä–∞—Å–ø—Ä–æ—Å—Ç—Ä–∞–Ω—è–µ—Ç—Å—è –≤ —Å–æ–æ—Ç–≤–µ—Ç—Å—Ç–≤–∏–∏ —Å –ª–∏—Ü–µ–Ω–∑–∏–µ–π <a href="[_1]">Creative Commons</a>.',

## default_templates/tag_cloud.mtml
	'Tag Cloud' => '–û–±–ª–∞–∫–æ —Ç–µ–≥–æ–≤',

## default_templates/commenter_notify.mtml
	'This email is to notify you that a new user has successfully registered on the blog \'[_1]\'. Listed below you will find some useful information about this new user.' => '–ù–∞ –≤–∞—à–µ–º —Å–∞–π—Ç–µ ¬´[_1]¬ª –∑–∞—Ä–µ–≥–∏—Å—Ç—Ä–∏—Ä–æ–≤–∞–ª—Å—è –Ω–æ–≤—ã–π –ø–æ–ª—å–∑–æ–≤–∞—Ç–µ–ª—å. –ù–∏–∂–µ –ø—Ä–µ–¥—Å—Ç–∞–≤–ª–µ–Ω–∞ –Ω–µ–∫–æ—Ç–æ—Ä–∞—è –∏–Ω—Ñ–æ—Ä–º–∞—Ü–∏—è –æ –Ω—ë–º:',
	'New User Information:' => '–ò–Ω—Ñ–æ—Ä–º–∞—Ü–∏—è –æ –Ω–æ–≤–æ–º –ø–æ–ª—å–∑–æ–≤–∞—Ç–µ–ª–µ:',
	'Username: [_1]' => '–õ–æ–≥–∏–Ω: [_1]',
	'Full Name: [_1]' => '–ü–æ–ª–Ω–æ–µ –∏–º—è: [_1]',
	'Email: [_1]' => 'Email: [_1]',
	'To view or edit this user, please click on or cut and paste the following URL into a web browser:' => '–î–ª—è –ø—Ä–æ—Å–º–æ—Ç—Ä–∞ –∏–ª–∏ —Ä–µ–¥–∞–∫—Ç–∏—Ä–æ–≤–∞–Ω–∏—è –ø–æ–ª—å–∑–æ–≤–∞—Ç–µ–ª—è, –ø–µ—Ä–µ–π–¥–∏—Ç–µ –ø–æ —Å–ª–µ–¥—É—é—â–µ–π —Å—Å—ã–ª–∫–µ:',

## default_templates/about_this_page.mtml
	'About this Entry' => '–û–± —ç—Ç–æ–π –∑–∞–ø–∏—Å–∏',
	'About this Archive' => '–û–± –∞—Ä—Ö–∏–≤–µ',
	'About Archives' => '–û–± –∞—Ä—Ö–∏–≤–∞—Ö',
	'This page contains links to all the archived content.' => '–≠—Ç–∞ —Å—Ç—Ä–∞–Ω–∏—Ü–∞ —Å–æ–¥–µ—Ä–∂–∏—Ç —Å—Å—ã–ª–∫–∏ –Ω–∞ –≤—Å–µ –∞—Ä—Ö–∏–≤—ã.',
	'This page contains a single entry by [_1] published on <em>[_2]</em>.' => '–°–æ–æ–±—â–µ–Ω–∏–µ –æ–ø—É–±–ª–∏–∫–æ–≤–∞–Ω–æ <em>[_2]</em>. –ê–≤—Ç–æ—Ä ‚Äî [_1].',
	'<a href="[_1]">[_2]</a> was the previous entry in this blog.' => '–ü—Ä–µ–¥—ã–¥—É—â–∞—è –∑–∞–ø–∏—Å—å ‚Äî <a href="[_1]">[_2]</a>',
	'<a href="[_1]">[_2]</a> is the next entry in this blog.' => '–°–ª–µ–¥—É—é—â–∞—è –∑–∞–ø–∏—Å—å ‚Äî <a href="[_1]">[_2]</a>',
	'This page is an archive of entries in the <strong>[_1]</strong> category from <strong>[_2]</strong>.' => '–≠—Ç–∞ —Å—Ç—Ä–∞–Ω–∏—Ü–∞ —Å–æ–¥–µ—Ä–∂–∏—Ç –∑–∞–ø–∏—Å–∏ –∏–∑ –∫–∞—Ç–µ–≥–æ—Ä–∏–∏ <strong>[_1]</strong> –∑–∞ <strong>[_2]</strong>.',
	'<a href="[_1]">[_2]</a> is the previous archive.' => '<a href="[_1]">[_2]</a> ‚Äî –ø—Ä–µ–¥—ã–¥—É—â–∏–π –∞—Ä—Ö–∏–≤.',
	'<a href="[_1]">[_2]</a> is the next archive.' => '<a href="[_1]">[_2]</a> ‚Äî —Å–ª–µ–¥—É—é—â–∏–π –∞—Ä—Ö–∏–≤.',
	'This page is an archive of recent entries in the <strong>[_1]</strong> category.' => '–≠—Ç–∞ —Å—Ç—Ä–∞–Ω–∏—Ü–∞ —Å–æ–¥–µ—Ä–∂–∏—Ç –ø–æ—Å–ª–µ–¥–Ω–∏–µ –∑–∞–ø–∏—Å–∏ –∫–∞—Ç–µ–≥–æ—Ä–∏–∏ <strong>[_1]</strong>.',
	'<a href="[_1]">[_2]</a> is the previous category.' => '–ü—Ä–µ–¥—ã–¥—É—â–∞—è –∫–∞—Ç–µ–≥–æ—Ä–∏—è ‚Äî <a href="[_1]">[_2]</a>.',
	'<a href="[_1]">[_2]</a> is the next category.' => '–°–ª–µ–¥—É—é—â–∞—è –∫–∞—Ç–µ–≥–æ—Ä–∏—è ‚Äî <a href="[_1]">[_2]</a>.',
	'This page is an archive of recent entries written by <strong>[_1]</strong> in <strong>[_2]</strong>.' => '–≠—Ç–∞ —Å—Ç—Ä–∞–Ω–∏—Ü–∞ —Å–æ–¥–µ—Ä–∂–∏—Ç –ø–æ—Å–ª–µ–¥–Ω–∏–µ –∑–∞–ø–∏—Å–∏, —Å–æ–∑–¥–∞–Ω–Ω—ã–µ –∞–≤—Ç–æ—Ä–æ–º <strong>[_1]</strong> (<strong>[_2]</strong>).',
	'This page is an archive of recent entries written by <strong>[_1]</strong>.' => '–≠—Ç–∞ —Å—Ç—Ä–∞–Ω–∏—Ü–∞ —Å–æ–¥–µ—Ä–∂–∏—Ç –ø–æ—Å–ª–µ–¥–Ω–∏–µ –∑–∞–ø–∏—Å–∏, —Å–æ–∑–¥–∞–Ω–Ω—ã–µ –∞–≤—Ç–æ—Ä–æ–º <strong>[_1]</strong>.',
	'This page is an archive of entries from <strong>[_2]</strong> listed from newest to oldest.' => '–°—Ç—Ä–∞–Ω–∏—Ü–∞ —Å–æ–¥–µ—Ä–∂–∏—Ç –∞—Ä—Ö–∏–≤ –∑–∞–ø–∏—Å–µ–π –∑–∞ <strong>[_2]</strong>, —Ä–∞—Å–ø–æ–ª–æ–∂–µ–Ω–Ω—ã—Ö –ø–æ —É–±—ã–≤–∞–Ω–∏—é.',
	'Find recent content on the <a href="[_1]">main index</a>.' => '–°–º–æ—Ç—Ä–∏—Ç–µ –Ω–æ–≤—ã–µ –∑–∞–ø–∏—Å–∏ <a href="[_1]">–≥–ª–∞–≤–Ω–æ–π —Å—Ç—Ä–∞–Ω–∏—Ü–µ</a>.',
	'Find recent content on the <a href="[_1]">main index</a> or look in the <a href="[_2]">archives</a> to find all content.' => '–°–º–æ—Ç—Ä–∏—Ç–µ –Ω–æ–≤—ã–µ –∑–∞–ø–∏—Å–∏ –Ω–∞ <a href="[_1]">–≥–ª–∞–≤–Ω–æ–π —Å—Ç—Ä–∞–Ω–∏—Ü–µ</a> –∏–ª–∏ –∑–∞–≥–ª—è–Ω–∏—Ç–µ –≤ <a href="[_2]">–∞—Ä—Ö–∏–≤</a>, –≥–¥–µ –µ—Å—Ç—å —Å—Å—ã–ª–∫–∏ –Ω–∞ –≤—Å–µ —Å–æ–æ–±—â–µ–Ω–∏—è.',

## default_templates/technorati_search.mtml
	'Technorati' => 'Technorati',
	'<a href=\'http://www.technorati.com/\'>Technorati</a> search' => '–ü–æ–∏—Å–∫ <a href=\'http://www.technorati.com/\'>Technorati</a> ',
	'this blog' => '–≤ —ç—Ç–æ–º –±–ª–æ–≥–µ',
	'all blogs' => '–≤–æ –≤—Å–µ—Ö –±–ª–æ–≥–∞—Ö',
	'Search' => '–ù–∞–π—Ç–∏',
	'Blogs that link here' => '–°—Å—ã–ª–∞—é—â–∏–µ—Å—è –±–ª–æ–≥–∏',

## default_templates/monthly_archive_dropdown.mtml
	'Archives' => '–ê—Ä—Ö–∏–≤—ã',
	'Select a Month...' => '–í—ã–±–µ—Ä–∏—Ç–µ –º–µ—Å—è—Ü‚Ä¶',

## default_templates/comments.mtml
	'1 Comment' => '1 –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–π',
	'# Comments' => '–ö–æ–º–º–µ–Ω—Ç–∞—Ä–∏–µ–≤: #',
	'No Comments' => '–ù–µ—Ç –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–µ–≤',
	'Older Comments' => '–ü—Ä–µ–¥—ã–¥—É—â–∏–µ –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–∏',
	'Newer Comments' => '–°–ª–µ–¥—É—é—â–∏–µ –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–∏',
	'Comment Detail' => '–î–µ—Ç–∞–ª–∏ –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏—è',
	'The data is modified by the paginate script' => '–î–∞–Ω–Ω—ã–µ –∏–∑–º–µ–Ω–µ–Ω—ã —Å–∫—Ä–∏–ø—Ç–æ–º –ø–µ–π–¥–∂–∏–Ω–∞—Ü–∏–∏',
	'Leave a comment' => '–ö–æ–º–º–µ–Ω—Ç–∏—Ä–æ–≤–∞—Ç—å',
	'Name' => '–ò–º—è',
	'Email Address' => 'Email',
	'URL' => '–°–∞–π—Ç',
	'Remember personal info?' => '–ó–∞–ø–æ–º–Ω–∏—Ç—å –º–µ–Ω—è?',
	'Comments' => '–ö–æ–º–º–µ–Ω—Ç–∞—Ä–∏–∏',
	'(You may use HTML tags for style)' => '(–ú–æ–∂–Ω–æ –∏—Å–ø–æ–ª—å–∑–æ–≤–∞—Ç—å –Ω–µ–∫–æ—Ç–æ—Ä—ã–µ HTML —Ç–µ–≥–∏ –¥–ª—è —Ñ–æ—Ä–º–∞—Ç–∏—Ä–æ–≤–∞–Ω–∏—è)',
	'Preview' => '–ü—Ä–æ—Å–º–æ—Ç—Ä',
	'Submit' => '–û—Ç–ø—Ä–∞–≤–∏—Ç—å',

## default_templates/notify-entry.mtml
	'A new [lc,_3] entitled \'[_1]\' has been published to [_2].' => '–í –±–ª–æ–≥–µ ¬´[_2]¬ª –æ–ø—É–±–ª–∏–∫–æ–≤–∞–Ω–∞ –Ω–æ–≤–∞—è [lc,_3] ¬´[_1]¬ª.',
	'View entry:' => '–ü–æ—Å–º–æ—Ç—Ä–µ—Ç—å –∑–∞–ø–∏—Å—å:',
	'View page:' => '–ü–æ—Å–º–æ—Ç—Ä–µ—Ç—å —Å—Ç—Ä–∞–Ω–∏—Ü—É:',
	'[_1] Title: [_2]' => '–ó–∞–≥–æ–ª–æ–≤–æ–∫: [_2]',
	'Publish Date: [_1]' => '–î–∞—Ç–∞ –ø—É–±–ª–∏–∫–∞—Ü–∏–∏: [_1]',
	'Message from Sender:' => '–°–æ–æ–±—â–µ–Ω–∏–µ –æ—Ç –æ—Ç–ø—Ä–∞–≤–∏—Ç–µ–ª—è:',
	'You are receiving this email either because you have elected to receive notifications about new content on [_1], or the author of the post thought you would be interested. If you no longer wish to receive these emails, please contact the following person:' => '–í—ã –ø–æ–ª—É—á–∏–ª–∏ —ç—Ç–æ –ø–∏—Å—å–º–æ, —Ç–∞–∫ –∫–∞–∫ –ø–æ–¥–ø–∏—Å–∞–ª–∏—Å—å –Ω–∞ –ø–æ–ª—É—á–µ–Ω–∏–µ —É–≤–µ–¥–æ–º–ª–µ–Ω–∏–π –æ –Ω–æ–≤–æ–º –∫–æ–Ω—Ç–µ–Ω—Ç–µ –Ω–∞ —Å–∞–π—Ç–µ ¬´[_1]¬ª, –∏–ª–∏ –∞–≤—Ç–æ—Ä –ø–æ—Å—á–∏—Ç–∞–ª, —á—Ç–æ –≤–∞–º –±—É–¥–µ—Ç —ç—Ç–æ –∏–Ω—Ç–µ—Ä–µ—Å–Ω–æ. –ï—Å–ª–∏ –≤—ã –Ω–µ –∂–µ–ª–∞–µ—Ç–µ –ø–æ–ª—É—á–∞—Ç—å –ø–æ–¥–æ–±–Ω—ã–µ —É–≤–µ–¥–æ–º–ª–µ–Ω–∏—è, –ø–æ–∂–∞–ª—É–π—Å—Ç–∞, —Å–≤—è–∂–∏—Ç–µ—Å—å —Å –æ—Ç–ø—Ä–∞–≤–∏—Ç–µ–ª–µ–º:',

## default_templates/footer-email.mtml
	'Powered by Melody [_1]' => '–†–∞–±–æ—Ç–∞–µ—Ç –Ω–∞ Melody [_1]',

## default_templates/date_based_author_archives.mtml
	'Author Yearly Archives' => '–ï–∂–µ–≥–æ–¥–Ω—ã–µ –∞—Ä—Ö–∏–≤—ã –∞–≤—Ç–æ—Ä–æ–≤',
	'Author Monthly Archives' => '–ê—Ä—Ö–∏–≤—ã –∞–≤—Ç–æ—Ä–æ–≤ –ø–æ –º–µ—Å—è—Ü–∞–º',
	'Author Weekly Archives' => '–ï–∂–µ–Ω–µ–¥–µ–ª—å–Ω—ã–µ –∞—Ä—Ö–∏–≤—ã –∞–≤—Ç–æ—Ä–æ–≤',
	'Author Daily Archives' => '–ï–∂–µ–¥–Ω–µ–≤–Ω—ã–µ –∞—Ä—Ö–∏–≤—ã –∞–≤—Ç–æ—Ä–æ–≤',

## default_templates/entry_summary.mtml
	'By [_1] on [_2]' => '–ê–≤—Ç–æ—Ä: [_1] ‚Äî [_2]',
	'1 TrackBack' => '1 —Ç—Ä–µ–∫–±—ç–∫',
	'# TrackBacks' => '–¢—Ä–µ–∫–±—ç–∫–æ–≤: #',
	'No TrackBacks' => '–ù–µ—Ç —Ç—Ä–µ–∫–±—ç–∫–æ–≤',
	'Tags' => '–¢–µ–≥–∏',
	'Continue reading <a href="[_1]" rel="bookmark">[_2]</a>.' => '–ß–∏—Ç–∞—Ç—å –¥–∞–ª—å—à–µ ¬´<a href="[_1]" rel="bookmark">[_2] &rarr;</a>¬ª',

## default_templates/calendar.mtml
	'Monthly calendar with links to daily posts' => '–ö–∞–ª–µ–Ω–¥–∞—Ä—å –Ω–∞ –º–µ—Å—è—Ü —Å–æ —Å—Å—ã–ª–∫–∞–º–∏ –Ω–∞ –æ—Ç–¥–µ–ª—å–Ω—ã–µ —Å–æ–æ–±—â–µ–Ω–∏—è',
	'Sunday' => '–í–æ—Å–∫—Ä–µ—Å–µ–Ω—å–µ',
	'Sun' => '–í—Å',
	'Monday' => '–ü–æ–Ω–µ–¥–µ–ª—å–Ω–∏–∫',
	'Mon' => '–ü–Ω',
	'Tuesday' => '–í—Ç–æ—Ä–Ω–∏–∫',
	'Tue' => '–í—Ç',
	'Wednesday' => '–°—Ä–µ–¥–∞',
	'Wed' => '–°—Ä',
	'Thursday' => '–ß–µ—Ç–≤–µ—Ä–≥',
	'Thu' => '–ß—Ç',
	'Friday' => '–ü—è—Ç–Ω–∏—Ü–∞',
	'Fri' => '–ü—Ç',
	'Saturday' => '–°—É–±–±–æ—Ç–∞',
	'Sat' => '–°–±',

## default_templates/category_entry_listing.mtml
	'HTML Head' => 'HTML Head',
	'[_1] Archives' => '–ê—Ä—Ö–∏–≤ [_1]',
	'Banner Header' => '–®–∞–ø–∫–∞ —Å–∞–π—Ç–∞',
	'Recently in <em>[_1]</em> Category' => '–ü–æ—Å–ª–µ–¥–Ω–µ–µ –≤ –∫–∞—Ç–µ–≥–æ—Ä–∏–∏ <em>[_1]</em>',
	'Entry Summary' => '–û–±—â–∏–π –≤–∏–¥ –∑–∞–ø–∏—Å–∏',
	'Main Index' => '–ì–ª–∞–≤–Ω–∞—è —Å—Ç—Ä–∞–Ω–∏—Ü–∞',
	'Sidebar' => '–ë–æ–∫–æ–≤–æ–µ –º–µ–Ω—é',
	'Banner Footer' => '–ü–æ–¥–≤–∞–ª',

## default_templates/pages_list.mtml
	'Pages' => '–°—Ç—Ä–∞–Ω–∏—Ü—ã',

## default_templates/archive_index.mtml
	'Monthly Archives' => '–ê—Ä—Ö–∏–≤—ã –ø–æ –º–µ—Å—è—Ü–∞–º',
	'Categories' => '–ö–∞—Ç–µ–≥–æ—Ä–∏–∏',
	'Author Archives' => '–ê—Ä—Ö–∏–≤—ã –∞–≤—Ç–æ—Ä–æ–≤',
	'Category Monthly Archives' => '–ê—Ä—Ö–∏–≤—ã –∫–∞—Ç–µ–≥–æ—Ä–∏–π –ø–æ –º–µ—Å—è—Ü–∞–º',

## default_templates/search.mtml
	'Case sensitive' => '–£—á–∏—Ç—ã–≤–∞—Ç—å —Ä–µ–≥–∏—Å—Ç—Ä',
	'Regex search' => '–° —Ä–µ–≥—É–ª—è—Ä–Ω—ã–º–∏ –≤—ã—Ä–∞–∂–µ–Ω–∏—è–º–∏',
	'[_1] ([_2])' => '[_1] ([_2])',

## default_templates/trackbacks.mtml
	'TrackBack URL: [_1]' => 'URL –¥–ª—è —Ç—Ä–µ–∫–±—ç–∫–æ–≤: [_1]',
	'<a href="[_1]">[_2]</a> from [_3] on <a href="[_4]">[_5]</a>' => '<a href="[_1]">[_2]</a> –æ—Ç ¬´[_3]¬ª ‚Äî <a href="[_4]">[_5]</a>',
	'[_1] <a href="[_2]">Read More</a>' => '[_1] <a href="[_2]">–ß–∏—Ç–∞—Ç—å –¥–∞–ª—å—à–µ</a>',

## default_templates/recent_assets.mtml
	'Recent Assets' => '–ü–æ—Å–ª–µ–¥–Ω–µ–µ –º–µ–¥–∏–∞',

## default_templates/openid.mtml
	'[_1] accepted here' => '[_1] –ø—Ä–∏–Ω–∏–º–∞–µ—Ç—Å—è –∑–¥–µ—Å—å',
	'http://www.sixapart.com/labs/openid/' => 'http://www.sixapart.com/labs/openid/',
	'Learn more about OpenID' => '–£–∑–Ω–∞—Ç—å –±–æ–ª—å—à–µ –æ–± OpenID',

## default_templates/recent_comments.mtml
	'Recent Comments' => '–ü–æ—Å–ª–µ–¥–Ω–∏–µ –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–∏',
	'<strong>[_1]:</strong> [_2] <a href="[_3]" title="full comment on: [_4]">read more</a>' => '<strong>[_1]:</strong> [_2] <a href="[_3]" title="–ø–æ–ª–Ω—ã–π –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–π: [_4]">—á–∏—Ç–∞—Ç—å –¥–∞–ª—å—à–µ</a>',

## default_templates/dynamic_error.mtml
	'Page Not Found' => '–°—Ç—Ä–∞–Ω–∏—Ü–∞ –Ω–µ –Ω–∞–π–¥–µ–Ω–∞',

## default_templates/monthly_entry_listing.mtml

## default_templates/main_index_widgets_group.mtml
	'This is a custom set of widgets that are conditioned to only appear on the homepage (or "main_index"). More info: [_1]' => '–≠—Ç–æ –ø—Ä–æ–∏–∑–≤–æ–ª—å–Ω—ã–π –Ω–∞–±–æ—Ä –≤–∏–¥–∂–µ—Ç–æ–≤, —á—Ç–æ –æ–±—É—Å–ª–∞–≤–ª–∏–≤–∞–µ—Ç –µ–≥–æ –≤–∫–ª—é—á–µ–Ω–∏–µ —Ç–æ–ª—å–∫–æ –Ω–∞ –¥–æ–º–∞—à–Ω–µ–π —Å—Ç—Ä–∞–Ω–∏—Ü–µ (–∏–ª–∏ ¬´main_index¬ª). –î–æ–ø–æ–ª–Ω–∏—Ç–µ–ª—å–Ω–∞—è –∏–Ω—Ñ–æ—Ä–º–∞—Ü–∏—è: [_1]',
	'Recent Entries' => '–ü–æ—Å–ª–µ–¥–Ω–∏–µ –∑–∞–ø–∏—Å–∏',

## default_templates/banner_footer.mtml
	'_POWERED_BY' => '–†–∞–±–æ—Ç–∞–µ—Ç –Ω–∞<br /><a href="http://www.movabletype.org/"><MTProductName></a>',

## default_templates/page.mtml
	'Trackbacks' => '–¢—Ä–µ–∫–±—ç–∫–∏',

## default_templates/comment_throttle.mtml
	'If this was a mistake, you can unblock the IP address and allow the visitor to add it again by logging in to your Melody installation, going to Blog Config - IP Banning, and deleting the IP address [_1] from the list of banned addresses.' => '–ï—Å–ª–∏ –ø—Ä–æ–∏–∑–æ—à–ª–∞ –æ—à–∏–±–∫–∞, –≤—ã –º–æ–∂–µ—Ç–µ —Ä–∞–∑–±–ª–æ–∫–∏—Ä–æ–≤–∞—Ç—å IP –∞–¥—Ä–µ—Å. –î–ª—è —ç—Ç–æ–≥–æ –∑–∞–π–¥–∏—Ç–µ –≤ Melody, –ø–µ—Ä–µ–π–¥–∏—Ç–µ –∫ –Ω–∞—Å—Ç—Ä–æ–π–∫–µ –±–ª–æ–≥–∞ ‚Äî –ë–ª–æ–∫–∏—Ä–æ–≤–∫–∞ IP, –∞ –∑–∞—Ç–µ–º —É–¥–∞–ª–∏—Ç–µ –∞–¥—Ä–µ—Å [_1] –∏–∑ —Å–ø–∏—Å–∫–∞ –∑–∞–±–ª–æ–∫–∏—Ä–æ–≤–∞–Ω–Ω—ã—Ö.',
	'A visitor to your blog [_1] has automatically been banned by adding more than the allowed number of comments in the last [_2] seconds.' => '–ü–æ—Å–µ—Ç–∏—Ç–µ–ª—å –≤–∞—à–µ–≥–æ –±–ª–æ–≥–∞ ¬´[_1]¬ª –±—ã–ª –∞–≤—Ç–æ–º–∞—Ç–∏—á–µ—Å–∫–∏ –∑–∞–±–ª–æ–∫–∏—Ä–æ–≤–∞–Ω, —Ç–∞–∫ –∫–∞–∫ –ø—ã—Ç–∞–ª—Å—è –¥–æ–±–∞–≤–∏—Ç—å –±–æ–ª—å—à–µ –ø–æ–∑–≤–æ–ª–µ–Ω–Ω–æ–≥–æ –∫–æ–ª–∏—á–µ—Å—Ç–≤–∞ –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–µ–≤ –∑–∞ [quant,_2,—Å–µ–∫—É–Ω–¥—É,—Å–µ–∫—É–Ω–¥—ã,—Å–µ–∫—É–Ω–¥].',
	'This has been done to prevent a malicious script from overwhelming your weblog with comments. The banned IP address is' => '–≠—Ç–æ —Å–¥–µ–ª–∞–Ω–æ –¥–ª—è —Ç–æ–≥–æ, —á—Ç–æ–±—ã –ø—Ä–µ–¥–æ—Ç–≤—Ä–∞—Ç–∏—Ç—å –∑–∞—Å–æ—Ä–µ–Ω–∏–µ –±–ª–æ–≥–∞ –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏—è–º–∏, –¥–æ–±–∞–≤–ª—è–µ–º—ã–º–∏ –∞–≤—Ç–æ–º–∞—Ç–∏—á–µ—Å–∫–∏ —Å –ø–æ–º–æ—â—å—é —Å–ø–µ—Ü–∏–∞–ª—å–Ω—ã—Ö –ø—Ä–æ–≥—Ä–∞–º–º (—Å–ø–∞–º-–±–æ—Ç–æ–≤).',

## default_templates/current_category_monthly_archive_list.mtml
	'[_1]: Monthly Archives' => '[_1]: –∞—Ä—Ö–∏–≤ –∑–∞ –º–µ—Å—è—Ü',
	'[_1]' => '[_1]',

## default_templates/main_index.mtml

## default_templates/monthly_archive_list.mtml
	'[_1] <a href="[_2]">Archives</a>' => '<a href="[_2]">–ê—Ä—Ö–∏–≤—ã</a> [_1]',

## default_templates/powered_by.mtml
	'_MTCOM_URL' => 'http://www.movabletype.com/',

## default_templates/category_archive_list.mtml

## default_templates/comment_response.mtml
	'Confirmation...' => '–ü–æ–¥—Ç–≤–µ—Ä–∂–¥–µ–Ω–∏–µ‚Ä¶',
	'Your comment has been submitted!' => '–í–∞—à –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–π –¥–æ–±–∞–≤–ª–µ–Ω!',
	'Thank you for commenting.' => '–°–ø–∞—Å–∏–±–æ –∑–∞ –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–π.',
	'Your comment has been received and held for approval by the blog owner.' => '–í–∞—à –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–π –¥–æ–±–∞–≤–ª–µ–Ω, –Ω–æ –ø—Ä–µ–∂–¥–µ, —á–µ–º –æ–Ω –±—É–¥–µ—Ç –æ–ø—É–±–ª–∏–∫–æ–≤–∞–Ω, –æ–Ω –¥–æ–ª–∂–µ–Ω –±—ã—Ç—å –ø—Ä–æ–≤–µ—Ä–µ–Ω –≤–ª–∞–¥–µ–ª—å—Ü–µ–º –±–ª–æ–≥–∞.',
	'Comment Submission Error' => '–û—à–∏–±–∫–∞ –ø—Ä–∏ –¥–æ–±–∞–≤–ª–µ–Ω–∏–∏ –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏—è',
	'Your comment submission failed for the following reasons: [_1]' => '–í–∞—à –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–π –Ω–µ –¥–æ–±–∞–≤–ª–µ–Ω –ø–æ —Å–ª–µ–¥—É—é—â–∏–º –ø—Ä–∏—á–∏–Ω–∞–º: [_1]',
	'Return to the <a href="[_1]">original entry</a>.' => '–í–µ—Ä–Ω—É—Ç—å—Å—è –∫ <a href="[_1]">–∑–∞–ø–∏—Å–∏</a>.',

## default_templates/current_author_monthly_archive_list.mtml

## default_templates/date_based_category_archives.mtml
	'Category Yearly Archives' => '–ê—Ä—Ö–∏–≤—ã –∫–∞—Ç–µ–≥–æ—Ä–∏–π –ø–æ –º–µ—Å—è—Ü–∞–º',
	'Category Weekly Archives' => '–ê—Ä—Ö–∏–≤—ã –∫–∞—Ç–µ–≥–æ—Ä–∏–π –ø–æ –Ω–µ–¥–µ–ª—è–º',
	'Category Daily Archives' => '–ê—Ä—Ö–∏–≤—ã –∫–∞—Ç–µ–≥–æ—Ä–∏–π –ø–æ –¥–Ω—è–º',

## default_templates/new-ping.mtml
	'An unapproved TrackBack has been posted on your blog [_1], for entry #[_2] ([_3]). You need to approve this TrackBack before it will appear on your site.' => '–ù–∞ –±–ª–æ–≥ ¬´[_1]¬ª –ø—Ä–∏—Å–ª–∞–Ω —Ç—Ä–µ–∫–±—ç–∫, –∫ –∑–∞–ø–∏—Å–∏ #[_2] ([_3]). –ß—Ç–æ–±—ã –æ–Ω –ø–æ—è–≤–∏–ª—Å—è –≤ –≤–∞—à–µ–º –±–ª–æ–≥–µ, –Ω–µ–æ–±—Ö–æ–¥–∏–º–æ –µ–≥–æ –æ–¥–æ–±—Ä–∏—Ç—å.',
	'An unapproved TrackBack has been posted on your blog [_1], for category #[_2], ([_3]). You need to approve this TrackBack before it will appear on your site.' => '–ù–∞ –±–ª–æ–≥ ¬´[_1]¬ª –ø—Ä–∏—Å–ª–∞–Ω —Ç—Ä–µ–∫–±—ç–∫, –∫ –∫–∞—Ç–µ–≥–æ—Ä–∏–∏ #[_2], ([_3]). –ß—Ç–æ–±—ã –æ–Ω –ø–æ—è–≤–∏–ª—Å—è –≤ –≤–∞—à–µ–º –±–ª–æ–≥–µ, –µ–≥–æ –Ω–µ–æ–±—Ö–æ–¥–∏–º–æ –æ–¥–æ–±—Ä–∏—Ç—å.',
	'A new TrackBack has been posted on your blog [_1], on entry #[_2] ([_3]).' => '–ù–∞ –±–ª–æ–≥ ¬´[_1]¬ª –ø—Ä–∏—Å–ª–∞–Ω –Ω–æ–≤—ã–π —Ç—Ä–µ–∫–±—ç–∫, –∫ –∑–∞–ø–∏—Å–∏ #[_2] ([_3]).',
	'A new TrackBack has been posted on your blog [_1], on category #[_2] ([_3]).' => '–ù–∞ –±–ª–æ–≥ ¬´[_1]¬ª –ø—Ä–∏—Å–ª–∞–Ω –Ω–æ–≤—ã–π —Ç—Ä–µ–∫–±—ç–∫, –∫ –∫–∞—Ç–µ–≥–æ—Ä–∏–∏ #[_2] ([_3]).',
	'Excerpt' => '–í—ã–¥–µ—Ä–∂–∫–∞',
	'Title' => '–ó–∞–≥–æ–ª–æ–≤–æ–∫',
	'Blog' => '–ë–ª–æ–≥',
	'IP address' => 'IP –∞–¥—Ä–µ—Å',
	'Approve TrackBack' => '–û–¥–æ–±—Ä–∏—Ç—å —Ç—Ä–µ–∫–±—ç–∫',
	'View TrackBack' => '–ü–æ—Å–º–æ—Ç—Ä–µ—Ç—å —Ç—Ä–µ–∫–±—ç–∫',
	'Report TrackBack as spam' => '–ü–æ–º–µ—Ç–∏—Ç—å —Ç—Ä–µ–∫–±—ç–∫ –∫–∞–∫ —Å–ø–∞–º',
	'Edit TrackBack' => '–†–µ–¥–∞–∫—Ç–∏—Ä–æ–≤–∞—Ç—å —Ç—Ä–µ–∫–±—ç–∫',

## default_templates/sidebar.mtml
	'2-column layout - Sidebar' => '2-–∫–æ–ª–æ–Ω—á–∞—Ç—ã–π ‚Äî –ë–æ–∫–æ–≤–æ–µ –º–µ–Ω—é',
	'3-column layout - Primary Sidebar' => '3-–∫–æ–ª–æ–Ω—á–∞—Ç—ã–π ‚Äî –ì–ª–∞–≤–Ω–æ–µ –±–æ–∫–æ–≤–æ–µ –º–µ–Ω—é',
	'3-column layout - Secondary Sidebar' => '3-–∫–æ–ª–æ–Ω—á–∞—Ç—ã–π ‚Äî –í—Ç–æ—Ä–∏—á–Ω–æ–µ –±–æ–∫–æ–≤–æ–µ –º–µ–Ω—é',

## default_templates/new-comment.mtml
	'An unapproved comment has been posted on your blog [_1], for entry #[_2] ([_3]). You need to approve this comment before it will appear on your site.' => '–í –±–ª–æ–≥–µ [_1] –ø–æ—è–≤–∏–ª—Å—è –Ω–æ–≤—ã–π –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–π, –æ—Å—Ç–∞–≤–ª–µ–Ω–Ω—ã–π –∫ –∑–∞–ø–∏—Å–∏ #[_2] ([_3]). –í–∞–º –Ω–µ–æ–±—Ö–æ–¥–∏–º–æ –æ–¥–æ–±—Ä–∏—Ç—å –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–π, –ø—Ä–µ–∂–¥–µ —á–µ–º –æ–Ω –ø–æ—è–≤–∏—Ç—Å—è –≤ –±–ª–æ–≥–µ.',
	'A new comment has been posted on your blog [_1], on entry #[_2] ([_3]).' => '–í –±–ª–æ–≥–µ [_1] –ø–æ—è–≤–∏–ª—Å—è –Ω–æ–≤—ã–π –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–π, –æ—Å—Ç–∞–≤–ª–µ–Ω–Ω—ã–π –∫ –∑–∞–ø–∏—Å–∏ [_2] ([_3]). ',
	'Commenter name: [_1]' => '–ò–º—è –∫–æ–º–º–µ–Ω—Ç–∞—Ç–æ—Ä–∞: [_1]',
	'Commenter email address: [_1]' => 'Email: [_1]',
	'Commenter URL: [_1]' => 'URL: [_1]',
	'Commenter IP address: [_1]' => 'IP –∞–¥—Ä–µ—Å: [_1]',
	'Approve comment:' => '–û–¥–æ–±—Ä–∏—Ç—å –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–π:',
	'View comment:' => '–ü–æ—Å–º–æ—Ç—Ä–µ—Ç—å –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–π:',
	'Edit comment:' => '–†–µ–¥–∞–∫—Ç–∏—Ä–æ–≤–∞—Ç—å –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–π:',
	'Report comment as spam:' => '–ü–æ–º–µ—Ç–∏—Ç—å –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–π –∫–∞–∫ —Å–ø–∞–º:',

## default_templates/search_results.mtml
	'Search Results' => '–†–µ–∑—É–ª—å—Ç–∞—Ç –ø–æ–∏—Å–∫–∞',
	'Results matching &ldquo;[_1]&rdquo;' => '–ó–∞–ø–∏—Å–∏, –≤ –∫–æ—Ç–æ—Ä—ã—Ö –ø—Ä–∏—Å—É—Ç—Å—Ç–≤—É–µ—Ç ¬´[_1]¬ª',
	'Results tagged &ldquo;[_1]&rdquo;' => '–ó–∞–ø–∏—Å–∏, —Å–≤—è–∑–∞–Ω–Ω—ã–µ —Å —Ç–µ–≥–æ–º ¬´[_1]¬ª',
	'Previous' => '–ü—Ä–µ–¥—ã–¥—É—â–∏–π',
	'Next' => '–°–ª–µ–¥—É—é—â–∏–π',
	'No results found for &ldquo;[_1]&rdquo;.' => '–ü–æ –≤–∞—à–µ–º—É –∑–∞–ø—Ä–æ—Å—É ¬´[_1]¬ª –Ω–∏—á–µ–≥–æ –Ω–µ –Ω–∞–π–¥–µ–Ω–æ.',
	'Instructions' => '–ò–Ω—Å—Ç—Ä—É–∫—Ü–∏–∏',
	'By default, this search engine looks for all words in any order. To search for an exact phrase, enclose the phrase in quotes:' => '–ü–æ —É–º–æ–ª—á–∞–Ω–∏—é –ø–æ–∏—Å–∫–æ–≤—ã–π –º–µ—Ö–∞–Ω–∏–∑–º –∏—â–µ—Ç –≤—Å–µ —Å–ª–æ–≤–∞, —Ä–∞—Å–ø–æ–ª–æ–∂–µ–Ω–Ω—ã–µ –≤ –ª—é–±–æ–º –ø–æ—Ä—è–¥–∫–µ. –ß—Ç–æ–±—ã –∏—Å–∫–∞—Ç—å —Ç–æ—á–Ω—É—é —Ñ—Ä–∞–∑—É, –∑–∞–∫–ª—é—á–∏—Ç–µ –µ—ë –≤ –∫–∞–≤—ã—á–∫–∏: ',
	'movable type' => 'movable type',
	'The search engine also supports AND, OR, and NOT keywords to specify boolean expressions:' => '–¢–∞–∫–∂–µ –æ–±—Ä–∞—Ç–∏—Ç–µ –≤–Ω–∏–º–∞–Ω–∏–µ, —á—Ç–æ –ø–æ–∏—Å–∫–æ–≤—ã–π –º–µ—Ö–∞–Ω–∏–∑–º –ø–æ–¥–¥–µ—Ä–∂–∏–≤–∞–µ—Ç –æ–ø–µ—Ä–∞—Ç–æ—Ä—ã AND, OR –∏ NOT:',
	'personal OR publishing' => '—Å–æ–±–∞–∫–∞ OR –∂–∏–≤–æ—Ç–Ω–æ–µ',
	'publishing NOT personal' => '–∂–∏–≤–æ—Ç–Ω–æ–µ NOT –∫–æ—à–∫–∞',

## default_templates/author_archive_list.mtml
	'Authors' => '–ê–≤—Ç–æ—Ä—ã',

## default_templates/syndication.mtml
	'Subscribe to feed' => '–ü–æ–¥–ø–∏—Å–∞—Ç—å—Å—è –Ω–∞ –æ–±–Ω–æ–≤–ª–µ–Ω–∏—è',
	'Subscribe to this blog\'s feed' => '–ü–æ–¥–ø–∏—Å–∞—Ç—å—Å—è –Ω–∞ –æ–±–Ω–æ–≤–ª–µ–Ω–∏—è —ç—Ç–æ–≥–æ –±–ª–æ–≥–∞',
	'Subscribe to a feed of all future entries tagged &ldquo;[_1]&ldquo;' => '–ü–æ–¥–ø–∏—Å–∞—Ç—å—Å—è –Ω–∞ –æ–±–Ω–æ–≤–ª–µ–Ω–∏—è, —Å–≤—è–∑–∞–Ω–Ω—ã–µ —Å —Ç–µ–≥–æ–º ¬´[_1]¬ª',
	'Subscribe to a feed of all future entries matching &ldquo;[_1]&ldquo;' => '–ü–æ–¥–ø–∏—Å–∞—Ç—å—Å—è –Ω–∞ –æ–±–Ω–æ–≤–ª–µ–Ω–∏—è, —Å–æ–¥–µ—Ä–∂–∞—â–∏–µ ¬´[_1]¬ª',
	'Feed of results tagged &ldquo;[_1]&ldquo;' => '–û–±–Ω–æ–≤–ª–µ–Ω–∏—è –ø–æ —Ç–µ–≥—É ¬´[_1]¬ª',
	'Feed of results matching &ldquo;[_1]&ldquo;' => '–û–±–Ω–æ–≤–ª–µ–Ω–∏—è, —Å–æ–¥–µ—Ä–∂–∞—â–∏–µ ¬´[_1]¬ª',

## default_templates/comment_preview.mtml
	'Previewing your Comment' => '–ü—Ä–æ—Å–º–æ—Ç—Ä –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏—è',
	'[_1] replied to <a href="[_2]">comment from [_3]</a>' => '[_1] –æ—Ç–≤–µ—Ç–∏–ª –Ω–∞ <a href="[_2]">–∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–π –æ—Ç [_3]</a>',
	'Replying to comment from [_1]' => '–û—Ç–≤–µ—Ç –Ω–∞ –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–π –æ—Ç [_1]',
	'Cancel' => '–û—Ç–º–µ–Ω–∞',

## default_templates/archive_widgets_group.mtml
	'This is a custom set of widgets that are conditioned to serve different content based upon what type of archive it is included. More info: [_1]' => '–≠—Ç–æ –ø—Ä–æ–∏–∑–≤–æ–ª—å–Ω—ã–π –Ω–∞–±–æ—Ä –≤–∏–¥–∂–µ—Ç–æ–≤, —á—Ç–æ –æ–±—É—Å–ª–∞–≤–ª–∏–≤–∞–µ—Ç –µ–≥–æ –≤–∫–ª—é—á–µ–Ω–∏–∏ –Ω–∞ –æ—Å–Ω–æ–≤–µ —Ç–æ–≥–æ, –≤ –∫–∞–∫–æ–π –∞—Ä—Ö–∏–≤ –æ–Ω –≤–∫–ª—é—á—ë–Ω. –î–æ–ø–æ–ª–Ω–∏—Ç–µ–ª—å–Ω–∞—è –∏–Ω—Ñ–æ—Ä–º–∞—Ü–∏—è: [_1]',
	'Current Category Monthly Archives' => '–¢–µ–∫—É—â–∏–π –∞—Ä—Ö–∏–≤ –∫–∞—Ç–µ–≥–æ—Ä–∏–∏ –ø–æ –º–µ—Å—è—Ü–∞–º',
	'Category Archives' => '–ê—Ä—Ö–∏–≤—ã –∫–∞—Ç–µ–≥–æ—Ä–∏–π',

## default_templates/javascript.mtml
	'moments ago' => '—Ç–æ–ª—å–∫–æ —á—Ç–æ',
	'[quant,_1,hour,hours] ago' => '[quant,_1,—á–∞—Å,—á–∞—Å–∞,—á–∞—Å–æ–≤] –Ω–∞–∑–∞–¥',
	'[quant,_1,minute,minutes] ago' => '[quant,_1,–º–∏–Ω—É—Ç—É,–º–∏–Ω—É—Ç—ã,–º–∏–Ω—É—Ç] –Ω–∞–∑–∞–¥',
	'[quant,_1,day,days] ago' => '[quant,_1,–¥–µ–Ω—å,–¥–Ω—è,–¥–Ω–µ–π] –Ω–∞–∑–∞–¥',
	'Edit' => '–†–µ–¥–∞–∫—Ç–∏—Ä–æ–≤–∞—Ç—å',
	'Your session has expired. Please sign in again to comment.' => '–í–∞—à–∞ —Å–µ—Å—Å–∏—è –∏—Å—Ç–µ–∫–ª–∞. –ü–æ–∂–∞–ª—É–π—Å—Ç–∞, –∞–≤—Ç–æ—Ä–∏–∑—É–π—Ç–µ—Å—å –µ—â—ë —Ä–∞–∑.',
	'Signing in...' => '–ê–≤—Ç–æ—Ä–∏–∑–∞—Ü–∏—è‚Ä¶',
	'You do not have permission to comment on this blog. ([_1]sign out[_2])' => '–£ –≤–∞—Å –Ω–µ—Ç –ø—Ä–∞–≤ –¥–ª—è –∫–æ–º–º–µ–Ω—Ç–∏—Ä–æ–≤–∞–Ω–∏—è –≤ —ç—Ç–æ–º –±–ª–æ–≥–µ. ([_1]–≤—ã–π—Ç–∏[_2])',
	'Thanks for signing in, __NAME__. ([_1]sign out[_2])' => '–ü—Ä–∏–≤–µ—Ç! –°–µ–≥–æ–¥–Ω—è –≤—ã ‚Äî __NAME__.',
	'[_1]Sign in[_2] to comment.' => '–ù–µ–æ–±—Ö–æ–¥–∏–º–æ [_1]–∞–≤—Ç–æ—Ä–∏–∑–æ–≤–∞—Ç—å—Å—è[_2] –¥–ª—è –∫–æ–º–º–µ–Ω—Ç–∏—Ä–æ–≤–∞–Ω–∏—è.',
	'[_1]Sign in[_2] to comment, or comment anonymously.' => '[_1]–ê–≤—Ç–æ—Ä–∏–∑—É–π—Ç–µ—Å—å[_2], —á—Ç–æ–±—ã –ø—Ä–æ–∫–æ–º–º–µ–Ω—Ç–∏—Ä–æ–≤–∞—Ç—å —ç—Ç—É –∑–∞–ø–∏—Å—å, –ª–∏–±–æ –∫–æ–º–º–µ–Ω—Ç–∏—Ä—É–π—Ç–µ –∞–Ω–æ–Ω–∏–º–Ω–æ.',
	'Replying to <a href="[_1]" onclick="[_2]">comment from [_3]</a>' => '–û—Ç–≤–µ—Ç –Ω–∞ –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–π –æ—Ç <a href="[_1]" onclick="[_2]">[_3]</a>',

## default_templates/comment_detail.mtml

## default_templates/recent_entries.mtml

## default_templates/verify-subscribe.mtml
	'Thanks for subscribing to notifications about updates to [_1]. Follow the link below to confirm your subscription:' => '–ë–ª–∞–≥–æ–¥–∞—Ä–∏–º –∑–∞ –ø–æ–¥–ø–∏—Å–∫—É –Ω–∞ —É–≤–µ–¥–æ–º–ª–µ–Ω–∏—è –æ –Ω–æ–≤—ã—Ö –∑–∞–ø–∏—Å—è—Ö –Ω–∞ –≤–∞—à –∞–¥—Ä–µ—Å [_1]. –î–ª—è –ø–æ–¥—Ç–≤–µ—Ä–∂–¥–µ–Ω–∏—è –ø–æ–¥–ø–∏—Å–∫–∏ –ø–µ—Ä–µ–π–¥–∏—Ç–µ –ø–æ —Å–ª–µ–¥—É—é—â–µ–π —Å—Å—ã–ª–∫–µ:',
	'If the link is not clickable, just copy and paste it into your browser.' => '–ï—Å–ª–∏ —Å—Å—ã–ª–∫–∞ –Ω–µ –æ—Ç–∫—Ä—ã–≤–∞–µ—Ç—Å—è, –ø—Ä–æ—Å—Ç–æ —Å–∫–æ–ø–∏—Ä—É–π—Ç–µ –µ—ë –∏ –≤—Å—Ç–∞–≤—å—Ç–µ –≤ –∞–¥—Ä–µ—Å–Ω—É—é —Å—Ç—Ä–æ–∫—É –±—Ä–∞—É–∑–µ—Ä–∞.',

## default_templates/signin.mtml
	'Sign In' => '–ê–≤—Ç–æ—Ä–∏–∑–∞—Ü–∏—è',
	'You are signed in as ' => '–í—ã –∞–≤—Ç–æ—Ä–∏–∑–æ–≤–∞–ª–∏—Å—å –∫–∞–∫ ',
	'sign out' => '–≤—ã–π—Ç–∏',
	'You do not have permission to sign in to this blog.' => '–í—ã –Ω–µ –º–æ–∂–µ—Ç–µ –∞–≤—Ç–æ—Ä–∏–∑–æ–≤—ã–≤–∞—Ç—å—Å—è –≤ —ç—Ç–æ–º –±–ª–æ–≥–µ.',

## default_templates/commenter_confirm.mtml
	'Thank you registering for an account to comment on [_1].' => '–°–ø–∞—Å–∏–±–æ –∑–∞ —Ä–µ–≥–∏—Å—Ç—Ä–∞—Ü–∏—é –∞–∫–∫–∞—É–Ω—Ç–∞ –¥–ª—è –∫–æ–º–º–µ–Ω—Ç–∏—Ä–æ–≤–∞–Ω–∏—è ¬´[_1]¬ª.',
	'For your own security and to prevent fraud, we ask that you please confirm your account and email address before continuing. Once confirmed you will immediately be allowed to comment on [_1].' => '–î–ª—è –ø–æ–¥—Ç–≤–µ—Ä–∂–¥–µ–Ω–∏—è email –∞–¥—Ä–µ—Å–∞, –≤–∞–º –Ω–µ–æ–±—Ö–æ–¥–∏–º–æ –∞–∫—Ç–∏–≤–∏—Ä–æ–≤–∞—Ç—å –≤–∞—à –∞–∫–∫–∞—É–Ω—Ç. –ü–æ—Å–ª–µ —ç—Ç–æ–≥–æ –≤—ã —Å–º–æ–∂–µ—Ç–µ –Ω–µ–∑–∞–º–µ–¥–ª–∏—Ç–µ–ª—å–Ω–æ –∫–æ–º–º–µ–Ω—Ç–∏—Ä–æ–≤–∞—Ç—å ¬´[_1]¬ª.',
	'To confirm your account, please click on or cut and paste the following URL into a web browser:' => '–ü–µ—Ä–µ–π–¥–∏—Ç–µ –ø–æ —Å–ª–µ–¥—É—é—â–µ–π —Å—Å—ã–ª–∫–µ –∏–ª–∏ –≤—Å—Ç–∞–≤—å—Ç–µ –µ—ë –≤ –∞–¥—Ä–µ—Å–Ω—É—é —Å—Ç—Ä–æ–∫—É –±—Ä–∞—É–∑–µ—Ä–∞:',
	'If you did not make this request, or you don\'t want to register for an account to comment on [_1], then no further action is required.' => '–ï—Å–ª–∏ –∂–µ —Ä–µ–≥–∏—Å—Ç—Ä–∞—Ü–∏—é –∑–∞ –≤–∞—Å –≤—ã–ø–æ–ª–Ω–∏–ª –∫—Ç–æ-—Ç–æ –¥—Ä—É–≥–æ–π, –Ω–∞–≥–ª—ã–º –æ–±—Ä–∞–∑–æ–º –≤–æ—Å–ø–æ–ª—å–∑–æ–≤–∞–≤—à–∏—Å—å –≤–∞—à–∏–º –∞–¥—Ä–µ—Å–æ–º, –∏ –≤—ã –Ω–µ —Ö–æ—Ç–∏—Ç–µ –æ—Å—Ç–∞–≤–ª—è—Ç—å –∫–æ–º–º–µ–Ω—Ç–∞—Ä–∏–∏ –Ω–∞ —Å–∞–π—Ç–µ ¬´[_1]¬ª, –ø—Ä–æ—Å—Ç–æ –ø—Ä–æ–∏–≥–Ω–æ—Ä–∏—Ä—É–π—Ç–µ —ç—Ç–æ –ø–∏—Å—å–º–æ.',
	'Thank you very much for your understanding.' => '–ï—Å–ª–∏ –≤—ã –≤—Å—ë –∂–µ –ø–µ—Ä–µ–π–¥—ë—Ç–µ –ø–æ —Å—Å—ã–ª–∫–µ, –∑–Ω–∞—á–∏—Ç —Ä–æ–±–æ—Ç, –æ—Ç–ø—Ä–∞–≤–∏–≤—à–∏–π —ç—Ç–æ –ø–∏—Å—å–º–æ, —Å—Ç–∞—Ä–∞–ª—Å—è –Ω–µ –∑—Ä—è.',
	'Sincerely,' => '–° —É–≤–∞–∂–µ–Ω–∏–µ–º,',

## default_templates/comment_listing.mtml

## default_templates/recover-password.mtml
	'A request has been made to change your password in Melody. To complete this process click on the link below to select a new password.' => '–°–¥–µ–ª–∞–Ω –∑–∞–ø—Ä–æ—Å –Ω–∞ –∏–∑–º–µ–Ω–µ–Ω–∏–µ –ø–∞—Ä–æ–ª—è –≤ Melody. –î–ª—è –∑–∞–≤–µ—Ä—à–µ–Ω–∏—è –ø—Ä–æ—Ü–µ—Å—Å–∞, –ø–µ—Ä–µ–π–¥–∏—Ç–µ –ø–æ —Å—Å—ã–ª–∫–µ, —Ä–∞—Å–ø–æ–ª–æ–∂–µ–Ω–Ω–æ–π –Ω–∏–∂–µ:',
	'If you did not request this change, you can safely ignore this email.' => '–ï—Å–ª–∏ –≤—ã –Ω–µ –∑–∞–ø—Ä–∞—à–∏–≤–∞–ª–∏ –∏–∑–º–µ–Ω–µ–Ω–∏–µ –ø–∞—Ä–æ–ª—è, –ø—Ä–æ–∏–≥–Ω–æ—Ä–∏—Ä—É–π—Ç–µ —ç—Ç–æ –ø–∏—Å—å–º–æ.'

## default_templates/entry.mtml


);

1;


