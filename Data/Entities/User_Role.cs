using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace APIWebService.Data.Entities
{
    public class User_Role
    {
        public int id_user { get; set; }
        [ForeignKey("id_user")]
        public User user { get; set; }
        public int id_role { get; set; }
        [ForeignKey("id_role")]
        public Role role { get; set; }
        public int status { get; set; }
        public DateTime created_on { get; }
        public DateTime modified_on { get; }
        public int id_user_modified_by { get; set; }
    }
}