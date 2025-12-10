using Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Runtime;
using Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Runtime.PowerShell;
using System;

namespace Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Cmdlets
{    

    public partial class NewAzPolicyRemediation_CreateViaIdentityManagementGroupExpanded
    {
        // Remediation creation is a long-running operation. We want to poll for terminal state unless the user specifies NoWait.

        /// <summary>
        /// When specified, will make the remote call, and return the unfinished remediation.
        /// </summary>
        [global::System.Management.Automation.Parameter(Mandatory = false, HelpMessage = "Run the command asynchronously")]
        [global::Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Category(global::Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.ParameterCategory.Runtime)]
        public global::System.Management.Automation.SwitchParameter NoWait { get; set; }

        partial void overrideOnCreated(global::System.Net.Http.HttpResponseMessage responseMessage, global::System.Threading.Tasks.Task<Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.IRemediation> response, ref global::System.Threading.Tasks.Task<bool> returnNow)
        {
            // unless NoWait is present, this method will poll for terminal state before returning

            // if user requests NoWait, we just return immediately
            if (true == MyInvocation?.BoundParameters?.ContainsKey("NoWait"))
            {
                return;
            }

            returnNow = System.Threading.Tasks.Task.FromResult(true);

            var remediation = CustomizationHelpers
              .PollRemediationForTerminalState(
                  responseMessage: responseMessage,
                  cmdlet: this,
                  eventListener: this,
                  sender: this.Pipeline)
              .GetAwaiter()
              .GetResult();

            if (remediation != null)
            {
                WriteObject(remediation);
            }
        }

        partial void overrideOnOk(
            global::System.Net.Http.HttpResponseMessage responseMessage, 
            global::System.Threading.Tasks.Task<Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.IRemediation> response, 
            ref global::System.Threading.Tasks.Task<bool> returnNow)
        {
            // unless NoWait is present, this method will poll for terminal state before returning

            // if user requests NoWait, we just return immediately
            if (true == MyInvocation?.BoundParameters?.ContainsKey("NoWait"))
            {
                return;
            }

            returnNow = System.Threading.Tasks.Task.FromResult(true);

            var remediation = CustomizationHelpers
              .PollRemediationForTerminalState(
                  responseMessage: responseMessage,
                  cmdlet: this,
                  eventListener: this,
                  sender: this.Pipeline)
              .GetAwaiter()
              .GetResult();

            if (remediation != null)
            {
                WriteObject(remediation);
            }

        }
    }
}
