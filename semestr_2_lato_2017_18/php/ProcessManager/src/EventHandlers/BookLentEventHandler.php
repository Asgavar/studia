<?php

namespace Asgavar\ProcessManager\EventHandlers;

use Asgavar\ProcessManager\Events\BookLent;

class BookLentEventHandler
{
    public function handle(BookLent $event)
    {
        echo $event->getBookInstanceId() . PHP_EOL;
        echo $event->getAccountId() . PHP_EOL;
        echo $event->getDateAsSecondsSinceJan1970() . PHP_EOL;
    }
}
