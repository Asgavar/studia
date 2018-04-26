<?php

require_once("../vendor/autoload.php");

use CommandBus\Buses\CommandBus;
use CommandBus\Routers\DirectRouter;
use CommandBus\Commands\PingCommand;
use CommandBus\Commands\PongCommand;
use CommandBus\Handlers\PingHandler;
use CommandBus\Handlers\PongHandler;

$directRouter = new DirectRouter([
    PingCommand::class => PingHandler::class,
    PongCommand::class => PongHandler::class
]);

$commandBus = new CommandBus($directRouter);

$commandBus->dispatch(new PingCommand());
$commandBus->dispatch(new PongCommand());
