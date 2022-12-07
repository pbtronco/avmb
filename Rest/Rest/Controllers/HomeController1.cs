using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Rest.Data;
using Rest.Models;

namespace Rest.Controllers
{
    [Route("api")]
    public class HomeController1 : ControllerBase
    {
        [HttpGet]
        [Route("pessoas")]
        public async Task<IActionResult> GetallAsync(
            [FromServices] Contexto contexto)
        {
            var pessoas = await contexto
                .Pessoas
                .AsNoTracking()
                .ToListAsync();
            return pessoas == null ? NotFound() : Ok(pessoas);
        }
        [HttpGet]
        [Route("pessoas/{id}")]
        public async Task<IActionResult> getByIdAsync(
            [FromServices] Contexto contexto,
            [FromRoute] int id
            )
        {
            var pessoa = await contexto
                .Pessoas.AsNoTracking()
                .FirstOrDefaultAsync(p => p.id == id);
            return pessoa == null ? NotFound() : Ok(pessoa);
        }
        [HttpPost]
        [Route("pessoas")]
        public async Task<IActionResult> PostAsync(
            [FromServices] Contexto contexto,
            [FromBody] Pessoa pessoa
            )
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }
            try
            {
                await contexto.Pessoas.AddAsync(pessoa);
                await contexto.SaveChangesAsync();
                return Created($"api/pessoas/{pessoa.id}", pessoa);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpPut]
        [Route("pessoas/{id}")]
        public async Task<IActionResult> PutAsync
            (
            [FromServices] Contexto contexto,
            [FromBody] Pessoa pessoa,
            [FromRoute] int id
            )
        {
            if (!ModelState.IsValid)
                return BadRequest("Model Inválida");

            var p = await contexto.Pessoas
                .FirstOrDefaultAsync(x => x.id == id);

            if (p == null)
                return NotFound("Pessoa não encontrada!");

            try
            {
                p.nome = pessoa.nome;

                contexto.Pessoas.Update(p);
                await contexto.SaveChangesAsync();
                return Ok(p);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpDelete]
        [Route("pessoas/{id}")]
        public async Task<IActionResult> DeleteAsync(
            [FromServices] Contexto contexto,
            [FromRoute] int id)
        {
            var p = await contexto.Pessoas.FirstOrDefaultAsync(x => x.id == id);

            if (p == null)
                return BadRequest("Pessoa não encontrada!");

            try
            {
                contexto.Pessoas.Remove(p);
                await contexto.SaveChangesAsync();

                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
