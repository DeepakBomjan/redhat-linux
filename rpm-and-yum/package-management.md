# Linux package management with YUM and RPM

![image](../images/yum_rpm.jpeg)
Yellow Dog Updater, Modified (YUM)
> Note: DNF or Dandified YUM is the updated default since Red Hat Enterprise Linux 8, CentOS 8, Fedora 22, and any distros based on these. Generally, the options are the same. Read more about DNF here.

The main configuration file for YUM is at `/etc/yum.conf`, and all the repos are at `/etc/yum.repos.d`.

 Some commonly-used commands for `YUM` below:

| Command   | Purpose                                       |
|-----------|-----------------------------------------------|
| yum install | Installs the specified packages              |
| remove    | Removes the specified packages                |
| search    | Searches package metadata for keywords        |
| info      | Lists description                             |
| update    | Updates each package to the latest version   |
| repolist  | Lists repositories                            |
| history   | Displays what has happened in past transactions |

The following are commonly-used options with `YUM`:

| Options       | Purpose                                           |
|---------------|---------------------------------------------------|
| -C            | Runs from system cache                            |
| --security    | Includes packages that provide a fix for a security issue |
| -y            | Answers yes to all questions                      |
| --skip-broken | Skips packages causing problems                   |
| -v            | Verbose                                           |


## RPM (RPM Package Manager)
An `RPM` package consists of an archive of files and metadata. Metadata includes helper scripts, file attributes, and information about packages.

`RPM` maintains a database of installed packages, which enables powerful and fast queries. The `RPM` database is inside `/var/lib`, and the file is named `__db*`.


Some commonly-used modes are listed below:
| Mode  | Description          |
|-------|----------------------|
| -i    | Installs a package   |
| -U    | Upgrades a package   |
| -e    | Erases a package     |
| -V    | Verifies a package   |
| -q    | Queries a package    |

## Managing software with the DNF tool

In Red Hat Enterprise Linux (RHEL) 9, use the **DNF** utility to manage software. For compatibility reasons with previous major RHEL versions, you can still use the `yum` command. However, in RHEL 9, `yum` is an alias for `dnf` which provides a certain level of compatibility with `yum`.



### Repositories
Red Hat Enterprise Linux (RHEL) distributes content through different repositories

**BaseOS**  
Content in the BaseOS repository consists of the core set of the underlying operating system functionality that provides the foundation for all installations.  
 **AppStream**  
 Content in the AppStream repository includes additional user-space applications, runtime languages, and databases in support of the varied workloads and use cases.
> Both the BaseOS and AppStream content sets are required by RHEL and are available in all RHEL subscriptions.




## References: 
1. [Create yum local repo](https://rpmdeb.com/devops-articles/how-to-create-local-yum-repository/)
2. [Understanding RHEL 9 Packages, Repositories, and AppStreams](https://www.answertopia.com/rhel/understanding-rhel-packages-repositories-and-appstreams/)

