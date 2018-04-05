<?php require_once "../vendor/autoload.php";

use CartRules\Cart;
use CartRules\CombinedPromoRule;
use CartRules\ContainsProductWithNameLikePromoRule;
use CartRules\ExtraItemPromo;
use CartRules\ItemsCountGreaterThanPromoRule;
use CartRules\StandardProduct;
use CartRules\TotalSumGreaterThanPromoRule;
use Money\Money;

$cart = new Cart();

$cart->addProduct(
    new StandardProduct("Czapka Uszanka", Money::PLN(20))
);

$cart->addProduct(
    new StandardProduct("Banany", Money::PLN(3))
);

$cart->addProduct(
    new StandardProduct("Składający się z wielu słów telewizor kolorowy", Money::PLN(1500))
);

$promo1 = new ExtraItemPromo();
$promo2 = new ExtraItemPromo();
$promo3 = new ExtraItemPromo();

$promo1->registerPromoRule(
    new ContainsProductWithNameLikePromoRule("TELEWIZOR")
);

$promo2->registerPromoRule(
    new TotalSumGreaterThanPromoRule(2000)
);

$promo3->registerPromoRule(
    new CombinedPromoRule(
        new TotalSumGreaterThanPromoRule(100),
        new ItemsCountGreaterThanPromoRule(2)
    )
);

echo "Promocja 1, powinien się na nią łapać: " . $promo1->isEligible($cart) . PHP_EOL;
echo "Promocja 2, na nią _nie_ powinien się łapać: " . $promo2->isEligible($cart) . PHP_EOL;
echo "Promocja 3, na nią także powinien się łapać: " . $promo3->isEligible($cart) . PHP_EOL;
