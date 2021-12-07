# My personal docker desktop

From an original idea :
https://dhwaneetbhatt.com/blog/run-docker-without-docker-desktop-on-macos

## How to
The initial install is split into 2 file `masOsPrerequisite.sh` and `macOsConfig.sh`

`masOsPrerequisite.sh` is for all prerequisite (virtual box, vagrant and docker). You will probably need to authorize virtual box in your macOS preferences after the installation. 

After installing all dependancies the script will create the vm using vagrant
And in a last step the script will configure your local machine to mao docker, docker-compose to use the virtual machine to handle command

After this first install, you might need to recreate your vm (for any reason). T o do that just run `vagrant destroy` and `vagrant up`

`macOsConfig.sh` will finish the customisation of your local machine by setting the link between docker on your machine and docker engine on the virtual machine.

## Content of vm
The vm use Official Ubuntu 20.04 LTS Focal Fossa, you can change it by editing `FROM_VAGRANT_BOX` param. Boxes for vagrant can be found here [vagrant-boxes](https://app.vagrantup.com/boxes/search)

The initialisation of the vm is done with the `provision/provision.sh` script

After the provisioning you will be able to connect to portainer https://docker.local:9443/ (just create an admin account for your local machine)

## Pimp my VM 
In the `Vagrantfile` you can change value for
 - `CPUS` is the number of cpu for the vm, default value is '2'
 - `MEMORY` is the size of the vm memory, default value is '5120' 
 - `DISK_SIZE` is the size of the vm disk, default value is '50GB'
 - `FROM_VAGRANT_BOX` is the name of the vagrant base box, default value is 'ubuntu/focal64'


## Troubleshooting

### docker-credential-desktop
 `error getting credentials - err: exec: "docker-credential-desktop": executable file not found in $PATH, out: `` ` 
  
This error is linked to previous docker configuration. To correct this error :
  - Edit the file "~/.docker/config.json" and delete the following JSON key/value: "credsStore" : "desktop"
  - Source https://github.com/docker/docker-credential-helpers/issues/149#issuecomment-566832756
### Known issue with `postgre`
The mounting system of virtual box is not perfect. 
By default, when mounting a folder, the synced folder in the vm is link to the user `vagrant:vagrant` uid: 1000, gid: 1000. 

Some images need to be run with a very specific user and check very closely the permission of the file system like `postgres:12.5`. 

Because the filesystem is link to vagrant this image will not start. 

A workaround (and a good practice) is to use internal volumes instead of exposing them :
```
version: '2'
services:
  db:
     image: postgres:12.5
     volumes:
        - pgdata:/var/lib/postgresql/data
volumes:
  pgdata:   
```
  
