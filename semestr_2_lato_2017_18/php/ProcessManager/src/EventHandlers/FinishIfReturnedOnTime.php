<?php

namespace Asgavar\ProcessManager\EventHandlers;

use Prooph\ServiceBus\EventBus;
use Asgavar\ProcessManager\Events\LendProcessSuccesfullyFinished;
use Asgavar\ProcessManager\Events\PenaltyFeeCalculated;

class FinishIfReturnedOnTime
{
    private $eventBus;

    public function __construct(EventBus $eventBus)
    {
        $this->eventBus = $eventBus;
    }

    public function __invoke(PenaltyFeeCalculated $event)
    {
        if ($event->getFeeAmount() == 0)
            $this->emitLendProcessSuccesfullyFinishedEvent($event);
    }

    private function emitLendProcessSuccesfullyFinishedEvent(PenaltyFeeCalculated $previousEvent)
    {
        $this->eventBus->dispatch(
            new LendProcessSuccesfullyFinished(
                $previousEvent->getBookInstanceId(),
                $previousEvent->getAccountId(),
                $previousEvent->getDateAsSecondsSinceJan1970()
            )
        );
    }
}
