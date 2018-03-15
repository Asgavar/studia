<?php

namespace PHProducts\Product;

use Ds\Vector;
use Money\Money;


class Bundle implements IProductCollection, \IteratorAggregate
{
    /**
     * @var string
     */
    private $name;
    /**
     * @var Vector
     */
    private $productsInside;
    /**
     * @var Money
     */
    private $sumOfPrices;
    
    
    public function __construct(string $name, Money $initialPrice)
    {
        $this->name = $name;
        $this->sumOfPrices = $initialPrice;
        $this->productsInside = new Vector();
    }
    
    
    public function getName(): string
    {
        return $this->name;
    }
    
    
    public function getPrice(): Money
    {
        return $this->sumOfPrices;
    }
    
    
    public function addProduct(Product $product): void
    {
        $this->productsInside->push($product);
        $this->sumOfPrices->add($product->getPrice());
    }
    
    
    public function getIterator()
    {
        return new \ArrayIterator($this->productsInside->toArray());
    }
}