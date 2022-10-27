using System;

namespace atividade12
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int count, inf, sup, somatotal;
            Console.WriteLine("Digite o valor inicial: ");
            inf = int.Parse(Console.ReadLine());
            Console.WriteLine("Digite o valor final: ");
            sup = int.Parse(Console.ReadLine());
            for (count = inf; count < sup; count++)
            {
                if(count % 2 == 0)
                {
                    somatotal = +count;
                }
            }
            Console.WriteLine(somatotal);

        }
    }
}