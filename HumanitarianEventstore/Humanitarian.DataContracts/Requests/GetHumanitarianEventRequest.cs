using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Humanitarian.DataContracts.Requests
{
    [DataContract]
    public class GetHumanitarianEventRequest
    {
        public GetHumanitarianEventRequest()
        {

        }

        [DataMember]
        public List<Guid> Ids { get; set; }
    }
}
