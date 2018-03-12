using System;

namespace Dictionary
{
    public class Dictionary<K, V>
    {
        private K[] keys;
        private V[] values;
        private int itemsSoFar;
        private int innerListsCapacity;

        public Dictionary()
        {
            this.keys = new K[16];
            this.values = new V[16];
            this.itemsSoFar = 0;
            this.innerListsCapacity = 16;
        }

        public void Add(K new_key, V new_value)
        {
            if (this.itemsSoFar == this.innerListsCapacity)
            {
                GrowLists();
            }
            if (this.keys.Contains(new_key))
            {
                // throw new
            }
            this.keys[itemsSoFar] = key;
            this.values[itemsSoFar] = new_value;
        }

        /**
         * A może FindAllOcurrences?
         */
        public void Contains(V valueInQuestion)
        {
            return this.values.Contains(valueInQuestion);
        }

        public void Remove(K key)
        {
            if (! this.keys.Contains(key))
            {
                //
            }
            int indexOfTheKeyRemoved = this.keys.FindIndex(key);
        }

        private void GrowLists()
        {

        }
    }
}
