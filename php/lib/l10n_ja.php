<?php
global $Lexicon;
$Lexicon = array(
    ## default_templates.pl
    'Continue reading' => '続きを読む',
    'Posted by' => '投稿者',
    'at' => ':',
    'Comments' => 'コメント',
    'TrackBack' => 'トラックバック',
    'Monthly calendar with links to each day\'s posts' => '投稿されたエントリーへのリンク付き月間カレンダー',
    'Sunday' => '日曜日',
    'Sun' => '日',
    'Monday' => '月曜日',
    'Mon' => '月',
    'Tuesday' => '火曜日',
    'Tue' => '火',
    'Wednesday' => '水曜日',
    'Wed' => '水',
    'Thursday' => '木曜日',
    'Thu' => '木',
    'Friday' => '金曜日',
    'Fri' => '金',
    'Saturday' => '土曜日',
    'Sat' => '土',
    'Search' => '検索',
    'Search this site:' => 'サイト内の検索',
    'Archives' => 'アーカイブ',
    'Recent Entries' => '最近のエントリー',
    'Syndicate this site' => 'Syndicate this site',
    'This weblog is licensed under a' => 'このウェブログのライセンス:',
    'Powered by' => 'Powered by',
    'Comment Preview' => 'コメントの確認',
    'Previewing your Comment' => 'コメントの確認',
    'Previous Comments' => '以前のコメント',
    'Thank You for Commenting' => 'コメントしてくれてありがとう! ',
    'Your comment has been received. To protect against malicious comments, I have enabled a feature that allows your comments to be held for approval the first time you post a comment. I\'ll approve your comment when convenient; there is no need to re-post your comment.' => 'コメントを受けつけました。不適切なコメントを防止するために、初回のコメントが掲載される前に確認しています。適切なコメントであれば掲載されるでしょう。もう一度投稿する必要はありません。',
    'Return to the comment page' => 'コメントのページに戻る',
    'Comment Submission Error' => 'コメントの登録エラー',
    'Your comment submission failed for the following reasons:' => 'コメントの登録が失敗しました:',
    'Comment on' => 'コメント:',
    'Comments:' => 'コメント:',
    'Post a comment' => 'コメントしてください',
    'Main' => 'メイン',
    'Trackback Pings' => 'トラックバック',
    'TrackBack URL for this entry:' => 'このエントリーのトラックバックURL:',
    'Listed below are links to weblogs that reference' => 'このリストは、次のエントリーを参照しています: ',
    'Read More' => '続きを読む',
    'Tracked on' => 'トラックバック時刻: ',
    'Posted by:' => '投稿者',
    'Thanks for signing in, ' => 'サイン・インを確認しました、',
    'Now you can comment.' => 'さん。コメントしてください。',
    'sign out' => 'サイン・アウト',
    '(If you haven\'t left a comment here before, you may need to be approved by the site owner before your comment will appear. Until then, it won\'t appear on the entry. Thanks for waiting.)' => '(いままで、ここでコメントしたとがないときは、コメントを表示する前にこのウェブログのオーナーの承認が必要になることがあります。承認されるまではコメントは表示されません。そのときはしばらく待ってください。)',
    'URL' => 'URL',
    'Remember me?' => '情報を登録する?',
    'Yes' => 'はい',
    'No' => 'いいえ',
    'Preview' => '確認',
    'Post' => '投稿',
    'You are not signed in. You need to be registered to comment on this site.' => 'サイン・インしていません。このサイトにコメントをする前に登録してください。',
    'Sign in' => 'サイン・イン',
    '&#xA1;Comment registration is required but no TypeKey token has been given in weblog configuration!' => 'コメント登録機能を利用するには、TypeKey トークンを設定してください。',
    '. Now you can comment.' => 'さん。コメントしてください。',
    'If you have a TypeKey identity, you can' => 'TypeKey ID を使って',
    'sign in' => 'サイン・イン',
    'to use it here.' => 'してください。',
    'Name' => '名前',
    'Email Address' => 'メールアドレス',
    'Remember Me?' => '保存しますか?',
    '(you may use HTML tags for style)' => '(書式を変更するような一部のHTMLタグを使うことができます)',
    '(You may use HTML tags for style)' => '(書式を変更するような一部のHTMLタグを使うことができます)',
    'Discussion on' => 'トラックバック: ',
    'Continuing the discussion...' => 'トラックバック',
    'from' => ',',
    'file' => 'ファイル',
    'image' => '画像',
);

function translate_phrase($str, $params = null) {
    global $Lexicon;
    $l10n_str = isset($Lexicon[$str]) == true ? $Lexicon[$str] : $str;
    if (extension_loaded('mbstring')) {
        $str = mb_convert_encoding($l10n_str,mb_internal_encoding(),"UTF-8");
    } else {
        $str = $l10n_str;
    }
    return translate_phrase_param($str, $params);
}
?>
