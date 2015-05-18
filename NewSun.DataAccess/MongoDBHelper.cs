using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

using Com.NewSun.Common;

using MongoDB.Driver;
using MongoDB.Bson;
using MongoDB.Driver.GridFS;

namespace Com.NewSun.DataAccess
{
    public class MongoDBHelper<Model, IdT> where Model : BaseModel, new()
    {
        #region common define
        private static string mongoDBConnectionStr = "";
        private static string mongoDBName = "";
        public static MongoServer mongoServer = null;
        public static MongoDatabase mongoDatabase = null;
        #endregion

        #region MongoDBHelper
        public MongoDBHelper()
        {
            if (mongoDBConnectionStr == "")
                mongoDBConnectionStr = System.Configuration.ConfigurationManager.AppSettings[ConstantDefine.MongoDBConnectionConfigKey];
            if (mongoServer == null)
                mongoServer = MongoDB.Driver.MongoServer.Create(mongoDBConnectionStr);
            if (mongoDBName == "")
                mongoDBName = System.Configuration.ConfigurationManager.AppSettings[ConstantDefine.MongoDatabaseNameConfigKey];
            if (mongoDatabase == null)
                mongoDatabase = mongoServer.GetDatabase(mongoDBName);
        }
        #endregion

        #region Insert/Update/Delete/SaveOrUpdate
        public void Insert(Model o)
        {
            try
            {
                o._id = ObjectId.GenerateNewId();
                o.Created = DateTime.Now;
                var collection = mongoDatabase.GetCollection<Model>(typeof(Model).ToString());
                collection.Insert(o);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void Update(Model o,IdT id)
        {
            try
            {
                var collection = mongoDatabase.GetCollection<Model>(typeof(Model).ToString());
                o.Modified = DateTime.Now;
                BsonDocument bd = BsonExtensionMethods.ToBsonDocument(o);
                IMongoQuery query = MongoDB.Driver.Builders.Query.EQ("Id", id.ToString());
                collection.Update(query, new UpdateDocument(bd));

                /*
                var query02 = new QueryDocument { { "ID", 1 } };
                var update = new UpdateDocument { { "$set", new BsonDocument("rolename", "xxxxx").Add("passport","happytor") } };
                */
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void Update(IdT id, Dictionary<string, object> propertys)
        {
            try
            {
                var collection = mongoDatabase.GetCollection<Model>(typeof(Model).ToString());
                IMongoQuery query = MongoDB.Driver.Builders.Query.EQ("Id", id.ToString());
                propertys.Add("Modified", DateTime.Now);
                var update = new UpdateDocument(propertys);
                collection.Update(query, update);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void Update(List<QueryPropertyItem> queryPropertys, QueryType queryType, List<QueryPropertyItem> updatePropertys)
        {
            try
            {
                var collection = mongoDatabase.GetCollection<Model>(typeof(Model).ToString());
                IMongoQuery query = BuildQueryCondition(queryPropertys, queryType);
                var updateDictionary = new Dictionary<string, object>();
                foreach (QueryPropertyItem item in updatePropertys)
                    updateDictionary.Add(item.PropertyName, item.PropertyValue);
                updateDictionary.Add("Modified", DateTime.Now);
                var update = new UpdateDocument(updateDictionary);
                collection.Update(query, update);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void Delete(IdT id)
        {
            try
            {
                var collection = mongoDatabase.GetCollection<Model>(typeof(Model).ToString());
                IMongoQuery query = MongoDB.Driver.Builders.Query.EQ("Id", id.ToString());
                collection.Remove(query);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void Delete(List<QueryPropertyItem> queryPropertys, QueryType queryType)
        {
            try
            {
                var collection = mongoDatabase.GetCollection<Model>(typeof(Model).ToString());
                IMongoQuery query = BuildQueryCondition(queryPropertys, queryType);
                collection.Remove(query);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void SaveOrUpdate(Model o)
        {
            try
            {
                if (o._id == null)
                {
                    o._id = ObjectId.GenerateNewId();
                    o.Created = DateTime.Now;
                }
                var collection = mongoDatabase.GetCollection<Model>(typeof(Model).ToString());
                collection.Save(o);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region Get
        public IList<Model> GetAll()
        {
            try
            {
                var collection = mongoDatabase.GetCollection<Model>(typeof(Model).ToString());
                return collection.FindAll().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public IList<Model> GetAll(int start, int page, string sortExpression)
        {
            return GetAll().Skip(start).Take(page).ToList();
        }
        public int GetCount(int start, int page, string sortExpression)
        {
            return 0;
        }
        public Model GetById(IdT id)
        {
            try
            {
                var collection = mongoDatabase.GetCollection<Model>(typeof(Model).ToString());
                return collection.FindOne(MongoDB.Driver.Builders.Query.EQ("Id", id.ToString()));
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IList<Model> GetListByProperty(QueryPropertyItem item)
        {
            try
            {
                var collection = mongoDatabase.GetCollection<Model>(typeof(Model).ToString());
                IMongoQuery query = BuildQueryItem(item);
                return collection.FindAs<Model>(query).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public IList<Model> GetListByProperty(List<QueryPropertyItem> propertys, QueryType type)
        {
            try
            {
                var collection = mongoDatabase.GetCollection<Model>(typeof(Model).ToString());
                IMongoQuery query = BuildQueryCondition(propertys, type);
                return collection.FindAs<Model>(query).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public IList<Model> GetListByProperty(List<List<QueryPropertyItem>> propertys)
        {
            try
            {
                var collection = mongoDatabase.GetCollection<Model>(typeof(Model).ToString());
                IMongoQuery query = BuildQueryCondition(propertys);
                return collection.FindAs<Model>(query).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public IList<Model> GetListByQuery(string queryStr)
        {
            return null;
        }
        #endregion

        #region Util
        public IMongoQuery BuildQueryItem(QueryPropertyItem item)
        {
            IMongoQuery query = null;
            #region Change OpType
            switch (item.OpType)
            { 
                case QueryItemType.EQ:
                    query = MongoDB.Driver.Builders.Query.EQ(item.PropertyName, BsonValue.Create(item.PropertyValue));
                    break;
                case QueryItemType.Exists:
                    query = MongoDB.Driver.Builders.Query.Exists(item.PropertyName);
                    break;
                case QueryItemType.GT:
                    query = MongoDB.Driver.Builders.Query.GT(item.PropertyName, BsonValue.Create(item.PropertyValue));
                    break;
                case QueryItemType.GTE:
                    query = MongoDB.Driver.Builders.Query.GTE(item.PropertyName, BsonValue.Create(item.PropertyValue));
                    break;
                case QueryItemType.In:
                    query = MongoDB.Driver.Builders.Query.In(item.PropertyName, (List<BsonValue>)item.PropertyValue);
                    break;
                case QueryItemType.LT:
                    query = MongoDB.Driver.Builders.Query.LT(item.PropertyName, BsonValue.Create(item.PropertyValue));
                    break;
                case QueryItemType.LTE:
                    query = MongoDB.Driver.Builders.Query.LTE(item.PropertyName, BsonValue.Create(item.PropertyValue));
                    break;
                case QueryItemType.NE:
                    query = MongoDB.Driver.Builders.Query.NE(item.PropertyName, BsonValue.Create(item.PropertyValue));
                    break;
                case QueryItemType.Nor:
                    query = MongoDB.Driver.Builders.Query.NotIn(item.PropertyName, (List<BsonValue>)item.PropertyValue);
                    break;
                case QueryItemType.Size:
                    query = MongoDB.Driver.Builders.Query.Size(item.PropertyName, (int)item.PropertyValue);
                    break;
                default:
                    query = MongoDB.Driver.Builders.Query.EQ(item.PropertyName, BsonValue.Create(item.PropertyValue));
                    break;
            }
            #endregion
            return query;
        }
        public IMongoQuery BuildQueryCondition(List<QueryPropertyItem> propertys, QueryType type)
        {
            IMongoQuery queryCondition = null;
            List<IMongoQuery> queryList = new List<IMongoQuery>();
            foreach (QueryPropertyItem item in propertys)
                queryList.Add(BuildQueryItem(item));
            switch (type)
            {
                case QueryType.And:
                    queryCondition = MongoDB.Driver.Builders.Query.And(queryList.ToArray());
                    break;
                case QueryType.Or:
                    queryCondition = MongoDB.Driver.Builders.Query.Or(queryList.ToArray());
                    break;
                case QueryType.Not:
                    IMongoQuery notQueryCondition = MongoDB.Driver.Builders.Query.And(queryList.ToArray());
                    queryCondition = MongoDB.Driver.Builders.Query.Not(notQueryCondition);
                    break;
            }
            return queryCondition;
        }
        public IMongoQuery BuildQueryCondition(List<List<QueryPropertyItem>> propertys)
        {
            List<IMongoQuery> subConditionList = new List<IMongoQuery>();
            foreach (List<QueryPropertyItem> listItem in propertys)
            {
                List<IMongoQuery> subConditionListItem = new List<IMongoQuery>();
                foreach (QueryPropertyItem item in listItem)
                    subConditionListItem.Add(BuildQueryItem(item));
                IMongoQuery andQueryCondition = MongoDB.Driver.Builders.Query.And(subConditionListItem.ToArray());
                subConditionList.Add(andQueryCondition);
            }
            return MongoDB.Driver.Builders.Query.Or(subConditionList.ToArray());
        }
        #endregion

        #region File
        #region GridFS 范例
        /*
        var id = ObjectId.Empty;            
        using(var file = File.OpenRead(fileName))
        {
            id = gridFs.AddFile(file, fileName);
        }
 
        using(var file = gridFs.GetFile(id))
        {
            var buffer = new byte[file.Length];
            // note - you'll probably want to read in
            // small blocks or stream to avoid 
            // allocating large byte arrays like this
            file.Read(buffer, 0, (int)file.Length);
        }   
         */
        #endregion
        public ObjectId AddFile(Stream fileStream, string fileName)
        {
            try
            {
                var fileInfo = mongoDatabase.GridFS.Upload(fileStream, fileName);
                return (ObjectId)fileInfo.Id;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public Stream GetFile(ObjectId id)
        {
            try
            {
                var file = mongoDatabase.GridFS.FindOneById(id);
                return file.OpenRead();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public Stream GetFile(string fileName)
        {
            try
            {
                var file = mongoDatabase.GridFS.FindOne(fileName);
                return file.OpenRead();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public Stream GetFile(QueryPropertyItem item)
        {
            try
            {
                IMongoQuery query = BuildQueryItem(item);
                var file = mongoDatabase.GridFS.FindOne(query);
                return file.OpenRead();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public Stream GetFile(List<QueryPropertyItem> propertys, QueryType type)
        {
            try
            {
                IMongoQuery query = BuildQueryCondition(propertys, type);
                var file = mongoDatabase.GridFS.FindOne(query);
                return file.OpenRead();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void RemoveFile(ObjectId id)
        {
            try
            {
                mongoDatabase.GridFS.DeleteById(id);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void RemoveFile(string fileName)
        {
            try
            {
                mongoDatabase.GridFS.Delete(fileName);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void RemoveFile(QueryPropertyItem item)
        {
            try
            {
                IMongoQuery query = BuildQueryItem(item);
                mongoDatabase.GridFS.Delete(query);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void RemoveFile(List<QueryPropertyItem> propertys, QueryType type)
        {
            try
            {
                IMongoQuery query = BuildQueryCondition(propertys, type);
                mongoDatabase.GridFS.Delete(query);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion
    }
}
