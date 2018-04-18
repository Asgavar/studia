using System;
using System.Collections;

class Program
{
    static int IntComparer(int x, int y)
    {
        return x.CompareTo(y);
    }

    static void Main(string[] args)
    {
        ArrayList a = new ArrayList() { 1, 5, 3, 3, 2, 4, 3 };
        var adapter = new ComparisonToIComparerAdapter(IntComparer);

        foreach (int x in a)
            Console.WriteLine("Nieposortowana: " + x);

        a.Sort(adapter);

        foreach (int x in a)
            Console.WriteLine("Posortowana: " + x);
    }
}
