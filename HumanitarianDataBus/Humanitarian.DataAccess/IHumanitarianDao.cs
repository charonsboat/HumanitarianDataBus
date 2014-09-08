using Humanitarian.DataContracts.Requests;
using Humanitarian.DataContracts.Responses;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Humanitarian.DataAccess
{
    public interface IHumanitarianDao
    {
        AddHumanitarianEventResponse AddHumanitarianEvent(AddHumanitarianEventRequest request);
        GetHumanitarianEventResponse GetHumanitarianEvents(GetHumanitarianEventRequest request);
        GetHumanitarianEventResponse  GetHumanitarianEvent(GetHumanitarianEventRequest request);
    }
}
