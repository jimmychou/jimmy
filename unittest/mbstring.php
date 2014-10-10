<?php
$string  = '漢字はユニコード';
$needle  = 'は';
$replace = 'Foo';

echo str_replace($needle, $replace, $string);
// outputs: 漢字Fooユニコード
