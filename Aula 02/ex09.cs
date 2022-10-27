namespace atividade9
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int a, b, c;
            Console.WriteLine("Digite o valor do primeiro lado: ");
            a = int.Parse(Console.ReadLine());
            Console.WriteLine("Digite o valor do segundo lado: ");
            b = int.Parse(Console.ReadLine());
            Console.WriteLine("Digite o valor do terceiro lado: ");
            c = int.Parse(Console.ReadLine());

            if (a + b > c && a + c > b && b + c > a){
                Console.WriteLine("Os três lados formam um triângulo");
                if (a == b && a == c)
                {
                    Console.WriteLine("Equilátero");
                }
                else
                        if (a == b || a == c || b == c)
                    Console.WriteLine("Isosceles\n");
                else
                    Console.WriteLine("Escaleno\n");
            }
                else
                    Console.WriteLine("Os 3 lados não formam um triângulo!!");
            }
        }
    }