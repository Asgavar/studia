<?php

require_once('./vendor/autoload.php');

use Asgavar\DatabasePerformance\Entities\Transaction;
include('superAPI.php');

return [
    Transaction::class => [
        'transaction{1..'.$howManyTransactionsToCreate.'}' => [
            'pos_id' => '<randomNumber()>',
            'date_time' => '<dateTime()>',
            'amount' => '<randomFloat()>',
            'title' => '<sentence()>'
        ]
    ]
];
