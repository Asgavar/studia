<?php

namespace RESTfulProducts\Controllers;

use RESTfulProducts\Serializers\ProductSerializerInterface;
use RESTfulProducts\StorageManagers\ProductStorageManagerInterface;


class ProductsGetIndividualController
{
    private $serializer;
    private $storageManager;
    private $productId;


    public function __construct(ProductSerializerInterface $serializer,
                                ProductStorageManagerInterface $storageManager,
                                $productId)
    {
        $this->serializer = $serializer;
        $this->storageManager = $storageManager;
        $this->productId = $productId;
    }


    public function __invoke()
    {
        return $this->serializer->serializedIndividual(
            $this->storageManager->loadProduct($this->productId)
        );
    }
}
