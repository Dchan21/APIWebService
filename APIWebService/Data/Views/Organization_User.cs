using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace APIWebService.Data.Entities
{
    public class Organization_User
    {
        public int id_collaborator { get; set; }
        public int id_organization { get; set; }
        public int id_user { get; set; }
        public int id_department { get; set; }
        public int id_team { get; set; }
        public int user_type { get; set; }
    }
}
