using Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Runtime;
using System;
using System.Net.Http;
using System.Threading.Tasks;

namespace Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Cmdlets
{    
    /// <summary>
    /// Helper class for methods needed in custom overrides
    /// </summary>
    public class CustomizationHelpers
    {

        /// <summary>
        /// Polls the remediation operation for a terminal state and returns the Remediation object once reached.
        /// </summary>
        /// <remarks>This method repeatedly sends HTTP GET requests to the operation's URI to check its
        /// status. It continues polling until the operation reaches a terminal state. The method writes progress
        /// updates to the provided cmdlet and handles any exceptions that occur during the polling process.</remarks>
        /// <param name="responseMessage">The initial HTTP response message received from the remediation operation.</param>
        /// <param name="cmdlet">The PowerShell cmdlet instance used for writing debug and progress information.</param>
        /// <param name="eventListener">The event listener for handling events during the polling process.</param>
        /// <param name="sender">The sender used to send HTTP requests during polling.</param>
        /// <exception cref="Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Runtime.UndeclaredResponseException">Thrown if the operation reaches a "Failed" state.</exception>
        public static async Task<Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.IRemediation> PollRemediationForTerminalState(
            global::System.Net.Http.HttpResponseMessage responseMessage, 
            System.Management.Automation.PSCmdlet cmdlet,
            Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Runtime.IEventListener eventListener,
            Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Runtime.ISendAsync sender)
        {
            // setup the first polling request
            var requestUri = responseMessage.RequestMessage.RequestUri;
            HttpRequestMessage request = new global::System.Net.Http.HttpRequestMessage(Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Runtime.Method.Get, requestUri);

            // setup variables that will be continually updated during polling
            HttpResponseMessage response = responseMessage;
            int delay = 30;
      
            // polling loop
            while (response.StatusCode == global::System.Net.HttpStatusCode.OK || response.StatusCode == global::System.Net.HttpStatusCode.Created || response.StatusCode == global::System.Net.HttpStatusCode.Accepted)
            {
                // delay before making the next polling request                
                cmdlet.WriteDebug($"Delaying {delay} seconds before polling.");
                for (var now = 0; now < delay; ++now)
                {
                    cmdlet.WriteProgress(new global::System.Management.Automation.ProgressRecord(1, "In progress", "Checking operation status")
                    {
                        PercentComplete = now * 100 / delay
                    });
                    await global::System.Threading.Tasks.Task.Delay(1000);
                }

                // make the polling call
                response = await sender.SendAsync(request, eventListener);

                // if we got back an OK, take a peek inside and see if it's done
                if (response.StatusCode == global::System.Net.HttpStatusCode.OK)
                {
                    try
                    {
                        if (Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Runtime.Json.JsonNode.Parse(await response.Content.ReadAsStringAsync()) is Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Runtime.Json.JsonObject json)
                        {
                            var state = json.Property("properties")?.PropertyT<Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Runtime.Json.JsonString>("provisioningState") ?? json.PropertyT<Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Runtime.Json.JsonString>("status");
                            if (state is null)
                            {
                                // the body doesn't contain any information that has the state of the LRO
                                // we're going to just get out, and let the consumer have the result
                                break;
                            }

                            // check for any of the terminal states
                            switch (state?.ToString()?.ToLower())
                            {
                                case "failed":
                                case "succeeded":
                                case "complete":
                                case "canceled":
                                    // we're done polling.
                                    cmdlet.WriteInformation("Operation reached terminal state.", new string[] { });
                                    break;

                                default:
                                    // need to keep polling!
                                    response.StatusCode = global::System.Net.HttpStatusCode.Created;
                                    continue;
                            }
                        }
                    }
                    catch
                    {
                        // if we run into a problem peeking into the result,
                        // we really don't want to do anything special.
                    }
                }
            }

            // done polling - process final response into Remediation object and return it
            return await response.Content.ReadAsStringAsync().ContinueWith(body => Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Models.Remediation.FromJson(Microsoft.Azure.PowerShell.Cmdlets.PolicyInsights.Runtime.Json.JsonNode.Parse(body.Result)));
        }
    }
}