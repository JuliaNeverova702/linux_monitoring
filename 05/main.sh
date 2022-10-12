#!/bin/bash

TIME_START=`date +%s%N`

echo "Total number of folders (including all nested ones) = `find ${1} -type d | wc -l`"  
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"  
for (( i = 1; i < 6; i++ )); do
    SIZE_FOLDER=`du -xsh --exclude="*.*" $1* | sort -rh | head -$i | tail -1 | cut -f 1`
    NAME_FOLDER=`du -xsh --exclude="*.*" $1* | sort -rh | head -$i | tail -1 | cut -f 2`
    if [[ $NAME_FOLDER == $tmp ]]; then 
        break
    fi
    echo "$i - ${NAME_FOLDER}, ${SIZE_FOLDER}"
    tmp=${NAME_FOLDER}
done

echo "Total number of files = `ls -1 | wc -l`"

echo "Number of:"  
echo "Configuration files (with the .conf extension) = `find ${1} -type f -name "*.conf" | wc -l`" 
echo "Text files = `find ${1} -type f -name "*.txt" | wc -l`"  
echo "Executable files = `find ${1} -type f -perm -ugo=x | wc -l`"
echo "Log files (with the extension .log) = `find ${1} -type f -name "*.log" | wc -l`"  
echo "Archive files = `find ${1} -type f -name "*.rar" -name "*.arj" -name "*.zip" -name "*.tar" | wc -l`"  
echo "Symbolic links = `ls -li ${1} | grep softlink | wc -l`"  

echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
for (( i = 1; i < 11; i++ )); do
    SIZE_FILE=`find $1 -type f -exec du -sh {} 2>/dev/null + | sort -rh | head -n $i | tail -1 | cut -f 1`
    NAME_FILE=`find $1 -type f -exec du -sh {} 2>/dev/null + | sort -rh | head -n $i | tail -1 | cut -f 2`
    n=`find $1 -type f -exec du -sh {} 2>/dev/null + | sort -rh | head -n $i | tail -1 | cut -f 2 | tr -cd '/' | wc -m `
    n=$(( $n+1 ))
    FILE_TYPE=`find $1 -type f -exec du -sh {} 2>/dev/null + | sort -rh | head -n $i | tail -1 | cut -f 2 | cut -f $n -d '/' | cut -f 2 -d '.'`
if [[ $tmp == $TOP_FILE_TYPE ]]; then
    FILE_TYPE=" "
  fi
  if [[ $NAME_FILE == $tmp1 ]]; then
    break
  fi
  echo  "$i - $NAME_FILE, $SIZE_FILE, $FILE_TYPE"
  tmp1=$NAME_FILE
done

echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)"
col=$(find $1 -type f -perm /001 -ls  | wc -l)
if [ $col -gt 10 ]; then
  col=10;
fi
for (( i = 1; i <= col; i++ )); do
  tmp=$(find $1 -type f -perm /001 -ls | sort -nrk7 | sed -n "$i"p | awk '{print $11}')
  echo "$i - $(find $1 -type f -perm /001 -ls | sort -nrk7 | sed -n "$i"p | awk '{print $11, $7}') KB, $(md5sum $tmp | awk '{print $1}')"
done

TIME_END=`date +%s%N`
TIME=$(( $TIME_END - $TIME_START ))
SEC=$(( $TIME / 1000000000 ))
N_SEC=$(( $TIME % 1000000000 ))
echo "Script execution time (in seconds) = $SEC.$N_SEC"
