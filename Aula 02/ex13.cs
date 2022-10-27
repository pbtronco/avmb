namespace atividade13
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int num1, num2, valores, count;
            Console.WriteLine("Digite o valor inicial: ");
            num1 = int.Parse(Console.ReadLine());
            Console.WriteLine("Digite o valor final: ");
            num2 = int.Parse(Console.ReadLine());
            for (count = num1; count <= num2; count++);
            Console.WriteLine("1 - Pares\n2 - Ímpares");
            valores = int.Parse(Console.ReadLine());
            if (valores == 1)
            {
                if (count % 2 == 0)
                {
                    Console.WriteLine(count);
                }

            }
            if (valores == 2)
            {
                if (count % 3 == 0)
                {
                    Console.WriteLine(count);
                }

            }

        }
    }
}