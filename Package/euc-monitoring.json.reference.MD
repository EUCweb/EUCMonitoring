# EUC Monitoring JSON Reference File

This is a reference file for the JSON file that is provided with the EUC Monitoring Tool - below you will find the details of what each line in the JSON file means.

## JSON Reference
```json
{
    "WebData": {
        "outputlocation": "c:\\webdata", - Output location for the main web page.
        "htmldatafile": "htmldata.txt", - HTML data file name (Can leave as default).
        "htmloutputfile": "index.html", - HTML output file name.
        "refreshduration": 0, - Refresh Duration for the output web page.
        "servererrorfile": "server-errors.txt", - Server workload error file (Can leave as default).
        "desktoperrorfile": "desktop-errors.txt", - Desktop workload error file (Can leave as default).
        "UpColour": "rgba(221, 70, 70, 0.9)", - Service up colour.
        "DownColour": "rgba(67, 137, 203, 0.95)", - Service down colour.
        "WorkerDonutStroke": 5, - Thickness of the worker donut ring.
        "workerdonutsize": 500, - Size of the worker donut.
        "InfraDonutStroke": 4, - Thickness of the infrastructure donut ring.
        "Infradonutsize": 160, - Size of the infrastructure donut.
        "infraerrorfile": "infra-errors.txt" - Infrastructure error file.
    }, ```
    Test Text
    Test Text
    ```json
    "Microsoft": { - Microsoft Tests.
        "AD": { - Active Directory
            "test": "yes", - Test Active Directory?
            "ADServers": ["dc.domain.com"], - Comma delimited array of Domain Controllers.
            "ADLDAPPort": "389", - LDAP active port.
            "ADServices": ["Netlogon","ADWS","NTDS"] - LDAP services to test.
        },
        "SQL": { - SQL Server
            "test": "yes", - Test SQL Server?
            "SQLServers": ["sql.domain.com"], - Comma delimited array of SQL Serevrs
            "SQLPort": "1433", - SQL Port
            "SQLServices": ["MSSQLServer"] - SQL services to test.
        }
    },
    "Citrix": {
        "Global": {
            "xdbrokerprimary": "xdprimary.domain.com",
            "xdbrokerfailover": "xdsecondary.domain.com",
            "workloads": ["server","desktop"],
            "controlup": "no"
        },
        "server": {
            "bootthreshold": "7",
            "donutfile": "donut.txt",
            "highload": 8000
        },
        "desktop": {
            "bootthreshold": "31",
            "donutfile": "donut.txt",
            "highload": 8000
        },
        "xenserver": {
            "test": "yes",
            "poolmasters": ["pool_master_ip1","pool_master_ip2"],
            "poolmasterport": "80",
            "username": "root",
            "password": "password"
        },
        "storefront": {
            "test": "yes",
            "storefrontservers": "storefront.domain.com",
            "storefrontport": "80",
            "storefrontpath": "/citrix/storeweb",
            "protocol": "http"
        },
        "licensing": {
            "test": "yes",
            "licenseservers": ["license1.domain.com","license2.domain.com"],
            "vendordaemonport": "7279",
            "licenseport": "27000",
            "webadminport": "8082",
            "simplelicenseserviceport": "8083"
        },
        "director": {
            "test": "yes",            
            "directorservers": ["director1.domain.com","director2.domain.com"],
            "directorport": "80",
            "directorpath": "/Director/LogOn.aspx?cc=true",
            "protocol": "http"
        },
        "controllers": {
            "test": "yes",
            "controllerservers": ["controller1.domain.com","controller2.domain.com"],
            "controllerport": "80",
            "controllerservices": ["CitrixBrokerService","CitrixHighAvailabilityService","CitrixConfigSyncService","CitrixConfigurationService","CitrixConfigurationLogging","CitrixDelegatedAdmin","CitrixADIdentityService","CitrixMachineCreationService","CitrixHostService","CitrixEnvTest","CitrixMonitor","CitrixAnalytics","CitrixAppLibrary","CitrixOrchestration"]
        },
        "netscalers": {
            "test": "yes",
            "netscalers": ["netscaler_ip1","netscaler_ip2"],
            "netscalerusername": "nsroot",
            "netscalerpassword": "nsroot"
        },
        "netscalergateway": {
            "test": "yes",
            "netscalerhostinggateway": "netscaler_gateway_ip"
        },
        "ProvisioningServers": {
            "test": "yes",
            "ProvisioningServerFarm": "pvs",
            "ProvisioningServerSite": "pvs_site",
            "ProvisioningServers": ["pvs1.domain.com","pvs2.domain.com"],
            "ProvisioningServerPort": "54321",
            "ProvisioningServerServices": ["BNPXE","BNTFTP","PvsApi","PVSTSB","soapserver","StreamService"]
        },
        "WEM": {
            "test": "yes",
            "WEMServers": ["wembroker1.domain.com","wembroker2.domain.com"],
            "WEMAgentPort": "8286",
            "WEMServices": ["Norskale Infrastructure Service"]
        },
        "UPS": {
            "test": "yes",
            "UPSServers": "upsserver.domain.com",
            "UPSPort": "7229",
            "UPSServices": ["UpSvc","CitrixXTEServer"]
        },
        "FAS": {
            "test": "yes",
            "FASServers": ["fasserver1.domain.com","fasserver2.domain.com"],
            "FASPort": "135",
            "FASServices": ["CitrixFederatedAuthenticationService"]
         },   
         "CC": {
            "test": "yes",
            "CCServers": ["ccserver1.domain","ccserver2.domain"],
            "CCPort": "80",
            "CCServices": ["CitrixWorkspaceCloudADProvider","CitrixWorkspaceCloudAgentDiscovery","CitrixWorkspaceCloudAgentLogger","CitrixWorkspaceCloudAgentSystem","CitrixWorkspaceCloudAgentWatchDog","CitrixWorkspaceCloudCredentialProvider","CitrixWorkspaceCloudWebRelayProvider","CitrixConfigSyncService","CitrixHighAvailabilityService","Citrix NetScaler Cloud Gateway","XaXdCloudProxy","RemoteHCLServer","SessionManagerProxy"]
        },
        "EnvChecks": {
            "test": "yes",
            "ddccheck": "yes",
            "deliverygroupcheck": "yes",
            "catalogcheck": "yes",
            "hypervisorcheck": "yes"
        }
    }
}
```

Service reference List
Provisioning Server:
BNBOOTP = Citrix PVS BOOTP Service
BNPXE = Citrix PVS PXE Service
BNTFTP = Citrix PVS TFTP Service
PvsApi = Citrix PVS API Service
PVSTSB = Citrix PVS Two-Stage Boot Service
soapserver = Citrix PVS Soap Server
StreamService = Citrix PVS Stream Service

Controllers/Storefront/Licencing:
Citrix Licensing  = Citrix Licensing
Citrix Peer Resolution Service = Citrix Peer Resolution Service
Citrix_GTLicensingProv = Citrix Licensing WMI
CitrixADIdentityService = Citrix AD Identity Service
CitrixAnalytics = Citrix Analytics
CitrixAppLibrary = Cirix App Library
CitrixBrokerService = Citrix Broker Service
CitrixConfigSyncService = Citrix Config Synchronizer Service
CitrixConfigurationLogging = Citrix Configuration Logging Service
CitrixConfigurationReplication = Citrix Configuration Replication
CitrixConfigurationService = Citrix Configuration Service
CitrixConnector = Citrix Smart Tools Agent Service
CitrixCredentialWallet = Citrix Credential Wallet
CitrixDefaultDomainService = Citrix Default Domain Services
CitrixDelegatedAdmin = Citrix Delegated Administration Service
CitrixEnvTest = Citrix Environment Test Service
CitrixHighAvailabilityService = Citrix High Availability Service
CitrixHostService = Citrix Host Service
CitrixMachineCreationService = Citrix Machine Creation Service
CitrixMonitor = Citrix Monitor Service
CitrixOrchestration = Citrix Orchestration Service
CitrixPrivilegedService = Citrix Storefront Privileged Administration Service
CitrixServiceMonitor = Citrix Service Monitor
CitrixStorefront = Citrix Storefront Service
CitrixSubscriptionsStore = Citrix Subscriptions Store
CitrixTelemetryService = Citrix Telemetry Service
CitrixTrust = Citrix Trust Service
CitrixWebServicesforLicensing = Citrix Web Services for Licensing
CtxLSPortSvc = Citrix Licensing Support Service
XaXdCloudProxy = Citrix Remote Broker Provider
