using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace APIWebService.Data.Entities
{
    public class Organization
    {
        public int ID { get; set; }
        public string logo { get; set; }
        [Required]
        public string name { get; set; }
        public string email { get; set; }
        public string phone { get; set; }
        public string legal_certificate { get; set; }
        public int id_attendant { get; set; }
        public int type_organization { get; set; }
        public int suborganization { get; set; }
        public int status {get;set;}
        public DateTime created_on {get;}
        public DateTime modified_on {get;}
        public int id_user_modified_by { get; set; }

    }
}