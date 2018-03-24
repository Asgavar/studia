<?php

namespace RESTfulProducts\Controllers;

use RESTfulProducts\Serializers\ProductSerializerInterface;
use RESTfulProducts\StorageManagers\ProductStorageManagerInterface;


class ProductsDeleteController
{
    private $serializer;
    private $storageManager;
    private $productId;


    public function __construct(ProductSerializerInterface $serializer,
                                ProductStorageManagerInterface $storageManager,
                                $idToDelete)
    {
        $this->serializer = $serializer;
        $this->storageManager = $storageManager;
        $this->productId = $idToDelete;
    }


    public function __invoke()
    {
        $this->storageManager->deleteProduct($this->productId);
        return "Usunieto produkt nr " . $this->productId;
    }
}

