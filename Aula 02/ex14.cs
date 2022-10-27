namespace atividade14
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int a, b, c;
            Console.WriteLine("Digite o número inicial");
            a = int.Parse(Console.ReadLine());
            Console.WriteLine("Digite o número final");
            b = int.Parse(Console.ReadLine());
            Console.WriteLine("Sequencia de " + a + " à " + b);
            for (c = a; c <= b; c++)
            {
                Console.WriteLine(c);
            }

        }
    }
}