<?php

require_once("./vendor/autoload.php");

use Nelmio\Alice\Loader\NativeLoader;

$howManyTransactionsToCreate = $argv[1];
$apiString = '<?php'.PHP_EOL.'$howManyTransactionsToCreate='.$howManyTransactionsToCreate.';';
file_put_contents('superAPI.php', $apiString);

$aliceLoader = new NativeLoader();
$objectSet = $aliceLoader->loadFile(__DIR__.'/fixtures.php');

echo "koniec generacji!".PHP_EOL;

$pdo = new PDO('pgsql:dbname=DatabasePerformance user=napewnonieadmin password=brak');
$sqlInsertFakeTransactions = $pdo->prepare(
    'INSERT INTO transactions (pos_id, date_time, amount, title) VALUES (?, ?, ?, ?);'
);

$sqlInsertFakeTransactions->bindParam(1, $pos_id);
$sqlInsertFakeTransactions->bindParam(2, $date_time);
$sqlInsertFakeTransactions->bindParam(3, $amount);
$sqlInsertFakeTransactions->bindParam(4, $title);

//$pdo->beginTransaction();
foreach ($objectSet->getObjects() as $transactionObject)
{
    $pos_id = $transactionObject->pos_id;
    $date_time = $transactionObject->date_time->format('Y-m-d H:i:s');
    $amount = $transactionObject->amount;
    $title = $transactionObject->title;
    $sqlInsertFakeTransactions->execute();
}
//$pdo->commit();
