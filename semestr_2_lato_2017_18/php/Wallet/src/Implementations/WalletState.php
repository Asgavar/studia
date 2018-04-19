<?php

namespace Wallet\Implementations;

use Money\Currency;
use Money\Money;

use Wallet\Exceptions\InsufficientFundsException;
use Wallet\Exceptions\WalletAlreadyActiveException;
use Wallet\Exceptions\WalletAlreadyNotActiveException;
use Wallet\Interfaces\Event;
use Wallet\Interfaces\EventAggregator;

class WalletState
{
    /**
     * @var EventAggregator
     */
    private $active;
    /**
     * @var Money
     */
    private $currentBalance;
    /**
     * @var Currency
     */
    private $currency;

    public function __construct()
    {
        $this->active = true;
        $this->currentBalance = null;
    }

    public function processEvent(Event $event)
    {
        switch (get_class($event))
        {
            case "Wallet\Events\CurrencySetEvent":
                $newCurrency = $event->getCurrency();
                $this->currency = $newCurrency;
                $this->currentBalance = new Money(0, $newCurrency);
                break;

            case "Wallet\Events\MoneyDepositedEvent":

                $this->currentBalance = $this->currentBalance->add($event->getDifference());
                break;

            case "Wallet\Events\MoneyWithdrawnEvent":

                if (! $this->currentBalance->getAmount() > $event->getDifference()->getAmount())
                    throw new InsufficientFundsException();

                $this->currentBalance = $this->currentBalance->subtract($event->getDifference());
                break;

            case "Wallet\Events\WalletActivatedEvent":

                if ($this->active)
                    throw new WalletAlreadyActiveException();

                $this->active = true;
                break;

            case "Wallet\Events\WalletDeactivatedEvent":

                if (! $this->active)
                    throw new WalletAlreadyNotActiveException();

                $this->active = false;
                break;

        }
    }

    public function isActive(): bool
    {
        return $this->active;
    }

    public function getCurrentBalance()
    {
        return $this->currentBalance;
    }
}
