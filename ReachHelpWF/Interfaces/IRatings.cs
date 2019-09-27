using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReachHelpWF.Interfaces
{
    public interface IRatings
    {
        UInt16 number { get; set; }
        double ratingCount { get; set; }
    }
}
