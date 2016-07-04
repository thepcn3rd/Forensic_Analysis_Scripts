#!/bin/bash

filename=$1     # This is the filename to search for amongst the mounted volumes
fileLocations='files.txt'
notesFile='notes.txt'

if [ $filename ]
        then
                echo "" >> $notesFile
                for volume in '/mnt/drive0' '/mnt/drive1'  
                do
                        find $volume -type f -name $filename > $fileLocations
                done
                echo "#!/bin/bash" > evaluateFiles.sh
                echo "echo ''" >> evaluateFiles.sh
                echo "echo 'Calculating an MD5 Hash for the File'" >> evaluateFiles.sh
                cat $fileLocations | sed 's/ /\\ /g' | sed 's/^/md5deep /' >> evaluateFiles.sh
                echo "echo ''" >> evaluateFiles.sh
                echo "echo 'Calculating a SHA1 Hash for the File'" >> evaluateFiles.sh
                cat $fileLocations | sed 's/ /\\ /g' | sed 's/^/sha1deep /' >> evaluateFiles.sh
                echo "echo ''" >> evaluateFiles.sh
                echo "echo 'Displaying the size, inode and ownership of the file'" >> evaluateFiles.sh
                cat $fileLocations | sed 's/ /\\ /g' | sed 's/^/ls -li /' >> evaluateFiles.sh
                echo "echo ''" >> evaluateFiles.sh
                echo "echo 'Displaying the type of file through the file command'" >> evaluateFiles.sh
                cat $fileLocations | sed 's/ /\\ /g' | sed 's/^/file /' >> evaluateFiles.sh
                echo "echo ''" >> evaluateFiles.sh
                echo "echo 'Displaying the Modified, Creation, and Last Access Time of the file'" >> evaluateFiles.sh
                cat $fileLocations | sed 's/ /\\ /g' | sed "s/^/stat --printf '%n mtime: %y ctime: %z atime: %x crtime:%w\\n\\n' /" >> evaluateFiles.sh
                chmod 700 evaluateFiles.sh
                ./evaluateFiles.sh >> $notesFile
                # Clean-up the evaluateFiles.sh file
                rm -f evaluateFiles.sh
                # cat the notes file becuase this is normally the next command that I would run
                cat $notesFile
else
        echo "Usage './gatherFileInfo.sh <keyword/filename>'"
fi