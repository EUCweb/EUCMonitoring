function Test-CC {
    <#   
.SYNOPSIS   
    Tests Citrix Cloud Connector Servers
.DESCRIPTION 
    Tests Citrix Cloud Connector Servers
    Currently Testing
        Cloud Connector Server Availability
        Cloud Connector Port Connectivity
        All Services passed into the module     
.PARAMETER CCServers 
    Comma Delimited List of Cloud Connector Servers to check
.PARAMETER CCPortString 
    TCP Port to use for Cloud Connector Connectivity Tests
.PARAMETER CCServices 
    Cloud Connector Services to check
.PARAMETER ErrorFile 
    Infrastructure Error File to Log To
.PARAMETER OutputFile 
    Infrastructure OutputFile   
.NOTES
    Current Version:        1.0
    Creation Date:          19/03/2018
.CHANGE CONTROL
    Name                    Version         Date                Change Detail
    David Wilkinson         1.0             19/03/2018          Function Creation
.EXAMPLE
    None Required
#> 

    Param
    (
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]$CCServers,
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]$CCPortString,
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]$CCServices,
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]$ErrorFile,
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]$OutputFile

    )

    # Initialize Arrays and Variables
    $CCServerUp = 0
    $CCServerDown = 0
    Write-Verbose "Variables and Arrays Initalized"

    # Get Cloud Connector Server Comma Delimited List 
    Write-Verbose "Read in Cloud Connector Details"
    Write-Verbose "Cloud Connector Servers: $CCServers"
    Write-Verbose "Cloud Connector Ports: $CCPortString" 
    Write-Verbose "Cloud Connector Services: $CCServices"

    foreach ($CCServer in $CCServers) {

        # Check that the Cloud Connector Server is up
        if ((Connect-Server $CCServer) -eq "Successful") {
			
            # Server is up and responding to ping
            Write-Verbose "$CCServer is online and responding to ping" 

            # Check the Cloud Connector Server Port
            if ((Test-NetConnection $CCServer $CCPortString).open -eq "True") {

                # Cloud Connector incoming port is up and running
                Write-Verbose "$CCServer Incoming Port is up: Port - $CCPortString"

                # Check all critical services are running on the Cloud Connector Server
                # Initalize Pre loop variables and set Clean Run Services to Yes
                $ServicesUp = "Yes"
                $ServiceError = ""

                # Check Each Service for a Running State
                foreach ($Service in $CCServices) {
                    $CurrentServiceStatus = Test-Service $CCServer $Service
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

                # Check for ALL services running, if so mark Cloud Connector Server as UP, if not Mark as down and increment down count
                if ($ServicesUp -eq "Yes") {
                    # The Cloud Connector Server and all services tested successfully - mark as UP
                    Write-Verbose "$CCServer is up and all Services are running"
                    $CCServerUp++
                }
                else {
                    # There was an error with one or more of the services
                    Write-Verbose "$CCServer Service error - $ServiceError - is degraded or stopped."
                    "$CCServer Service error - $ServiceError - is degraded or stopped." | Out-File $ErrorFile -Append
                    $CCServerDown++
                }
                
            }
            else {
                # Cloud Connector incoming Port is down - mark down, error log and increment down count
                Write-Verbose "$CCServer incoming Port is down - Port - $CCPortString"
                "$CCServer Incoming Port is down - Port - $CCPortString" | Out-File $ErrorFile -Append
                $CCServerDown++
            }

        }
        else {
            # Cloud Connector Server is down - not responding to ping
            Write-Verbose "$CCServer is down" 
            "$CCServer is down"  | Out-File $ErrorFile -Append
            $CCServerDown++
        }
    }

    # Write Data to Output File
    Write-Verbose "Writing Cloud Connector Server Data to output file"
    "CCServer,$CCServerUp,$CCServerDown" | Out-File $OutputFile
}
