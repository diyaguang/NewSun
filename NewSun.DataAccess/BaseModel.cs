using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MongoDB.Driver;
using MongoDB.Bson;

namespace Com.NewSun.DataAccess
{
    public abstract class BaseModel
    {
        public  ObjectId? _id;

        [Id]
        public virtual  string ID { get; set; }

        [Column]
        public virtual string Creator { get; set; }

         [Column]
        public virtual DateTime? Created { get; set; }

         [Column]
        public virtual string Modifier { get; set; }

         [Column]
        public virtual DateTime? Modified { get; set; }

         [Column]
        public virtual string CompanyID { get; set; }
    }
}
