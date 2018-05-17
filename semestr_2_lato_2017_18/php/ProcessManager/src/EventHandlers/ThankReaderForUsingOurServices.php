<?php

namespace Asgavar\ProcessManager\EventHandlers;

use Asgavar\ProcessManager\Events\LendProcessSuccesfullyFinished;

class ThankReaderForUsingOurServices
{
    public function __invoke(LendProcessSuccesfullyFinished $event)
    {
        echo "PEŁEN SUKCES!" . PHP_EOL;
    }
}
