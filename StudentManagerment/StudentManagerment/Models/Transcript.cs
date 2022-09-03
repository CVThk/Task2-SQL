using System;
using System.Collections.Generic;
using System.Text;

namespace StudentManagerment.Models
{
    public class Transcript
    {
        public List<Result> bangDiem;
        public string MaSinhVien { get; set; }

        public Transcript(string mssv, List<Result> bangDiem)
        {
            MaSinhVien = mssv;
            this.bangDiem = bangDiem;
        }
    }
}
