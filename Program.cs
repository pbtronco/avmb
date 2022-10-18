using System;
using System.Threading;
namespace TIC_TAC_TOE
{
    class Program
    {
        static char[] arr = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
        static int jogador = 1;
        static int chance;
        static int flag = 0;
        static void Main(string[] args)
        {
            do
            {
                Console.Clear();
                Console.WriteLine("Jogador 1:X e Jogador 2:O");
                Console.WriteLine("\n");
                if (jogador % 2 == 0)
                {
                    Console.WriteLine("Jogador 2 Chance");
                }
                else
                {
                    Console.WriteLine("Jogador 1 Chance");
                }
                Console.WriteLine("\n");
                Board();
                chance = int.Parse(Console.ReadLine());
                if (arr[chance] != 'X' && arr[chance] != 'O')
                {
                    if (jogador % 2 == 0) 
                    {
                        arr[chance] = 'O';
                        jogador++;
                    }
                    else
                    {
                        arr[chance] = 'X';
                        jogador++;
                    }
                }
                else
                {
                    Console.WriteLine("Desculpa, a fileira {0} já esta marcada com {1}", chance, arr[chance]);
                    Console.WriteLine("\n");
                    Console.WriteLine("Espere um momento");
                    Thread.Sleep(2000);
                }
                flag = CheckWin();
            }
            while (flag != 1 && flag != -1);

            Console.Clear();
            Board();
            if (flag == 1)
            {
                Console.WriteLine("Jogador {0} ganhou!", (jogador % 2) + 1);
            }
            else
            {
                Console.WriteLine("Empate");
            }
            Console.ReadLine();
        }
        private static void Board()
        {
            Console.WriteLine("     |     |      ");
            Console.WriteLine("  {0}  |  {1}  |  {2}", arr[1], arr[2], arr[3]);
            Console.WriteLine("_____|_____|_____ ");
            Console.WriteLine("     |     |      ");
            Console.WriteLine("  {0}  |  {1}  |  {2}", arr[4], arr[5], arr[6]);
            Console.WriteLine("_____|_____|_____ ");
            Console.WriteLine("     |     |      ");
            Console.WriteLine("  {0}  |  {1}  |  {2}", arr[7], arr[8], arr[9]);
            Console.WriteLine("     |     |      ");
        }
        private static int CheckWin()
        {
            if (arr[1] == arr[2] && arr[2] == arr[3])
            {
                return 1;
            }
            else if (arr[4] == arr[5] && arr[5] == arr[6])
            {
                return 1;
            }
            else if (arr[6] == arr[7] && arr[7] == arr[8])
            {
                return 1;
            }
            else if (arr[1] == arr[4] && arr[4] == arr[7])
            {
                return 1;
            }
            else if (arr[2] == arr[5] && arr[5] == arr[8])
            {
                return 1;
            }
            else if (arr[3] == arr[6] && arr[6] == arr[9])
            {
                return 1;
            }
            else if (arr[1] == arr[5] && arr[5] == arr[9])
            {
                return 1;
            }
            else if (arr[3] == arr[5] && arr[5] == arr[7])
            {
                return 1;
            }
            else if (arr[1] != '1' && arr[2] != '2' && arr[3] != '3' && arr[4] != '4' && arr[5] != '5' && arr[6] != '6' && arr[7] != '7' && arr[8] != '8' && arr[9] != '9')
            {
                return -1;
            }
            else
            {
                return 0;
            }
        }
    }
}