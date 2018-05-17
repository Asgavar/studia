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
    public function getReturnTimeAsSecondsSinceJan1970()
    {
        return $this->returnTimeAsSecondsSinceJan1970;
    }
}
