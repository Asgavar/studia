<?php

require "../vendor/autoload.php";

$loader = new \Composer\Autoload\ClassLoader();
$loader->register();
$loader->add("PHProducts", ".");

use Money\Money;
use PHProducts\Product\Product;
use PHProducts\Product\DiscountedProduct;
use PHProducts\Product\Bundle;


$totalPrice = Money::PLN(0);

$product1 = new Product("produkt 1", Money::PLN(10000));
$product2 = new Product("produkt 2", Money::PLN(10000));
$discounted1 = new DiscountedProduct($product1, 75);
$bundleOfAllThree = new Bundle(
    "Trzy produkty w cenie trzech", Money::PLN(0)
);


$products = [
    $product1,
    $product2,
    $discounted1,
    $bundleOfAllThree
];

foreach ($products as $product)
{
    echo $product->getName() . PHP_EOL;
    $totalPrice = $totalPrice->add($product->getPrice);
}

echo "Cena wszystkich: {$totalPrice}";