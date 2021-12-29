using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace APIWebService.Data.Entities
{
   public class Course_Price
    {
        public int ID { get; set; }
        public int id_course { get; set; }
        [ForeignKey("id_course")]
        public Course course { get; set; }
        public decimal price { get; set; }
        public int currency { get; set; }
        public decimal discount_amount { get; set; }
        public int discount_percentage { get; set; }
        public DateTime discount_start_date { get; set; }
        public DateTime discount_end_date { get; set; }
        public int status { get; set; }
        public DateTime created_on { get; }
        public DateTime modified_on { get; }
        public int id_user_modified_by { get; set; }
    }
}
