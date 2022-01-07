using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace APIWebService.Data.Entities
{
    public class Basic_Information
    {
        public int ID { get; set; }
        [Required]
        public string name { get; set; }
        [Required]
        public int id_user { get; set; }
        [ForeignKey("id_user")]
        public User User { get; set; }
        public string last_name { get; set; }
        public string profile_avatar { get; set; }
        public string passport { get; set; }
        public string identification_card { get; set; }
        public int age { get; set; }
        public DateTime birth_date { get; set; }
        public string nationality { get; set; }
        public int gender { get; set; }
        public int civil_status { get; set; }
        public int blood_type { get; set; }
        public string phone_number { get; set; }
        public string phone_number2 { get; set; }
        public string email { get; set; }
        public string job_id { get; set; }
        public int status { get; set; }
        public DateTime created_on {get;}
        public DateTime modified_on {get;}
        public int id_user_modified_by { get; set; }

    }
}