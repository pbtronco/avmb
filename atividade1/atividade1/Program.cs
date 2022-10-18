namespace atividade1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int n1, n2, n3, n4, media;
            Console.WriteLine("Digite o valor da primeira nota: ");
            n1 = int.Parse(Console.ReadLine());
            Console.WriteLine("Digite o valor da segunda nota: ");
            n2 = int.Parse(Console.ReadLine());
            Console.WriteLine("Digite o valor da terceira nota: ");
            n3 = int.Parse(Console.ReadLine());
            Console.WriteLine("Digite o valor da quarta nota: ");
            n4 = int.Parse(Console.ReadLine());
            media = (n1 + n2 + n3 + n4) / 4;
            Console.WriteLine(media);
            if (n1 > media)
            {
                Console.WriteLine("Nota 1: "+n1);
            }
            if (n2 > media)
            {
                Console.WriteLine("Nota 2: "+n2);
            }
            if (n3 > media)
            {
                Console.WriteLine("Nota 3: "+n3);
            }
            if (n4 > media)
            {
                Console.WriteLine("Nota 4: "+n4);
            }
            else
            {
                Console.WriteLine("Nenhuma nota é maior que a média!");
            }
        }
    }
}