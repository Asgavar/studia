<?php

namespace CartRules;

use Money\Money;

class StandardProduct implements Product
{
    /**
     * @var string
     */
    private $name;
    /**
     * @var Money
     */
    private $price;

    public function __construct(string $name, Money $price)
    {
        $this->name = $name;
        $this->price = $price;
    }

    public function getName(): string
    {
        return $this->name;
    }

    public function getPrice(): Money
    {
        return $this->price;
    }
}