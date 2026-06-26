# BitLocker

Get-Command -Module BitLocker 
Get-BitLockerVolume

# Beispiele

$SecureString = ConvertTo-SecureString "1234" -AsPlainText -Force
Enable-BitLocker -MountPoint "C:" -EncryptionMethod Aes256 -UsedSpaceOnly -Pin $SecureString -TPMandPinProtector

Get-BitLockerVolume | Enable-BitLocker -EncryptionMethod Aes128 -RecoveryKeyPath "C:\Recovery\" -RecoveryKeyProtector

Enable-Bitlocker C: -PasswordProtector -UsedSpaceOnly

Get-BitLockerVolume | Disable-BitLocker