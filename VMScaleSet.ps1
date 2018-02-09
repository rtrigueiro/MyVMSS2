# Define the script for your Custom Script Extension to run
$customConfig = @{
    "fileUris" = (,"https://github.com/rtrigueiro/MyVMSS2/blob/master/VMScaleSet_with_FW.ps1");
    "commandToExecute" = "powershell -ExecutionPolicy Unrestricted -File automate-iis.ps1"
}

# Get information about the scale set
$vmss = Get-AzureRmVmss `
                -ResourceGroupName "VMSS" `
                -VMScaleSetName "MyVMSS"

# Add the Custom Script Extension to install IIS and configure basic website
$vmss = Add-AzureRmVmssExtension `
    -VirtualMachineScaleSet $vmss `
    -Name "customScript" `
    -Publisher "Microsoft.Compute" `
    -Type "CustomScriptExtension" `
    -TypeHandlerVersion 1.8 `
    -Setting $customConfig

# Update the scale set and apply the Custom Script Extension to the VM instances
Update-AzureRmVmss `
    -ResourceGroupName "VMSS" `
    -Name "myScaleSet" `
    -VirtualMachineScaleSet $vmss