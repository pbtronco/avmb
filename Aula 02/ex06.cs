using System;

namespace atividade6
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int hora, min, seg;

            do
            {
                Console.WriteLine("Digite a hora: ");
                hora = int.Parse(Console.ReadLine());

            }
            while (hora < 0 || hora > 23);
            do
            {
                Console.WriteLine("Digite o minuto: ");
                min = int.Parse(Console.ReadLine());

            }
            while (min < 0 || min > 59);

            do
            {
                Console.WriteLine("Digite o segundo: ");
                seg = int.Parse(Console.ReadLine());

            }

            while (seg < 0 || seg > 59);
            Console.WriteLine("Horário Digitado "+hora + ":" + min + ":" + seg);
        }
        
    }
}