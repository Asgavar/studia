<?php


namespace CartRules;


class CombinedPromoRule implements PromoRule
{
    /**
     * @var array
     */
    private $rules;

    public function __construct(PromoRule ...$promoRules)
    {
        $this->rules = [];

        foreach ($promoRules as $promoRule)
        {
            array_push($this->rules, $promoRule);
        }
    }

    public function isEligible(Cart $cart): bool
    {
        foreach ($this->rules as $promoRule)
        {
            if (! $promoRule->isEligible($cart))
            {
                return false;
            }
        }

        return true;
    }
}