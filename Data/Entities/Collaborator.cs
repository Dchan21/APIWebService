using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace APIWebService.Data.Entities
{
    public class Collaborator
    {
        public int ID { get; set; }
        public int id_basic_information { get; set; }
        [ForeignKey("id_basic_information")]
        public Basic_Information basic_information { get; set; }
        public int id_organization { get; set; }
        [ForeignKey("id_organization")]
        public Organization organization { get; set; }
        public int id_team { get; set; }
        public int id_department { get; set; }
        public int status { get; set; }
        public DateTime created_on {get;}
        public DateTime modified_on {get;}
        public int id_user_modified_by { get; set; }

    }
}