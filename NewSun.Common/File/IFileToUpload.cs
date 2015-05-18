using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace Com.NewSun.Common
{
    public interface IFileToUpload
    {
        HttpPostedFileBase FileData { set; }
        string SaveName { get; }
        string FileName { get; }
        string SavePath { get; }
        int FileZise { get; }
    }
}
