using System.Security.Cryptography;

namespace ConsoleApp2
{
    internal class Program
    {
        static void Main(string[] args)
        {
            double n1, n2;
            Console.WriteLine("Digite o primeiro número: ");
            n1 = double.Parse(Console.ReadLine());
            Console.WriteLine("Digite o segundo número: ");
            n2 = double.Parse(Console.ReadLine());
            var r1 = n1 + n2;
            var r2 = n1 - n2;
            var r3 = n1 / n2;
            var r4 = n1 * n2;
            Console.WriteLine($"Soma: {r1}\nSubtração: {r2}\nDivisão: {r3}\nMultiplicação: {r4}");
        }
    }
}