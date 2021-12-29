using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace APIWebService.Data.Entities
{
    public class Author
    {
        public int ID { get; set; }
        public int id_basic_information { get; set; }
        [ForeignKey("id_basic_information")]
        public Basic_Information basic_information { get; set; }
        public string facebook_link { get; set; }
        public string linkedin_link { get; set; }
        public string description { get; set; }
        public string studies { get; set; }
        public string work { get; set; }
        public string specialty { get; set; }
        public int total_courses { get; set; }
        public int status { get; set; }
        public DateTime created_on { get; }
        public DateTime modified_on { get; }
        public int id_user_modified_by { get; set; }
    }
}
