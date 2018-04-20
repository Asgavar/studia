<?php

use Money\Currency;
use Money\Money;
use Wallet\Implementations\Wallet;
use Wallet\Implementations\WalletEventAggregator;

require_once("../vendor/autoload.php");

$TRANSACTION_OFFSET = 3;

$currency_name = $argv[1];
$transactions_count = (int)$argv[2];
$aggregator = new WalletEventAggregator();
$wallet = new Wallet();
$wallet->setEventAggregator($aggregator);

for ($x = 0; $x < $transactions_count; $x++)
{
    $amount = $argv[$TRANSACTION_OFFSET + $x];
    $wallet->deposit(
        new Money((int)$amount, new Currency($currency_name))
    );
}

$wallet->withdraw(
    new Money((int) $argv[$TRANSACTION_OFFSET + $transactions_count],
        new Currency($currency_name))
);

echo $wallet->getBalance()->getAmount() . " " . $currency_name . PHP_EOL;