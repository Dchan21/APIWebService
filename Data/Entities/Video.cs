using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace APIWebService.Data.Entities
{
    public class Video
    {
        public int ID { get; set; }
        public string video_url { get; set; }
        [Required]
        public string name { get; set; }
        public int video_type { get; set; }
        public int order { get; set; }
        public string description { get; set; }
        public int total_views { get; set; }
        public int total_likes { get; set; }
        public int id_author { get; set; }
        [ForeignKey("id_author")]
        public Author author { get; set; }
        public int total_minutes { get; set; }
        public int total_seconds { get; set; }
        public int status { get; set; }
        public DateTime created_on { get; }
        public DateTime modified_on { get; }
        public int id_user_modified_by { get; set; }

    }
}