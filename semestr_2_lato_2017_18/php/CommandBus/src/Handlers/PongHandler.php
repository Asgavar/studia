<?php

namespace CommandBus\Handlers;

use CommandBus\Commands\PongCommand;

class PongHandler
{
    public function __invoke(PongCommand $command)
    {
        echo "PONG!" . PHP_EOL;
    }
}
