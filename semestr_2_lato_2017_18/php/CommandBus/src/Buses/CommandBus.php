<?php

namespace CommandBus\Buses;

use CommandBus\Commands\Command;
use CommandBus\Routers\Router;

class CommandBus
{
    private $router;

    public function __construct(Router $router)
    {
        $this->router = $router;
    }

    public function dispatch(Command $command)
    {
        $classToInstantiate = $this->router->match_handler($command);
        $handlerInstance = new $classToInstantiate();
        $handlerInstance($command);
    }
}
