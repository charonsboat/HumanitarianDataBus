using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace Humanitarian.Publication.Integration.Test
{
    public static class XmlHelper
    {
        public static void SetDefaultXmlNamespace(this XElement xelem, XNamespace xmlns)
        {
            if (xelem.Name.NamespaceName == string.Empty)
                xelem.Name = xmlns + xelem.Name.LocalName;
            foreach (var e in xelem.Elements())
                e.SetDefaultXmlNamespace(xmlns);
        }
    }
}
