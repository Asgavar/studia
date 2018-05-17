<?php

namespace Asgavar\ProcessManager\EventHandlers;

use Asgavar\ProcessManager\Events\BookLent;

class CreateNewBookFile
{
    public function __invoke(BookLent $event)
    {
        echo $event->getBookInstanceId() . PHP_EOL;
        echo $event->getAccountId() . PHP_EOL;
        echo $event->getDateAsSecondsSinceJan1970() . PHP_EOL;
    }
}
