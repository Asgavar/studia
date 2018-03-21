using System;
using System.Collections.Generic;

namespace ContextFreeGrammars
{
    public class Term : ITerm
    {
        private List<ITerm> innerTerms;


        public Term()
        {
            this.innerTerms = new List<ITerm>();
        }


        public Term(ISymbol symbol)
        {
            this.innerTerms = new List<ITerm>();
            this.innerTerms.Add(symbol);
        }
        

        public bool ReplaceSymbol(ProductionRule rule)
        {
            if (this.innerTerms.Contains(rule.GetFrom()))
            {
                Console.WriteLine("jest");
                for (var x = 0; x < this.innerTerms.Count; x++)
                {
                    if (this.innerTerms[x].Equals(rule.GetFrom()))
                    {
                        this.innerTerms.RemoveAt(x);
                        break;
                    }
                }

                foreach (var newSymbol in rule.GetTo())
                {
                    this.innerTerms.Add(newSymbol);
                }
                
                return true;
            } else {
                foreach (var term in this.innerTerms)
                {
                    if (term.ReplaceSymbol(rule))
                    {
                        return true;
                    }
                }
            }
            return false;
        }


        public List<ITerm> GetReplaceableSymbols()
        {
            var ret = new List<ITerm>();
            foreach (var term in this.innerTerms)
            {
                ret.AddRange(term.GetReplaceableSymbols());
            }
            return ret;
        }


        public override string ToString()
        {
            string ret = "";
            foreach (var term in this.innerTerms)
            {
                ret += term.ToString();
            }
            return ret;
        }
    }
}
