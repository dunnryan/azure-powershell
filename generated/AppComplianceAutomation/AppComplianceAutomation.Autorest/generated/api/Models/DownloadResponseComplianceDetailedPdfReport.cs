// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is regenerated.

namespace Microsoft.Azure.PowerShell.Cmdlets.AppComplianceAutomation.Models
{
    using static Microsoft.Azure.PowerShell.Cmdlets.AppComplianceAutomation.Runtime.Extensions;

    /// <summary>The detailed compliance pdf report</summary>
    public partial class DownloadResponseComplianceDetailedPdfReport :
        Microsoft.Azure.PowerShell.Cmdlets.AppComplianceAutomation.Models.IDownloadResponseComplianceDetailedPdfReport,
        Microsoft.Azure.PowerShell.Cmdlets.AppComplianceAutomation.Models.IDownloadResponseComplianceDetailedPdfReportInternal
    {

        /// <summary>Internal Acessors for SasUri</summary>
        string Microsoft.Azure.PowerShell.Cmdlets.AppComplianceAutomation.Models.IDownloadResponseComplianceDetailedPdfReportInternal.SasUri { get => this._sasUri; set { {_sasUri = value;} } }

        /// <summary>Backing field for <see cref="SasUri" /> property.</summary>
        private string _sasUri;

        /// <summary>The uri of detailed compliance pdf report</summary>
        [Microsoft.Azure.PowerShell.Cmdlets.AppComplianceAutomation.Origin(Microsoft.Azure.PowerShell.Cmdlets.AppComplianceAutomation.PropertyOrigin.Owned)]
        public string SasUri { get => this._sasUri; }

        /// <summary>
        /// Creates an new <see cref="DownloadResponseComplianceDetailedPdfReport" /> instance.
        /// </summary>
        public DownloadResponseComplianceDetailedPdfReport()
        {

        }
    }
    /// The detailed compliance pdf report
    public partial interface IDownloadResponseComplianceDetailedPdfReport :
        Microsoft.Azure.PowerShell.Cmdlets.AppComplianceAutomation.Runtime.IJsonSerializable
    {
        /// <summary>The uri of detailed compliance pdf report</summary>
        [Microsoft.Azure.PowerShell.Cmdlets.AppComplianceAutomation.Runtime.Info(
        Required = false,
        ReadOnly = true,
        Read = true,
        Create = false,
        Update = false,
        Description = @"The uri of detailed compliance pdf report",
        SerializedName = @"sasUri",
        PossibleTypes = new [] { typeof(string) })]
        string SasUri { get;  }

    }
    /// The detailed compliance pdf report
    internal partial interface IDownloadResponseComplianceDetailedPdfReportInternal

    {
        /// <summary>The uri of detailed compliance pdf report</summary>
        string SasUri { get; set; }

    }
}