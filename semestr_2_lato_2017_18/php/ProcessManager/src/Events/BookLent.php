<?php

namespace Asgavar\ProcessManager\Events;

class BookLent
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
    public function getDateAsSecondsSinceJan1970()
    {
        return $this->dateAsSecondsSinceJan1970;
    }
}
