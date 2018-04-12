<?php


namespace ReversePolishNotation\Functors\BinaryOperators;


use ReversePolishNotation\Functors\RpnFunctor;

class BinaryDivision implements RpnFunctor
{

    public function getArity(): int
    {
        return 2;
    }

    public function evaluate(int ...$operands): int
    {
        return $operands[0] / $operands[1];
    }

    public function doesSymbolReferTo(string $symbol): bool
    {
        return $symbol == "/";
    }
}