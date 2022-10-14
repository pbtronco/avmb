namespace SomatorioNotas
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int i, n;
            double media = 0, nota;
            Console.WriteLine("Calculo da media de notas da turma em uma avaliacao \n");
            Console.WriteLine("Quantos alunos realizaram a avaliação? ");
            n = int.Parse(Console.ReadLine());
            for (i = 1; i <= n; i++)
            {
                Console.WriteLine("Digite a nota do aluno " + i);
                nota = double.Parse(Console.ReadLine());
                media += nota;
            }
            media = media / n;
            Console.WriteLine("\nA média final da turma é " +media);
        }
    }
}