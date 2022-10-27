namespace ativadade17
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int a, b, c, opcao;
            Console.WriteLine("Digite o número inicial");
            a = int.Parse(Console.ReadLine());
            Console.WriteLine("Digite o número final");
            b = int.Parse(Console.ReadLine());
            Console.WriteLine("Sequencia de " + a + " à " + b);
            Console.WriteLine("Digite \n1- Crescente:\n2- Decrescente: ");
            opcao = int.Parse(Console.ReadLine());
            if (opcao == 1)
            {
                for (c = a; c <= b; c++)
                {
                    Console.WriteLine(c);
                }
            }
            else if (opcao == 2)
            {
                for (c = b; c >= a; c--)
                {
                    Console.WriteLine(c);
                }
            }
        }
    }
}