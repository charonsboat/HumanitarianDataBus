using Humanitarian.DataContracts;
using Humanitarian.DataContracts.Requests;
using Humanitarian.DataContracts.Responses;
using Humanitarian.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace Humanitarian.PublicationServices
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select Service1.svc or Service1.svc.cs at the Solution Explorer and start debugging.
    public class HumanitarianPublicationServices : IHumanitarianPublicationServices
    {
        public GetHumanitarianEventResponse GetHumanitarianEvents(GetHumanitarianEventRequest request)
        {
            return new GetHumanitarianEventResponse { Events = new List<HumanitarianEvent>() };
        }

        public AddHumanitarianEventResponse AddHumanitarianEvent(AddHumanitarianEventRequest request)
        {
            AddHumanitarianEventResponse response = new AddHumanitarianEventResponse();
            var dao = new HumanitarianDao();
            dao.AddHumanitarianEvent(request);
            return response;            
        }

    }
}
