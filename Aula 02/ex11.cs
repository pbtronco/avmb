namespace atividade11
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int contador;
            for (contador = 1000; contador <= 1999; contador++)
            {
                if (contador % 11 == 5)
                {
                    Console.WriteLine(contador);
                }
            }
        }
    }
}