<?php

namespace Asgavar\ProcessManager\EventHandlers;

use Prooph\ServiceBus\EventBus;
use Asgavar\ProcessManager\Events\PenaltyFeePaid;
use Asgavar\ProcessManager\Events\LendProcessSuccesfullyFinished;

class AcceptPenaltyFeePayment
{
    private $eventBus;

    public function __construct(EventBus $eventBus)
    {
        $this->eventBus = $eventBus;
    }

    public function __invoke(PenaltyFeePaid $event)
    {
        $debtFileName = $this->constructDebtFileName(
            $event->getBookInstanceId(),
            $event->getAccountId()
        );
        $amountPaid = $event->getPaymentAmount();
        $previousDebt = $this->readCurrentDebtFromDebtFile($debtFileName);
        if ($amountPaid >= $previousDebt)
        {
            $this->removeDebtFile($debtFileName);
            $this->emitLendProcessSuccessfullyFinishedEvent($event);
        }
        else
        {
            $this->updateDebtFile($debtFileName, $previousDebt - $amountPaid);
        }
    }

    private function constructDebtFileName(int $bookId, int $accountId)
    {
        return "debt_account_{$bookId}_book_{$accountId}";
    }

    private function readCurrentDebtFromDebtFile(String $filename): int
    {
        return intval(file_get_contents($filename));
    }

    private function removeDebtFile(String $filename)
    {
        unlink($filename);
    }

    private function updateDebtFile(String $filename, int $newDebt)
    {
        file_put_contents($filename, $newDebt);
    }

    private function emitLendProcessSuccessfullyFinishedEvent(PenaltyFeePaid $previousEvent)
    {
        $this->eventBus->dispatch(
            new LendProcessSuccesfullyFinished(
                $previousEvent->getBookInstanceId(),
                $previousEvent->getAccountId(),
                $previousEvent->getPaymentDateAsSecondsSinceJan1970()
            )
        );
    }
}
