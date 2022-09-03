using System;
using System.Collections.Generic;
using System.Text;
using StudentManagerment.Models;

namespace StudentManagerment.Core.Interfaces
{
    public interface ISubjectService
    {
        void loadData();
        List<Subject> getAllSubject();
    }
}
