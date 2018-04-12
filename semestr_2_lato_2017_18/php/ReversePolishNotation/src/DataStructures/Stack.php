<?php


namespace ReversePolishNotation\DataStructures;


use ReversePolishNotation\Exceptions\EmptyStackException;

class Stack
{
    /**
     * @var array
     */
    private $innerArray = [];

    /**
     * @throws EmptyStackException
     */
    public function pop()
    {
        if (count($this->innerArray) == 0)
        {
            throw new EmptyStackException();
        }

        return array_pop($this->innerArray);
    }

    public function push($element): void
    {
        array_push($this->innerArray, $element);
    }
}