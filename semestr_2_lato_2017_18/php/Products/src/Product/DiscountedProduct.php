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
    
    
    public function __construct(IProduct $product, int $discountInPercents)
    {
        $discountAsFloat = (100 - $discountInPercents) / 100;
        $this->product = $product;
        $this->priceModifier = $discountAsFloat;
    }


    public function getName(): string
    {
        return "[PRZECENIONY] " . $this->product->getName();
    }
    
    
    public function getPrice(): Money
    {
        $newPrice = $this->product->getPrice()->multiply($this->priceModifier);
        return $newPrice;
    }
}