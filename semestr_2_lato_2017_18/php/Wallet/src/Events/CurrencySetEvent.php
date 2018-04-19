<?php


namespace Wallet\Events;


use Money\Currency;
use Wallet\Interfaces\Event;

class CurrencySetEvent implements Event
{
    /**
     * @var Currency
     */
    private $currency;

    public function __construct(Currency $currency)
    {
        $this->currency = $currency;
    }

    /**
     * @return Currency
     */
    public function getCurrency(): Currency
    {
        return $this->currency;
    }
}