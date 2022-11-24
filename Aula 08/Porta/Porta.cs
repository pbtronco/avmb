using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Porta
{
    internal abstract class Porta
    {
        public string cor;
        public double tamanho;
        public string tipoFechadura;
        public abstract void abre();
    }
}
