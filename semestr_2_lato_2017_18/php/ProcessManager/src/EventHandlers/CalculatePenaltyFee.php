<?php

namespace Asgavar\ProcessManager\EventHandlers;

use Prooph\ServiceBus\EventBus;
use Asgavar\ProcessManager\Events\BookReturned;
use Asgavar\ProcessManager\Events\PenaltyFeeCalculated;
use Asgavar\ProcessManager\Events\ReturnTimeExceeded;

class CalculatePenaltyFee
{
    private $eventBus;

    public function __construct(EventBus $eventBus)
    {
        $this->eventBus = $eventBus;
    }

    public function __invoke(BookReturned $event)
    {
        $lendTime = $this->readLendTimeFromBookFile($event->getBookInstanceId());
        $returnTime = $event->getReturnTimeAsSecondsSinceJan1970();
        if ($returnTime - $lendTime > 100)
        {
            $this->emitReturnTimeExceededEvent($event);
            $penaltyFee = 100;
        }
        else
        {
            $penaltyFee = 0;
        }
        $this->emitPenaltyFeeCalculatedEvent($penaltyFee, $event);
    }

    private function readLendTimeFromBookFile(String $bookInstanceId): int
    {
        $bookFileName = "book_{$bookInstanceId}";
        $bookFileContents = file_get_contents($bookFileName);
        return intval(explode(PHP_EOL, $bookFileContents)[1]);
    }

    private function emitReturnTimeExceededEvent(BookReturned $returnEvent)
    {
        $this->eventBus->dispatch(
            new ReturnTimeExceeded(
                $returnEvent->getBookInstanceId(),
                $returnEvent->getAccountId(),
                $returnEvent->getReturnTimeAsSecondsSinceJan1970()
            )
        );
    }

    private function emitPenaltyFeeCalculatedEvent(int $penaltyFee,
                                                   BookReturned $returnEvent)
    {
        $this->eventBus->dispatch(
            new PenaltyFeeCalculated(
                $returnEvent->getBookInstanceId(),
                $returnEvent->getAccountId(),
                $penaltyFee,
                $returnEvent->getReturnTimeAsSecondsSinceJan1970()
            )
        );
    }
}
