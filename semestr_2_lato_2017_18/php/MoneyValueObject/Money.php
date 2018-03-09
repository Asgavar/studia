<?php

namespace Asgavar\MoneyValueObject;


class Money
{
    private $currency;
    private $value;


    public function __construct(Currency $currency, float $initial_value=0.0)
    {
        $this->currency = $currency;
        $this->value = $this->float_to_value($initial_value);
    }


    private function float_to_value(float $float_value): int
    {
        $int_value = $float_value * $this->currency->getSubunitsPerUnit();
        // czy otrzymaliśmy liczbę całkowitą?
        var_dump($int_value, $float_value, floor($int_value), ceil($int_value));
        if (floor($int_value) == ceil($int_value))
            return (int)$int_value;
        throw new \InvalidArgumentException("Czyżby za dużo miejsc po przecinku?");
    }


    private function ensureCurrenciesAreOfSameType(Money $money1, Money $money2): void
    {
       if ($money1->getCurrency() !== $money2->getCurrency())
       {
           throw new \InvalidArgumentException("Operacja na różnych walutach!");
       }
    }


    /**
     * Nie rzuca wyjątków jeśli waluty się zgadzają.
     *
     * @param Money $money
     */
    public function add(Money $money): void
    {
        $this->ensureCurrenciesAreOfSameType($this, $money);
        $this->value += $money->getValue();
    }


    /**
     * Rzuca wyjątek przy próbie odejmowania, które dałoby liczbę ujemną.
     *
     * @param Money $money
     *
     * @throws \ArithmeticError
     */
    public function substract(Money $money): void
    {
        $this->ensureCurrenciesAreOfSameType($this, $money);
        if ($money->getValue() > $this->value)
            throw new \ArithmeticError("Odejmowanie większej od mniejszej!");
        $this->value -= $money->getValue();
    }


    /**
     * Rzuca wyjątek, jeśli multiplier jest ujemny.
     *
     * @param int $multiplier
     *
     * @throws \InvalidArgumentException
     */
    public function multiply(int $multiplier): void
    {
        if ($multiplier < 0)
            throw new \InvalidArgumentException("Mnożenie przez liczbę ujemną!");
        $this->value *= $multiplier;
    }


    /**
     * Rzuca wyjątek przy dzieleniu przez zero.
     *
     * @param int $divisor
     *
     * @throws \DivisionByZeroError
     */
    public function divide(int $divisor): void
    {
        if ($divisor == 0)
            throw new \DivisionByZeroError("Dzielenie przez zero!");
        $this->value /= $divisor;
    }


    /**
     * Zwraca CYFRY pełnych jednostek.
     *
     * @return int
     */
    public function getUnits(): int
    {
        return floor($this->value / $this->currency->getSubunitsPerUnit());
    }


    /**
     * Zwraca CYFRY podjednostek.
     *
     * @return int
     */
    public function getSubunits(): int
    {
        return $this->value % $this->currency->getSubunitsPerUnit();
    }


    /**
     * @return Currency
     */
    public function getCurrency(): Currency
    {
        return $this->currency;
    }


    /**
     * @return int
     */
    public function getValue(): int
    {
        return $this->value;
    }
}