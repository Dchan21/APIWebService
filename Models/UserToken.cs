using System;
using System.Collections.Generic;

namespace APIWebService.Models
{
    public class UserToken
    {
        public string token { get; set; }
        public DateTime expiration { get; set; }
        public bool succeeded { get; set; }
        public int userId { get; set; }
        public string name { get; set; }
        public int userType { get; set; }
        public int organizationId { get; set; }
        public string profilePicture { get; set; }
        public bool changePasswordRequired { get; set; }
        public string message { get; set; }
        public List<Feature> features { get; set; }
    }
}