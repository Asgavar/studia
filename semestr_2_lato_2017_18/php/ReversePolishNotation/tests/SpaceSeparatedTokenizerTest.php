<?php

namespace ReversePolishNotation\Tokenizers;


use PHPUnit\Framework\TestCase;

class SpaceSeparatedTokenizerTest extends TestCase
{
    /**
     * @dataProvider getDataForTokenizing
     * @param string $input
     * @param array $expectedOutput
     */
    public function testTokenizing(string $input, array $expectedOutput)
    {
        $tokenizer = new SpaceSeparatedTokenizer();

        $this->assertEquals(
            $expectedOutput,
            $tokenizer->tokenize($input)
        );
    }

    public function getDataForTokenizing()
    {
        return [
            ["1 2 +", ["1", "2", "+"]],
            ["999 17 /", ["999", "17", "/"]]
        ];
    }
}
