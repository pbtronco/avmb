namespace Atividade5
{
    internal class Program
    {
        static void Main(string[] args)
        {
            char letra;
            Console.WriteLine("Digite uma letra: ");
            letra = char.Parse(Console.ReadLine());
            switch (letra)
            {
                case ('a' or 'A'):
                        Console.WriteLine("Letra:" + letra + " = VOGAL");
                        break;
                case ('e' or 'E'):
                        Console.WriteLine("Letra:" + letra + " = VOGAL");
                break;
                case ('i' or 'I'):
                        Console.WriteLine("Letra:" + letra + " = VOGAL");
                break;

                case ('o' or 'O'):
                        Console.WriteLine("Letra:" + letra + " = VOGAL");
                break;
                case ('u' or 'U'):
                        Console.WriteLine("Letra:" + letra + " = VOGAL");
                break;

                default:
                    Console.WriteLine("Letra "+letra+" = Consoante");
                    break;
            }
        }
    }
}