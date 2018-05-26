<?php

namespace Asgavar\DatabaseRepository\Aggregates;

use Ramsey\Uuid\Uuid;
use Money\Money;
use MyCLabs\Enum\Enum;

class Transaction
{
    private $uuid;
    private $amount;
    private $fromAccount;
    private $toAccount;
    private $status;

    public function __construct(Uuid $uuid,
                                Money $amount,
                                String $fromAccount,
                                String $toAccount,
                                Enum $status)
    {
        $this->uuid = $uuid;
        $this->amount = $amount;
        $this->fromAccount = $fromAccount;
        $this->toAccount = $toAccount;
        $this->status = $status;
    }

    public function getUuid(): Uuid
    {
        return $this->uuid;
    }

    public function setAmount(Money $newAmount)
    {
        $this->amount = $newAmount;
    }
}
