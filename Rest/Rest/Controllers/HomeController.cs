using Microsoft.AspNetCore.Mvc;

namespace Rest.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class HomeController : ControllerBase
    {
        [HttpGet]
        [Route("meuNome")]
        public string GetNome()
        {
            return "Pablo";
        }
        [HttpGet]
        [Route("minhaIdade")]
        public string GetIdade()
        {
            return "Eu tenho 3981273981267378126317826318726381763182361 anos";
        }
        [HttpPost]
        public string GetRecebe(string nome)
        {
            return nome;
        }
        [HttpPost]
        [Route("recebeNI")]
        public string PostRecebeNI(string nome, int idade)
        {
            if (idade >= 18)
                return nome + " é maior de idade, e tem " + idade;
            else
                return nome + " é menor de idade, e tem " + idade;
        }
    }
}

