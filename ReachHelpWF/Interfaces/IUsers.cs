using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReachHelpWF.Interfaces
{
    public interface IUsers
    {
        UInt16 number { get; set; }
        UInt16 userCount { get; set; }
        string phoneNumber { get; set; }
        string emailId { get; set; }
        string userName { get; set; }
    }
}
