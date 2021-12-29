using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace APIWebService.Data.Entities
{
    public class Course
    {
        public int ID { get; set; }
        [Required]
        public string name { get; set; }
        public int id_category { get; set; }
        [ForeignKey("id_category")]
        public Category category { get; set; }
        public string image { get; set; }
        public string icon { get; set; }
        public string description { get; set; }
        public string short_description { get; set; }
        public int level { get; set; }
        public int id_author { get; set; }
        [ForeignKey("id_author")]
        public Author author { get; set; }
        public string slug { get; set; }
        public string video_introduction { get; set; }
        public int language { get; set; }
        public int search_count { get; set; }
        public string prerequisites { get; set; }
        public int total_minutes { get; set; }
        public int total_seconds { get; set; }
        public string characteristics { get; set; }
        public int certificate { get; set; }
        public int like_quantity { get; set; }
        public int feature { get; set; }
        public int status { get; set; }
        public DateTime created_on { get; }
        public DateTime modified_on { get; }
        public int id_user_modified_by { get; set; }
    }


}