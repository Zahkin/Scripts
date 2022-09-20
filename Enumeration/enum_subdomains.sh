#!/bin/bash
# This tool enumerates subdomains with 3 different scripts.
# TO DO: Organize output by name and validate requirements.
#
# REQUIRES ASSETFINDER, AMASS AND HTTPROBE INSTALLED.
#
# Author: Bernardo Carvalho

printf "Insert Domain: "
read dom
mkdir ./$dom

echo "[+] Searching for subdomains with assetfinder..."
assetfinder $dom > ./$dom/asset_$dom.txt
echo "[+] Searching for subdomains with amass... (This step might take a while)"
amass enum -d $dom > ./$dom/amass_$dom.txt
cat ./$dom/amass_$dom.txt >> ./$dom/asset_$dom.txt

echo "[+] Validating active subdomains with httprobe..."
awk '!seen[$0]++' ./$dom/asset_$dom.txt | httprobe > ./$dom/$dom.txt

echo "[+] Done"
