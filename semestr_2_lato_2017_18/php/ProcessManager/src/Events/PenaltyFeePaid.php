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
    public function getPaymentAmount()
    {
        return $this->paymentAmount;
    }

    /**
     * @return int
     */
    public function getPaymentDateAsSecondsSinceJan1970()
    {
        return $this->paymentDateAsSecondsSinceJan1970;
    }
}
