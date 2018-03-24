<?php

namespace RESTfulProducts\Serializers;

use RESTfulProducts\DataSpecifications\ProductCollection;
use RESTfulProducts\DataSpecifications\ProductIndividual;


class JSONProductSerializer implements ProductSerializerInterface
{
    public function serializedIndividual(ProductIndividual $product): string
    {
        return json_encode(
            $this->makeProductFieldsArray($product),
            JSON_PRETTY_PRINT
        );
    }


    public function serializedCollection(ProductCollection $productCollection): string
    {
        $productsArray = [];

        foreach ($productCollection->getProducts() as $product)
        {
            array_push($productsArray, $this->makeProductFieldsArray($product));
        }

        return json_encode(
            array(
                "products" => $productsArray
            ),
            JSON_PRETTY_PRINT
        );
    }


    private function makeProductFieldsArray(ProductIndividual $product)
    {
        return array(
            "id" => $product->getId(),
            "name" => $product->getName(),
            "price" => $product->getPrice()
        );
    }
}
