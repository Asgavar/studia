<?php

namespace Asgavar\ProcessManager\EventHandlers;

use Asgavar\ProcessManager\Events\PenaltyFeeCalculated;

class CreateNewDebtFile
{
    public function __invoke(PenaltyFeeCalculated $event)
    {
        if ($event->getFeeAmount() == 0)
            return;
        $debtFileName =
            "debt_account_{$event->getAccountId()}_book_{$event->getBookInstanceId()}";
        file_put_contents($debtFileName, $event->getFeeAmount());
    }
}
