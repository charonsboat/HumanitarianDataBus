using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using System.Xml;

namespace Humanitarian.Publication.Integration.Test
{
    [TestClass]
    public class PublicationTests
    {
        [TestMethod]
        public void AddNewEvent()
        {
            using(var client = new HumanitarianPublicationServices.HumanitarianPublicationServicesClient())
            {
                client.AddHumanitarianEvent(new HumanitarianPublicationServices.AddHumanitarianEventRequest() 
                { 
                    EventToAdd = new HumanitarianPublicationServices.HumanitarianEvent() 
                        { EventXml = XElement.Parse(""),
                        PropertyXml = XElement.Parse("")
                        
                        } 
                });
            }            
        }

        [TestMethod]
        public void GetEvents()
        {
            var humEvents = new List<HumanitarianPublicationServices.HumanitarianEvent>();
            using (var client = new HumanitarianPublicationServices.HumanitarianPublicationServicesClient())
            {
                client.GetHumanitarianEvents(new HumanitarianPublicationServices.GetHumanitarianEventRequest());
            }
            Assert.IsTrue(humEvents.Any());
        }
    }
}
