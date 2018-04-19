<?php


namespace Wallet\Implementations;


use Wallet\Interfaces\Event;
use Wallet\Interfaces\EventAggregator;
use Wallet\Interfaces\EventSubscriber;

class WalletEventAggregator implements EventAggregator
{
    private $subscribers = [];

    public function registerSubscriber(EventSubscriber $es)
    {
        array_push($this->subscribers, $es);
    }

    public function publish(Event $event)
    {
        foreach ($this->subscribers as $subscriber)
        {
            $subscriber->notify($event);
        }
    }
}