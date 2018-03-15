using System;

namespace Dictionary
{
    public class Dictionary<K, V>
    {
        private static int INITIAL_CAPACITY = 16;

        private K[] keys;
        private V[] values;
        private int itemsSoFar;
        private int innerListsCapacity;

        public Dictionary()
        {
            this.keys = new K[INITIAL_CAPACITY];
            this.values = new V[INITIAL_CAPACITY];
            this.itemsSoFar = 0;
            this.innerListsCapacity = INITIAL_CAPACITY;
        }

        public void Add(K new_key, V new_value)
        {
            if (this.itemsSoFar == this.innerListsCapacity)
            {
                GrowLists();
            }
            if (this.Contains(new_key))
            {
                throw new Exception("Klucz już istnieje");
            }
            this.keys[itemsSoFar] = new_key;
            this.values[itemsSoFar] = new_value;
            ++itemsSoFar;
        }

        public V Get(K key)
        {
            if (! this.Contains(key))
            {
                throw new Exception("Nie znaleziono klucza");
            }
            int index = Array.FindIndex(this.keys, k => k.Equals(key));
            return this.values[index];
        }

        public bool Contains(K key)
        {
            foreach (K kkeeyy in this.keys)
            {
                if (key.Equals(kkeeyy))
                {
                    return true;
                }
            }
            return false;
        }

        public void Remove(K key)
        {
            if (! this.Contains(key))
            {
                throw new Exception("Nie znaleziono klucza");
            }
            int indexOfTheKeyRemoved = Array.FindIndex(this.keys, k => k.Equals(key));
            this.keys[indexOfTheKeyRemoved] = default(K);
        }

        private void GrowLists()
        {
            // zwiekszamy za kazdym razem o tyle, ile bylo na poczatku
            K[] new_keys = new K[itemsSoFar + INITIAL_CAPACITY];
            V[] new_values = new V[itemsSoFar + INITIAL_CAPACITY];
            Array.Copy(this.keys, new_keys, itemsSoFar);
            Array.Copy(this.values, new_values, itemsSoFar);
            this.keys = new_keys;
            this.values = new_values;
            this.innerListsCapacity += INITIAL_CAPACITY;
        }

        public override string ToString()
        {
            string repr = "";
            for (int x = 0; x < this.innerListsCapacity; x++)
            {
                repr += this.keys[x];
                repr += " => ";
                repr += this.values[x];
                repr += "\n";
            }
            return repr;
        }
    }
}
