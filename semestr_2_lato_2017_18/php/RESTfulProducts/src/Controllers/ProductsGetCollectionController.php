<?php

namespace RESTfulProducts\Controllers;

use RESTfulProducts\Serializers\ProductSerializerInterface;
use RESTfulProducts\StorageManagers\ProductStorageManagerInterface;

class ProductsGetCollectionController
{
    private $serializer;
    private $storageManager;


    public function __construct(ProductSerializerInterface $serializer,
                                ProductStorageManagerInterface $storageManager)
    {
        $this->serializer = $serializer;
        $this->storageManager = $storageManager;
    }


    public function __invoke()
    {
        return $this->serializer->serializedCollection(
            $this->storageManager->loadAllProducts()
        );
    }
}
