using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReachHelpWF.Interfaces
{
    public interface IDonations
    {
        UInt16 number { get; set; }
        double amount { get; set; }
    }

    public interface IDonationDetails
    {
        string donationId { get; set; }
        string phoneNumber { get; set; }
        string emailId { get; set; }
        string userName { get; set; }        
        string date { get; set; }
        string transactionId { get; set; }
        string status { get; set; }
    }
}
