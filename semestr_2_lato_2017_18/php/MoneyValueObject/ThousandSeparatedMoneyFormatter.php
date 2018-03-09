<?php

namespace Asgavar\MoneyValueObject;


class ThousandSeparatedMoneyFormatter implements MoneyFormatterInterface
{
    private $thousandSeparator;
    private $decimalSeparator;


    public function __construct(string $thousandSeparator, string $decimalSeparator)
    {
        $this->thousandSeparator = $thousandSeparator;
        $this->decimalSeparator = $decimalSeparator;
    }


    public function format(Money $money): string
    {
        $currency = $money->getCurrency();
        $units = $money->getUnits();
        $subUnits = $money->getSubunits() / $currency->getSubunitsPerUnit();
        $total = $units + $subUnits;
        $decimal_places = strlen($money->getCurrency()->getSubunitsPerUnit());
        $decimal_places -= 1;  // na przykład: 1/1000 = 0.001
        return number_format($total, $decimal_places, $this->decimalSeparator,
            $this->thousandSeparator) . " " . $currency->getShortName() . PHP_EOL;
    }
}