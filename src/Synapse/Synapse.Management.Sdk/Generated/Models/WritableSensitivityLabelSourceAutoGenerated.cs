// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is regenerated.

namespace Microsoft.Azure.Management.Synapse.Models
{

    /// <summary>
    /// Defines values for WritableSensitivityLabelSourceAutoGenerated.
    /// </summary>


    [Newtonsoft.Json.JsonConverter(typeof(Newtonsoft.Json.Converters.StringEnumConverter))]
    public enum WritableSensitivityLabelSourceAutoGenerated
    {
        [System.Runtime.Serialization.EnumMember(Value = "recommended")]
        Recommended
    }
    internal static class WritableSensitivityLabelSourceAutoGeneratedEnumExtension
    {
        internal static string ToSerializedValue(this WritableSensitivityLabelSourceAutoGenerated? value)
        {
            return value == null ? null : ((WritableSensitivityLabelSourceAutoGenerated)value).ToSerializedValue();
        }
        internal static string ToSerializedValue(this WritableSensitivityLabelSourceAutoGenerated value)
        {
            switch( value )
            {
                case WritableSensitivityLabelSourceAutoGenerated.Recommended:
                    return "recommended";
            }
            return null;
        }
        internal static WritableSensitivityLabelSourceAutoGenerated? ParseWritableSensitivityLabelSourceAutoGenerated(this string value)
        {
            switch( value )
            {
                case "recommended":
                    return WritableSensitivityLabelSourceAutoGenerated.Recommended;
            }
            return null;
        }
    }
}