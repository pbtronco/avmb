namespace atividade3
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int mes;
            Console.WriteLine("Digite o número correspondente ao mês do seu aniversário");
            mes = int.Parse(Console.ReadLine());
            if ( mes == 1)
            {
                Console.WriteLine("Mês: JANEIRO");
            }
            if (mes == 2)
            {
                Console.WriteLine("Mês: FEVEREIRO");
            }
            if (mes == 3)
            {
                Console.WriteLine("Mês: MARÇO");
            }
            if (mes == 4)
            {
                Console.WriteLine("Mês: ABRIL");
            }
            if (mes == 5)
            {
                Console.WriteLine("Mês: MAIO");
            }
            if (mes == 6)
            {
                Console.WriteLine("Mês: JUNHO");
            }
            if (mes == 7)
            {
                Console.WriteLine("Mês: JULHO");
            }
            if (mes == 8)
            {
                Console.WriteLine("Mês: AGOSTO");
            }
            if (mes == 9)
            {
                Console.WriteLine("Mês: SETEMBRO");
            }
            if (mes == 10)
            {
                Console.WriteLine("Mês: OUTUBRO");
            }
            if (mes == 11)
            {
                Console.WriteLine("Mês: NOVEMBRO");
            }
            if (mes == 12)
            {
                Console.WriteLine("Mês: DEZEMBRO");
            }
            else if (mes < 1 || mes > 12)
            {
                Console.WriteLine("Mês Inválido!!");
            }
        }
    }
}