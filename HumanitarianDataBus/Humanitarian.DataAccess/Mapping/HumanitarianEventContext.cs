using Humanitarian.DataContracts;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Humanitarian.DataAccess.Mapping
{
    public class HumanitarianEventContext : DbContext
    {
        public HumanitarianEventContext()
            : base("Name=HumanitarianEvents")
        {
        }
        public DbSet<HumanitarianEvent> HumanitarianEvents { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new HumanitarianEventMapping());           
            base.OnModelCreating(modelBuilder);
        }
    }
}
