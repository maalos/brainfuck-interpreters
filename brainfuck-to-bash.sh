#!/bin/bash

c=`cat $1`
f="bbi.tmp"
echo $c

for (( i=0; i<${#c}; i++ )); do
    case ${c:$i:1} in
        "+") echo "(( a[p] = a[p] + 1 ))" >> $f ;;
        "-") echo "(( a[p] = a[p] - 1 ))" >> $f ;;
        ">") echo "(( p = p + 1 ))" >> $f ;;
        "<") echo "(( p = p - 1 ))" >> $f ;;
        ".") echo 'printf "\x$(printf %x ${a[$p]})"' >> $f ;;
        "[") echo "while [ \${a[\$p]} -ne 0 ]; do" >> $f ;;
        "]") echo "done" >> $f ;;
        *) echo ${c:$i:1} ;;
    esac
done

bash $f
rm $f
