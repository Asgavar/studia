<?php

require "../vendor/autoload.php";

//$loader = new \Composer\Autoload\ClassLoader();
//$loader->register();
//$loader->addPsr4("PHProducts", ".");

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

$bundleOfAllThree->addProduct($product1);
$bundleOfAllThree->addProduct($product2);
$bundleOfAllThree->addProduct($discounted1);
$discountedBundle = new DiscountedProduct($bundleOfAllThree, 10);


$products = [
    $product1,
    $product2,
    $discounted1,
    $bundleOfAllThree,
    $discountedBundle
];

foreach ($products as $product)
{
    echo $product->getName();
    echo " kosztuje: ";
    echo $product->getPrice()->getAmount() . PHP_EOL;
    $totalPrice = $totalPrice->add($product->getPrice());
}

echo "Cena wszystkich: {$totalPrice->getAmount()}";