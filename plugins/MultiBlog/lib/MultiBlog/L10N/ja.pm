# Movable Type (r) Open Source (C) 2006-2008 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

# Original Copyright (c) 2004-2006 David Raynes

package MultiBlog::L10N::ja;

use strict;
use base 'MultiBlog::L10N::en_us';
use vars qw( %Lexicon );

## The following is the translation table.

%Lexicon = (
## plugins/MultiBlog/lib/MultiBlog/Tags.pm
	'MTMultiBlog tags cannot be nested.' => 'MTMultiBlogタグは入れ子にできません。',
	'Unknown "mode" attribute value: [_1]. Valid values are "loop" and "context".' => 'mode属性が不正です。loopまたはcontextを指定してください。',

## plugins/MultiBlog/lib/MultiBlog.pm
	'The include_blogs, exclude_blogs, blog_ids and blog_id attributes cannot be used together.' => 'include_blogs、exclude_blogs、blog_ids、そしてblog_id属性は一緒に使えません。',
	'The attribute exclude_blogs cannot take "all" for a value.' => 'exclude_blogs属性はallを設定できません。',
	'The value of the blog_id attribute must be a single blog ID.' => 'blog_id属性にはブログIDをひとつしか指定できません。',
	'The value for the include_blogs/exclude_blogs attributes must be one or more blog IDs, separated by commas.' => 'include_blogs/exclude_blogs属性はカンマで区切ったひとつ以上のIDを設定できます。',

## plugins/MultiBlog/tmpl/dialog_create_trigger.tmpl
	'Create MultiBlog Trigger' => 'MultiBlog トリガーの作成',

## plugins/MultiBlog/tmpl/blog_config.tmpl
	'When' => '',
	'Any Weblog' => 'すべてのブログ',
	'Weblog' => 'ブログ',
	'Trigger' => 'トリガー',
	'Action' => 'アクション',
	'Content Privacy' => 'コンテンツのセキュリティ',
	'Specify whether other blogs in the installation may publish content from this blog. This setting takes precedence over the default system aggregation policy found in the system-level MultiBlog configuration.' => '同じMovable Type内の他のブログがこのブログのコンテンツを公開できるかどうかを指定します。この設定はシステムレベルのMultiBlogの構成で指定された既定のアグリゲーションポリシーよりも優先されます。',
	'Use system default' => 'システムの既定値を使用',
	'Allow' => '許可',
	'Disallow' => '許可しない',
	'MTMultiBlog tag default arguments' => 'MTMultiBlogタグの既定の属性:',
	'Enables use of the MTMultiBlog tag without include_blogs/exclude_blogs attributes. Comma-separated BlogIDs or \'all\' (include_blogs only) are acceptable values.' => 'include_blogs/exclude_blogs属性なしでMTMultiBlogタグを使用できるようにします。カンマで区切ったブログID、または「all」(include_blogs のみ)が指定できます。',
	'Include blogs' => '含めるブログ',
	'Exclude blogs' => '除外するブログ',
	'Rebuild Triggers' => '再構築トリガー',
	'Create Rebuild Trigger' => '再構築トリガーを作成',
	'You have not defined any rebuild triggers.' => '再構築トリガーを設定していません。',

## plugins/MultiBlog/tmpl/system_config.tmpl
	'Default system aggregation policy' => '既定のアグリゲーションポリシー',
	'Cross-blog aggregation will be allowed by default.  Individual blogs can be configured through the blog-level MultiBlog settings to restrict access to their content by other blogs.' => 'ブログを>またがったアグリゲーションが既定で許可されます。個別のブログレベルでのMultiBlogの設定で他のブログか>らのコンテンツへのアクセスを制限できます。',
	'Cross-blog aggregation will be disallowed by default.  Individual blogs can be configured through the blog-level MultiBlog settings to allow access to their content by other blogs.' => 'ブログを>またがったアグリゲーションが既定で不許可になります。個別のブログレベルでのMultiBlogの設定で他のブロ>グからのコンテンツへのアクセスを許可することもできます。',

## plugins/MultiBlog/multiblog.pl
	'MultiBlog allows you to publish content from other blogs and define publishing rules and access controls between them.' => 'MultiBlogを使うと他のブログのコンテンツを公開したりブログ同士での公開ルールの設定やアクセス制限を行うことができます。',
	'MultiBlog' => 'マルチブログ',
	'Create Trigger' => 'トリガーを作成',
	'Weblog Name' => 'ブログ名',
	'Search Weblogs' => 'ブログ検索',
	'When this' => 'トリガー:',
	'* All Weblogs' => '* すべてのブログ',
	'Select to apply this trigger to all weblogs' => 'このトリガーをすべてのブログで有効にする',
	'saves an entry' => 'ブログ記事の保存時',
	'publishes an entry' => 'ブログ記事の公開時',
	'publishes a comment' => 'コメントの公開時',
	'publishes a TrackBack' => 'トラックバックの公開時',
	'rebuild indexes.' => 'インデックスを再構築する',
	'rebuild indexes and send pings.' => 'インデックスを再構築して更新情報を送信する',

);

1;

