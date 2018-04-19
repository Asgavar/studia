<?php

namespace Wallet\Interfaces;


interface EventSubscriber
{
    public function notify(Event $event);
}
