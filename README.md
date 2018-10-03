# habitat tools
This is a repo of small tools for working with habitat environments. Mostly the are blunt instruments for digging around in the supervisor http pages.

## hab_deps.rb
Print out the package dependencies for all habitat packages currently loaded in the supervisor.

**Usage:** run on the command line. Default host is *localhost*. To query a remote host, pass the IP address of the remote host. Queries 9631.

*Requires* the **curb** ruby gem. More on curb: [https://github.com/taf2/curb](https://github.com/taf2/curb)

```
$ ./hab_deps.rb 
lnxchk/container_sched_backend/0.1.3/20181003183354
|-  core/binutils/2.30/20180608050633
|-  core/gcc-libs/7.3.0/20180608091701
|-  core/gcc/7.3.0/20180608051919
|-  core/glibc/2.27/20180608041157
|-  core/gmp/6.1.2/20180608051426
|-  core/libmpc/1.1.0/20180608051824
|-  core/linux-headers/4.15.9/20180608041107
|-  core/mpfr/4.0.1/20180608051629
|-  core/zlib/1.2.11/20180608050617
```

## hab_deps_search.rb
Search the dependencies of all habitat packages loaded in the supervisor for a specific package. 

**Usage** 
```
Usage: hab_deps_search [options]
    -h, --host HOST                  Hostname or IP to test
    -d, --dep DEPENDENCY             Dependency to check for
        --help                       Displays help

```

**Example**
```
$ ./hab_deps_search.rb -d core/zlib/1.2.8/20170513201911
chef-demo/np-mongodb/3.2.9/20180517215632 matches
```

*Requires* the **curb** ruby gem. 

## partners.rb
Find the supervisor's partner hosts

**Usage**
```
./partners.rb
```

Optionally add an IP address to query a remote host


**Example**
```
$ ./partners.rb 
My partners are:
172.31.47.61
172.31.45.179
172.31.37.155
```
