using System;
using System.Collections.Generic;
using System.Text;

namespace StudentManagerment.Models
{
    public class Subject
    {
        #region attribute
        public string MaMonHoc { get; set; }
        public string TenMonHoc { get; set; }
        public int SoTiet { get; set; }
        public double TyLeQT { get; set; }
        public double TyLeTP { get; set; }
        #endregion

        #region contructor
        public Subject() { }
        public Subject(string maMonHoc, string tenMonHoc, int soTiet, double tyLeQuaTrinh, double tyLeThanhPhan)
        {
            this.MaMonHoc = maMonHoc;
            this.TenMonHoc = tenMonHoc;
            this.SoTiet = soTiet;
            this.TyLeQT = tyLeQuaTrinh;
            this.TyLeTP = tyLeThanhPhan;
        }
        #endregion
    }
}
