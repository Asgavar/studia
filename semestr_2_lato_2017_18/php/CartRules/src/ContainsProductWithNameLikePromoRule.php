<?php


namespace CartRules;


class ContainsProductWithNameLikePromoRule implements PromoRule
{
    /**
     * @var string
     */
    private $regexPattern;

    public function __construct(string $wordToSearchFor)
    {
        /* dopasowanie jest case-insensitive */
        $this->regexPattern = "/" . $wordToSearchFor . "/i";
    }

    public function isEligible(Cart $cart): bool
    {
        foreach ($cart->getProducts() as $product)
        {
            if (preg_match($this->regexPattern, $product->getName()))
            {
                return true;
            }
        }

        return false;
    }
}