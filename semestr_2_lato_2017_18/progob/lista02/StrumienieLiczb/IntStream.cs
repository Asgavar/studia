using System;

namespace StrumienieLiczb
{
    class IntStream
    {
        protected int current;

        public IntStream()
        {
            this.Reset();
        }

        public int Next()
        {
            if (! this.Eos())
            {
                ++current;
            }
            return current;
        }

        public bool Eos()
        {
            return current >= Int32.MaxValue;
        }

        public void Reset()
        {
            this.current = 0;
        }
    }
}
