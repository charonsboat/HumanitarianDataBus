using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Humanitarian.DataAccess.Mapping;


namespace HumanitarianWebAPI.Controllers
{

    public class EventController : ApiController
    {
        // GET: api/Event --- Return *ALL* humanitarian events
        public IEnumerable<string> Get()
        {
            var ctx = new HumanitarianEventContext();

            return ctx.HumanitarianEvents.Select(x => x.EventXml).ToList();
        }

        // GET: api/Event/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/Event
        public void Post([FromBody]string value)
        {
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
