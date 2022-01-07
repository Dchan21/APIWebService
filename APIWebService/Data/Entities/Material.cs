using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace APIWebService.Data.Entities
{
    public class Material
    {
        public int ID { get; set; }
        [Required]
        public string name { get; set; }
        public int type { get; set; }
        public int status { get; set; }
        public int extension { get; set; }
        public int download { get; set; }
        public int size { get; set; }
        public string url { get; set; }
        public DateTime created_on {get;}
        public DateTime modified_on {get;}
        public int id_user_modified_by { get; set; }

    }
}