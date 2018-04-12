<?php

namespace ReversePolishNotation;


use PHPUnit\Framework\TestCase;
use ReversePolishNotation\Functors\BinaryOperators\BinaryAddition;
use ReversePolishNotation\Functors\BinaryOperators\BinaryDivision;
use ReversePolishNotation\Functors\BinaryOperators\BinaryMultiplication;
use ReversePolishNotation\Functors\BinaryOperators\BinarySubstraction;
use ReversePolishNotation\Tokenizers\SpaceSeparatedTokenizer;

class RPNCalculatorTest extends TestCase
{

    /**
     * @dataProvider getDataForEvaluation
     * @param String $input
     * @param int $expectedResult
     */
    public function testEvaluation(String $input, int $expectedResult)
    {
        $rpnCalc = new RPNCalculator(
            new SpaceSeparatedTokenizer(),
            new BinaryAddition(),
            new BinarySubstraction(),
            new BinaryMultiplication(),
            new BinaryDivision()
        );

        $this->assertEquals(
            $expectedResult,
            $rpnCalc->evaluate($input)
        );
    }

    public function getDataForEvaluation()
    {
        return [
            ["2 3 +", 5],
            ["2 3 + 5 * 10 +", 35],
            ["12 1 -", 11],
            ["20 20 * 10 * 20 / 1 - 3 +", 202]
        ];
    }
}
