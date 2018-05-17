<?php

namespace Asgavar\ProcessManager\EventHandlers;

use Asgavar\ProcessManager\Events\PenaltyFeeCalculated;

class RemoveBookFile
{
    public function __invoke(PenaltyFeeCalculated $event)
    {
        unlink("book_{$event->getBookInstanceId()}");
    }
}
