#!/bin/sh
# a simple way to parse shell script arguments by jehiah: https://gist.github.com/jehiah/855086


function usage()
{
    echo "Option for install"
    echo ""
    echo "-h  --help      this help"
    echo "    --jdk-path      path of jdk-xxxxx-xxxxx-xxx.tar.gz"
    echo "                visit: http://www.oracle.com/technetwork/java/javase/downloads/"
    echo "                and copy lastest JDK for Linux x86 or x64 .tar.gz link"
    echo "    --no-update  Install the new version while keeping the previous ones"
    echo ""
}

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        --jdk-path)
            ENVIRONMENT=$VALUE
            ;;
        --no-update)
            DB_PATH=$VALUE
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done


echo -e "\e[32m"
echo "Installation JDK..."

echo "Visit: http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html"
echo "and past lastest JDK for Linux x86 or x64 .tar.gz"
echo
echo "JDK URL:"
JDKfileName="http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz"

echo ${JDKfileName}
#read -p "Enter the JDK URL: " -e -i ${JDKfileName} JDKfileName
wget  --progress=bar:force --header "Cookie: oraclelicense=accept-securebackup-cookie" -N ${JDKfileName} -P /tmp/
JDKfileName=$(ls -f /tmp/jdk-*.gz)
echo "File Name: " ${JDKfileName}
 mkdir -p /opt/jdk/
 tar -xvzf ${JDKfileName} -C /opt/jdk
#rm ${JDKfileName}
JDKfolderName=$(ls -d /opt/jdk/jdk*)


# Del alternative for java*
for i in `update-alternatives --get-selections | grep java | awk '{print $1}'`;
do
  for j in `update-alternatives --list  $i | awk '{print $1}'`;
  do
    update-alternatives --remove $i $j
  done
done

# Adding a new alternative for "java".
update-alternatives --install /usr/bin/java java ${JDKfolderName}/bin/java 1
update-alternatives --install /usr/bin/javac javac ${JDKfolderName}/bin/javac 1
# Setting the new alternative as default for "java".
update-alternatives --set java ${JDKfolderName}/bin/java
update-alternatives --set javac ${JDKfolderName}/bin/javac

