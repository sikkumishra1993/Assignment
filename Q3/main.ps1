
Function getObjectKeys {

    param (
        [Parameter(Mandatory = $True)][string]$object,
        [Parameter(Mandatory = $True)][string]$key

    )

    process {

        try {

            $objData = $object | ConvertFrom-Json
            $keyVal = $key -split "/"

            foreach ($val in $keyVal) {
                $objData = $objData.$val
            }

            return $objData
        }
        catch {
            Write-Error "[ERROR] Failed to get the value"
            throw $_.Exception.Message
        }
        
    }

}

#**********************************************#
#************Function body*********************#
#********Function execution begins here********#
#**********************************************#

try {

    $obj = '{"x1": { "y1": { "z1": "a1" }}}'
    $key = "x1/y1"
    Write-Output (getObjectKeys -object $obj -key $key)

}

catch {
    Write-Error "[ERROR] Failed to get the value"
    throw $_.Exception.Message
}
