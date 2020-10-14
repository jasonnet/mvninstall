# mvninstall
A little help installing Maven quickly

## Details

This project provides a script to install Maven in seconds rather than a couple minutes. It also assists in confirming
that you are using Java 8 and in setting your environment variables appropraitely.

## Usage
### One Liner Method

If you are willing to run this exactly as written, you can download and invoke it with a single command:

```
 bash <(curl -s https://raw.githubusercontent.com/jasonnet/mvninstall/master/install_maven.sh )
```

Or if you have wget instead of curl, you can invoke:

```
 bash <(wget -q https://raw.githubusercontent.com/jasonnet/mvninstall/master/install_maven.sh -O - )
```
It is often considered insecure to invoke a remote script like this without first looking at it. If you are concerned,
please use the "Custom Execution" method below

### Custom Execution Method

By default this script tries to install a particular version of Maven.  (At the time of this writing that default is version 3.3.9, but
by the time you read this, you might find that the default version has changed.)
If you need to install another version, you can download the install_maven.sh script and invoke it from the
command line with an argument specifying the version. For example:

```
wget https://raw.githubusercontent.com/jasonnet/mvninstall/master/install_maven.sh
chmod install_maven.sh
./install_maven.sh 3.4.0
```

## Compatibility

This script uses bash.  

It requires that wget or curl be installed and in the path. If it finds they are not installed, it asks you to download 
the Maven tar.gz files manually.

It has been tested on CentOS and should also work on Ubuntu and Mac/OS as well.

You do not need to update your .bashrc or .bash_profile.  This script will provide you with a sample source file
that sets environment variables appropriately.

## Support

We will make a reasonable effort to update this package as necessary.  If you find a bug or have a suggestion, please file
an Issue at (https://github.com/jasonnet/mvninstall/issues).

## License

The code at (https://github.com/jasonnet/mvninstall) is an original work of the contributors there.  It has not been copied from
other projects.

It is our intent to let one use or modify this script however one likes.  You do not need to credit us.  See the LICENSE.txt file
for details.

