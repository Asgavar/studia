<?php


namespace ReversePolishNotation\Functors;


interface RpnFunctor
{
    public function doesSymbolReferTo(string $symbol): bool;
    public function getArity(): int;
    public function evaluate(int ...$operands): int;
}