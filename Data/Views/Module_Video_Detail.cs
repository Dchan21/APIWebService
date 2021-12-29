using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace APIWebService.Data.Entities
{
    public class Module_Video_Detail
    {
        public int IdModule { get; set; }
        public string NameModule { get; set; }
        public string DescriptionModule { get; set; }
        public decimal PercentDone { get; set; }
        public int IdVideo { get; set; }
        public string NameVideo { get; set; }
        public string Description { get; set; }
        public string Url { get; set; }
        public int Minutes { get; set; }
        public int Seconds { get; set; }
        public int IdAuthor { get; set; }
        public string Author { get; set; }
        public int Viewed { get; set; }
        public int Order { get; set; }
    }
}
