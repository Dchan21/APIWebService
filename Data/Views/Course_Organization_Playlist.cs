using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace APIWebService.Data.Entities
{

    public class Course_Organization_Playlist
    {
        //public int id_course_organization { get; set; }
        public int id_course { get; set; }
        public int id_module { get; set; }
        public int id_video { get; set; }
    }
}
