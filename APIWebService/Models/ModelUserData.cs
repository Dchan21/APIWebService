using System;
using System.Collections.Generic;
using System.Text;

namespace APIWebService.Models
{
   public class ModelUserData
    {
        public int UserID { get; set; }
        public int OrganizationID { get; set; }
        public int CollaboratorID { get; set; }
        public int PersonID { get; set; }
        public int AuthorID { get; set; }
        public int CoachID { get; set; }
        public int UserType { get; set; }
    }
}
