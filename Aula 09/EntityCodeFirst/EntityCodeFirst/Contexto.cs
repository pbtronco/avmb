using EntityCodeFirst.DataModels;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using System.Configuration;

namespace EntityCodeFirst
{
    public class Contexto : DbContext
    {
        public DbSet<Pessoa> Pessoas { get; set; }
        public DbSet<Email> Emails { get; set; }

        public Contexto()
        {

        }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            ConnectionStringSettings settings = ConfigurationManager.ConnectionStrings["EntityPostgresql"];
            string retorno = "";

            if (settings != null)
                retorno = settings.ConnectionString;
            optionsBuilder.UseNpgsql(retorno);

            optionsBuilder.UseLazyLoadingProxies();
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Email>()
                .HasOne(e => e.pessoa)
                .WithMany(e => e.Emails)
                .OnDelete(DeleteBehavior.ClientCascade);
        }
    }
}