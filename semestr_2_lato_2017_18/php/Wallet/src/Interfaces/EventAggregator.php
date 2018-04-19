<?php


namespace Wallet\Interfaces;


interface EventAggregator
{
    public function registerSubscriber(EventSubscriber $es);
    public function publish(Event $event);
}
