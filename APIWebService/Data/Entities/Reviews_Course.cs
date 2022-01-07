using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace APIWebService.Data.Entities
{
   public class Reviews_Course
    {
        public int ID { get; set; }
        public int id_course { get; set; }
        [ForeignKey("id_course")]
        public Course course { get; set; }
        public decimal rate_course { get; set; }
        public decimal rate_author { get; set; }
        public decimal rate_material { get; set; }
        public string comment { get; set; }
        public int id_user { get; set; }
        [ForeignKey("id_user")]
        public User user { get; set; }
        public int status { get; set; }
        public DateTime created_on { get; }
        public DateTime modified_on { get; }
        public int id_user_modified_by { get; set; }
    }
}
