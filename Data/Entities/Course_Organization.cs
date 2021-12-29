using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace APIWebService.Data.Entities
{
    public class Course_Organization
    {
        public int ID { get; set; }
        public int id_course { get; set; }
        [ForeignKey("id_course")]
        public Course course { get; set; }
        public int id_organization { get; set; }
        [ForeignKey("id_organization")]
        public Organization organization { get; set; }
        public int type_course { get; set; }
        public int schedule_course { get; set; }
        public string schedule_date { get; set; }
        public int status { get; set; }
        public DateTime created_on { get; }
        public DateTime modified_on { get; }
        public int id_user_modified_by { get; set; }
    }
}
