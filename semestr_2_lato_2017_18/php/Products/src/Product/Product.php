<?php

namespace PHProducts\Product;

use Money\Money;


class Product implements IProduct
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