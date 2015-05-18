using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Aspose.Cells;
using ExcelOperation;

namespace Com.NewSun.Common
{
    public class ExcelHelper
    {
        /// <summary>
        /// 读取Excel方法,将数据读取到DataSet,可读取多个Sheet
        /// </summary>
        /// <param name="dataFile"></param>
        /// <returns></returns>
        public DataSet ReadExcel(string dataFile)
        {
            DataSet dsExcel = new DataSet();
            //创建一个Workbook和Worksheet对象
            Worksheet wkSheet = null;
            Workbook wkBook = new Workbook(dataFile);

            //遍历读取sheet
            for (int i = 0; i < wkBook.Worksheets.Count; i++)
            {
                wkSheet = wkBook.Worksheets[i];
                //声明DataTable存放sheet
                DataTable dtTemp = new DataTable();
                //设置Table名为sheet的名称
                dtTemp.TableName = wkSheet.Name;
                //遍历行
                for (int x = 0; x < wkSheet.Cells.MaxDataRow + 1; x++)
                {
                    //声明DataRow存放sheet的数据行
                    DataRow dRow = null;
                    //遍历列
                    for (int y = 0; y < wkSheet.Cells.MaxDataColumn + 1; y++)
                    {
                        //获取单元格的值
                        string value = wkSheet.Cells[x, y].StringValue.Trim();
                        //如果是第一行，则当作表头
                        if (x == 0)
                        {
                            //设置表头
                            DataColumn dCol = new DataColumn(value);
                            dtTemp.Columns.Add(dCol);
                        }
                        //非第一行，则为数据行
                        else
                        {
                            //每次循环到第一列时，实例DataRow
                            if (y == 0)
                            {
                                dRow = dtTemp.NewRow();
                            }
                            //给第Y列赋值
                            dRow[y] = value;
                        }
                    }

                    if (dRow != null)
                    {
                        dtTemp.Rows.Add(dRow);
                    }
                }
                dsExcel.Tables.Add(dtTemp);
            }

            //释放对象
            wkSheet = null;
            wkBook = null;

            //返回数据
            return dsExcel;
        }

        /// <summary>
        /// 读取Excel方法,将数据读取到DataTable,需要读入配置
        /// </summary>
        /// <param name="postedFile"></param>
        /// <param name="readConfig"></param>
        /// <returns></returns>
        public DataTable ReadExcel(System.Web.HttpPostedFile postedFile,string readConfig)
        {
            try
            {
                string[] tmpConfigItems = readConfig.Split(new char[] {'|'});
                if (tmpConfigItems.Count() != 6)
                    throw new Exception("读取配置错误");
                Import import = new Import();
                DataTable tmpdt = import.ImportExcelFile(import.GetWorkBook(postedFile), tmpConfigItems[0].ToInt(),
                    tmpConfigItems[1].ToInt(), tmpConfigItems[2].ToInt(), tmpConfigItems[3].ToInt(),
                    tmpConfigItems[4].ToInt(), tmpConfigItems[5].ToInt());
                return tmpdt;
            }
            catch (Exception ex)
            {
                throw new Exception("读取Excel发生错误(PostedFile),原因:" + ex.Message, ex);
            }
        }

        /// <summary>
        /// 导出数据到Excel中,传入DataSet,可写入多个Sheet
        /// </summary>
        /// <param name="dsExcel"></param>
        /// <param name="outFileName"></param>
        /// <param name="savePath"></param>
        public void ExportExcel(DataSet dsExcel, string outFileName, string savePath)
        {
            //创建一个workbook和worksheet对象
            Worksheet wkSheet = null;
            Workbook wkBook = new Workbook();
            wkBook.Worksheets.Clear();

            //遍历DataSet
            for (int i = 0; i < dsExcel.Tables.Count; i++)
            {
                //获取DataTable
                DataTable table = dsExcel.Tables[i];

                //创建一个worksheet
                wkBook.Worksheets.Add(table.TableName);

                //获取worksheet
                wkSheet = wkBook.Worksheets[i];


                //遍历Table的行
                for (int rNum = 0; rNum < table.Rows.Count; rNum++)
                {
                    //遍历Table的列
                    for (int cNum = 0; cNum < table.Columns.Count; cNum++)
                    {
                        //给sheet写入标头,只需执行一次
                        if (rNum == 0)
                        {
                            string _columnName = table.Columns[cNum].ColumnName.ToString().Trim();

                            //如果DataTable列名包含Column，则表示此列名是由系统自动生成，导出时将列名还原为空值
                            if (_columnName.Contains("Column"))
                            {
                                _columnName = "";
                            }

                            wkSheet.Cells[0, cNum].PutValue(_columnName);
                        }

                        //给sheet写入数据
                        wkSheet.Cells[rNum + 1, cNum].PutValue(table.Rows[rNum][cNum].ToString().Trim());
                    }
                }
            }

            //导出保存
            wkBook.Save(savePath + "\\" + outFileName, FileFormatType.Excel2003);

            //释放对象
            wkSheet = null;
            wkBook = null;
        }
    }
}
