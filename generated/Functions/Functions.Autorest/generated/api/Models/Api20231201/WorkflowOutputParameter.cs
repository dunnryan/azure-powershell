// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is regenerated.

namespace Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Api20231201
{
    using static Microsoft.Azure.PowerShell.Cmdlets.Functions.Runtime.Extensions;

    /// <summary>The workflow output parameter.</summary>
    public partial class WorkflowOutputParameter :
        Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Api20231201.IWorkflowOutputParameter,
        Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Api20231201.IWorkflowOutputParameterInternal,
        Microsoft.Azure.PowerShell.Cmdlets.Functions.Runtime.IValidates
    {
        /// <summary>
        /// Backing field for Inherited model <see cref= "Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Api20231201.IWorkflowParameter"
        /// />
        /// </summary>
        private Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Api20231201.IWorkflowParameter __workflowParameter = new Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Api20231201.WorkflowParameter();

        /// <summary>The description.</summary>
        [Microsoft.Azure.PowerShell.Cmdlets.Functions.Origin(Microsoft.Azure.PowerShell.Cmdlets.Functions.PropertyOrigin.Inherited)]
        public string Description { get => ((Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Api20231201.IWorkflowParameterInternal)__workflowParameter).Description; set => ((Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Api20231201.IWorkflowParameterInternal)__workflowParameter).Description = value ?? null; }

        /// <summary>Backing field for <see cref="Error" /> property.</summary>
        private Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.IAny _error;

        /// <summary>Gets the error.</summary>
        [Microsoft.Azure.PowerShell.Cmdlets.Functions.Origin(Microsoft.Azure.PowerShell.Cmdlets.Functions.PropertyOrigin.Owned)]
        public Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.IAny Error { get => (this._error = this._error ?? new Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Any()); }

        /// <summary>The metadata.</summary>
        [Microsoft.Azure.PowerShell.Cmdlets.Functions.Origin(Microsoft.Azure.PowerShell.Cmdlets.Functions.PropertyOrigin.Inherited)]
        public Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.IAny Metadata { get => ((Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Api20231201.IWorkflowParameterInternal)__workflowParameter).Metadata; set => ((Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Api20231201.IWorkflowParameterInternal)__workflowParameter).Metadata = value ?? null /* model class */; }

        /// <summary>Internal Acessors for Error</summary>
        Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.IAny Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Api20231201.IWorkflowOutputParameterInternal.Error { get => (this._error = this._error ?? new Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Any()); set { {_error = value;} } }

        /// <summary>The type.</summary>
        [Microsoft.Azure.PowerShell.Cmdlets.Functions.Origin(Microsoft.Azure.PowerShell.Cmdlets.Functions.PropertyOrigin.Inherited)]
        public Microsoft.Azure.PowerShell.Cmdlets.Functions.Support.ParameterType? Type { get => ((Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Api20231201.IWorkflowParameterInternal)__workflowParameter).Type; set => ((Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Api20231201.IWorkflowParameterInternal)__workflowParameter).Type = value ?? ((Microsoft.Azure.PowerShell.Cmdlets.Functions.Support.ParameterType)""); }

        /// <summary>The value.</summary>
        [Microsoft.Azure.PowerShell.Cmdlets.Functions.Origin(Microsoft.Azure.PowerShell.Cmdlets.Functions.PropertyOrigin.Inherited)]
        public Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.IAny Value { get => ((Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Api20231201.IWorkflowParameterInternal)__workflowParameter).Value; set => ((Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Api20231201.IWorkflowParameterInternal)__workflowParameter).Value = value ?? null /* model class */; }

        /// <summary>Validates that this object meets the validation criteria.</summary>
        /// <param name="eventListener">an <see cref="Microsoft.Azure.PowerShell.Cmdlets.Functions.Runtime.IEventListener" /> instance that will receive validation
        /// events.</param>
        /// <returns>
        /// A <see cref = "global::System.Threading.Tasks.Task" /> that will be complete when validation is completed.
        /// </returns>
        public async global::System.Threading.Tasks.Task Validate(Microsoft.Azure.PowerShell.Cmdlets.Functions.Runtime.IEventListener eventListener)
        {
            await eventListener.AssertNotNull(nameof(__workflowParameter), __workflowParameter);
            await eventListener.AssertObjectIsValid(nameof(__workflowParameter), __workflowParameter);
        }

        /// <summary>Creates an new <see cref="WorkflowOutputParameter" /> instance.</summary>
        public WorkflowOutputParameter()
        {

        }
    }
    /// The workflow output parameter.
    public partial interface IWorkflowOutputParameter :
        Microsoft.Azure.PowerShell.Cmdlets.Functions.Runtime.IJsonSerializable,
        Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Api20231201.IWorkflowParameter
    {
        /// <summary>Gets the error.</summary>
        [Microsoft.Azure.PowerShell.Cmdlets.Functions.Runtime.Info(
        Required = false,
        ReadOnly = true,
        Description = @"Gets the error.",
        SerializedName = @"error",
        PossibleTypes = new [] { typeof(Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.IAny) })]
        Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.IAny Error { get;  }

    }
    /// The workflow output parameter.
    internal partial interface IWorkflowOutputParameterInternal :
        Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.Api20231201.IWorkflowParameterInternal
    {
        /// <summary>Gets the error.</summary>
        Microsoft.Azure.PowerShell.Cmdlets.Functions.Models.IAny Error { get; set; }

    }
}