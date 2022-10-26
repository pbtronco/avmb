namespace ExArquivos01
{
    internal class Program
    {
        static void Main(string[] args)
        {
            string nomearquivo, mensagem;
            int op;
            Console.WriteLine("Digite o nome do arquivo para os emails");
            nomearquivo = Console.ReadLine();
            Class1 a = new Class1(nomearquivo);

            while (true)
            {
                Console.WriteLine("Digite:\n1- Escrever um arquivo\n" +
                    "2 - Gravar um Email\n" +
                    "3 - Ler os Emails\n" +
                    "0 - Para sair do programa");
                op = int.Parse(Console.ReadLine());
                switch (op)
                {
                    case 1:
                        a.criarArquivo();
                        a.fecharArquivo();
                        break;
                    case 2:
                        a.criarArquivo();
                        Console.WriteLine("Digite o Email:");
                        string email = Console.ReadLine();
                        a.gravarMensagem(email);
                        a.fecharArquivo();
                        break;
                    case 3:
                        a.lerArquivo();
                        break;
                    case 0:
                        break;
                }
            
            }
        }
    }
}