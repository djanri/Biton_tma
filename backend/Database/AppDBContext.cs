using Microsoft.EntityFrameworkCore;

public class AppDBContext : DbContext
{
    public AppDBContext(DbContextOptions<AppDBContext> options) : base(options)
    {
        
    }

    public DbSet<User> Users { get; set; }
    public DbSet<Prize> Prizes { get; set; }
    public DbSet<Admin> Admins { get; set; }
    public DbSet<Channel> Channels { get; set; }
}