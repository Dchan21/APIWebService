using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace APIWebService.Data.Entities
{
    public class Video_Progress
    {
        public int ID { get; set; }
        public int id_video { get; set; }
        [ForeignKey("id_video")]
        public Video video { get; set; }
        public int id_user { get; set; }
        [ForeignKey("id_user")]
        public User user { get; set; }
        public int minutes { get; set; }
        public int seconds { get; set; }
        public int status { get; set; }
        public DateTime created_on {get;}
        public DateTime modified_on {get;}
        public int id_user_modified_by { get; set; }

    }
}