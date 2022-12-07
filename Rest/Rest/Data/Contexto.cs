
using Microsoft.EntityFrameworkCore;
using Rest.Models;


namespace Rest.Data
{
    public class Contexto : DbContext
    {
        public DbSet<Pessoa> Pessoas { get; set; }


        public Contexto()
        {
            //Add-Migration Initial
            //Update-Database
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseNpgsql(@"server=localhost; Port=5432; User ID=postgres; password=123456;database=BD0712");
            optionsBuilder.UseLazyLoadingProxies();
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {

        }
    }
}
