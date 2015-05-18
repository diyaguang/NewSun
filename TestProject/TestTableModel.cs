using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Com.NewSun.DataAccess;

namespace TestProject
{
    [Serializable]
    public class TestTable : BaseModel
    {
        [Column]
        public string Description { get; set; }
    }
}
