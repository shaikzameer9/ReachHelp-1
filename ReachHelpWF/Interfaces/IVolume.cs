using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReachHelpWF.Interfaces
{
    public interface IVolume
    {
        int quantity { get; set; }
        string category { get; set; }
        string subCategory { get; set; }
        string unit { get; set; }

        List<IVolume> ReceivedVolume(bool prevMonth);
        List<IVolume> OfferedVolume(bool prevMonth);
    }
}
