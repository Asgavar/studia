<?php

namespace CommandBus\Handlers;

use CommandBus\Commands\PingCommand;

class PingHandler
{
    public function __invoke(PingCommand $command)
    {
        echo "PING!" . PHP_EOL;
    }
}
