<?php

namespace RESTfulProducts\Serializers;

use RESTfulProducts\DataSpecifications\ProductIndividual;
use RESTfulProducts\DataSpecifications\ProductCollection;

interface ProductSerializerInterface
{
    public function serializedIndividual(ProductIndividual $product);
    public function serializedCollection(ProductCollection $productCollection);
}
