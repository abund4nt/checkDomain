#!/usr/bin/env python3

import argparse
import subprocess
import sys
import time
import dns.resolver

def banner():
    print("")

def analyze_domain(domain):
    print("\n[+] SPF Configuration:\n")
    try:
        answers = dns.resolver.resolve(domain, 'TXT')
        for rdata in answers:
            for txt_string in rdata.strings:
                decoded = txt_string.decode()
                if decoded.startswith('v=spf1'):
                    print(decoded)
    except Exception as e:
        print(f"Error fetching SPF record: {e}")

    print("\n[+] DMARC Configuration:\n")
    try:
        dmarc_domain = f"_dmarc.{domain}"
        answers = dns.resolver.resolve(dmarc_domain, 'TXT')
        for rdata in answers:
            for txt_string in rdata.strings:
                print(txt_string.decode())
    except Exception as e:
        print(f"Error fetching DMARC record: {e}")

def send_email(recipient, domain):
    sender = f"noreply@{domain}"
    print(f"\n[+] Sending email from {sender} to {recipient}\n")
    subprocess.run([
        "swaks",
        "--from", sender,
        "--to", recipient,
        "--body", "Spoofed Test",
        "--h-Subject", "pwned"
    ])
    time.sleep(0.5)
    print("\n[+] Email sent successfully.\n")

def main():
    banner()
    parser = argparse.ArgumentParser(
        description="Domain analysis and spoofed email sender",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter
    )
    parser.add_argument("-d", "--domain", metavar="DOMAIN", help="Target domain for SPF and DMARC analysis")
    parser.add_argument("-s", "--send", metavar="RECIPIENT", help="Recipient email address for spoofed test (sender is noreply@domain)")
    args = parser.parse_args()

    if not args.domain and not args.send:
        parser.print_help()
        sys.exit(1)

    if args.domain and not args.send:
        analyze_domain(args.domain)
    elif args.domain and args.send:
        send_email(args.send, args.domain)
    else:
        print("[-] Please specify both --domain and --send to send a spoofed email.")
        sys.exit(1)

if __name__ == "__main__":
    main()
