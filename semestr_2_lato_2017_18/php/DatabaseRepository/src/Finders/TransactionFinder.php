<?php

namespace Asgavar\DatabaseRepository\Finders;

interface TransactionFinder
{
    public function findAll(int $limit = 10, int $offset = 0);
}
