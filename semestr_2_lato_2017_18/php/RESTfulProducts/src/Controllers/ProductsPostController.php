<?php

namespace RESTfulProducts\Controllers;

use Money\Money;

use RESTfulProducts\DataSpecifications\ProductIndividual;
use RESTfulProducts\Serializers\ProductSerializerInterface;
use RESTfulProducts\StorageManagers\ProductStorageManagerInterface;


/**
   Tworzy produkt z losowymi danymi.
 */
class ProductsPostController
{
    private $serializer;
    private $storageManager;
    private $newName;


    public function __construct(ProductSerializerInterface $serializer,
                                ProductStorageManagerInterface $storageManager,
                                string $newName)
    {
        $this->serializer = $serializer;
        $this->storageManager = $storageManager;
        $this->newName = $newName;
    }


    public function __invoke()
    {
        $newProduct = new ProductIndividual(
            -42,  // ehh
            $this->newName,
            Money::PLN(rand())
        );
        $this->storageManager->writeProduct($newProduct);
        return $newProduct->getID() . " zapisany!";
    }
}
