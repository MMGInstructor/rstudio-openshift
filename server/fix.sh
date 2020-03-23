#!/bin/bash

echo "Creating passwd entries"
tempfile=$(mktemp)  
#Eliminio lineas de usuarios rstudio y $USERNAME y lineas vacias
sed -e "s/^rstudio.*//g" /etc/passwd | sed -e "s/^$USERNAME.*//g" | sed "/^$/d" > $tempfile
cp $tempfile /etc/passwd

rm -f $tempfile
echo "rstudio-server:x:$(id -u):$(id -g)::$HOME:" >> /etc/passwd
echo "$USERNAME:x:$(id -u):$(id -g)::$HOME:" >> /etc/passwd

echo "Creating group entries"
tempfile2=$(mktemp)
# Elimino grupo rstudio y $USERNAME y lineas vacías
sed -e "s/^rstudio.*//g" /etc/group | sed -e "s/^$USERNAME.*//g" | sed "/^$/d" > $tempfile2
cp $tempfile2 /etc/group

rm -f $tempfile2
#echo "$USERNAME:x:$(id -u):" >> /etc/group

echo "Reading credentials"
RPassword=$(cat /tmp/shadow/shadow.crypt)

echo "Creating shadow entries"
tempfile3=$(mktemp)   
# Elimino passwords de rstudio y USERNAME y lineas vacias
sed -e "s/^rstudio.*//g" /etc/shadow | sed -e "s/^$USERNAME.*//g" | sed "/^$/d" > $tempfile3

cp $tempfile3 /etc/shadow
rm -f $tempfile3
echo "$USERNAME:${RPassword}:17866:0:99999:7:::" >> /etc/shadow
echo "rstudio-server:${RPassword}:17866:0:99999:7:::" >> /etc/shadow

# echo "rstudio-server:$6$OLWwdiLp$uLstyoh.dp5yAWgZqoHUj707hxKlca17PrGFoDKvOlX.QHJVdLBm3eBfG9JF0NKjgxCL8QKTl3xMR/LZJSmgR1:17652:0:99999:7:::" >> /etc/shadow
