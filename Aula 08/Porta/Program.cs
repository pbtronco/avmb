namespace Porta
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Porta p = new PortaNormal();
            p.abre();
            PortaCorrer p2 = new PortaCorrer();
            p2.abre();
            Porta p3;
            int tipo;
            Console.WriteLine("Digite 1 para criar uma porta e 2 para uma porta de correr");
            tipo = int.Parse(Console.ReadLine());
            if (tipo == 1)
                p3 = new PortaNormal();
            else if (tipo == 2)
                p3 = new PortaCorrer();
            else
                p3 = new PortaNormal();
            p3.abre();
            
        }
    }
}