<?php

namespace Asgavar\DatabaseRepository\ValueObjects;

use MyCLabs\Enum\Enum;

class TransactionState extends Enum
{
    private const ACTIVE = 'active';
    private const BLOCKED = 'blocked';
    private const SUSPENDED = 'suspended';
    private const CLOSED = 'closed';
}
