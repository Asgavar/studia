<?php

namespace RESTfulProducts\StorageManagers;

use RESTfulProducts\DataSpecifications\ProductCollection;
use RESTfulProducts\DataSpecifications\ProductIndividual;


interface ProductStorageManagerInterface
{
    public function loadProduct(int $productId): ProductIndividual;
    public function loadAllProducts(): ProductCollection;
    public function writeProduct(ProductIndividual $product): void;
    public function insertProduct(int $productId, ProductIndividual $product): void;
    public function deleteProduct(int $productId): void;
    public function getProductsCount(): int;
}
