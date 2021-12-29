using Wellness_SDK.Data.Entities;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Wellness_SDK.Models
{
    public class ApplicationUser: IdentityUser
    {
        public int UserID { get; set; }
        public virtual User User { get; set; }
    }
}
