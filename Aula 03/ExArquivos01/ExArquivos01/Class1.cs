using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExArquivos01
{
    internal class Class1
    {
        string email, nome;
        StreamWriter sw;
        StreamReader sr;
        public Class1(string nome)
        {
            this.nome = nome;
        }
        public void criarArquivo()
        {
            sw = new StreamWriter("C:\\Arquivo\\" + nome + ".txt", true, Encoding.UTF8);
        }
        public void lerArquivo()
        {
            string linha;
            sr = new StreamReader("C:\\Arquivo\\" + nome + ".txt");
            linha = sr.ReadLine();
            while (linha != null)
            {
                Console.WriteLine(linha);
                linha = sr.ReadLine();
            }
            sr.Close();
        }
        public void gravarMensagem(string email)
        {
            sw.WriteLine(email);
            sw.Flush();
        }
        public void fecharArquivo()
        {
            sw.Close();
        }
    }
}
