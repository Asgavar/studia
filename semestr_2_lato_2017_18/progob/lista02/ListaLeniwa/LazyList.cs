using System;
using System.Collections.Generic;

namespace ListaLeniwa
{
    /**
     * Moznaby sterowac parametrem Capacity listy, ale po co.
     */
    class LazyList
    {
        protected int elementCount;
        protected List<int> innerList;
        protected Random rng;

        public LazyList()
        {
            this.elementCount = 0;
            this.innerList = new List<int>();
            this.rng = new Random();
        }

        public int Element(int index)
        {
            if (index >= elementCount)
            {
                int difference = index - elementCount + 1;
                FillInnerList(difference);
                elementCount = index;
            }
            return innerList[index];
        }

        public int Size()
        {
            return elementCount;
        }

        protected virtual void FillInnerList(int howMany)
        {
            while (howMany >= 0)
            {
                innerList.Add(rng.Next());
                --howMany;
            }
        }
    }
}
