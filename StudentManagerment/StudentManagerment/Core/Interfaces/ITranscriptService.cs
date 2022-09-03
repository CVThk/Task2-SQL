using System;
using System.Collections.Generic;
using System.Text;
using StudentManagerment.Models;

namespace StudentManagerment.Core.Interfaces
{
    public interface ITranscriptService
    {
        void loadData();
        List<Transcript> getAllTranscript();
        void showInfo(Student student, Transcript transcript, IStudentService studentService);
        void upScores(string maMonHoc, Transcript transcript); // lên điểm cho sinh viên
        void showResult(Transcript transcript); // xét đánh giá môn học là đỗ hay trượt
    }
}
