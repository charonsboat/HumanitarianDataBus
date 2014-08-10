using Humanitarian.DataContracts;
using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace Humanitarian.DataAccess.Mapping
{
    public class HumanitarianEventMapping : EntityTypeConfiguration<HumanitarianEvent> 
    {
        public HumanitarianEventMapping()
        {
            this.HasKey(t => t.Id);          
            this.ToTable("Events");
            this.Property(t => t.EventXml).HasColumnName("EventXml").HasColumnType("xml");
            this.Property(t => t.PropertyXml).HasColumnName("PropertyXml").HasColumnType("xml");
            this.Property(t => t.LastModifiedDateTime).HasColumnName("LastModifiedDateTime").HasColumnType("datetime");
            this.Property(t => t.LastModifiedUser).HasColumnName("LastModifiedUser").HasColumnType("varchar");
            this.Property(t => t.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.None);
        }

    }
}
