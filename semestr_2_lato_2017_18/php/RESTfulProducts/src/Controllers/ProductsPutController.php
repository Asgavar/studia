<?php

namespace RESTfulProducts\Controllers;

use Money\Money;

use RESTfulProducts\DataSpecifications\ProductIndividual;
use RESTfulProducts\Serializers\ProductSerializerInterface;
use RESTfulProducts\StorageManagers\ProductStorageManagerInterface;


class ProductsPutController
{
    private $serializer;
    private $storageManager;
    private $oldId;
    private $newName;
    private $newPrice;


    public function __construct(ProductSerializerInterface $serializer,
                                ProductStorageManagerInterface $storageManager,
                                int $oldId,
                                string $newName)
    {
        $this->serializer = $serializer;
        $this->storageManager = $storageManager;
        $this->oldId = $oldId;
        $this->newName = $newName;
        $this->newPrice = Money::PLN(rand());
    }


    public function __invoke()
    {
        $newProduct = new ProductIndividual(
            $this->oldId,
            $this->newName,
            Money::PLN(rand())
        );
        $this->storageManager->insertProduct($this->oldId, $newProduct);

        return $newProduct->getID() . " nadpisany!";
    }
}
