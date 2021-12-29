using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace APIWebService.Data.Entities
{
    public class User
    {
        public int ID { get; set; }
        public int id_entity { get; set; }
        public int user_type { get; set; }
        public int language { get; set; }
        public int status { get; set; }
        public int terms_conditions { get; set; }
        public int login_failed { get; set; }
        public DateTime last_login { get; set; }
        public DateTime created_on {get;}
        public DateTime modified_on {get;}
        public int id_user_modified_by { get; set; }

    }
}
