# iMessageTool

Introduction

iMessageTool is a simple automated bash script that either deletes iMessage files and folders stored within a user's "Library" folder OR generates 20 unique ids(SmUUIDs).

You can download the latest version of iMessageTool to your Desktop by entering the following command in a terminal window:
```
curl -o ~/Desktop/iMessageTool.sh https://raw.githubusercontent.com/mattcarlotta/iMessageTool/master/iMessageTool.sh
```
You can then verify the downloaded size (should be about 8kb):
```
wc -c ~/Desktop/iMessageTool.sh
```
Then, you must change the file permissions to make it executable:
```
chmod +x ~/Desktop/iMessageTool.sh
```
Lastly, use this command to run the script:
```
~/Desktop/iMessageTool.sh
```

Commands:
```
dic (will delete iMessage caches)
idgen (will generate SmUUIDs)
help (will display instructions)
exit (will exit the script)
```
--------------------------------------------------------------------------------------------------------------

You'll be initially greeted with:
```
This script must be run as ROOT!
```
Input your Mac OS password to continue.

--------------------------------------------------------------------------------------------------------------

You'll then greeted with:
```
Would you like to delete iMessage caches or generate SmUUIDs? (dic/idgen/help/exit)?
```

If you input "idc" or "IDC" without quotes, then press the Enter key:
```
idc
```

The following folders/files will be deleted:
```
Folders in {user}/Library/Caches:
1.) com.apple.iCloudHelper
2.) com.apple.imfoundation.IMRemoteURLConnectionAgent
3.) com.apple.Messages

Files in {user}/Library/Preferences:
1.) com.apple.iChat*
2.) com.apple.icloud*
3.) com.apple.ids.service*
4.) com.apple.imagent*
5.) com.apple.imessage*
6.) com.apple.imservice*

Folder and files in {user}/Library/Messages
1.) Archive
2.) chat.db
3.) chat.db-shm
4.) chat.db-wal
```
You'll then be greeted with:
```
All related iMessage files and folders have been successfully removed!

Do you want to reboot now? (y/n)
```

Type "y" or "Y" without quotes to reboot your computer and press the Enter key. Otherwise, you can type "n" or "N" to abort the script and restart your OS manually.

--------------------------------------------------------------------------------------------------------------

If you input "idgen" or "IDGEN" without quotes, then press the Enter key:
```
idgen
```
You will then see an output like:
```
1: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
...
20: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
```
Now you copy and use any of the generated SmUUIDs!

--------------------------------------------------------------------------------------------------------------

If you input "macgen" or "MACGEN" without quotes, then press the Enter key:
```
macgen
```
You will then see an output like:
```
NOTE: No input product name found, using IORegistry value ({SMBIOS})
NOTE: No input serial number found, using IORegistry value ({Board Serial})
Manufacturing location (from serial number): {MANUFACTURER}
Manufacturing year (from serial number): {YEAR}
Manufacturing week (from serial number): {WEEK}
Generated board type: XXX
Generated CC value: XX
Generated EEEE value: XXXX
Generated KK value: XX

Generated {SMBIOS} MLB serial number: XXXXXXXXXXXXXXXXX
```
Now you copy and use the generated MLB serial number!

Note: The author of MacGen is theracermaster and you can find his repo here: <a href="https://github.com/theracermaster/MacGen">MacGen</a>

--------------------------------------------------------------------------------------------------------------

**Note: If at any point you type an invalid character, then that will temporarily stop the script. Wait a few seconds and it will restart on its own!
