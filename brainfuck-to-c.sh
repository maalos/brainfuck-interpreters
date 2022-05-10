#!/bin/bash

c=`cat $1`
f="bbi.c"
echo $c

echo -ne "#include <stdio.h>\nchar a[30000]={0};char *p=a;int main(){" >> $f

for (( i=0; i<${#c}; i++ )); do
    case ${c:$i:1} in
        "+") echo -n "++p;" >> $f ;;
        "-") echo -n "--p;" >> $f ;;
        ">") echo -n "++*p;" >> $f ;;
        "<") echo -n "--*p;" >> $f ;;
        ".") echo -n "putchar(*p);" >> $f ;;
        ",") echo -n "*p=getchar();" >> $f ;;
        "[") echo -n "while(*p){" >> $f ;;
        "]") echo -n "};" >> $f ;;
        *) echo ${c:$i:1} ;;
    esac
done

echo -ne "return 0;};" >> $f

gcc $f
./a.out
rm $f
