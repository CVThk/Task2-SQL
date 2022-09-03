using System;
using System.Collections.Generic;
using System.Text;

namespace StudentManagerment.Models
{
    public class Result
    {
        public Subject MonHoc { get; set; }
        public Scores DiemMonHoc { get; set; }

        public Result(Subject monHoc, Scores diem)
        {
            this.MonHoc = monHoc;
            this.DiemMonHoc = diem;
        }
    }
}
