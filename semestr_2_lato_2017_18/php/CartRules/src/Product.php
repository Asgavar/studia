<?php

namespace CartRules;

use Money\Money;

interface Product
{
    public function getName(): string;

    public function getPrice(): Money;
}