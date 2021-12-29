using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace APIWebService.Data.Entities
{
    public class Module_Video
    {
        public int ID { get; set; }
        public int id_module { get; set; }
        [ForeignKey("id_module")]
        public Module module { get; set; }
        public int id_video { get; set; }
        [ForeignKey("id_video")]
        public Video video { get; set; }
        public int status { get; set; }
        public DateTime created_on { get; }
        public DateTime modified_on { get; }
        public int id_user_modified_by { get; set; }
    }
}
