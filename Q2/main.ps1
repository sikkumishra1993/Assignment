Function getInstanceMetaData {
    param (
        [Parameter(Mandatory = $False)][string]$datakey,
        [Parameter(Mandatory = $False)][string]$instanceName


    )

    process {

        try {
            
            if ($null -eq $instanceName)
            {
                $url = "http://169.254.169.254/metadata/instance?api-version=2021-02-01"
                $imdata = Invoke-RestMethod -Headers @{"Metadata" = "true" } -Method GET -Uri $url | ConvertTo-Json -Depth 64

                return $imdata
            }

            else
            {
                $url = "http://169.254.169.254/metadata/instance/" + $instanceName + "?api-version=2021-02-01"
                $imdata = Invoke-RestMethod -Headers @{"Metadata" = "true" } -Method GET -Uri $url

                return $imdata.$datakey
            }
            
        }

        catch {
            Write-Error "[ERROR] Failed to get the metadata"
            throw $_.Exception.Message
        }
        
    }
}

#**********************************************#
#************Function body*********************#
#********Function execution begins here********#
#**********************************************#

try {

    #$key = "subscriptionId"
    #$insName = "compute"

    if ($insName) {

        $idata = getInstanceMetaData -datakey $key -instanceName $insName

        Write-Output "Instance data for key [$key] is [$idata]"

    }

    else {

        $idata = getInstanceMetaData

        Write-Output "Instance data fis [$idata]"

    }
}

catch {
    Write-Error "[ERROR] Failed to get instance data"
    throw $_.Exception.Message
}
