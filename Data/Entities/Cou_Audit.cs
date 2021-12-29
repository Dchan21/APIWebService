using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace APIWebService.Data.Entities
{
    public class Cou_Audit
    {
        public int ID { get; set; }
        public string identification_user { get; set; }
        public string application { get; set; }
        public string application_action { get; set; }
        public string action_details { get; set; }
        public string action_error { get; set; }
        public string error_id { get; set; }
        public string data { get; set; }
        public int status { get; set; }
        public DateTime created_on { get; }
    }
}