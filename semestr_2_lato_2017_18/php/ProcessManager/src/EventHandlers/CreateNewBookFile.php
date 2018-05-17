<?php

namespace Asgavar\ProcessManager\EventHandlers;

use Asgavar\ProcessManager\Events\BookLent;

class CreateNewBookFile
{
    public function __invoke(BookLent $event)
    {
        file_put_contents(
            "book_{$event->getBookInstanceId()}",
            "{$event->getAccountId()}" .
            PHP_EOL .
            "{$event->getDateAsSecondsSinceJan1970()}"
        );
    }
}
