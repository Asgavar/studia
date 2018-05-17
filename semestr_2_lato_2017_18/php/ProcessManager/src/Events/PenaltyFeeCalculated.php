<?php

namespace Asgavar\ProcessManager\Events;

class PenaltyFeeCalculated
{
    private $bookInstanceId;
    private $accountId;
    private $feeAmount;
    private $dateAsSecondsSinceJan1970;

    public function __construct(int $bookInstanceId,
                                int $accountId,
                                int $feeAmount,
                                int $dateAsSecondsSinceJan1970)
    {
        $this->bookInstanceId = $bookInstanceId;
        $this->accountId = $accountId;
        $this->feeAmount = $feeAmount;
        $this->dateAsSecondsSinceJan1970 = $dateAsSecondsSinceJan1970;
    }
}
