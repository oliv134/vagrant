echo "     ██╗██████╗ ██╗  ██╗"
echo "     ██║██╔══██╗██║ ██╔╝"
echo "     ██║██║  ██║█████╔╝ "
echo "██   ██║██║  ██║██╔═██╗ "
echo "╚█████╔╝██████╔╝██║  ██╗"
echo " ╚════╝ ╚═════╝ ╚═╝  ╚═╝"
echo
echo "Installation..."


echo "Visit: http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html"
echo "and past lastest JDK for Linux x86 or x64 .tar.gz"
echo
echo "JDK URL:"
JDKfileName="http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-arm64-vfp-hflt.tar.gz"
echo ${JDKfileName}
#read -p "Enter the JDK URL: " -e -i ${JDKfileName} JDKfileName
#JDKfileName = ls -f jdk-*
wget  --progress=bar:force --header "Cookie: oraclelicense=accept-securebackup-cookie" ${JDKfileName} -P /tmp/ ~/tmp/
mkdir -p /developpement/jdk/
tar -xvzf ${JDKfileName} /developpement/jdk/
rm /tmp/${JDKfileName}
JDKfolderName = ls D /developpement/jdk/jdk*

# Del alternative for java (à vérifier)
for i in `update-alternatives --get-selections | grep java | awk '{print $1}'`; do update-alternatives --config $i; done

# Adding a new alternative for "java".
sudo update-alternatives --install /usr/bin/java java ${JDKfolderName}/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac ${JDKfolderName}/bin/javac 1
sudo update-alternatives --set javac ${JDKfolderName}/bin/java

# Setting the new alternative as default for "java".
sudo update-alternatives --config java

