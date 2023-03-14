# Load the 'init.sh'.
source ~/zshrc/init.sh
# Find all .sh files in ~/zshrc, exclude 'init.sh'.
FILES_STR=$(fd --glob '*.sh' --exclude 'init.sh' ./zshrc)
# 'tr' is a find-and-replace utility.
# Outer () will convert the output of $() to array.
FILES=($(echo $FILES_STR | tr '\n' ' '))
for FILE in $FILES; do
    source $FILE
done