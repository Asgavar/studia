<?php

namespace Asgavar\ProcessManager\Events;

class BookReturned
{
    private $bookInstanceId;
    private $accountId;
    private $returnTimeAsSecondsSinceJan1970;

    public function __construct(int $bookInstanceId,
                                int $accountId,
                                int $returnTimeAsSecondsSinceJan1970)
    {
        $this->bookInstanceId = $bookInstanceId;
        $this->accountId = $accountId;
        $this->returnTimeAsSecondsSinceJan1970 = $returnTimeAsSecondsSinceJan1970;
    }
}
