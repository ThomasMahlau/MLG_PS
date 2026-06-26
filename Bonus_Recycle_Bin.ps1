# Recycle Bin aktivieren (Forest-Mode mind. Windows Server 2008R2)

$ForestRootDomain = 'contoso.com'

Enable-ADOptionalFeature 'Recycle Bin Feature' `
-Scope ForestOrConfigurationSet -Target $ForestRootDomain

Get-ADOptionalFeature -Filter * | Select-Object Name,EnabledScopes # pruefen

# Papierkorb testen 

Remove-ADUser f.bizeps 

Get-ADObject -Filter `
{samaccountname -eq "f.bizeps"} -IncludeDeletedObjects | 
Restore-ADObject -Verbose

Get-ADUser -Identity f.bizeps


# Forest Mode ueberpruefen (minimum: W2k16)

(Get-ADForest).ForestMode

# Time-based-Groupmembership aktivieren
Enable-ADOptionalFeature 'Privileged Access Management Feature' `
-Scope ForestOrConfigurationSet `
-Target contoso.com

# Benutzer zu einer Gruppe fuer 5 Minuten hinzufuegen
Add-ADGroupMember `
-Identity 'Domänen-Admins' `
-Members 'f.bizeps' `
-MemberTimeToLive (New-TimeSpan -Minutes 5)

# TTL Wert anzeigen
Get-ADGroup 'Domänen-Admins' -Properties Member -ShowMemberTimeToLive