using System;
using System.Collections.Generic;
using System.Text;
using StudentManagerment.Models;
using StudentManagerment.Core.Interfaces;
using StudentManagerment.Data;

namespace StudentManagerment.Core.Services
{
    public class StudentService : IStudentService
    {
        List<Student> list;
        public void loadData()
        {
            list = new Database().getAllStudent();
        }
        public StudentService() { }
        public Student find(string maSV)
        {
            return list.Find(t => t.MaSinhVien == maSV);
        }

        public List<Student> getAllStudent()
        {
            return list;
        }

        public void showInfo(Student student)
        {
            Console.WriteLine("\t{0,-15}{1,-30}{2,-15}{3,-15}{4,-10}", student.MaSinhVien, student.Ten, student.Lop, student.GioiTinh, student.NgaySinh.ToShortDateString());
        }

        public void showInfoDetail(Student student)
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("\n\tTHÔNG TIN SINH VIÊN");
            Console.ResetColor();
            Console.WriteLine("\tMã sinh viên: " + student.MaSinhVien);
            Console.WriteLine("\tHọ tên: " + student.Ten);
            Console.WriteLine("\tGiới tính: " + student.GioiTinh);
            Console.WriteLine(("\tNgày sinh: " + student.NgaySinh.ToShortDateString()).PadRight(30) + ("Dân tộc: " + student.DanToc).PadRight(20) + "Tôn giáo: " + student.TonGiao);
            Console.WriteLine("\tSố CMND: " + student.CMND);
            Console.WriteLine("\tĐiện thoại: " + student.SDT);
            Console.WriteLine("\tĐịa chỉ thường trú: " + student.DiaChiTT);
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("\n\tTHÔNG TIN HỌC VẤN");
            Console.ResetColor();
            Console.WriteLine(("\tTrạng thái: " + student.TrangThai).PadRight(50) + "Ngày vào trường: " + student.NgayVaoTruong.ToShortDateString());
            Console.WriteLine(("\tLớp: " + student.Lop).PadRight(50) + "Bậc đào tạo: " + student.BacDaoTao);
            Console.WriteLine(("\tKhoa: " + student.Khoa).PadRight(50) + "Khóa học: " + student.KhoaHoc);
        }
    }
}