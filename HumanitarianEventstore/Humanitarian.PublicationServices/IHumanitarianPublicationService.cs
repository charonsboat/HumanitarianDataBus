using Humanitarian.DataContracts;
using Humanitarian.DataContracts.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace HumanitarianPublicationServices
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IHumanitarianPublicationService
    {
        [OperationContract]
        HumanitarianEvent GetEvents(GetEventRequest request);
    }

}
