<?php

namespace Wallet\Interfaces;

use Money\Money;

interface BalanceChangedEvent extends Event
{
    public function getChange(): Money;
}
