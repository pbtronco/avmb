using System.Diagnostics.Contracts;
using System.Runtime.CompilerServices;

namespace Arquivos02
{
    internal class Program
    {
        static void Main(string[] args)
        {
            string nomearquivo, mensagem;
            int op;
            Console.WriteLine("Digite o nome do arquivo: ");
            nomearquivo = Console.ReadLine();
            Arquivo a = new Arquivo(nomearquivo);

            while (true)
            {
                Console.WriteLine("Digite:\n1 - para escrever um arquivo\n" +
                    "2 - para gravar um texto no arquivo\n" +
                    "3 - para ler o arquivo\n" +
                    "0 - para sair do programa");
                op = int.Parse(Console.ReadLine());
                switch (op)
                {
                    case 1:
                        a.criarAbreArquivo();
                        a.fechaArquivo();
                        break;
                    case 2:
                        a.criarAbreArquivo();
                        Console.WriteLine("Digite uma mensagem para o futuro: ");
                        string msg = Console.ReadLine();
                        a.gravaMensagem(msg);
                        a.fechaArquivo();
                        break;
                    case 3:
                        a.lerArquivo();
                        break;
                    case 0:
                        break;

                    default:
                        Console.WriteLine("digite um valor valido animalzinho s2");
                        break;
                }
            }
        }
    }
}