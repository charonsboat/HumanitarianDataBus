using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using System.Xml;
using System.Xml.Schema;
using System.IO;
using System.Text;

namespace Humanitarian.Publication.Integration.Test
{
    [TestClass]
    public class PublicationTests
    {
        [TestMethod]
        [DeploymentItem(@"Schemas\HumanitarianEventSchema.xsd")]
        [DeploymentItem(@"Schemas\HumanitarianEventSchema.xml")]
        public void AddNewEvent()
        {

            //string filePath = Path.Combine(Directory.GetCurrentDirectory(), @"HumanitarianEventSchema.xsd");
            XmlSchemaSet schemas = new XmlSchemaSet();
            
            //Load schema from deployment item
            schemas.Add("http://www.w3.org/2001/XMLSchema", "HumanitarianEventSchema.xsd");

            //load XML from deployment item
           var doc = XDocument.Load("HumanitarianEventSchema.xml", LoadOptions.SetBaseUri);
           doc.Root.SetDefaultXmlNamespace("http://www.w3.org/2001/XMLSchema");

            // Valid according to the schema
            doc.Validate(schemas, null, true);

            //Create XML with schema defintion
            var sb = new StringBuilder();
            var xws = new XmlWriterSettings();

            xws.OmitXmlDeclaration = true;
            xws.Indent = true;
            xws.WriteEndDocumentOnClose = true;
            
            
            using (var xw = XmlWriter.Create(sb, xws))
            {   
               doc.WriteTo(xw);
            }

                       
            using(var client = new HumanitarianPublicationServices.HumanitarianPublicationServicesClient())
            {
                client.AddHumanitarianEvent(new HumanitarianPublicationServices.AddHumanitarianEventRequest() 
                { 
                    EventToAdd = new HumanitarianPublicationServices.HumanitarianEvent() 
                        { EventEnvelopeXml = "envelope" ,
                         EventPropertyXml = sb.ToString()
                        
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
              var response =  client.GetHumanitarianEvents(new HumanitarianPublicationServices.GetHumanitarianEventRequest());
              humEvents = response.Events;
            }
            Assert.IsTrue(humEvents.Any());
        }        
    }
}
