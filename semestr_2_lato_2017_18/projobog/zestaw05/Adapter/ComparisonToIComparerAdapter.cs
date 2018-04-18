using System;
using System.Collections;
using System.Collections.Generic;

public class ComparisonToIComparerAdapter : IComparer
{

    private Comparison<int> comparison;

    public ComparisonToIComparerAdapter(Comparison<int> comparison)
    {
        this.comparison = comparison;
    }

    public int Compare(object x, object y)
    {
        return this.comparison((int)x, (int)y);
    }
}
