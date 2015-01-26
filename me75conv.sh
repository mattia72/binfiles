#!/bin/bash
#me75 béna kimenetét konvártálja

if [ -z "$1" ]; then
              echo Usage: $0 me75_output_file
              exit
fi

#Convert encoding of given files from one encoding to another
iconv -f latin2 -t utf8 -o me75convtmp $1
# az idézőjeleket lecseréli
sed -i "s/\"//g"  me75convtmp

# az ékezetes betűk cseréje...
sed -i "s/ĂĄ/á/g"  me75convtmp
sed -i "s/Ă /á/g"  me75convtmp
sed -i "s/Ă/Á/g" me75convtmp

sed -i "s/ĂŠ/é/g" me75convtmp
sed -i "s/Ă¨/é/g" me75convtmp

sed -i "s/ĂŹ/í/g" me75convtmp

sed -i "s/Ă˛/ó/g" me75convtmp
sed -i "s/Ăł/ó/g" me75convtmp

sed -i "s/Ă/Ö/g" me75convtmp
sed -i "s/Ăś/ö/g" me75convtmp

sed -i "s/Ĺ/ő/g" me75convtmp

sed -i "s/Ăź/ü/g" me75convtmp
sed -i "s/Ă/Ü/g" me75convtmp

sed -i "s/Ăš/ú/g" me75convtmp

sed -i "s/ĂŹ/ű/g" me75convtmp



if cat me75convtmp | grep Ă; then
        echo Nem konvertált karakter !!!\n
	cat me75convtmp | grep --color Ă
	exit
fi

echo Minden ok!
#cp $1 $1.bak
#mv me75convtmp $1


