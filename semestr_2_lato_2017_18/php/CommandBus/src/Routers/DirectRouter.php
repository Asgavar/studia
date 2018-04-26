<?php

namespace CommandBus\Routers;

use CommandBus\Routers\Router;
use CommandBus\Commands\Command;

class DirectRouter implements Router
{
    private $mapping;

    public function __construct(array $mapping)
    {
        $this->mapping = $mapping;
    }

    public function match_handler(Command $command)
    {
        return $this->mapping[get_class($command)];
    }
}
