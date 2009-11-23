<?php
# Movable Type (r) Open Source (C) 2001-2008 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id: l10n_ru.php 49 2008-08-19 11:51:26Z saahov $

global $Lexicon_ru;
$Lexicon_ru = array(
## php/lib/function.mtvar.php
	'You used a [_1] tag without a valid name attribute.' => 'Вы использовали тег [_1] без допустимого имени атрибута.',
	'\'[_1]\' is not a valid function for a hash.' => '«[_1]» — это неправильная функция для хэша.',
	'\'[_1]\' is not a valid function for an array.' => '«[_1]» — это неправильная функция для массива.',
	'[_1] [_2] [_3] is illegal.' => '[_1] [_2] [_3] — это недопустимо.',

## php/lib/archive_lib.php
	'Page' => 'Страница',
	'Individual' => 'Индивидуальный',
	'Yearly' => 'Ежегодный',
	'Monthly' => 'Ежемесячный',
	'Daily' => 'Ежедневный',
	'Weekly' => 'Еженедельный',
	'Author' => 'Автор',
	'(Display Name not set)' => '(Отображаемое имя не указано)',
	'Author Yearly' => 'Автор по годам',
	'Author Monthly' => 'Автор по месяцам',
	'Author Daily' => 'Автор по дням',
	'Author Weekly' => 'Автор по неделям',
	'Category Yearly' => 'Категория по годам',
	'Category Monthly' => 'Категория по месяцам',
	'Category Daily' => 'Категория по дням',
	'Category Weekly' => 'Категория по неделям',

## php/lib/block.mtsethashvar.php

## php/lib/block.mtif.php

## php/lib/function.mtremotesigninlink.php
	'TypeKey authentication is not enabled in this blog.  MTRemoteSignInLink can\'t be used.' => 'Авторизация через TypeKey не активна в этом блоге.  MTRemoteSignInLink не может быть использован.',

## php/lib/block.mtauthorhaspage.php
	'No author available' => 'Нет такого автора',

## php/lib/block.mtauthorhasentry.php

## php/lib/function.mtproductname.php
	'[_1] [_2]' => '[_1] [_2]',

## php/lib/captcha_lib.php
	'Captcha' => 'Captcha',
	'Type the characters you see in the picture above.' => 'Введите символы, отображённые на картинке.',

## php/lib/function.mtsetvar.php
	'\'[_1]\' is not a hash.' => '«[_1]» — это не хэш.',
	'Invalid index.' => 'Неправильный индекс.',
	'\'[_1]\' is not an array.' => '«[_1]» — это не массив.',
	'\'[_1]\' is not a valid function.' => '«[_1]» — это неправильная функция.',

## php/lib/block.mtassets.php
	'sort_by="score" must be used in combination with namespace.' => 'sort_by="score" должен использоваться в сочетании с namespace.',

## php/lib/block.mtsetvarblock.php

## php/lib/block.mtentries.php

## php/lib/MTUtil.php
	'userpic-[_1]-%wx%h%x' => 'userpic-[_1]-%wx%h%x',

## php/lib/thumbnail_lib.php
	'GD support has not been available. Please install GD support.' => 'Нет поддержки GD. Пожалуйста, установите необходимый модуль.', # Translate - New

## php/lib/function.mtauthordisplayname.php

## php/lib/function.mtentryclasslabel.php
	'page' => 'страница',
	'entry' => 'запись',
	'Entry' => 'Записи',
);
function translate_phrase($str, $params = null) {
    global $Lexicon, $Lexicon_ru;
    $l10n_str = isset($Lexicon_ru[$str]) ? $Lexicon_ru[$str] : (isset($Lexicon[$str]) ? $Lexicon[$str] : $str);
    if (extension_loaded('mbstring')) {
        $str = mb_convert_encoding($l10n_str,mb_internal_encoding(),"UTF-8");
    } else {
        $str = $l10n_str;
    }
    return translate_phrase_param($str, $params);
}
?>
