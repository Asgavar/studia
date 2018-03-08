<?php

namespace Asgavar\MoneyValueObject;


class Currency
{
    private $full_name;
    private $short_name;
    private $subunitsPerUnit;


    public function __construct($full_name, $short_name, $subunitsPerUnit)
    {
        $this->full_name = $full_name;
        $this->short_name = $short_name;
        $this->subunitsPerUnit = $subunitsPerUnit;
    }


    /**
     * @return string
     */
    public function getFullName(): string
    {
        return $this->full_name;
    }


    /**
     * @return string
     */
    public function getShortName(): string
    {
        return $this->short_name;
    }


    /**
     * @return int
     */
    public function getSubunitsPerUnit(): int
    {
        return $this->subunitsPerUnit;
    }
}