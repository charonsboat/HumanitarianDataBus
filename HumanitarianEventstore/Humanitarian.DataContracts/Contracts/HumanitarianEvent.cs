using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.Xml.Linq;

namespace Humanitarian.DataContracts
{
    // Use a data contract as illustrated in the sample below to add composite types to service operations.
    [Serializable]
    [DataContract]
    public class HumanitarianEvent
    {
        private Guid id;
        private string eventXml;
        private string propertyXml;
        private DateTime lastModifiedDateTime;
        private string lastModifiedUser;


        public HumanitarianEvent()
        {
            this.lastModifiedDateTime = DateTime.Now;
        }      
        [DataMember]
        public Guid Id
        {
            get { return id; }
            set { id = value; }
        }

        [DataMember]
        public string EventXml
        {
            get { return eventXml; }
            set { eventXml = value; }
        }
        [DataMember]
        public string PropertyXml
        {
            get { return propertyXml; }
            set { propertyXml = value; }
        }

        [DataMember]
        public DateTime LastModifiedDateTime
        {
            get { return this.lastModifiedDateTime;}
            set { this.lastModifiedDateTime = value; }
        }
        [DataMember]
        public string LastModifiedUser
        {
            get { return this.lastModifiedUser; }
            set { this.lastModifiedUser = value; }
        }

    }
}
