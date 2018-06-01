<?php

require_once("./vendor/autoload.php");

use Nelmio\Alice\Loader\NativeLoader;

$aliceLoader = new NativeLoader();

$howManyTransactionsToCreate = $argv[1];

echo 'uuu' . PHP_EOL;
echo $howManyTransactionsToCreate;
$ha = 0;

$objectSet = $aliceLoader->loadFile(__DIR__.'/fixtures.php');

var_dump($objectSet);
