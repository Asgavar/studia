using System;
using System.Linq;
using System.Globalization;
using System.Text;

namespace StrumienieLiczb
{
    class RandomWordStream
    {
        private PrimeStream primeStream;
        private RandomStream rng;

        public RandomWordStream()
        {
            this.primeStream = new PrimeStream();
            this.rng = new RandomStream();
        }

        public string Next()
        {
            int desiredLength = primeStream.Next();
            var builder = new StringBuilder();
            for (int i = 0; i < desiredLength; i++)
            {
                builder.Append(GetRandomUnicodeLetter());
            }
            return builder.ToString();
        }

        private char GetRandomUnicodeLetter()
        {
            char letter;
            UnicodeCategory letterCategory;
            do
            {
                // letter = (char) (rng.Next() % 128);
                // int latinA = Convert.ToInt32(0xfeff0041);
                // int latinEEE = Convert.ToInt32(0xfeff0063);
                // letter = (char) new Random().Next(latinA, Int32.MaxValue);
                // int offset = (char) new Random().Next(0, 26);
                int offset = rng.Next() % 26;
                return (char) ('a' + offset);
                letterCategory = char.GetUnicodeCategory(letter);
            // } while (char.IsLetter(letter) && ! (letterCategory == UnicodeCategory.TitlecaseLetter));
            } while (! true);
            return letter;
        }
    }
}
