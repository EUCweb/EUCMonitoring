function Test-WEM {
    <#   
.SYNOPSIS   
    Tests Citrix Workspace Environment Servers Functionailty.
.DESCRIPTION 
    Tests Citrix Workspace Environment Management Servers Functionailty..
    Currently Testing
        WEM Server Availability
        WEM Agent Port Connectivity
        All Services passed into the module     
.PARAMETER WEMServers 
    Comma Delimited List of WEM Servers to check
.PARAMETER WEMAgentPortString 
    TCP Port to use for WEM Connectivity Tests
.PARAMETER WEMServices 
    WEM Services to check
.PARAMETER ErrorFile 
    Infrastructure Error File to Log To
.PARAMETER OutputFile 
    Infrastructure OutputFile   
.NOTES
    Current Version:        1.0
    Creation Date:          16/03/2018
.CHANGE CONTROL
    Name                    Version         Date                Change Detail
    James Kindon            1.0             16/03/2018          Function Creation
.EXAMPLE
    None Required
#> 

    Param
    (
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]$WEMServers,
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]$WEMAgentPortString,
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]$WEMServices,
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]$ErrorFile,
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]$OutputFile

    )

    # Initialize Arrays and Variables
    $WEMServerUp = 0
    $WEMServerDown = 0
    Write-Verbose "Variables and Arrays Initalized"

    Write-Verbose "Read in WEM Details"
    Write-Verbose "WEM Servers: $WEMServers"
    Write-Verbose "WEM Ports: $WEMAgentPortString" 
    Write-Verbose "WEM Services: $WEMServices"

    foreach ($WEMServer in $WEMServers) {

        # Check that the WEM Server is up
        if ((Connect-Server $WEMServer) -eq "Successful") {
			
            # Server is up and responding to ping
            Write-Verbose "$WEMServer is online and responding to ping" 

            # Check the WEM Server Port
            if ((Test-NetConnection $WEMServer $WEMAgentPortString).open -eq "True") {

                # WEM Server port is up and running
                Write-Verbose "$WEMServer WEM Server Agent Port is up: Port - $WEMAgentPortString"

                # Check all critical services are running on the WEM Server
                # Initalize Pre loop variables and set Clean Run Services to Yes
                $ServicesUp = "Yes"
                $ServiceError = ""

                # Check Each Service for a Running State
                foreach ($Service in $WEMServices) {
                    $CurrentServiceStatus = Test-Service $WEMServer $Service
                    If ($CurrentServiceStatus -ne "Running") {
                        # If the Service is not running set ServicesUp to No and Append The Service with an error to the error description
                        if ($ServiceError -eq "") {
                            $ServiceError = $Service
                        }
                        else {
                            $ServiceError = $ServiceError + ", " + $Service
                        }
                        $ServicesUp = "no"
                    }
                }

                # Check for ALL services running, if so mark WEM Server as UP, if not Mark as down and increment down count
                if ($ServicesUp -eq "Yes") {
                    # The WEM Server and all services tested successfully - mark as UP
                    Write-Verbose "$WEMServer is up and all Services are running"
                    $WEMServerUp++
                }
                else {
                    # There was an error with one or more of the services
                    Write-Verbose "$WEMServer Service error - $ServiceError - is degraded or stopped."
                    "$WEMServer Service error - $ServiceError - is degraded or stopped." | Out-File $ErrorFile -Append
                    $WEMServerDown++
                }
                
            }
            else {
                # WEM Server Agent Port is down - mark down, error log and increment down count
                Write-Verbose "$WEMServer WEM Server Agent Port is down - Port - $WEMAgentPortString"
                "$WEMServer Server Agent Port is down - Port - $WEMAgentPortString" | Out-File $ErrorFile -Append
                $WEMServerDown++
            }

        }
        else {
            # WEM Server is down - not responding to ping
            Write-Verbose "$WEMServer is down" 
            "$WEMServer is down"  | Out-File $ErrorFile -Append
            $WEMServerDown++
        }
    }

    # Write Data to Output File
    Write-Verbose "Writing WEM Server Data to output file"
    "WEMServer,$WEMServerUp,$WEMServerDown" | Out-File $OutputFile
}
