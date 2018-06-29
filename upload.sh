#!/bin/bash
if [ -z "$1$2" ]; then
  echo "Usage: upload.sh [file] [esp8266 telnet server ip address]"
  exit 1
fi
delay=0.5
file=`basename $1`
(k=1;echo "file.remove(\"$file\")";sleep $delay;echo "file.open(\"$file\",\"w+\")";sleep $delay; while IFS='' read -r line;do echo "print($k);file.writeline([==[""${line//]/] }""]==])";echo "file.flush()"; k=$((k+1)); sleep $delay; done < $1;echo "file.close()")|telnet $2 23
