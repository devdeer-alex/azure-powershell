function Get-AzWebAppMetric_ListBySiteObject {
    [OutputType('Microsoft.Azure.PowerShell.Cmdlets.WebSite.Models.Api20180201.IResourceMetric')]
    [CmdletBinding(PositionalBinding=$false)]
    [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Profile('latest-2019-04-30')]
    param(
        [Parameter(Mandatory, HelpMessage='Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Path')]
        [System.String[]]
        ${SubscriptionId},

        [Parameter(Mandatory, HelpMessage='The object representation of the web app or slot.')]
        [Alias('WebApp', 'WebAppSlot')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Body')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Models.Api20180201.ISite]
        ${SiteObject},

        [Parameter(HelpMessage='Specify "true" to include metric details in the response. It is "false" by default.')]
        [Alias('InstanceDetails')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Query')]
        [System.Management.Automation.SwitchParameter]
        ${Detail},

        [Parameter(HelpMessage='Return only metrics specified in the filter (using OData syntax). For example: $filter=(name.value eq ''Metric1'' or name.value eq ''Metric2'') and startTime eq 2014-01-01T00:00:00Z and endTime eq 2014-12-31T23:59:59Z and timeGrain eq duration''[Hour|Minute|Day]''.')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Query')]
        [System.String]
        ${Filter},

        [Parameter(HelpMessage='The credentials, account, tenant, and subscription used for communication with Azure.')]
        [Alias('AzureRMContext', 'AzureCredential')]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Azure')]
        [System.Management.Automation.PSObject]
        ${DefaultProfile},

        [Parameter(DontShow, HelpMessage='Wait for .NET debugger to attach')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        ${Break},

        [Parameter(DontShow, HelpMessage='SendAsync Pipeline Steps to be appended to the front of the pipeline')]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Runtime.SendAsyncStep[]]
        ${HttpPipelineAppend},

        [Parameter(DontShow, HelpMessage='SendAsync Pipeline Steps to be prepended to the front of the pipeline')]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend},

        [Parameter(DontShow, HelpMessage='The URI for the proxy server to use')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Runtime')]
        [System.Uri]
        ${Proxy},

        [Parameter(DontShow, HelpMessage='Credentials for a proxy server to use for the remote call')]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Runtime')]
        [System.Management.Automation.PSCredential]
        ${ProxyCredential},

        [Parameter(DontShow, HelpMessage='Use the default credentials for the proxy')]
        [Microsoft.Azure.PowerShell.Cmdlets.WebSite.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        ${ProxyUseDefaultCredentials}
    )

    process {
        $Tokens = $SiteObject.Id.Split("/", [System.StringSplitOptions]::RemoveEmptyEntries)
        $null = $PSBoundParameters.Add("ResourceGroupName", $Tokens[3])
        $null = $PSBoundParameters.Add("Name", $Tokens[7])
        if ($Tokens.Length -eq 10)
        {
            $null = $PSBoundParameters.Add("Slot", $Tokens[9])
        }

        $null = $PSBoundParameters.Remove("SiteObject")
        Az.WebSite\Get-AzWebAppMetric @PSBoundParameters
    }
}