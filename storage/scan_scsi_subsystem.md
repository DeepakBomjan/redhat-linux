When Adding a New Disk
When adding a new disk to your Linux system you need to rescan SCSI host.

You can do this with the following command:

echo "- - -" > /sys/class/scsi_host/hostX/scan
..where X is the number of SCSI host to scan.

You probably have more than one SCSI host available so to make it right you should repeat the above command for each SCSI host available.

Below is a practical example on how to rescan SCSI bus on Linux and and see the newly added disk:

[root@node-1 ~]# echo "- - -" > /sys/class/scsi_host/host0/scan
[root@node-1 ~]# echo "- - -" > /sys/class/scsi_host/host1/scan
[root@node-1 ~]# echo "- - -" > /sys/class/scsi_host/host2/scan
The “- – -” part is where you tell the SCSI host what exactly to rescan and the hyphens are wildcards which tell SCSI host to rescan all controllers, channels and LUNs.

When Increasing Existing Disk Size
If you changed the size of an existing disk you might notice that the operating system can not see the new disk size until you rescan SCSI bus on Linux operating system.

The easiest way i’ve found is to rescan the specific device with the following command:

echo "1" > /sys/class/block/sdX/device/rescan
..where X is the device you increased and want to rescan.

Below is a practical example on how to rescan SCSI bus on Linux and and see the newly added disk:

[root@node-1 ~]# echo "1" > /sys/class/block/sdb/device/rescan
The “1” is a flag which causes the SCSI host to rescan the “sdb” block device and therefore refresh the data about the disk size. Please note that i choose this command due to the human readable “sdb” naming which is really easy to remember.

Otherwise the command could also be triggered as follows:

[root@node-1 ~]# echo "1" > /sys/class/scsi_device/2:0:1:0/device/rescan
..but in the last case you should know which device you want to rescan by the SCSI bus ID.
