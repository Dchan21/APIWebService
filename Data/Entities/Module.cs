using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace APIWebService.Data.Entities
{
    public class Module
    {
        public int ID { get; set; }
        [Required]
        public string name { get; set; }
        public string icon { get; set; }
        public string image { get; set; }
        public int order { get; set; }
        public string description { get; set; }
        public string slug { get; set; }
        public int total_minutes { get; set; }
        public int total_seconds { get; set; }
        public int status {get;set;}
        public DateTime created_on {get;}
        public DateTime modified_on {get;}
        public int id_user_modified_by { get; set; }

    }
}