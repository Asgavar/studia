<?php

namespace CartRules;

use CartRules\Cart;
use CartRules\PromoRule;

class ExtraItemPromo {

    /**
     * @var array
     */
    private $promoRules;

    public function __construct()
    {
        $this->promoRules = [];
    }

    public function isEligible(Cart $cart): bool
    {
        foreach ($this->promoRules as $promoRule)
        {
            if ($promoRule->isEligible($cart))
            {
                return true;
            }
        }

        return false;
    }

    public function registerPromoRule(PromoRule $promoRule): void
    {
        array_push($this->promoRules, $promoRule);
    }
}