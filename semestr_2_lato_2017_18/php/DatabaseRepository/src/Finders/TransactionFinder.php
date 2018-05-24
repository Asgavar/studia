<?php

namespace Asgavar\Finders;

interface TransactionFinder
{
    public function findAll(int $limit = 10, int $offset = 0);
}
