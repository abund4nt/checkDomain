# domainCheck

During many security audits in real environments I have come across the need to analyze the security measures implemented by the domain I am auditing, specifically to review the SPF and DMARC configuration of the domain to see if there is the possibility of spoofing emails.

This process was a bit tedious because as I am a forgetful person the dig and swaks flags both to check the domain and to spoof the domain in an email, with this I came up with the idea of creating a tool to “automate” this process.

<center><img src="https://i.imgur.com/0JO50XF.png" width="350px"/></center>

## Setup

To use this tool just install dig + swaks, clone the repository and run it.

```shell
$ sudo apt install dig swaks
$ git clone https://github.com/abund4nt/domainCheck/
$ cd domainCheck
$ bash domainCheck.sh
```
