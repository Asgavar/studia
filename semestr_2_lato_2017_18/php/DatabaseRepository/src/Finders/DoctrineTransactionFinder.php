<?php

namespace Asgavar\DatabaseRepository\Finders;

use Doctrine\ORM\EntityManager;

class DoctrineTransactionFinder implements TransactionFinder
{
    private $entityManager;

    public function __construct(EntityManager $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    public function findAll(int $limit = 10, int $offset = 0)
    {
        return $this->entityManager
            ->createQueryBuilder()
            ->select('t')
            ->from('Asgavar\DatabaseRepository\Aggregates\Transaction', 't')
            ->setMaxResults($limit)
            ->setFirstResult($offset)
            ->getQuery()
            ->getArrayResult();
    }
}
