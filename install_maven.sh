#!/bin/bash





# This is currently the latest version of Maven.  If it's no longer available, you can find a new
# version here: https://maven.apache.org/download.cgi 
DEFAULTMVNVERSION=3.3.9

if [[ -n $1 ]] ; then
    SSS=3.3.4
    MATCHLEN=`expr match "$1" '3[.][1-9][0-9]*[.][1-9][0-9]*'`
    HAYSTACKLEN=`expr length $1`
    #echo lengths are $MATCHLEN  $HAYSTACKLEN
    if [ "$MATCHLEN" = "$HAYSTACKLEN" ] ; then
        MVNVERSION=$1
    else
        echo " Error: the parameter must be a version number of the form n.n.n. For example:"
        echo "    3.43.2  "
        echo " Please try again with a version number of the right format or pass no parameter"
        echo " at all to install version $MVNVERSION."
        echo ""
        exit 15
    fi
else
    MVNVERSION=$DEFAULTMVNVERSION
fi

DIRNAME2=apache-maven-${MVNVERSION}
FN2=apache-maven-${MVNVERSION}-bin.tar.gz

if [ -d $DIRNAME2 ] ; then
    echo " Error:  $DIRNAME2/ already exists.  If you don't want to use it, please remove it and "
    echo " invoke this script again"
    echo " "
    exit 16
else


FN=`ls $FN2 2>/dev/null`
#FN=`ls p*ml 2>/dev/null`
if [ "$?" = "0" ] ; then
    # no problem, file was found
    echo " The file $FN was found in the current directory."
else
    echo " $FN2 was not found in the current directory."
    echo " This script will now attempt to download it"
    echo Hit any key to proceed
    read -n 1 -s
    echo " "

    URL2=http://www.trieuvan.com/apache/maven/maven-3/${MVNVERSION}/binaries/${FN2}
    WGETPATH=`which wget`
    if [ "$?" = "0" ] ; then
        # wget is installed
        wget $URL2 2>/dev/null
        if [ "$?" = "0" ] ; then
            echo " Successful download of $FN2"
        else
            echo " The download of "
            echo "   $URL2"
            echo " failed.  Please download it yourself from https://maven.apache.org/download.cgi"
            echo " and try this script again.  If you find that version $MVNVERSION simply is no longer "
            echo " available, please specify a different version on the command line"
            echo ""
            exit 3
        fi
    else
        CURLPATH=`which curl`
        if [ "$?" = "0" ] ; then
            # curl is installed
            curl -O $URL2
            if [ "$?" = "0" ] ; then
                echo " Successful download of $FN2"
            else
                echo " The download of "
                echo "   $URL2"
                echo " failed.  Please download it yourself from https://maven.apache.org/download.cgi"
                echo " and try this script again."
                echo ""
                exit 2
            fi
        else
            echo " curl and wget are not found.  Please install them or download Maven "
            echo " from from https://maven.apache.org/download.cgi"
            echo ""
            exit 1
        fi
    fi
fi
echo " Next this script will unpack the tar.gz file in this directory"
echo " This will probably will produce a subdirectory called $DIRNAME2"
echo Hit any key to proceed
read -n 1 -s
echo " "
tar -xzf $FN2
fi
JAVAV=`java -version 2>&1 | grep "1[.]8[.]" | head -n 1`
if [ "$?" = "0" ] ; then
    echo " java version found:  $JAVAV"
else
    echo " You do not have java 1.8 installed in your path.  We recoommend that you fix this and"
    echo " invoke this command again."
    echo ""
    exit 8
fi
JAVACV=`javac -version 2>&1 | grep "1[.]8[.]"`
if [ "$?" = "0" ] ; then
    echo " javac version found: $JAVACV"
else
    echo " You do not have javac 1.8 installed in your path.  We recoommend that you fix this and"
    echo " invoke this command again."
    echo ""
    exit 8
fi
echo " "
if [ "${JAVA_HOME}F" = "F" ] ; then
    # JAVA_HOME is not set
    JAVACPATH=`which javac`
    
    JPP=$(readlink -f ${JAVACPATH} | sed "s:bin/javac::")
    #    echo $? for readlink sed
    if [ "$?" = "0" ] ; then
        echo " You need to set JAVA_HOME.  The following command probably should work:"
        echo "    export JAVA_HOME=${JPP}"
    else
        echo " You need to set JAVA_HOME.  You will need to determine the directory that contains the"
        echo " java that you are using.  You should start your search at $JAVAPATH"
    fi
    echo " Note: You do not need to set this in your .bashrc or .bash_profile file because"
    echo " this script will provide you with a source file that you can use instead,"
    echo " which should allow you to maintain more than one instance of maven."
    echo " "
    echo " Once you you have done this, invoke this script again."
    echo ""
    exit 9
else
    if [ -f ${JAVA_HOME}/bin/javac ] ; then
        JAVACV2=`${JAVA_HOME}/bin/javac -version 2>&1 | grep "1[.]8[.]"`
        if [ "$?" = "0" ] ; then
            if [ "${JAVACV}" = "$JAVACV2" ] ; then
                echo " "
            else
                echo " The javac in the JAVA_HOME bin directory does not seem to be the one in that path"
                echo " Please correct this and invoke this script again"
                echo ""
                exit 13
            fi
        else
            echo " The javac in the JAVA_HOME bin directory does not seem executable. Please"
            echo " investigate and invoke this script again."
            echo ""
            exit 11
        fi
    else
        echo " You do have JAVA_HOME  set, but it does not seem to be pointing at a valid JDK."
        echo " Please correct this and invoke this script again."
        echo ""
        exit 10
    fi
fi
FNTEMPLATE=setenv.maven.template.source
PWD=`pwd`

MVNPATH=${PWD}/${DIRNAME2}/
echo export JAVA_HOME=${JAVA_HOME} >$FNTEMPLATE
echo export PATH=${JAVA_HOME}/bin:\${PATH} >>$FNTEMPLATE
echo export PATH=${MVNPATH}/bin:\${PATH} >>$FNTEMPLATE
echo " You will want to set your PATH to point to Maven.  You can find a sample"
echo " source script here:  $FNTEMPLATE "
echo " You should copy it and edit it as appropriate.  You can invoke it via:"
echo "     source setenv.maven.source"
echo " if you have named it  setenv.maven.source . "
echo " "
echo " done"



