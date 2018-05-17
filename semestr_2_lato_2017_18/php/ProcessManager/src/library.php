<?php

require_once("../vendor/autoload.php");

use Asgavar\ProcessManager\EventHandlers\CreateNewBookFile;
use Asgavar\ProcessManager\Events\BookLent;
use Prooph\ServiceBus\EventBus;
use Prooph\ServiceBus\Plugin\Router\EventRouter;

$eventBus = new EventBus();
$eventRouter = new EventRouter;

$eventRouter->route('Asgavar\ProcessManager\Events\BookLent')
            ->to(new CreateNewBookFile());

$eventRouter->attachToMessageBus($eventBus);

$eventBus->dispatch(new BookLent(1, 1, 1234));
