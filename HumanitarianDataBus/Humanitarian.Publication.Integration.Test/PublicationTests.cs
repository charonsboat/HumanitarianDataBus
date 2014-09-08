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
        [DeploymentItem(@"Schemas\HumanitarianEventProperty.xsd")]
        [DeploymentItem(@"Schemas\HumanitarianEventProperty.xml")]
        public void AddNewEvent()
        {

            var ex = CreateEventXml();
            var px = CreatePropertyXml();

                       
            using(var client = new HumanitarianPublicationServices.HumanitarianPublicationServicesClient())
            {
                client.AddHumanitarianEvent(new HumanitarianPublicationServices.AddHumanitarianEventRequest() 
                { 
                    EventToAdd = new HumanitarianPublicationServices.HumanitarianEvent() 
                        { EventEnvelopeXml = ex.ToString(),
                         EventPropertyXml = px.ToString()                        
                        } 
                });
            }            
        }

        [DeploymentItem(@"Schemas\HumanitarianEventSchema.xsd")]
        [DeploymentItem(@"Schemas\HumanitarianEventSchema.xml")]
        [DeploymentItem(@"Schemas\HumanitarianEventProperty.xsd")]
        [DeploymentItem(@"Schemas\HumanitarianEventProperty.xml")]
        [DeploymentItem(@"TestData\HumanitarianEventTestData1.xml")]
        [DeploymentItem(@"TestData\HumanitarianEventTestData2.xml")]
        [TestMethod]
        public void AddNewTestEvents()
        {

            var ex = CreateEventXml("HumanitarianEventTestData1.xml");
            var px = CreatePropertyXml();


            using (var client = new HumanitarianPublicationServices.HumanitarianPublicationServicesClient())
            {
                client.AddHumanitarianEvent(new HumanitarianPublicationServices.AddHumanitarianEventRequest()
                {
                    EventToAdd = new HumanitarianPublicationServices.HumanitarianEvent()
                    {
                        EventEnvelopeXml = ex.ToString(),
                        EventPropertyXml = px.ToString()
                    }
                });


                var ex2 = CreateEventXml("HumanitarianEventTestData2.xml");
                var px2 = CreatePropertyXml();


                using (var client2 = new HumanitarianPublicationServices.HumanitarianPublicationServicesClient())
                {
                    client.AddHumanitarianEvent(new HumanitarianPublicationServices.AddHumanitarianEventRequest()
                    {
                        EventToAdd = new HumanitarianPublicationServices.HumanitarianEvent()
                        {
                            EventEnvelopeXml = ex2.ToString(),
                            EventPropertyXml = px2.ToString()
                        }
                    });
                }
            }
        }

        private static StringBuilder CreatePropertyXml()
        {
            //string filePath = Path.Combine(Directory.GetCurrentDirectory(), @"HumanitarianEventSchema.xsd");
            XmlSchemaSet schemas = new XmlSchemaSet();

            //Load schema from deployment item
            schemas.Add("http://schemas.humanitariantoolbox.com/HumanitarianPropertySchema/1/0/0/0/", "HumanitarianEventProperty.xsd");

            //load XML from deployment item
            var doc = XDocument.Load("HumanitarianEventProperty.xml", LoadOptions.SetBaseUri);
            doc.Root.SetDefaultXmlNamespace("http://schemas.humanitariantoolbox.com/HumanitarianPropertySchema/1/0/0/0/");

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
            return sb;
        }

        private static StringBuilder CreatePropertyXml(string fileName)
        {
            //string filePath = Path.Combine(Directory.GetCurrentDirectory(), @"HumanitarianEventSchema.xsd");
            XmlSchemaSet schemas = new XmlSchemaSet();

            //Load schema from deployment item
            schemas.Add("http://schemas.humanitariantoolbox.com/HumanitarianPropertySchema/1/0/0/0/", "HumanitarianEventProperty.xsd");

            //load XML from deployment item
            var doc = XDocument.Load(fileName, LoadOptions.SetBaseUri);
            doc.Root.SetDefaultXmlNamespace("http://schemas.humanitariantoolbox.com/HumanitarianPropertySchema/1/0/0/0/");

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
            return sb;
        }
        private static StringBuilder CreateEventXml()
        {
            //string filePath = Path.Combine(Directory.GetCurrentDirectory(), @"HumanitarianEventSchema.xsd");
            XmlSchemaSet schemas = new XmlSchemaSet();

            //Load schema from deployment item
            schemas.Add("http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/", "HumanitarianEventSchema.xsd");

            //load XML from deployment item
            var doc = XDocument.Load("HumanitarianEventSchema.xml", LoadOptions.SetBaseUri);
            doc.Root.SetDefaultXmlNamespace("http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/");

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
            return sb;
        }

          private static StringBuilder CreateEventXml(string fileName)
        {
            //string filePath = Path.Combine(Directory.GetCurrentDirectory(), @"HumanitarianEventSchema.xsd");
            XmlSchemaSet schemas = new XmlSchemaSet();

            //Load schema from deployment item
            schemas.Add("http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/", "HumanitarianEventSchema.xsd");

            //load XML from deployment item
            var doc = XDocument.Load(fileName, LoadOptions.SetBaseUri);
            doc.Root.SetDefaultXmlNamespace("http://schemas.humanitariantoolbox.com/HumanitarianEventSchema/1/0/0/0/");

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
            return sb;
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
      
         [TestMethod]
        public void GetSingleEvent()
        {
            var humEvents = new List<HumanitarianPublicationServices.HumanitarianEvent>();
            using (var client = new HumanitarianPublicationServices.HumanitarianPublicationServicesClient())
            {
                var request = new HumanitarianPublicationServices.GetHumanitarianEventRequest() 
                { 
                    Ids = new List<Guid>()
                    {Guid.Parse("A7A86B6D-2CEC-4422-8824-5C154EAE6BC7") 
                    } 
                };

              var response =  client.GetHumanitarianEvent(request);
              humEvents = response.Events;
            }
            Assert.IsTrue(humEvents.Count == 1);
        }
         [TestMethod]
         public void GetMultipleEvent()
         {
             var humEvents = new List<HumanitarianPublicationServices.HumanitarianEvent>();
             using (var client = new HumanitarianPublicationServices.HumanitarianPublicationServicesClient())
             {
                 var request = new HumanitarianPublicationServices.GetHumanitarianEventRequest()
                 {
                     Ids = new List<Guid>()
                    {Guid.Parse("A7A86B6D-2CEC-4422-8824-5C154EAE6BC7"),
                     Guid.Parse("34B6798B-82E8-47E5-8F67-C750B529C6A5")  
                    }
                 };

                 var response = client.GetHumanitarianEvent(request);
                 humEvents = response.Events;
             }
             Assert.IsTrue(humEvents.Count ==2);
         }  
    }    
}
