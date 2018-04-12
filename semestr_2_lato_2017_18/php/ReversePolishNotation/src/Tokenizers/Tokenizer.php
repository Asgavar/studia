<?php


namespace ReversePolishNotation\Tokenizers;


interface Tokenizer
{
    public function tokenize(string $input): array;
}