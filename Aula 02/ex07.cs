namespace atividade7
{
    internal class Program
    {
        static void Main(string[] args)
        {
            float renda, total;
            int pessoas;
            Console.WriteLine("Digite o valor da renda: ");
            renda = float.Parse(Console.ReadLine());
            Console.WriteLine("Digite o valor de pessoas: ");
            pessoas = int.Parse(Console.ReadLine());
            total = renda / pessoas;
            Console.WriteLine("Renda Per Capita: " + total);
        }
    }
}