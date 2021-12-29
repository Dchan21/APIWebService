using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace APIWebService.Data.Entities
{
    public class Subscription_User
    {
        public int ID { get; set; }
        public int id_subscription { get; set; }
        [ForeignKey("id_subscription")]
        public Subscription subscription { get; set; }
        public int id_user { get; set; }
        [ForeignKey("id_user")]
        public User user { get; set; }
        public int master { get; set; }
        public DateTime start_date { get; set; }
        public DateTime finish_date { get; set; }
        public int status { get; set; }
        public DateTime created_on { get; }
        public DateTime modified_on { get; }
        public int id_user_modified_by { get; set; }
    }
}
