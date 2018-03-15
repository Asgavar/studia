<?php

namespace PHProducts\Product;

use Money\Money;


class DiscountedProduct implements IProduct
{
    /**
     * @var float
     */
    private $priceModifier;
    /**
     * @var Product
     */
    private $product;
    
    
    public function __construct(Product $product, int $discountInPercents)
    {
        $discountAsFloat = (100 - $discountInPercents) / 100;
        $this->product = $product;
        $this->priceModifier = $discountAsFloat;
    }


    public function getName(): string
    {
        return $this->product->getName();
    }
    
    
    public function getPrice(): Money
    {
        $newPrice = clone $this->product->getPrice();
        $newPrice->multiply($this->priceModifier);
        return $newPrice;
    }
}