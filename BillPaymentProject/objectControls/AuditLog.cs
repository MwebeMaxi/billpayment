using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BillPaymentProject.objectControls
{
    public class AuditLog
    {
        public int UserID { get; set; }
        public string Action { get; set; }
        public DateTime Timestamp { get; set; } // Can be DateTime.MinValue if unset
        public string Details { get; set; }
    }

}
