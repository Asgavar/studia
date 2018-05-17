<?php

require_once("../vendor/autoload.php");

use Prooph\ServiceBus\EventBus;
use Prooph\ServiceBus\Plugin\Router\EventRouter;

use Asgavar\ProcessManager\EventHandlers\AcceptPenaltyFeePayment;
use Asgavar\ProcessManager\EventHandlers\CalculatePenaltyFee;
use Asgavar\ProcessManager\EventHandlers\CreateNewBookFile;
use Asgavar\ProcessManager\EventHandlers\CreateNewDebtFile;
use Asgavar\ProcessManager\EventHandlers\FinishIfReturnedOnTime;
use Asgavar\ProcessManager\EventHandlers\RemindReaderAboutReturnTime;
use Asgavar\ProcessManager\EventHandlers\RemoveBookFile;
use Asgavar\ProcessManager\EventHandlers\ThankReaderForUsingOurServices;

$eventBus = new EventBus();
$eventRouter = new EventRouter;

$eventRouter->route('Asgavar\ProcessManager\Events\BookLent')
            ->to(new CreateNewBookFile());
$eventRouter->route('Asgavar\ProcessManager\Events\ReturnTimeExceeded')
            ->to(new RemindReaderAboutReturnTime());
$eventRouter->route('Asgavar\ProcessManager\Events\BookReturned')
            ->to(new CalculatePenaltyFee($eventBus));
$eventRouter->route('Asgavar\ProcessManager\Events\PenaltyFeeCalculated')
            ->to(new FinishIfReturnedOnTime($eventBus));
$eventRouter->route('Asgavar\ProcessManager\Events\PenaltyFeeCalculated')
            ->to(new CreateNewDebtFile());
$eventRouter->route('Asgavar\ProcessManager\Events\PenaltyFeeCalculated')
            ->to(new RemoveBookFile());
$eventRouter->route('Asgavar\ProcessManager\Events\PenaltyFeePaid')
            ->to(new AcceptPenaltyFeePayment($eventBus));
$eventRouter->route('Asgavar\ProcessManager\Events\LendProcessSuccesfullyFinished')
            ->to(new ThankReaderForUsingOurServices());

$eventRouter->attachToMessageBus($eventBus);

$eventClassNamePrefix = 'Asgavar\ProcessManager\Events\\';
$eventToDispatchName = $eventClassNamePrefix . $argv[1];
$eventToDispatchArgs = array_slice($argv, 2);
$eventToDispatchObject = new $eventToDispatchName(...$eventToDispatchArgs);

$eventBus->dispatch($eventToDispatchObject);
