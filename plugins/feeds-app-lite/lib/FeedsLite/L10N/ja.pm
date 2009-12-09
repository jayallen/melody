# Copyright 2002-2006 Appnel Internet Solutions, LLC
# This code is distributed with permission by Six Apart

package FeedsLite::L10N::ja;

use strict;
use base 'FeedsLite::L10N::en_us';
use vars qw( %Lexicon );

## The following is the translation table.

%Lexicon = (

## plugins/feeds-app-lite/lib/MT/Feeds/Lite.pm
  'An error occurred processing [_1]. The previous version of the feed was used. A HTTP status of [_2] was returned.' => '[_1]の実行中にエラーが発生しました。以前のバージョンのフィードが使用されます。[_2]のHTTPステータスが返されました。',
  'An error occurred processing [_1]. A previous version of the feed was not available.A HTTP status of [_2] was returned.' => '[_1]の実行中にエラーが発生しました。以前のバージョンのフィードはありません。[_2]のHTTPステータスが返されました。',

## plugins/feeds-app-lite/lib/MT/Feeds/Tags.pm
  '\'[_1]\' is a required argument of [_2]' => '\'[_1]\' は[_2]の引数を必要とします',
  'MT[_1] was not used in the proper context.' => 'MT[_1]を適切なコンテキスト外で使用しています。',

## plugins/feeds-app-lite/tmpl/config.tmpl
  'Feeds.App Lite Widget Creator' => 'Feeds.App Lite ウィジェット作成ツール',
  'Configure feed widget settings' => 'フィードウィジェットを設定する',
  'Enter a title for your widget.  This will also be displayed as the title of the feed when used on your published blog.' => 'Widgetのタイトルを入力してください。このタイトルは、公開されているブログでWidgetが使用されたときにもフィードのタイトルとして表示されます。',
  '[_1] Feed Widget' => '[_1]フィードウィジェット',
  'Select the maximum number of entries to display.' => '表示するブログ記事の最大数を選択します。',
  '3' => '3',
  '5' => '5',
  '10' => '10',
  'All' => 'すべて',

## plugins/feeds-app-lite/tmpl/msg.tmpl
  'No feeds could be discovered using [_1]' => '[_1]でフィードが見つかりませんでした。',
  'An error occurred processing [_1]. Check <a href="javascript:void(0)" onclick="closeDialog(\'http://www.feedvalidator.org/check.cgi?url=[_2]\')">here</a> for more detail and please try again.' => '[_1]の実行中にエラーが発生しました。<a href="javascript:void(0)" onclick="closeDialog(\'http://www.feedvalidator.org/check.cgi?url=[_2]\')">ここ</a>をクリックし、詳細を確認のうえ、再度実行してください。',
  'A widget named <strong>[_1]</strong> has been created.' => 'フィードウィジェット「[_1]」を作成しました。',
  'You may now <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">edit &ldquo;[_1]&rdquo;</a> or include the widget in your blog using <a href="javascript:void(0)" onclick="closeDialog(\'[_3]\')">WidgetManager</a> or the following MTInclude tag:' => '<a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">[_1]を編集</a>できます。また、<a href="javascript:void(0)" onclick="closeDialog(\'[_3]\')">WidgetManager</a>か以下のMTIncludeタグを使ってブログに挿入できます。',
  'You may now <a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">edit &ldquo;[_1]&rdquo;</a> or include the widget in your blog using the following MTInclude tag:' => '<a href="javascript:void(0)" onclick="closeDialog(\'[_2]\')">[_1]を編集</a>できます。また、以下のMTIncludeタグを使ってブログに挿入できます。',
  'Create Another' => '続けて作成する',

## plugins/feeds-app-lite/tmpl/start.tmpl
  'You must enter a feed or site URL to proceed' => 'フィードまたはサイトのURLを入力してください。',
  'Create a widget from a feed' => 'フィードからウィジェットを作成する',
  'Feed or Site URL' => 'フィードまたはサイトのURL',
  'Enter the URL of a feed, or the URL of a site that has a feed.' => 'フィードのURLを入力するか、フィードを配信しているサイトのURLを入力してください。',

## plugins/feeds-app-lite/tmpl/select.tmpl
  'Multiple feeds were found' => 'フィードが複数見つかりました。',
  'Select the feed you wish to use. <em>Feeds.App Lite supports text-only RSS 1.0, 2.0 and Atom feeds.</em>' => '利用するフィードを選択してください。<strong>Feeds.App Liteはテキストで構成されたRSS 1.0、RSS 2.0、Atomの各形式をサポートしています</strong>。',
  'URI' => 'URI',

## plugins/feeds-app-lite/mt-feeds.pl
  'Feeds.App Lite helps you republish feeds on your blogs. Want to do more with feeds in Movable Type? <a href="http://code.appnel.com/feeds-app" target="_blank">Upgrade to Feeds.App</a>.' => 'Feeds.App Liteからブログ上のフィードを更新（再構築）できます。Movable Typeでフィードをさらに活用するには<a href="http://code.appnel.com/feeds-app" target="_blank">Feeds.App</a>にアップグレードします。',
  'Create a Feed Widget' => 'フィードウィジェットを作成',
);

1;

