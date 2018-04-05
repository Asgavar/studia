<?php


namespace CartRules;


class TotalSumGreaterThanPromoRule implements PromoRule
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
        return $cart->getTotalPrice()->getAmount() > $this->eligibilityThreshold;
    }
}