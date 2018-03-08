using System;
using System.Collections.Generic;

using StrumienieLiczb;

namespace ListaLeniwa
{
    class PrimesLazyList : LazyList
    {
        private PrimeStream primeGenerator;

        public PrimesLazyList()
        {
            this.primeGenerator = new PrimeStream();
        }

        protected override void FillInnerList(int howMany)
        {
            innerList.Add(primeGenerator.Next());
        }
    }
}
