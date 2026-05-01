#!/bin/bash
read -p 'file name; ' choice
touch $choice.sh
chmod u+x $choice.sh
echo "#!/bin/bash" > $choice.sh
echo "script was made"
