using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace APIWebService.Data.Entities
{
    public class Position_Collaborator
    {
        public int ID { get; set; }
        public int id_position { get; set; }
        [ForeignKey("id_position")]
        public Position position { get; set; }
        public int id_collaborator { get; set; }
        [ForeignKey("id_collaborator")]
        public Collaborator collaborator { get; set; }
        public int status { get; set; }
        public DateTime created_on {get;}
        public DateTime modified_on {get;}
        public int id_user_modified_by { get; set; }
    }
}