using System;
using System.Collections.Generic;
using System.Text;
using StudentManagerment.Core.Interfaces;
using StudentManagerment.Data;
using StudentManagerment.Models;
using StudentManagerment.Utilities;

namespace StudentManagerment.Core.Services
{
    public class TranscriptService : ITranscriptService
    {
        List<Transcript> list;
        public TranscriptService() { }

        public void loadData()
        {
            list = new Database().getAllTranscript();
        }
        public List<Transcript> getAllTranscript()
        {
            return list;
        }

        public void showInfo(Student student, Transcript transcript, IStudentService studentService)
        {
            studentService.showInfo(student);
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine("\n\t[>]BẢNG ĐIỂM");
            Console.ResetColor();
            Title title = new Title();
            title.showTitleTranscript();

            foreach (Result result in transcript.bangDiem)
            {
                string diemQuaTrinh = (result.DiemMonHoc.DiemQuaTrinh == -1) ? "" : result.DiemMonHoc.DiemQuaTrinh.ToString();
                string diemThanhPhan = (result.DiemMonHoc.DiemThanhPhan == -1) ? "" : result.DiemMonHoc.DiemThanhPhan.ToString();
                Console.WriteLine("\t{0,-15}{1,-50}{2,-10}{3,-20}{4,-20}", result.MonHoc.MaMonHoc, result.MonHoc.TenMonHoc, result.MonHoc.SoTiet, diemQuaTrinh, diemThanhPhan);
            }
        }

        public void showResult(Transcript transcript)
        {
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine("\n\t[>]BẢNG ĐIỂM");
            Console.ResetColor();
            new Title().showTitleTranscript();
            foreach (Result result in transcript.bangDiem)
            {
                string kq = result.DiemMonHoc.DiemQuaTrinh * result.MonHoc.TyLeQT + result.DiemMonHoc.DiemThanhPhan * result.MonHoc.TyLeTP >= 4 ? "Đỗ" : "Trượt";
                string diemQuaTrinh = (result.DiemMonHoc.DiemQuaTrinh == -1) ? "" : result.DiemMonHoc.DiemQuaTrinh.ToString();
                string diemThanhPhan = (result.DiemMonHoc.DiemThanhPhan == -1) ? "" : result.DiemMonHoc.DiemThanhPhan.ToString();
                Console.WriteLine("\t{0,-15}{1,-50}{2,-10}{3,-20}{4,-20}{5,-10}", result.MonHoc.MaMonHoc, result.MonHoc.TenMonHoc, result.MonHoc.SoTiet, diemQuaTrinh, diemThanhPhan, kq);
            }
        }

        public void upScores(string maMonHoc, Transcript transcript)
        {
            foreach (Result result in transcript.bangDiem)
            {
                if (result.MonHoc.MaMonHoc == maMonHoc.ToUpper())
                {
                    double diemQuaTrinh, diemThanhPhan;
                    bool kt;
                    do
                    {
                        Console.Write("\tNhập điểm quá trình: ");
                        kt = double.TryParse(Console.ReadLine(), out diemQuaTrinh);
                    } while (kt == false || diemQuaTrinh < 0 || diemQuaTrinh > 10);
                    do
                    {
                        Console.Write("\tNhập điểm thành phần: ");
                        kt = double.TryParse(Console.ReadLine(), out diemThanhPhan);
                    } while (kt == false || diemThanhPhan < 0 || diemThanhPhan > 10);
                    result.DiemMonHoc.DiemQuaTrinh = diemQuaTrinh;
                    result.DiemMonHoc.DiemThanhPhan = diemThanhPhan;
                    // update database
                    new Database().updateTranscript(result, transcript.MaSinhVien);
                    return;
                }
            }
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("\tKhông tìm thấy môn học trong danh sách hiện tại!");
            Console.ResetColor();
        }
    }
}
