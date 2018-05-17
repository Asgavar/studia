<?php

namespace Asgavar\ProcessManager\EventHandlers;

use Asgavar\ProcessManager\Events\ReturnTimeExceeded;

class RemindReaderAboutReturnTime
{
    public function __invoke(ReturnTimeExceeded $event)
    {
        echo "PRZEKROCZONO CZAS ODDDANIA" . PHP_EOL;
    }
}
