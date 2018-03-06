using System;
using System.Collections.Generic;

namespace ListaLeniwa
{
    /**
     * Moznaby sterowac parametrem Capacity listy, ale po co.
     */
    class LazyList
    {
        private int elementCount;
        private List<int> innerList;
        private Random rng;

        public LazyList()
        {
            this.elementCount = 0;
            this.innerList = new List<int>();
            this.rng = new Random();
        }

        public int Element(int index)
        {
            if (index >= this.elementCount)
            {
                int difference = index - this.elementCount + 1;
                this.FillInnerList(difference);
                this.elementCount = index;
            }
            return this.innerList[index];
        }

        public int Size()
        {
            return elementCount;
        }

        private void FillInnerList(int howMany)
        {
            while (howMany >= 0)
            {
                this.innerList.Add(rng.Next());
                --howMany;
            }
        }
    }
}
