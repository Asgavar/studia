<?php


namespace CartRules;


class ItemsCountGreaterThanPromoRule implements PromoRule
{
    /**
     * @var int
     */
    private $eligibilityThreshold;

    public function __construct(int $thanWhat)
    {
        $this->eligibilityThreshold = $thanWhat;
    }

    public function isEligible(Cart $cart): bool
    {
        return count($cart) > $this->eligibilityThreshold;
    }
}