<?php

namespace Asgavar\DatabaseRepository\Repositories;

use Doctrine\ORM\EntityManager;
use Ramsey\Uuid\Uuid;

use Asgavar\DatabaseRepository\Aggregates\Transaction;
use Asgavar\DatabaseRepository\Repositories\TransactionRepository;

class DoctrineTransactionRepository implements TransactionRepository
{
    private $entityManager;

    public function __construct(EntityManager $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    public function get(Uuid $uuid): Transaction
    {
        return $this->entityManager->find('Asgavar\DatabaseRepository\Aggregates\Transaction', $uuid);
    }

    public function save(Transaction $transaction): void
    {
        $this->entityManager->persist($transaction);
        $this->entityManager->flush();
    }
}
