using APIWebService.Data.Entities;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIWebService.Models
{
    public class ApplicationUser: IdentityUser
    {
        public int UserID { get; set; }
        public virtual User User { get; set; }
    }
}
