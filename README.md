# domainCheck

During many security audits in real environments I have come across the need to analyze the security measures implemented by the domain I am auditing, specifically to review the SPF and DMARC configuration of the domain to see if there is the possibility of spoofing emails.

This process was a bit tedious because as I am a forgetful person the dig and swaks flags both to check the domain and to spoof the domain in an email, with this I came up with the idea of creating a tool to “automate” this process.

<div align="center">
  <img src="https://i.imgur.com/0JO50XF.png" width="450px" />
</div>

## Setup

To use this tool just install dig + swaks, clone the repository and run it.

```shell
$ sudo apt install dig swaks
$ git clone https://github.com/abund4nt/domainCheck/
$ cd domainCheck
$ bash domainCheck.sh
```

## Usage

To check the SPF and DMARC configuration of the domain you must use the -d flag.

```shell
$ bash domaincheck.sh -d rop.ng
         __             _                
        /  |_  _  _|/  | \ _ __  _  o __ 
        \__| |(/_(_|\  |_/(_)|||(_| | | |
                abund4nt

[+] SPF configuration: 


[+] DMARC configuration: 

; <<>> DiG 9.18.30-0ubuntu0.24.04.1-Ubuntu <<>> TXT _dmarc.rop.ng
;_dmarc.rop.ng.                 IN      TXT
```

As we can see we can see that the previous domain does not have SPF nor DMARC configured, now to spoof the mail we use the -s flag with a random mail plus the domain.

```shell
$ bash domaincheck.sh -s test@rop.ng
         __             _                
        /  |_  _  _|/  | \ _ __  _  o __ 
        \__| |(/_(_|\  |_/(_)|||(_| | | |
                abund4nt

[+] Enter the recipient's e-mail address: xxx@xxx.com
=== Trying ASPMX.L.GOOGLE.com:25...
=== Connected to ASPMX.L.GOOGLE.com.
<-  220 mx.google.com ESMTP 586e51a60fabf-2b28f1504ccsi401649fac.13 - gsmtp
 -> EHLO work
<-  250-mx.google.com at your service, [186.78.3.225]
<-  250-SIZE 157286400
<-  250-8BITMIME
<-  250-STARTTLS
<-  250-ENHANCEDSTATUSCODES
<-  250-PIPELINING
<-  250-CHUNKING
<-  250 SMTPUTF8
 -> MAIL FROM:<test@rop.ng>
<-  250 2.1.0 OK 586e51a60fabf-2b28f1504ccsi401649fac.13 - gsmtp
 -> RCPT TO:<xxx@xxx.com>
<-  250 2.1.5 OK 586e51a60fabf-2b28f1504ccsi401649fac.13 - gsmtp
 -> DATA
<-  354 Go ahead 586e51a60fabf-2b28f1504ccsi401649fac.13 - gsmtp
 -> Date: Thu, 23 Jan 2025 15:58:19 -0300
 -> To: xxx@xxx.com
 -> From: test@rop.ng
 -> Subject: pwned
 -> Message-Id: <20250123155819.153879@work>
 -> X-Mailer: swaks v20240103.0 jetmore.org/john/code/swaks/
 -> 
 -> Spoofed Test
 -> 
 -> 
 -> .
<-  250 2.0.0 OK  1737658701 586e51a60fabf-2b28f1504ccsi401649fac.13 - gsmtp
 -> QUIT
<-  221 2.0.0 closing connection 586e51a60fabf-2b28f1504ccsi401649fac.13 - gsmtp
=== Connection closed with remote host.

[+]  Mail sent correctly.
```

When entering the email to impersonate we are asked to enter our email, after entering it we press enter and when checking the inbox we can see that it arrives without problems.

<img src="https://i.imgur.com/zjm8Hha.png">
