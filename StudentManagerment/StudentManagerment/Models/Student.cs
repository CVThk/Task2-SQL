using System;
using System.Collections.Generic;
using System.Text;

namespace StudentManagerment.Models
{
    public class Student
    {
        #region attribute
        public string MaSinhVien { get; set; }
        public string Ten { get; set; }
        public string GioiTinh { get; set; }
        public DateTime NgaySinh { get; set; }
        public string Lop { get; set; }
        public int KhoaHoc // Khóa học
        {
            get { return NgayVaoTruong.Year; }
        }
        public DateTime NgayVaoTruong { get; set; } // Ngày vào trường
        public string Khoa { get; set; } // Khoa: Công nghệ Thông tin, Quản Trị Kinh Doanh, ...
        public string TrangThai { get; set; } // Trạng thái: Đang học, ra trường, ...
        public string BacDaoTao { get; set; } // Bậc đào tạo: Đại học, cao đẳng, ...
        public string SDT { get; set; } // Số điện thoại
        public string CMND { get; set; }
        public string DiaChiTT { get; set; } // Địa chỉ thường trú
        public string DanToc { get; set; }
        public string TonGiao { get; set; }
        #endregion

        #region contructor
        public Student() { }
        public Student(string masv, string ten, string gioiTinh, string lop, DateTime ngaySinh, DateTime ngayVaoTruong, string khoa, string trangThai, string bacDaoTao, string sdt, string cmnd, string diaChiThuongTru, string danToc, string tonGiao)
        {
            this.MaSinhVien = masv;
            this.Ten = ten;
            this.GioiTinh = gioiTinh;
            this.Lop = lop;
            this.NgaySinh = ngaySinh;
            this.NgayVaoTruong = ngayVaoTruong;
            this.Khoa = khoa;
            this.TrangThai = trangThai;
            this.BacDaoTao = bacDaoTao;
            this.SDT = sdt;
            this.CMND = cmnd;
            this.DiaChiTT = diaChiThuongTru;
            this.DanToc = danToc;
            this.TonGiao = tonGiao;
        }
        #endregion
    }
}
