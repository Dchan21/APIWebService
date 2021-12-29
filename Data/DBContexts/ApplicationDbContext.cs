using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using APIWebService.Models;
using APIWebService.Data.Entities;

namespace APIWebService.Data.DBContexts
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<Author> Authors { get; set; }
        public DbSet<Basic_Information> Basics_Information { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Coach> Coaches { get; set; }
        public DbSet<Collaborator> Collaborators { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<Course> Courses { get; set; }
        public DbSet<Course_Price> Courses_Prices { get; set; }
        public DbSet<Course_Module> Courses_Modules { get; set; }
        public DbSet<Course_Organization> Courses_Organizations { get; set; }
        public DbSet<Course_User> Courses_Users { get; set; }
        public DbSet<Department> Departments { get; set; }
        public DbSet<Entity_Material> Entities_Materials { get; set; }
        public DbSet<Localization> Localizations { get; set; }
        public DbSet<Material> Materials { get; set; }
        public DbSet<Module> Modules { get; set; }
        public DbSet<Module_Video_Detail> Module_Video_Details { get; set; }
        public DbSet<Module_Progress> Modules_Progress { get; set; }
        public DbSet<Module_Video> Modules_Videos { get; set; }
        public DbSet<Organization> Organizations { get; set; }
        public DbSet<Organization_User> Organization_Users_View { get; set; }
        public DbSet<Course_Organization_Playlist> Course_Organization_Playlist_View { get; set; }
        public DbSet<Person> Persons { get; set; }
        public DbSet<Position> Positions { get; set; }
        public DbSet<Position_Collaborator> Positions_Collaborators { get; set; }
        public DbSet<Program> Programs { get; set; }
        public DbSet<Reviews_Course> Reviews_Courses { get; set; }
        public DbSet<Subscription> Subscriptions { get; set; }
        public DbSet<Subscription_User> Subscriptions_Users { get; set; }
        public DbSet<Team> Teams { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Video> Videos { get; set; }
        public DbSet<Video_Progress> Videos_Progress { get; set; }

        /**************************************************************************************************************************************************************************************/
        public DbSet<Aut_Audit> Aut_Audits { get; set; }
        public DbSet<Cou_Audit> Cou_Audits { get; set; }
        public DbSet<Org_Audit> Org_Audit { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<ApplicationUser>(i => { i.Property(o => o.EmailConfirmed).HasConversion<int>(); i.Property(o => o.LockoutEnabled).HasConversion<int>(); i.Property(o => o.PhoneNumberConfirmed).HasConversion<int>(); i.Property(o => o.TwoFactorEnabled).HasConversion<int>(); });
            modelBuilder.Entity<IdentityRole>(entity => entity.Property(m => m.NormalizedName).HasMaxLength(200));
            modelBuilder.Entity<IdentityUserLogin<string>>(entity => entity.Property(m => m.UserId).HasMaxLength(200));
            modelBuilder.Entity<IdentityUserLogin<string>>(entity => entity.Property(m => m.LoginProvider).HasMaxLength(200));
            modelBuilder.Entity<IdentityUserLogin<string>>(entity => entity.Property(m => m.ProviderKey).HasMaxLength(200));
            modelBuilder.Entity<IdentityUserRole<string>>(entity => entity.Property(m => m.UserId).HasMaxLength(200));
            modelBuilder.Entity<IdentityUserRole<string>>(entity => entity.Property(m => m.RoleId).HasMaxLength(200));
            modelBuilder.Entity<IdentityUserToken<string>>(entity => entity.Property(m => m.UserId).HasMaxLength(200));
            modelBuilder.Entity<IdentityUserToken<string>>(entity => entity.Property(m => m.LoginProvider).HasMaxLength(200));
            modelBuilder.Entity<IdentityUserToken<string>>(entity => entity.Property(m => m.Name).HasMaxLength(200));
            modelBuilder.Entity<IdentityUserClaim<string>>(entity => entity.Property(m => m.UserId).HasMaxLength(200));

            modelBuilder.Entity<Course_Module>().HasKey(x => new { x.id_course, x.id_module });
            modelBuilder.Entity<Course_User>().HasKey(x => new { x.id_course, x.id_user });
            modelBuilder.Entity<Module_Video>().HasKey(x => new { x.id_video, x.id_module });
            modelBuilder.Entity<Subscription_User>().HasKey(x => new { x.id_subscription, x.id_user });
            modelBuilder.Entity<Organization_User>().HasKey(x => new { x.id_user, x.id_organization });
            modelBuilder.Entity<Course_Organization_Playlist>().HasKey(x => new { x.id_video, x.id_module });
            modelBuilder.Entity<Module_Video_Detail>().HasKey(x => new { x.IdModule, x.IdVideo });
        }
    }
}