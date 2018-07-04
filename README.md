# habitat tools
This is a repo of small tools for working with habitat environments. Mostly the are blunt instruments for digging around in the supervisor http pages.

## hab_deps.rb
Print out the package dependencies for all habitat packages currently loaded in the supervisor.

**Usage:** run on the command line. Default host is *localhost*. To query a remote host, pass the IP address of the remote host. Queries 9631.

*Requires* the **curb** ruby gem. More on curb: [https://github.com/taf2/curb](https://github.com/taf2/curb)

## hab_deps_search.rb
Search the dependencies of all habitat packages loaded in the supervisor for a specific package. 

**Usage** 
Usage: hab_deps_search [options]
    -h, --host HOST                  Hostname or IP to test
    -d, --dep DEPENDENCY             Dependency to check for
        --help                       Displays help


`./hab_deps_search.rb core/zlib/1.2.8/20170513201911`

*Requires* the **curb** ruby gem. 
