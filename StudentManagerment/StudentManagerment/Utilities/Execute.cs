using System;
using System.Collections.Generic;
using System.Text;
using StudentManagerment.Core.Interfaces;
using StudentManagerment.Core.Services;
using StudentManagerment.Models;

namespace StudentManagerment.Utilities
{
    public class Execute
    {
        public void runMain()
        {
            try
            {
                Console.SetWindowSize(150, 40);
                Title title = new Title();
                
                IStudentService studentService = new StudentService();
                studentService.loadData(); // load data from SQL
                List<Student> dssv = studentService.getAllStudent();

                ISubjectService subjectService = new SubjectService();
                subjectService.loadData();
                List<Subject> dsmh = subjectService.getAllSubject();

                ITranscriptService transcriptService = new TranscriptService();
                transcriptService.loadData();
                List<Transcript> dsbd = transcriptService.getAllTranscript();

                int ttChucNang;
                menu();
                while (true)
                {
                    Console.ForegroundColor = ConsoleColor.Blue;
                    Console.Write("\n\tNhập chức năng: ");

                    bool ktNhap = int.TryParse(Console.ReadLine(), out ttChucNang);
                    if (!ktNhap)
                        throw new Exception("nhập sai thứ tự chức năng!");
                    Console.ResetColor();


                    if (ttChucNang == 0)
                        break;
                    else if (ttChucNang == 1)
                    {
                        title.showTitleStudent();
                        dssv.ForEach(t => studentService.showInfo(t));
                    }
                    else if (ttChucNang == 2)
                    {
                        string maSV;
                        Console.Write("\tNhập mã sinh viên để xem thông tin: ");
                        maSV = Console.ReadLine();
                        Student f = dssv.Find(t => t.MaSinhVien == maSV);
                        if (f == null)
                        {
                            showFail();
                        }
                        else
                        {
                            showSuccessful();
                            studentService.showInfoDetail(f);
                        }
                    }
                    else if (ttChucNang == 3)
                    {
                        title.showTitleSubject();
                        List<string> dsMH_DaXuat = new List<string>();
                        foreach (Transcript bd in dsbd)
                        {
                            foreach (Result k in bd.bangDiem)
                            {
                                if (dsMH_DaXuat.Find(t => t == k.MonHoc.MaMonHoc) == null)
                                {
                                    Console.WriteLine("\t{0,-15}{1,-50}{2,-10}", k.MonHoc.MaMonHoc, k.MonHoc.TenMonHoc, k.MonHoc.SoTiet.ToString());
                                    dsMH_DaXuat.Add(k.MonHoc.MaMonHoc);
                                }
                            }
                        }
                    }
                    else if (ttChucNang == 4)
                    {
                        string masv;
                        Console.Write("\tNhập mã sinh viên để xem điểm: ");
                        masv = Console.ReadLine();
                        Transcript bdsv = dsbd.Find(t => t.MaSinhVien == masv);
                        if (bdsv == null)
                        {
                            showFail();
                        }
                        else
                        {
                            showSuccessful();
                            transcriptService.showInfo(studentService.find(masv), bdsv, studentService);
                        }
                    }
                    else if (ttChucNang == 5)
                    {
                        string masv;
                        Console.Write("\tNhập mã sinh viên để nhập điểm: ");
                        masv = Console.ReadLine();
                        Transcript bdsv = dsbd.Find(t => t.MaSinhVien == masv);
                        if (bdsv == null)
                        {
                            showFail();
                        }
                        else
                        {
                            showSuccessful();
                            transcriptService.showInfo(studentService.find(masv), bdsv, studentService);
                            Console.Write("\tNhập mã môn học: ");
                            string mamh = Console.ReadLine();
                            transcriptService.upScores(mamh, bdsv);
                        }
                    }
                    else if (ttChucNang == 6)
                    {
                        string masv;
                        Console.Write("\tNhập mã sinh viên để xem kết quả: ");
                        masv = Console.ReadLine();
                        Transcript bdsv = dsbd.Find(t => t.MaSinhVien == masv);
                        if (bdsv == null)
                        {
                            showFail();
                        }
                        else
                        {
                            showSuccessful();
                            studentService.showInfo(dssv.Find(t => t.MaSinhVien == masv));
                            transcriptService.showResult(bdsv);
                        }
                    }
                    else throw new Exception("nhập sai thứ tự chức năng!");
                }
            }
            catch (Exception e)
            {
                Console.ForegroundColor = ConsoleColor.DarkRed;
                Console.WriteLine("Lỗi: " + e.Message);
                Console.ReadLine();
            }
        }

        void showSuccessful()
        {
            Console.ForegroundColor = ConsoleColor.Green;
            Console.Write("\t[>]Tìm thấy");
            Console.ResetColor();
        }
        void showFail()
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("\tKhông tìm thấy sinh viên trong danh sách hiện tại!");
            Console.ResetColor();
        }
        private void menu()
        {
            Console.Clear();
            Console.WriteLine("\t\t----------------- CHỨC NĂNG -----------------");
            Console.WriteLine("\t\t1. Xem danh sách sinh viên.");
            Console.WriteLine("\t\t2. Xem chi tiết sinh viên.");
            Console.WriteLine("\t\t3. Xem số môn học sinh viên đăng ký.");
            Console.WriteLine("\t\t4. Xem điểm môn học của sinh viên.");
            Console.WriteLine("\t\t5. Nhập điểm của sinh viên.");
            Console.WriteLine("\t\t6. Xem kết quả trượt đỗ của sinh viên.");
            Console.WriteLine("\t\t0. Thoát.");
            Console.Write("\t\t---------------------------------------------");
        }
    }
}
