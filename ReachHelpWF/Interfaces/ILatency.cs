using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReachHelpWF.Interfaces
{
    public interface ILatency
    {
        UInt16 number { get; set; }
        UInt16 days { get; set; }
        UInt16 hours { get; set; }
        UInt16 minutes { get; set; }
        UInt16 seconds { get; set; }
    }
}
