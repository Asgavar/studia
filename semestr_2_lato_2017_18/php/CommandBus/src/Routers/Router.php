<?php

namespace CommandBus\Routers;

use CommandBus\Commands\Command;

interface Router
{
    /**
     * Czy handlery powinny implementować jakiś wspólny interfejs?
     */
    public function match_handler(Command $command);
}
