using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace APIWebService.Data.Entities
{
    public class Course_User
    {
        public int ID { get; set; }
        public int id_course { get; set; }
        [ForeignKey("id_course")]
        public Course course { get; set; }
        public int id_user { get; set; }
        [ForeignKey("id_user")]
        public User user { get; set; }
        public decimal percent_done { get; set; }
        public int modules { get; set; }
        public int videos { get; set; }
        public DateTime start_date { get; set; }
        public DateTime finish_date { get; set; }
        public int status { get; set; }
        public DateTime created_on {get;}
        public DateTime modified_on {get;}
        public int id_user_modified_by { get; set; }

    }
}