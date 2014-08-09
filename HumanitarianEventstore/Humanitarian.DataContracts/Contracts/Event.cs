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
    [DataContract]
    public class HumanitarianEvent
    {
        public HumanitarianEvent()
        {

        }

        private XElement eventXml;

        [DataMember]
        public XElement EventXml
        {
            get { return eventXml; }
            set { eventXml = value; }
        }

    }
}
