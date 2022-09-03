using System;
using System.Collections.Generic;
using System.Text;
using StudentManagerment.Models;

namespace StudentManagerment.Core.Interfaces
{
    public interface IStudentService
    {
        void loadData();
        Student find(string maSV);
        List<Student> getAllStudent();
        void showInfo(Student student); // xuất thông tin cơ bản của sinh viên
        void showInfoDetail(Student student); // xuất tất cả thông tin của sinh viên
    }
}
