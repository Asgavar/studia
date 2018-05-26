<?php

namespace Asgavar\DatabaseRepository\Repositories;

use Ramsey\Uuid\Uuid;
use Asgavar\DatabaseRepository\Aggregates\Transaction;

interface TransactionRepository
{
    public function get(UUid $transactionId): Transaction;

    public function save(Transaction $transaction): void;
}
