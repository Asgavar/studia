<?php

namespace Asgavar\MoneyValueObject;


interface MoneyFormatterInterface
{
    public function format(Money $money): string;
}