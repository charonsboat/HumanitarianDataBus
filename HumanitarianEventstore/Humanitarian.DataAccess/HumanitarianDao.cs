using Humanitarian.DataAccess.Mapping;
using Humanitarian.DataContracts.Requests;
using Humanitarian.DataContracts.Responses;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Humanitarian.DataAccess
{
    public class HumanitarianDao : IHumanitarianDao
    {
        public AddHumanitarianEventResponse AddHumanitarianEvent(AddHumanitarianEventRequest request)
        {
            var response = new AddHumanitarianEventResponse();

            using(var context = new HumanitarianEventContext())
            {
                request.EventToAdd.Id = Guid.NewGuid();
                context.HumanitarianEvents.Add(request.EventToAdd);
                context.SaveChanges();
            }
            return response;


        }
        public GetHumanitarianEventResponse GetHumanitarianEvents(GetHumanitarianEventRequest request)
        {
            var response = new GetHumanitarianEventResponse();
            using (var context = new HumanitarianEventContext())
            {
                response.Events = (from c in context.HumanitarianEvents
                                  select c).ToList();
            }
            return response;

        }
    }
}
