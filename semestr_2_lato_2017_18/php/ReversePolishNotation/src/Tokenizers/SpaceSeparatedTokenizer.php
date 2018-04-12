<?php


namespace ReversePolishNotation\Tokenizers;


class SpaceSeparatedTokenizer implements Tokenizer
{

    public function tokenize(string $input): array
    {
        return preg_split("/ /", $input);
    }
}