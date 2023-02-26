# windows-server-import-dns-blacklist
Import a DNS blacklist to a server-level Windows DNS Server query resolution policy

Using DNS blacklists with Windows Server DNS isn't straightforward, and all the other methods I've found revolve around creating a new zone for each domain that will be blocked, which just isn't practical and would make administration a nightmare. Luckily we have the DnsServerQueryResolutionPolicy object that we can use instead. This script will read a typical text file blacklist and create a single server-level DnsServerQueryResolutionPolicy that includes the entire blacklist.

This is still a work in progress so it's not perfect, but it is in a working state.

## Usage
The blacklist file should be formatted as a comma-separated list of domains, preferably one per line. If the list you want to use isn't already comma-separated, this can be easily achieved with a Notepad++ function or a similar text editor. 
