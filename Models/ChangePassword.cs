using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIWebService.Models
{
    public class ChangePassword
    {
        public string NewPassword { get; set; }
        public bool Succeeded { get; set; }
        public string Message { get; set; }
    }
}
