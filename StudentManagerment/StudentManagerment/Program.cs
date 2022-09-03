using System;
using System.Text;
using StudentManagerment.Utilities;

namespace StudentManagerment
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.InputEncoding = Encoding.Unicode;
            Console.OutputEncoding = Encoding.Unicode;
            new Execute().runMain();
        }
    }
}
