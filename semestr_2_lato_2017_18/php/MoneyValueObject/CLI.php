#!/usr/bin/env php
<?php

require "vendor/autoload.php";

$loader = new \Aura\Autoload\Loader;
$loader->register();
$loader->addPrefix("Asgavar\MoneyValueObject", ".");

use Asgavar\MoneyValueObject\Currency;
use Asgavar\MoneyValueObject\Money;
use Asgavar\MoneyValueObject\ThousandSeparatedMoneyFormatter;


$currencyShortName = $argv[1];
$currency = new Currency("polski złoty", $currencyShortName, 100);
$sumOfThemAll = new Money($currency);
$formatter = new ThousandSeparatedMoneyFormatter(" ", ",");
// bo pierwsze dwa argumenty to nazwa programu i kod waluty
$actual_values = array_slice($argv, 2);

foreach ($actual_values as $value)
{
    $as_money_object = new Money($currency, doubleval($value));
    $sumOfThemAll->add($as_money_object);
}

print($formatter->format($sumOfThemAll));