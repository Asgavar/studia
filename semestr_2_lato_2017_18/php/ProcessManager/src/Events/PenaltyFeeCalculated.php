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

    /**
     * @return int
     */
    public function getBookInstanceId()
    {
        return $this->bookInstanceId;
    }

    /**
     * @return int
     */
    public function getAccountId()
    {
        return $this->accountId;
    }

    /**
     * @return int
     */
    public function getFeeAmount()
    {
        return $this->feeAmount;
    }

    /**
     * @return int
     */
    public function getDateAsSecondsSinceJan1970()
    {
        return $this->dateAsSecondsSinceJan1970;
    }
}
