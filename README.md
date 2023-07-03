# windows-server-import-dns-blacklist
Import a DNS blacklist to a server-level Windows DNS Server query resolution policy

Using DNS blacklists with Windows Server DNS isn't straightforward, and all the other methods I've found revolve around creating a new zone for each domain that will be blocked, which just isn't practical as a DNSBL implementation and would make administration a nightmare. Luckily we have the DnsServerQueryResolutionPolicy object that we can use instead, which is better suited for this purpose. This script will read a typical text file blocklist and create a single server-level DnsServerQueryResolutionPolicy that includes the entire blocklist. 

This is a rough work in progress, but it is in a basic working state. 

## Requirements
If executing the script remotely, you need to have the DnsServer Powershell module installed.

## Usage
The blacklist file should be formatted as a comma-separated list of domains, preferably one per line. If the list you want to use isn't already comma-separated, this can be easily achieved with a Notepad++ function or a similar text editor. 

Once your blacklist is ready, edit the variables at the top of the script for the server hostname + input filename + policy name, then run it in a Powershell prompt as Admin or a user with DNS Admin role. 

Each time you execute it will replace the previous query resolution policy, so you don't end up with a mess of different policies. 

## To do
- Use command line arguments for hostname/infile/policy name
- Make companion tool to format blacklists or add to script itself.
