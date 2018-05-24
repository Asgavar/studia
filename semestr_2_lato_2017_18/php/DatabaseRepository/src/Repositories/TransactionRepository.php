<?php

namespace Asgavar\Repositories;

use Ramsey\Uuid\Uuid;
use Asgavar\Aggregates\Transaction;

interface TransactionRepository
{
    public function get(UUid $transactionId): Transaction;

    public function save(Transaction $transaction): void;
}
