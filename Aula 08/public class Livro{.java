using System;

namespace POO
{
    public abstract class Conta
    {
        int agencia;

        public int Agencia
        {
            get { return agencia; }
            set { 
                if(value > 0)
                    agencia = value; 
            }
        }
        int numeroConta;

        public int NumeroConta
        {
            get { return numeroConta; }
            private set { numeroConta = value; }
        }
        decimal saldo;

        public decimal Saldo
        {
            get { return saldo; }
            protected set { saldo = value; }
        }

        decimal limite;

        public decimal Limite
        {
            get { return limite; }
            private set { limite = value; }
        }

        public Conta()
        {
            this.limite = 1000;
        }

        public Conta(decimal limite)
        {
            this.limite = limite;
        }
        
        public void SetAgencia(int agencia)
        {
            this.agencia = agencia;
        }
        public virtual void Sacar(decimal valor)
        {
            saldo -= valor;
        }

        public abstract void Depositar(decimal valor);
    }
}