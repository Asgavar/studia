using System.Collections;
using System.Collections.Generic;

namespace EnumerablePrimes
{
    public class PrimeCollection : IEnumerable<int>, IEnumerator<int>
    {
        private int currentPrime;


        public PrimeCollection()
        {
            this.currentPrime = 2;
        }
        
        
        public IEnumerator<int> GetEnumerator()
        {
            return this;
        }


        IEnumerator IEnumerable.GetEnumerator()
        {
            return this;
        }


        public void Reset()
        {
            this.currentPrime = 2;
        }


        public bool MoveNext()
        {
            do
            {
                ++this.currentPrime;
            } while (! IsCurrentPrime());

            return true;
        }


        public int Current
        {
            get
            {
                return this.currentPrime;
            }
        }


        object IEnumerator.Current
        {
            get
            {
                return this.currentPrime;
            }
        }


        public void Dispose()
        {
            
        }
        
        
        private bool IsCurrentPrime()
        {
            for (var x = 2; x < this.currentPrime; x++)
            {
                if (this.currentPrime % x == 0)
                {
                    return false;
                }
            }
            
            return true;
        }
    }
}
