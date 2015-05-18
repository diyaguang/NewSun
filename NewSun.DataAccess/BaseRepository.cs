using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Com.NewSun.DataAccess
{
    public interface iBaseRepository<Model,IdT> where Model : class,  new()
    {
        #region Insert/Update/Delete/SaveOrUpdate
        void Insert(Model o);
        void Update(Model o, IdT id);
        void Delete(IdT id);
        void SaveOrUpdate(Model o, IdT id);
        #endregion

        #region Get one / more
        IList<Model> GetAll();
        IList<Model> GetAll(int start, int page, string sortExpression);
        int GetCount(int start, int page, string sortExpression);
        Model GetById(IdT id);
        IList<Model> GetListByProperty(string propertyName, string propertyValue);
        IList<Model> GetListByProperty(SortedList<string,string> propertys);
        IList<Model> GetListByQuery(string queryStr);
        #endregion
    }
}
