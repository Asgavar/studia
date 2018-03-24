<?php

namespace RESTfulProducts\DataSpecifications;

use Money\Money;


class ProductIndividual
{
    private $productId;
    private $productName;
    private $productPrice;


    public function __construct(int $productId,
                                string $productName,
                                Money $productPrice)
    {
        $this->productId = $productId;
        $this->productName = $productName;
        $this->productPrice = $productPrice;
    }


    public function getId(): int
    {
        return $this->productId;
    }


    public function getName(): string
    {
        return $this->productName;
    }


    public function getPrice(): Money
    {
        return $this->productPrice;
    }


    /**
     * ID ma jakikolwiek sens dopiero po zapisaniu produktu xD
     *
     * @param int $newId
     */
    public function setId(int $newId)
    {
        $this->productId = $newId;
    }
}
