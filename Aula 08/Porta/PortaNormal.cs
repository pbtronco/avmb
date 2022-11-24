using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Porta
{
    internal class PortaNormal : Porta
    {
        public override void abre()
        {
            cor = "preta";
            tamanho = 1.55;
            Console.WriteLine("Porta abre normal " + cor);
        }
    }
}
