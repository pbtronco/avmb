using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Porta
{
    internal class PortaCorrer : Porta
    {
        public override void abre()
        {
            cor = "transparente";
            tamanho = 2.33;
            Console.WriteLine("Porta correr arrastando "+ cor);
        }
    }
}
