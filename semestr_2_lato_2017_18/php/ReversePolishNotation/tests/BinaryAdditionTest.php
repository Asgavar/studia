<?php


use PHPUnit\Framework\TestCase;
use ReversePolishNotation\Functors\BinaryOperators\BinaryAddition;

class BinaryAdditionTest extends TestCase
{
    /**
     * @dataProvider getDataForEvalutaion
     */
    public function testEvaluation(int $a, int $b, int $expectedSum)
    {
        $instance = new BinaryAddition();
        $this->assertEquals($expectedSum, $instance->evaluate($a, $b));
    }

    public function getDataForEvalutaion()
    {
        return [
            [1, 2, 3],
            ["1", "2", "3"],
            [5, -5, 0],
            [-42, -42, -84],
        ];
    }
}
