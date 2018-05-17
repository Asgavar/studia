<?php

namespace Asgavar\ProcessManager\Events;

class PenaltyFeePaid
{
    private $bookInstanceId;
    private $accountId;
    private $paymentAmount;
    private $paymentDateAsSecondsSinceJan1970;

    public function __construct(int $bookInstanceId,
                                int $accountId,
                                int $paymentAmount,
                                int $paymentDateAsSecondsSinceJan1970)
    {
        $this->bookInstanceId = $bookInstanceId;
        $this->accountId = $accountId;
        $this->paymentAmount = $paymentAmount;
        $this->paymentDateAsSecondsSinceJan1970 = $paymentDateAsSecondsSinceJan1970;
    }
}
