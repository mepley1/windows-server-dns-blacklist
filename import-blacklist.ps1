# Import a DNS blocklist into a server-level DnsServerQueryResolutionPolicy.
# Input file should be a comma-separated list of domains, one per line.
# Wildcards supported such as *.domain.com - see https://learn.microsoft.com/en-us/powershell/module/dnsserver/add-dnsserverqueryresolutionpolicy

# For testing / validation of the policies, refer to the following guide to enable analytical logging, 
# then look for event ID 259 in Event Viewer (ignored query) after making a few queries with nslookup etc.: 
# https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800669(v=ws.11)

# Customize the following to your needs
$SERVERNAME = 'dc1' # DNS server hostname (-ComputerName)
$BLOCKLISTFILE = '.\input.txt' # replace with the blocklist filename
$POLICYNAME = 'Blacklist-Custom' # Make sure this is unique to avoid deleting any existing policy you might have


# read the input file
$badDomains = Get-Content $BLOCKLISTFILE

# Check for existing policy made by this script & delete if exists
if ( Get-DnsServerQueryResolutionPolicy -ComputerName $SERVERNAME | Where Name -eq $POLICYNAME )
{
    Write-Host 'Found an existing policy we made, deleting it...'
    Remove-DnsServerQueryResolutionPolicy -Name $POLICYNAME
}

# Finally create the policy
Add-DnsServerQueryResolutionPolicy -ComputerName $SERVERNAME -Name $POLICYNAME -Action IGNORE -FQDN "EQ,$badDomains" -PassThru | Format-List *
