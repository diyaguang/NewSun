using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Web;
using ICSharpCode.SharpZipLib.Zip;

namespace Com.NewSun.Common
{

    public class FileHelper : IFileToUpload
    {
        ////文件夹路径物理路径
        static string _zipName = "\\download" + DateTime.Now.ToString("yyyy-MM-dd-hh-mm") + ".zip";
        public static string GetDirectory()
        {
            string url = System.Configuration.ConfigurationManager.AppSettings["UpLoad"].ToString() + "/" + DateTime.Now.ToString("yyyy");
            if (!System.IO.Directory.Exists(HttpContext.Current.Server.MapPath("~/" + url)))
            {
                System.IO.Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/" + url));
            }
            url += "/" + DateTime.Now.ToString("MM");
            if (!System.IO.Directory.Exists(HttpContext.Current.Server.MapPath("~/" + url)))
            {
                System.IO.Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/" + url));
            }
            url += "/" + DateTime.Now.ToString("dd") + "/";
            if (!System.IO.Directory.Exists(HttpContext.Current.Server.MapPath("~/" + url)))
            {
                System.IO.Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/" + url));
            }
            return url;
        }
        public static string CreateDirectory(string strDir)
        {
            string strRes = HttpContext.Current.Server.MapPath("~/" + strDir);

            if (!Directory.Exists(strDir))
            {
                Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/" + strDir));
            }
            return strRes;
        }

        #region 利用SharpZipLib压缩文件

        public void filesToZip(IEnumerable<string> filesPath, string zipPath)
        {
            ZipOutputStream u = new ZipOutputStream(System.IO.File.Create(zipPath));
            foreach (var item in filesPath)
            {
                this.AddZipEntry(item, u, out u);
            }
            u.Finish();
            u.Close();
            //return result;
        }

        public void FilesToZip(IEnumerable<VirFile> files, string zipPath)
        {
            ZipOutputStream u = new ZipOutputStream(System.IO.File.Create(zipPath));
            foreach (var item in files)
            {
                this.AddZipEntry(item.Path, item.RealName, u, out u);
            }
            u.Finish();
            u.Close();
        }



        //文件打包
        public void FileToZip(string filePath, string ZipPath)
        {
            //判断是否存在
            if (Directory.Exists(filePath))
            {
                //打开文件夹
                DirectoryInfo SourceDir = new DirectoryInfo(filePath);
                List<string> listFilePath = new List<string>();
                // 得到文件夹里面所有文件路径
                foreach (FileSystemInfo file in SourceDir.GetFileSystemInfos())
                    listFilePath.Add(file.FullName);
                if (listFilePath.Count > 0)
                {
                    ZipOutputStream u = new ZipOutputStream(System.IO.File.Create(ZipPath));  //新建压缩文件流   “ZipOutputStream”
                    foreach (string s in listFilePath)
                    {
                        this.AddZipEntry(s, u, out u);
                    }
                    u.Finish();   //   结束压缩
                    u.Close();
                }
            }
        }

        /// <summary>
        /// 添加压缩项目
        /// </summary>
        /// <param name="p">p 为需压缩的文件或文件夹</param>
        /// <param name="u">u为现有的源ZipOutputStream</param>
        /// <param name="j">out j为已添加“ZipEntry”的“ZipOutputStream”</param>
        public void AddZipEntry(string p, ZipOutputStream u, out ZipOutputStream j)
        {
            if (System.IO.File.Exists(p))     //文件的处理
            {
                u.SetLevel(9);             //压缩等级
                FileStream f = System.IO.File.OpenRead(p);
                byte[] b = new byte[f.Length];
                f.Read(b, 0, b.Length);                     //将文件流加入缓冲字节中
                ZipEntry z = new ZipEntry(Path.GetFileName(p));
                u.PutNextEntry(z);                           //为压缩文件流提供一个容器
                u.Write(b, 0, b.Length);   //写入字节
                f.Close();
            }
            j = u;         //返回已添加数据的“ZipOutputStream”
        }

        public void AddZipEntry(string path, string rename, ZipOutputStream u, out ZipOutputStream j)
        {
            if (System.IO.File.Exists(path))     //文件的处理
            {
                u.SetLevel(9);             //压缩等级
                FileStream f = System.IO.File.OpenRead(path);
                byte[] b = new byte[f.Length];
                f.Read(b, 0, b.Length);                     //将文件流加入缓冲字节中
                ZipEntry z = new ZipEntry(Path.GetFileName(rename));
                u.PutNextEntry(z);                           //为压缩文件流提供一个容器
                u.Write(b, 0, b.Length);   //写入字节
                f.Close();
            }
            j = u;         //返回已添加数据的“ZipOutputStream”
        }

        #endregion

        #region 文件操作

        public static string RenameExistFile(string path, string filename)
        {
            int diffname = 1;
            string refilename = filename;
            while (System.IO.File.Exists(Path.Combine(path, refilename)))
            {
                refilename = filename.Insert(filename.LastIndexOf('.'), "_" + (diffname++));// filename + "_" + (diffname++);
            }
            filename = refilename;
            return filename;
        }
        /// <summary>
        /// 计算文件大小函数(保留两位小数),Size为字节大小
        /// </summary>
        /// <param name="Size">初始文件大小</param>
        /// <returns></returns>
        public static string CountSize(long Size)
        {
            long FactSize = 0;
            FactSize = Size;
            string filezise = "";
            if (FactSize < 1024.00)
                filezise = FactSize.ToString("F2") + "(Byte)";
            else if (FactSize >= 1024.00 && FactSize < 1048576)
                filezise = (FactSize / 1024.00).ToString("F2") + "(KB)";
            else if (FactSize >= 1048576 && FactSize < 1073741824)
                filezise = (FactSize / 1024.00 / 1024.00).ToString("F2") + "(MB)";
            else if (FactSize >= 1073741824)
                filezise = (FactSize / 1024.00 / 1024.00 / 1024.00).ToString("F2") + "(GB)";
            return filezise;
        }

        #endregion

        private HttpPostedFileBase _fileData;
        public HttpPostedFileBase FileData
        {
            set { _fileData = value; }
        }

        private string _saveName;
        public string SaveName
        {
            get { return _saveName; }
        }

        private string _fileName;
        public string FileName
        {
            get { return _fileName; }
        }

        private string _savePath;
        public string SavePath
        {
            get { return _savePath; }
        }

        public int FileZise
        {
            get { return _fileData.ContentLength; }
        }

        public FileHelper()
        {
        }

        public FileHelper(HttpPostedFileBase fileData, string fileConfigName)
        {

            try
            {
                _fileData = fileData;
                _fileName = fileData.FileName;   //从文件流中读取文件名称
                if (_fileName != null && _fileName.Length > 64) throw new FileUploadException("3##上传异常!错误原因:文件名太长！请不要上传超过32个字符的文件名称。");
                _saveName = string.Format("{0}{1}", Utilitys.GetStreamMD5(fileData.InputStream), Path.GetExtension(FileName));
                //文件存储的相对路径
                var virtualPath = string.Format("Upload\\{0}\\{1}\\{2}\\{3}",
                    DateTime.Now.Year.ToString(),
                    DateTime.Now.ToString("MM"),
                    DateTime.Now.ToString("dd"),
                    SaveName);   // 按时间存放的相对文件夹
                var pathConfig = fileConfigName;
                _savePath = Path.Combine(pathConfig, virtualPath);        // 保存的虚拟路径
                var fullPath = Path.Combine(CommonHelper.GetConfigString("FileServicePath"), _savePath);     // 完整路径
                var path = Path.GetDirectoryName(fullPath);     // 获取目录名字
                Directory.CreateDirectory(path);                   //  创建目录
                if (!System.IO.File.Exists(fullPath))          //  判断文件是否存在
                    fileData.SaveAs(fullPath);                 // 保存文件
            }
            catch (Exception ex)
            {
                throw new FileUploadException("3##上传异常!错误原因:" + ex);
            }

        }

    }

    public class VirFile
    {
        public string Path { get; set; }
        public string RealName { get; set; }
        public string FolderName { get; set; }
    }
}

#region  文件异常类
[Serializable]
public class FileUploadException : Exception
{
    public FileUploadException()
    {
    }

    public FileUploadException(string message)
        : base(message)
    {
    }

    public FileUploadException(string message, Exception inner)
        : base(message, inner)
    {
    }

    protected FileUploadException(
        SerializationInfo info,
        StreamingContext context)
        : base(info, context)
    {
    }
}
#endregion
