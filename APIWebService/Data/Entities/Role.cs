using System;
using System.ComponentModel.DataAnnotations;

namespace APIWebService.Data.Entities
{
    public class Role
    {
        public int ID { get; set; }
        [Required]
        public string name { get; set; }
        public int status { get; set; }
        public DateTime created_on { get; }
        public DateTime modified_on { get; }
        public int id_user_modified_by { get; set; }
    }
}