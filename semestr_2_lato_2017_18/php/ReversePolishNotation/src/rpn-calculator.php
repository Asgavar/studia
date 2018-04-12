<?php

require_once("../vendor/autoload.php");

use ReversePolishNotation\Functors\BinaryOperators\BinaryAddition;
use ReversePolishNotation\Functors\BinaryOperators\BinaryDivision;
use ReversePolishNotation\Functors\BinaryOperators\BinaryMultiplication;
use ReversePolishNotation\Functors\BinaryOperators\BinarySubstraction;
use ReversePolishNotation\RPNCalculator;
use ReversePolishNotation\Tokenizers\SpaceSeparatedTokenizer;


$rpnCalc = new RPNCalculator(
    new SpaceSeparatedTokenizer(),
    new BinaryAddition(),
    new BinarySubstraction(),
    new BinaryMultiplication(),
    new BinaryDivision()
);

$result = $rpnCalc->evaluate(
    $argv[1]
);

echo $result . PHP_EOL;