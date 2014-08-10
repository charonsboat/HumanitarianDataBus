using Humanitarian.DataContracts;
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
            this.Property(t => t.EventEnvelopeXml).HasColumnName("EventEnvelopeXml").HasColumnType("xml");
            this.Property(t => t.EventPropertyXml).HasColumnName("EventPropertyXml").HasColumnType("xml");
            this.Property(t => t.LastModifiedDateTime).HasColumnName("LastModifiedDateTime").HasColumnType("datetime");
            this.Property(t => t.LastModifiedUser).HasColumnName("LastModifiedUser").HasColumnType("varchar");
            this.Property(t => t.Id).HasDatabaseGeneratedOption(DatabaseGeneratedOption.None);
        }

    }
}
