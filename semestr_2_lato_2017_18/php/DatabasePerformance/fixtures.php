<?php

echo 'UWAGA';
echo $ha;
include('kek.txt');
echo $zmienna;

return [
    \Asgavar\DatabasePerformance\Entities\Transaction::class => [
        'transaction{1..'.$howManyTransactionsToCreate.'}' => [
            'pos_id' => '<randomNumber()>',
            'date_time' => '<dateTime()>',
            'amount' => '<numberBetween(0, 9999999)>',  // TODO
            'title' => '<text()>'
        ]
    ]
];
