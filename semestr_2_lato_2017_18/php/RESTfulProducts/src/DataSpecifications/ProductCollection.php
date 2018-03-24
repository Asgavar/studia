<?php

namespace RESTfulProducts\DataSpecifications;

use RESTfulProducts\DataSpecifications\ProductIndividual;


class ProductCollection
{
    private $productsArray;


    public function __construct()
    {
        $this->productsArray = [];
    }


    public function getProducts(): array
    {
        return $this->productsArray;
    }


    public function addProduct(ProductIndividual $product): void
    {
        array_push($this->productsArray, $product);
    }
}
