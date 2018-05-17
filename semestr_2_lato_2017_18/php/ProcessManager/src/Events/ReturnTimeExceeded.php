<?php

namespace Asgavar\ProcessManager\Events;

class ReturnTimeExceeded
{
    private $bookInstanceId;
    private $accountId;
    private $dateAsSecondsSinceJan1970;

    public function __construct(int $bookInstanceId,
                                int $accountId,
                                int $dateAsSecondsSinceJan1970)
    {
        $this->bookInstanceId = $bookInstanceId;
        $this->accountId = $accountId;
        $this->dateAsSecondsSinceJan1970 = $dateAsSecondsSinceJan1970;
    }
}
