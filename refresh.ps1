
# Instructions:
# 1. Install PowerShell (https://msdn.microsoft.com/en-us/powershell/scripting/setup/installing-windows-powershell) and the Azure PowerShell cmdlets (https://aka.ms/webpi-azps)
# 2. Set up a dataset for refresh in the Power BI service - make sure that the dataset can be 
# updated successfully
# 3. Fill in the parameters below
# 4. Run the PowerShell script

# Parameters - fill these in before running the script!
# =====================================================

$clientId = "cf38b687-e170-48bb-8954-2023c36269d8" 

# End Parameters =======================================

# Calls the Active Directory Authentication Library (ADAL) to authenticate against AAD
# MS online powershell module (connect-msolservice )


function GetAuthToken
{
       if(-not (Get-Module AzureRm.Profile)) {
         Import-Module AzureRm.Profile
       }
 
       $redirectUri = "urn:ietf:wg:oauth:2.0:oob"
 
      $resourceAppIdURI = "https://analysis.windows.net/powerbi/api"
 
       $authority = "https://login.microsoftonline.com/common/oauth2/authorize";
 
       $authContext = New-Object "Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationContext" -ArgumentList $authority
 
       $authResult = $authContext.AcquireToken($resourceAppIdURI, $clientId, $redirectUri, "Auto")
	   

 
       return $authResult
}


# Get the auth token from AAD
$token = GetAuthToken
#Write-Host $token

# properly format groups path
$FilePath = 'C:\scripts\authtoken2.txt' -f $env:SystemDrive;
$token.CreateAuthorizationHeader() | Out-File -FilePath $FilePath ;
# Refresh the dataset
#$uri = "https://api.powerbi.com/v1.0/$groupsPath/datasets/$datasetID/refreshes"
#$uri = "https://api.powerbi.com/v1.0/$groupsPath/datasets/$datasetID/refreshes"
