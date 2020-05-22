# PS-VMSettingtovROPs or Adding Virtual Machine advanced settings to custom properties in vRealize Operations

#### What the script does

This script collects values from the advanced settings of Virtual Machines objects stored in Virtual Centre and posts them to the matching Virtual Machine object in vRealize Operations Manager

1. The Advanced Setting is set as part of the script and the value is collected from the Virtual Centre Virtual Machine object
2. The StatKey is set as part of the script
3. The Cluster to target is set as part of the script
4. Simple logic checks if the Advanced Setting requested exists against the Virtual Centre Virtual Machine object and if it does not it skips
5. Calls the 'resource.addproperty' method to Post the value to the matching Virtual machine object wihin vRealize Operations Manager

#### Requirements

1. This script requires VMware PowerCLI including the VMware.VimAutomation.vROps module
2. An existing connection to Virtual Centre
3. An existing connection to vRealize Operations Manager

#### Ouput Example

##### PowerShell

![PowerShell Output Example](https://raw.githubusercontent.com/sconyard/PS-VMSettingtovROPs/master/images/PS_Example.png)

##### vRealize Operations Manager

![vROps Output Example](https://raw.githubusercontent.com/sconyard/PS-VMSettingtovROPs/master/images/vROPs_example.png)

#### Support

No support offered or liability accepted use this script at your own risk.

This script was built and tested using;

1. VMware.VimAutomation.vROps version 12.0.0.15940184.
2. Vmware.VimAutomation.Core version 12.0.0.15939655.
3. VMware vRealize Operations Manager 8.1.0 Enterprise Edition.
4. VMware ESXi 7.0.0 15843807
5. VMware vCenter 7.0.0 15952599
