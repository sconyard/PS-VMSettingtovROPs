<#
    .DESCRIPTION: Captures the value of a specified Virtual Machine advanced setting and then pushes that to vRealize Operations Manager
    .REQUIREMENTS: VMware PowerCLI including VMware.VimAutomation.vROps module
    .NOTES  Author:  Simon Conyard
    .NOTES  Site:    www.virtual-simon.co.uk
    .NOTES  Reference:  https://virtual-simon.co.uk/adding-virtual-machine-advanced-settings-to-custom-properties-in-vrealize-operations/
#>

#Ask for variable values for Advanced Settings and StatKey
$Advsetting = Read-Host -Prompt "Enter the Virtual Machine advanced setting string exactly as it is listed e.g. tools.guest.desktop.autolock"
$statkey = Read-Host -Propmt "Enter the vRealize Operations Manager property location to display the property value e.g. import|desktopAutolock"

#Ask for a VMware Cluster to target 
$allclusters = Get-Cluster
    Write-Host ("$allclusters") -ForegroundColor DarkGreen -BackgroundColor White
$cluster = Read-Host -Prompt "Enter the connected Cluster Name from the list above"

$VMS = Get-VM -location $cluster

#Test to see if Advanced Setting exists and either write out "nothing to do!" or pass to the elements that call the addproperty method
foreach($VM in $VMS){
    $n = ("$($VM.name)")
    $OMResource = Get-OMResource $n

    $value = Get-AdvancedSetting -Entity $VM -Name $Advsetting -ErrorAction SilentlyContinue
if ($value -eq $null) {
    write-host ("$Advsetting is not set on VC object $VM! Nothing to Do!") -ForegroundColor DarkGreen -BackgroundColor White
    }
else {
    write-host ("$Advsetting is set on VC object $VM! Writing value to vRealize Operations Manager!") -ForegroundColor White -BackgroundColor DarkGreen

    $contentprops = New-Object VMware.VimAutomation.vROps.Views.PropertyContents
    $contentprop = New-Object VMware.VimAutomation.vROps.Views.PropertyContent
        
        $contentprop.StatKey = ("$($statkey)")
        $contentprop.Values = @("$($value.Value)")
        $contentprop.Timestamps = [double]::Parse((Get-Date -UFormat %s))

        $contentprops.Propertycontent = @($contentprop)

    write-host( "Writing value $($Value.value) to location $StatKey for vRealize Operations Manager object $VM" ) -ForegroundColor White -BackgroundColor Blue

        $OMResource.ExtensionData.AddProperties($contentprops)
    } 
}
