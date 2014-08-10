using Humanitarian.DataContracts;
using Humanitarian.DataContracts.Requests;
using Humanitarian.DataContracts.Responses;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace Humanitarian.PublicationServices
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IHumanitarianPublicationServices
    {
        [OperationContract]
        GetHumanitarianEventResponse GetHumanitarianEvents(GetHumanitarianEventRequest request);

        [OperationContract]
        GetHumanitarianEventResponse GetHumanitarianEvent(GetHumanitarianEventRequest request);

        [OperationContract]
        AddHumanitarianEventResponse AddHumanitarianEvent(AddHumanitarianEventRequest request);

    }
    
}
