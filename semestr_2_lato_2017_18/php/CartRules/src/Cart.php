<?php

namespace CartRules;

use Money\Money;

class Cart implements \Countable
{
    /**
     * @var array
     */
    private $products;

    public function __construct()
    {
        $this->products = [];
    }

    public function count(): int
    {
        return count($this->products);
    }

    public function getTotalPrice(): Money
    {
        $sumOfAllProducts = Money::PLN(0);
        foreach ($this->products as $product)
        {
            $sumOfAllProducts = $sumOfAllProducts->add($product->getPrice());
        }

        return $sumOfAllProducts;
    }

    public function addProduct(Product $product): void
    {
        array_push($this->products, $product);
    }

    public function getProducts(): array
    {
        return $this->products;
    }
}