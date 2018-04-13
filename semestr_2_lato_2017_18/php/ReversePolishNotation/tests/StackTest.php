<?php

use PHPUnit\Framework\TestCase;
use ReversePolishNotation\DataStructures\Stack;
//use ReversePolishNotation\Exceptions\EmptyStackException;

class StackTest extends TestCase
{

    /**
     * @var Stack
     */
    private $stack;

    /**
     * @before
     */
    public function setupEach()
    {
        $this->stack = new Stack();
    }

    /**
     * @dataProvider getDataForPushAndPop
     */
    public function testStackPushAndPop($elem)
    {
        $this->stack->push($elem);
        $popped = $this->stack->pop();

        $this->assertEquals($elem, $popped);
    }

    public function getDataForPushAndPop()
    {
        return [
            [1],
            ["42"],
            ["+"]
        ];
    }

    /**
     * @expectedException \ReversePolishNotation\Exceptions\EmptyStackException
     */
    public function testPoppingFromEmptyStackThrowsException()
    {
        $this->stack->pop();
    }
}