using System.Collections.Generic;
using System.Linq;

namespace Singleton
{
    public sealed class TimeNTon
    {
        private const int WORKSHOPS_START_HOUR = 14;
        private const int WORKSHOPS_END_HOUR = 16;
        private const int MAX_OBJECT_COUNT = 4;

        private static int instanceCount = 0;
        private static readonly List<TimeNTon> instanceList = new List<TimeNTon>();

        private int instanceNumber;

        private TimeNTon(int instanceNumber)
        {
            // blokujemy mozliwosc tworzenia instancji z zewnatrz
            this.instanceNumber = instanceNumber;
        }


        private static int GetHourFromEpoch(int epoch)
        {
            return ((epoch / 60) / 60) % 24;
        }


        /**
         * Zwraca zawsze ostatni obiekt z listy, jeśli trwa pracownia to dodaje do niej nowy obiekt
         * o ile jest jeszcze na niego miejsce.
         */
        public static TimeNTon GetInstance(int secondsSinceJan1970)
        {
            int currentHour = GetHourFromEpoch(secondsSinceJan1970);
            if (instanceCount < MAX_OBJECT_COUNT)
            {
            if (Enumerable.Range(WORKSHOPS_START_HOUR, WORKSHOPS_END_HOUR)
                    .Contains(currentHour) || instanceCount == 0)
                {
                    instanceList.Add(new TimeNTon(instanceCount));
                    ++instanceCount;
                }
            }
            return instanceList.Last();
        }

        public override string ToString()
        {
            return $"{this.instanceNumber}";
        }
    }
}
