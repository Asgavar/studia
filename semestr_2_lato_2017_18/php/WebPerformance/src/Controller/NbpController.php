<?php

namespace App\Controller;

use MaciejSz\NbpPhp\NbpRepository;
use Symfony\Component\HttpFoundation\Response;

class NbpController
{
    public function avg_rate_for_day($currencyCode, $date)
    {
        $nbp = new NbpRepository();
        $currencyDataForDayGiven = $nbp->getRate($date, $currencyCode);
        return new Response(
            "Kurs dla waluty $currencyCode na dzień $date wynosi $currencyDataForDayGiven->avg"
        );
    }
}
