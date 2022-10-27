namespace Atividade8
{
    internal class Program
    {
        static void Main(string[] args)
        {
            float valor;
            valor = float.Parse(Console.ReadLine());
            if ( valor < 10)
            {
                Console.WriteLine("Valor: " + valor + " e o lucro é de: " + valor * 0.7);
            }
            if (valor >= 10 && valor < 30)
            {
                Console.WriteLine("Valor: " + valor + " e o lucro é de: " + valor * 0.5);
            }
            if (valor >= 30 && valor < 50)
            {
                Console.WriteLine("Valor: " + valor + " e o lucro é de: " + valor * 0.4);
            }
            if (valor >= 50)
            {
                Console.WriteLine("Valor: " + valor + " e o lucro é de: " + valor * 0.3);
            }
        }
    }
}