namespace HumanitarianWebAPI.Controllers
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Net;
    using System.Net.Http;
    using System.Web.Http;
    using Humanitarian.DataAccess.Mapping;
    using System.Threading.Tasks;
    using Humanitarian.DataContracts;

    public class EventController : ApiController
    {
        // GET: api/Event --- Return *ALL* humanitarian events
        public IEnumerable<HumanitarianEvent> Get()
        {
            var ctx = new HumanitarianEventContext();

            return ctx.HumanitarianEvents;
        }

        // GET: api/Event/5
        public string Get(string value)
        {
            //todo: implement GET using a single GUID or collection
            return "pointAndRadius";
        }

        // POST: api/Event
        public async Task<HttpResponseMessage> Post(HttpRequestMessage request)
        {
            // todo: Using a POST to retrieve data will make a REST purist cry. Better option?

            // get the raw JSON from the request.
            var jsonString = await request.Content.ReadAsStringAsync();

            // todo: Process the string. Dates should be provided in "ISO 8601" format - 2009-02-15T00:00:00Z
            // pass the data to the sprocs.

            // todo: implement logic to return proper status code and content, if any...
            return new HttpResponseMessage(HttpStatusCode.Forbidden);
        }

        // PUT: api/Event/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Event/5
        public void Delete(int id)
        {
        }
    }
}
