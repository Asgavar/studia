<?php


namespace Wallet\Implementations;


use Money\Money;

use Wallet\Events\CurrencySetEvent;
use Wallet\Events\MoneyDepositedEvent;
use Wallet\Events\MoneyWithdrawnEvent;
use Wallet\Events\WalletActivatedEvent;
use Wallet\Events\WalletDeactivatedEvent;
use Wallet\Interfaces\Event;
use Wallet\Interfaces\EventAggregator;
use Wallet\Interfaces\EventSubscriber;

class Wallet implements EventSubscriber
{
    private $pastEvents;
    private $state;
    /**
     * @var EventAggregator
     */
    private $aggregator;

    public function __construct(WalletState $walletState = null)
    {
        $this->pastEvents = [];
        $this->state = new WalletState();
    }


    public static function fromEvents(array $events): Wallet
    {
        $newState = new WalletState();

        foreach ($events as $event)
        {
            $newState->processEvent($event);
        }

        return new Wallet($newState);
    }

    public function setEventAggregator(EventAggregator $aggregator)
    {
        $this->aggregator = $aggregator;
    }

    public function deposit(Money $moneyToDeposit): void
    {
        if (is_null($this->state->getCurrentBalance()))
        {
            $currencySetEvent = new CurrencySetEvent($moneyToDeposit->getCurrency());
            $this->aggregator->publish($currencySetEvent);
            $this->state->processEvent($currencySetEvent);
        }

        $depositEvent = new MoneyDepositedEvent($moneyToDeposit);
        $this->aggregator->publish($depositEvent);
        $this->state->processEvent($depositEvent);
    }

    public function withdraw(Money $moneyToWithdraw): void
    {
        $withdrawEvent = new MoneyWithdrawnEvent($moneyToWithdraw);
        $this->aggregator->publish($withdrawEvent);
        $this->state->processEvent($withdrawEvent);
    }

    public function deactivate(string $reason): void
    {
        $deactivateEvent = new WalletDeactivatedEvent();
        $this->aggregator->publish($deactivateEvent);
        $this->state->processEvent($deactivateEvent);
    }

    public function activate(string $reason): void
    {
        $activateEvent = new WalletActivatedEvent();
        $this->aggregator->publish($activateEvent);
        $this->state->processEvent($activateEvent);
    }

    public function getBalance(): Money
    {
        return $this->state->getCurrentBalance();
    }

    public function notify(Event $event)
    {
        array_push($this->pastEvents, $event);
    }
}
