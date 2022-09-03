using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;

using StudentManagerment.Data;
using StudentManagerment.Models;

namespace StudentManagerment.Data
{
    public class Database
    {
        public DataTable fillData(string stringSqlConnection, string stringCommand)
        {
            DataTable data = new DataTable();
            using (SqlConnection sqlConnection = new SqlConnection(stringSqlConnection))
            {
                sqlConnection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(stringCommand, sqlConnection);
                adapter.Fill(data);
                sqlConnection.Close();
            }
            return data;
        }


        public string getStringConnection(string serverName, string databaseName, string id, string pass)
        {
            return @"Data Source=" + serverName + ";Initial Catalog=" + databaseName + ";User ID=" + id + ";Password=" + pass;
        }

        public string getStringConnection(string serverName, string databaseName)
        {
            return "Data Source=" + serverName + ";Initial Catalog=" + databaseName + ";Integrated Security=True";
        }

        public List<Student> getAllStudent()
        {
            List<Student> ds = new List<Student>();
            DataTable data = fillData(getStringConnection(@"CVTHINH\SQLEXPRESS", "StudentManagerment"), @"SELECT * FROM SINHVIEN");
            foreach (DataRow row in data.Rows)
            {
                string mssv = row["mssv"].ToString().Trim();
                string ten = row["tensv"].ToString().Trim();
                string gt = row["gioitinh"].ToString().Trim();
                DateTime ns = DateTime.ParseExact(((DateTime)row["NgaySinh"]).ToShortDateString(), "dd/MM/yyyy", null);
                DateTime nvt = DateTime.ParseExact(((DateTime)row["NgayVaoTruong"]).ToShortDateString(), "dd/MM/yyyy", null);
                string lop = row["Lop"].ToString().Trim();
                string khoa = row["Khoa"].ToString().Trim();
                string trangthai = row["TrangThai"].ToString().Trim();
                string bacdaotao = row["BacDaoTao"].ToString().Trim();
                string sdt = row["SDT"].ToString().Trim();
                string cmnd = row["CMND"].ToString().Trim();
                string diachithuongtru = row["Diachi"].ToString().Trim();
                string dantoc = row["DanToc"].ToString().Trim();
                string tongiao = row["TONGIAO"].ToString().Trim();
                ds.Add(new Student(mssv, ten, gt, lop, ns, nvt, khoa, trangthai, bacdaotao, sdt, cmnd, diachithuongtru, dantoc, tongiao));
            }
            return ds;
        }

        public List<Subject> getAllSubject()
        {
            List<Subject> ds = new List<Subject>();
            DataTable data = fillData(getStringConnection(@"CVTHINH\SQLEXPRESS", "StudentManagerment"), @"SELECT * FROM MONHOC");
            foreach (DataRow row in data.Rows)
            {
                string maMH = row["MAMH"].ToString().Trim();
                string tenMH = row["TENMH"].ToString().Trim();
                int soTiet = int.Parse(row["SoTiet"].ToString());
                double tlQT = double.Parse(row["TyLeQuaTrinh"].ToString());
                double tlTP = double.Parse(row["TyLeThanhPhan"].ToString());
                ds.Add(new Subject(maMH, tenMH, soTiet, tlQT, tlTP));
            }
            return ds;
        }

        public List<Transcript> getAllTranscript()
        {
            List<Transcript> ds = new List<Transcript>();
            DataTable data = fillData(getStringConnection(@"CVTHINH\SQLEXPRESS", "StudentManagerment"), @"SELECT * FROM bangDiem");
            foreach (DataRow row in data.Rows)
            {
                string mssv = row["MSSV"].ToString().Trim();
                string maMH = row["MAMH"].ToString().Trim();
                string tenMH = row["TENMH"].ToString().Trim();
                int soTiet = int.Parse(row["SoTiet"].ToString());
                double diemQuaTrinh = double.Parse(row["DiemQuaTrinh"].ToString());
                double diemThanhPhan = double.Parse(row["DiemThanhPhan"].ToString());
                double tyLeQuaTrinh = double.Parse(row["TYLEQUATRINH"].ToString());
                double tyLeThanhPhan = double.Parse(row["TYLETHANHPHAN"].ToString());
                Transcript tam = ds.Find(t => t.MaSinhVien == mssv);
                if (tam != null)
                {
                    tam.bangDiem.Add(new Result(new Subject(maMH, tenMH, soTiet, tyLeQuaTrinh, tyLeThanhPhan), new Scores(diemQuaTrinh, diemThanhPhan)));
                }
                else
                {
                    List<Result> ketQuaMonHoc = new List<Result>();
                    ketQuaMonHoc.Add(new Result(new Subject(maMH, tenMH, soTiet, tyLeQuaTrinh, tyLeThanhPhan), new Scores(diemQuaTrinh, diemThanhPhan)));
                    ds.Add(new Transcript(mssv, ketQuaMonHoc));
                }
            }
            return ds;
        }

        // cập nhật lại điểm trên SQL
        public void updateTranscript(Result result, string maSV)
        {
            using (SqlConnection sqlConnection = new SqlConnection(getStringConnection(@"CVTHINH\SQLEXPRESS", "StudentManagerment")))
            {
                sqlConnection.Open();
                SqlCommand command = new SqlCommand(@"UPDATE DIEM SET DIEMQUATRINH = @diemQuaTrinh, DIEMTHANHPHAN = @diemThanhPhan WHERE MSSV = @mssv AND MAMH = @mamh", sqlConnection);
                command.Parameters.Add("@diemQuaTrinh", SqlDbType.Float).Value = result.DiemMonHoc.DiemQuaTrinh;
                command.Parameters.Add("@diemThanhPhan", SqlDbType.Float).Value = result.DiemMonHoc.DiemThanhPhan;
                command.Parameters.Add("@mssv", SqlDbType.Char).Value = maSV;
                command.Parameters.Add("@mamh", SqlDbType.Char).Value = result.MonHoc.MaMonHoc;
                // Thực thi Command (Dùng cho delete, insert, update).
                int rowCount = command.ExecuteNonQuery();
                Console.WriteLine("\t{0} row(s) affected", rowCount);
            }
        }
    }
}
