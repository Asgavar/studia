<?php

require_once(__DIR__.'/../vendor/autoload.php');

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Tools\Setup;
use Money\Money;
use Ramsey\Uuid\Uuid;

use Asgavar\DatabaseRepository\Aggregates\Transaction;
use Asgavar\DatabaseRepository\ValueObjects\TransactionState;
use Asgavar\DatabaseRepository\Finders\DoctrineTransactionFinder;
use Asgavar\DatabaseRepository\Repositories\DoctrineTransactionRepository;

$isDevMode = true;
// eee, relatywne ścieżki?
// $config = Setup::createYAMLMetadataConfiguration(array("/../config/yaml"), $isDevMode);
$config = Setup::createYAMLMetadataConfiguration(
    array(
        '/home/asgavar/studia/semestr_2_lato_2017_18/php/DatabaseRepository/config/yml'
    ),
    $isDevMode
);

$connectionParameters = array(
    'driver' => 'pdo_pgsql',
    'host' => 'localhost',
    'dbname' => 'DatabaseRepository',
    'user' => 'napewnonieadmin',
    'password' => 'brak'
);

$entityManager = EntityManager::create($connectionParameters, $config);

if (in_array('run', $argv))
{
    $transactionRepository = new DoctrineTransactionRepository($entityManager);
    $transactionFinder = new DoctrineTransactionFinder($entityManager);

    print_r('PRZED ZAPISEM'.PHP_EOL);
    print_r($transactionFinder->findAll());

    $transactionToSave = prepareExampleTransaction();
    $transactionRepository->save($transactionToSave);
    print_r('PO ZAPISIE'.PHP_EOL);
    print_r($transactionFinder->findAll());

    $transactionToUpdate = $transactionRepository->get($transactionToSave->getUuid());
    $transactionToUpdate->setAmount(Money::PLN(204));
    $transactionRepository->save($transactionToUpdate);
    print_r('PO ZMIANIE'.PHP_EOL);
    print_r($transactionFinder->findAll());
}

function prepareExampleTransaction()
{
    $uuid = Uuid::uuid4();
    $amount = Money::PLN(102);
    $fromAccount = '1234';
    $toAccount = '5678';
    $state = TransactionState::ACTIVE();

    return new Transaction($uuid, $amount, $fromAccount, $toAccount, $state);
}
