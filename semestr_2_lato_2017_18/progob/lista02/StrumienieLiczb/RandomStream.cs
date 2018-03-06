using System;

namespace StrumienieLiczb 
{
    class RandomStream : IntStream
    {
        private Random rng;

        public RandomStream()
        {
            this.rng = new Random();
            this.Reset();
        }

        public new int Next()
        {
            return rng.Next();
        }

        public new bool Eos()
        {
            return false;
        }
    }
}
