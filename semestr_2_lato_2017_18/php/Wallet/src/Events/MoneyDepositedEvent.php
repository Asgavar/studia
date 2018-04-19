<?php

namespace Wallet\Events;

use Money\Money;
use Wallet\Interfaces\Event;

class MoneyDepositedEvent implements Event
{
    private $difference;

    public function __construct(Money $amount)
    {
        $this->difference = $amount;
    }

    /**
     * @return Money
     */
    public function getDifference(): Money
    {
        return $this->difference;
    }
}
