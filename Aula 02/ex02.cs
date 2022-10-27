namespace atividade2
{
    internal class Program
    {
        static void Main(string[] args)
        {
            float hora1, hora2, valor1, valor2, media1, media2;
            Console.WriteLine("Digite quantas horas o professor 1 trabalha: ");
            hora1 = float.Parse(Console.ReadLine());
            Console.WriteLine("Digite o valor de cada hora aula do professor 1: ");
            valor1 = float.Parse(Console.ReadLine());
            Console.WriteLine("Digite quantas horas o professor 2 trabalha: ");
            hora2 = float.Parse(Console.ReadLine());
            Console.WriteLine("Digite o valor de cada hora aula do professor 2: ");
            valor2 = float.Parse(Console.ReadLine());
            media1 = hora1 * valor1;
            media2 = hora2 * valor2;
            if (media1 > media2)
            {
                Console.WriteLine("O professor 1 recebe R$ " + media1 + " e o professor 2 recebe R$ " + media2 + ". Portanto o Professor 1, recebe mais!!");
            }
            if (media2 > media1)
            {
                Console.WriteLine("O professor 2 recebe R$ " + media2 + " e o professor 1 recebe R$ " + media1 + ". Portanto o Professor 2, recebe mais!!");
            }
            else
            {
                Console.WriteLine("Os professores recebem o mesmo salário!");
            }
        }
    }
}