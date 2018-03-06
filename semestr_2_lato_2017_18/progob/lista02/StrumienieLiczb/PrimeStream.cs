using System;

namespace StrumienieLiczb 
{
    /**
     * Nie przeciążam Eos(), ponieważ dziwnym trafem największa liczba
     * zapisywalna na 4 bajtach jest pierwsza.
     */
    class PrimeStream : IntStream
    {
        public PrimeStream()
        {
            this.Reset();
        }

        private bool IsCurrentPrime()
        {
            int divisor = 2;
            double searchThreshold = Math.Sqrt(this.current);
            while (divisor <= searchThreshold)
            {
                if (this.current % divisor == 0)
                {
                    return false;
                }
                ++divisor;
            }
            return true;
        }

        public new int Next()
        {
            int oldValue = this.current;
            do
            {
                ++this.current;
            } while (! this.IsCurrentPrime());
            return oldValue;
        }

        public new void Reset()
        {
            this.current = 2;
        }
    }
}
