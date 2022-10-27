namespace atividade4
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int num, ling;
            Console.WriteLine("Digite um numero de 0 a 9: ");
            num = int.Parse(Console.ReadLine());
            Console.WriteLine("Digite 1 = Português\n2 = Espanhol\n3 = Inglês");
            ling = int.Parse(Console.ReadLine());

            if (ling == 1)
            {
                switch (num)
                {
                    case 0:
                        Console.WriteLine("Português: Zero");
                        break;
                    case 1:
                        Console.WriteLine("Português: Um");
                        break;
                    case 2:
                        Console.WriteLine("Português: Dois");
                        break;
                    case 3:
                        Console.WriteLine("Português: Três");
                        break;
                    case 4:
                        Console.WriteLine("Português: Quatro");
                        break;
                    case 5:
                        Console.WriteLine("Português: Cinco");
                        break;
                    case 6:
                        Console.WriteLine("Português: Seis");
                        break;
                    case 7:
                        Console.WriteLine("Português: Sete");
                        break;
                    case 8:
                        Console.WriteLine("Português: Oito");
                        break;
                    case 9:
                        Console.WriteLine("Português: Nove");
                        break;
                }
            }
                if (ling == 2)
                {
                    switch (num)
                    {
                        case 0:
                            Console.WriteLine("Espanhol: Cero");
                            break;
                        case 1:
                            Console.WriteLine("Espanhol: Uno");
                            break;
                        case 2:
                            Console.WriteLine("Espanhol: Dos");
                            break;
                        case 3:
                            Console.WriteLine("Espanhol: Tres");
                            break;
                        case 4:
                            Console.WriteLine("Espanhol: Cuatro");
                            break;
                        case 5:
                            Console.WriteLine("Espanhol: Cinco");
                            break;
                        case 6:
                            Console.WriteLine("Espanhol: Seis");
                            break;
                        case 7:
                            Console.WriteLine("Espanhol: Siete");
                            break;
                        case 8:
                            Console.WriteLine("Espanhol: Ocho");
                            break;
                        case 9:
                            Console.WriteLine("Espanhol: Nueve");
                            break;
                    }
                }
            if (ling == 3)
            {
                switch (num)
                {
                    case 0:
                        Console.WriteLine("IngLês: Zero");
                        break;
                    case 1:
                        Console.WriteLine("IngLês: One");
                        break;
                    case 2:
                        Console.WriteLine("IngLês: Two");
                        break;
                    case 3:
                        Console.WriteLine("IngLês: Three");
                        break;
                    case 4:
                        Console.WriteLine("IngLês: Four");
                        break;
                    case 5:
                        Console.WriteLine("IngLês: Five");
                        break;
                    case 6:
                        Console.WriteLine("IngLês: Six");
                        break;
                    case 7:
                        Console.WriteLine("IngLês: Seven");
                        break;
                    case 8:
                        Console.WriteLine("IngLês: Eight");
                        break;
                    case 9:
                        Console.WriteLine("IngLês: Nine");
                        break;
                }
            }
            else
            {
                Console.WriteLine("Opcão Inválida");
            }
        }
    }
}