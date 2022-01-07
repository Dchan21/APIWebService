using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace APIWebService.Data.Entities
{
   public class Course_Module
    {
        public int ID { get; set; }
        public int id_course { get; set; }
        [ForeignKey("id_course")]
        public Course course { get; set; }
        public int  id_module { get; set; }
        [ForeignKey("id_module")]
        public Module module { get; set; }
        public int status { get; set; }
        public DateTime created_on { get; }
        public DateTime modified_on { get; }
        public int id_user_modified_by { get; set; }
    }
}
