using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Humanitarian.DataContracts.Requests
{
    [DataContract]
    public class AddHumanitarianEventRequest
    {
        [DataMember]
        public HumanitarianEvent EventToAdd { get; set; }

    }
}
