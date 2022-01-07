using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace APIWebService.Data.Entities
{
    public class Entity_Material
    {
        public int ID { get; set; }
        public int id_organization { get; set; }
        [ForeignKey("id_organization")]
        public Organization organization { get; set; }
        public int id_material { get; set; }
        [ForeignKey("id_material")]
        public Material material { get; set; }
        public int id_entity { get; set; }
        public int entity_type { get; set; }
        public DateTime start_date { get; set; }
        public DateTime finish_date { get; set; }
        public int status { get; set; }
        public DateTime created_on {get;}
        public DateTime modified_on {get;}
        public int id_user_modified_by { get; set; }

    }
}