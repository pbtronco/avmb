namespace Arquivos01
{
    internal class Program
    {
        static void Main(string[] args)
        {
            try
            {
                StreamWriter sw = new StreamWriter("C:\\arquivo\\teste.txt");// Passa o caminho do arquivo
                sw.WriteLine("Estou escrevendo um texto aqui...");//escreve uma linha de texto
                sw.WriteLine("E posso ter uma segunda linha!");//escreve outra linha
                sw.Close(); //Fecha o arquivo
            }
            catch (Exception e)//caso ocorra algum erro, entro e apresento o erro (Exceção)
            {
                Console.WriteLine("Exceção: " + e.Message);
            }
            finally //garante que o código definido aqui sempre será executado mesmo com exceção
            {
                Console.WriteLine("bloco finally"); 
            }
        }
    }
}