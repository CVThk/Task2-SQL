using System;
using System.Collections.Generic;
using System.Text;
using StudentManagerment.Core.Interfaces;
using StudentManagerment.Models;
using StudentManagerment.Data;


namespace StudentManagerment.Core.Services
{
    public class SubjectService : ISubjectService
    {
        List<Subject> list;
        public SubjectService() { }
        

        public void loadData()
        {
            list = new Database().getAllSubject();
        }
        public List<Subject> getAllSubject()
        {
            return list;
        }
    }
}
