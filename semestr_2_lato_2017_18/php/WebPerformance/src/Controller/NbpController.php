<?php

namespace App\Controller;

use Cache\Adapter\Redis\RedisCachePool;
use MaciejSz\NbpPhp\NbpRepository;
use Redis;
use Symfony\Component\HttpFoundation\Response;

class NbpController
{
    private $currencyCode;
    private $date;
    private $redisCachePool;

    public function avg_rate_for_day($currencyCode, $date)
    {
        $this->currencyCode = $currencyCode;
        $this->date = $date;
        $currencyDataForDayGiven = $this->getAvgRateForDayGivenFromCacheOrNbp();
        return new Response(
            "Kurs dla waluty $currencyCode na dzień $date wynosi $currencyDataForDayGiven->avg"
        );
    }

    private function getAvgRateForDayGivenFromCacheOrNbp()
    {
        $this->setupRedisCachePool();
        $cacheKey = $this->currencyCodeAndDateToCacheKey();

        if (! $this->redisCachePool->hasItem($cacheKey))
        {
            $nbp = new NbpRepository();
            $currencyDataForDayGiven = $nbp->getRate($this->date, $this->currencyCode);

            $newItem = $this->redisCachePool->getItem($cacheKey);
            $newItem->set($currencyDataForDayGiven);
            $this->redisCachePool->save($newItem);
        }

        return $this->redisCachePool->getItem($cacheKey)->get();
    }

    private function currencyCodeAndDateToCacheKey()
    {
        return "{$this->currencyCode}_{$this->date}";
    }

    private function setupRedisCachePool()
    {
        $redisClient = new Redis();
        $redisClient->connect('127.0.0.1', 6379);
        $redisCachePool = new RedisCachePool($redisClient);
        $this->redisCachePool = $redisCachePool;
    }
}
