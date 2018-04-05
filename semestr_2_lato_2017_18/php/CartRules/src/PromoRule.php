<?php

namespace CartRules;

interface PromoRule
{
    public function isEligible(Cart $cart): bool;
}