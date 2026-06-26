# Disk

Get-Disk | 
Select-Object -Property `
DiskNumber,BusType,FriendlyName,OperationalStatus,NumberOfPartitions,FirmwareVersion,IsBoot
$disk = (Get-Disk | Where-Object IsBoot -eq $true).Number # Disknummer als Variable speichern

# Partitions and Volumes

Get-Volume
Get-Partition -DiskNumber $disk
$cpartition = (Get-Partition -DriveLetter C).PartitionNumber # PartitionNumber als Variable speichern
Get-Partition -PartitionNumber $cpartition | Resize-Partition -Size (220GB) # C verkleinern

New-Partition -DiskNumber $disk -UseMaximumSize | Format-Volume -FileSystem NTFS # Neue Partition erstellen
Get-Partition
Get-Partition -PartitionNumber 5 | Set-Partition -NewDriveLetter F

Get-Partition -PartitionNumber 5 | Remove-Partition -Confirm:$false

$size = Get-PartitionSupportedSize -DiskNumber $disk -PartitionNumber $cpartition
Resize-Partition -DiskNumber $disk -PartitionNumber $cpartition -Size $size.SizeMax



