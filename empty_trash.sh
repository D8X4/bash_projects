
#!/bin/bash

read -p 'Delete all in trash? ' choice

if [ $choice == 'y' ]
then
rm -rf ~/.local/share/Trash/files
echo trash has been deleted
fi


