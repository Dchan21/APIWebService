using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace APIWebService.Data.Entities
{
    public class Localization
    {
        public int ID { get; set; }
        public int id_user { get; set; }
        [ForeignKey("id_user")]
        public User User { get; set; }
        public string address { get; set; }
        public string address2 { get; set; }
        public string latitude { get; set; }
        public string longitude { get; set; }
        public string state { get; set; }
        public string city { get; set; }
        public string district { get; set; }
        public string country { get; set; }
        public int status { get; set; }
        public DateTime created_on {get;}
        public DateTime modified_on {get;}
        public int id_user_modified_by { get; set; }
    }

}