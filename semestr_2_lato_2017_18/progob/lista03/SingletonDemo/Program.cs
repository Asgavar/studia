using System;

using Singleton;

namespace SingletonDemo
{
    class Program
    {
        static void Main(string[] args)
        {
            // Sunday, March 11, 2018 15:30:11
            int workshopsTime = 1520782211;
            // Sun, 11 Mar 2018 18:54:59 GMT
            int outOfWorkshopsTime = 1520794499;

            var instance0 = TimeNTon.GetInstance(outOfWorkshopsTime);
            var instance1 = TimeNTon.GetInstance(outOfWorkshopsTime);

            Console.WriteLine(
                "Dwie instancje utworzone poza godzinami pracowni:"
            );
            Console.WriteLine($"Instancja #0: {instance0}");
            Console.WriteLine($"Instancja #1: {instance1}");

            var instance2 = TimeNTon.GetInstance(workshopsTime);
            var instance3 = TimeNTon.GetInstance(workshopsTime);
            var instance4 = TimeNTon.GetInstance(workshopsTime);
            var instance5 = TimeNTon.GetInstance(workshopsTime);

            Console.WriteLine(
                "Cztery instancje utworzone w czasie pracowni:"
            );
            Console.WriteLine($"Instancja #2: {instance2}");
            Console.WriteLine($"Instancja #3: {instance3}");
            Console.WriteLine($"Instancja #4: {instance4}");
            Console.WriteLine($"Instancja #5: {instance5}");
        }
    }
}
