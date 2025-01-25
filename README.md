# OpenStack Lab

Deploy a [OpenStack](https://www.openstack.org/) Lab in a single node with [DevStack](https://docs.openstack.org/devstack/latest/) with [Terrafrom](https://terraform.io) and [Ansible](https://ansible.com)

## Deploy the local VM using terraform and libvirt as provider
This will use your default ssh key to acces to the nodes

```
~/.ssh/id_rsa.pub
```

If you want use a different key update
[terraform/user_data.cfg](terraform/user_data.cfg)

```
git clone git@github.com:wverac/openstack_lab.git
cd openstack_lab/terraform
terraform init  
terraform apply -auto-approve   
virsh list --all
```
```
 Id   Name            State
-------------------------------
 1    openstack-lab   running
```
## Deploy devstack
```
cd openstack_lab/ansible
```
Export your Horizon password

```
export ADMIN_PASSWORD="YOUR_ADMIN_PASSWORD_HERE"
```
Deploy devstack
```
ansible-playbook devstack.yml
```
ssh to the OpenStack node
```
ssh cloud@192.168.122.10
```


You can also access to the dashboard trough 
```
https://localhost
```
Devstack use `stack` user, become the user, source the env file and test it

```
cloud@ubuntu:~$ sudo su stack -
stack@ubuntu:/home/cloud$ cd ~
stack@ubuntu:~$ cd devstack/
stack@ubuntu:~/devstack$ source openrc
stack@ubuntu:~/devstack$ openstack --version
openstack 7.2.1
stack@ubuntu:~/devstack$ openstack network list
+--------------------------------------+---------+--------------------------------------------------------------------------+
| ID                                   | Name    | Subnets                                                                  |
+--------------------------------------+---------+--------------------------------------------------------------------------+
| 3212330b-d646-4365-a051-8ed9d2227ff0 | public  | 64c056f6-7e8d-4a1f-955f-000904dcb0aa,                                    |
|                                      |         | 83c96f8f-6a9f-46d3-a402-b553ab56f820                                     |
| 6b3cfd2f-02e0-4260-aa6c-4b0ee9cae384 | shared  | 21412677-4b24-4e32-8141-0915cf9274cc                                     |
| db53077f-bdf4-4aca-b2e6-f75e5c6d6e62 | private | b44c9792-42e1-48c2-95dd-b3e305ec1086,                                    |
|                                      |         | ffb36f29-a66c-44a0-8a10-ea81fa8c65cb                                     |
+--------------------------------------+---------+--------------------------------------------------------------------------+
stack@ubuntu:~/devstack$
```
You can also access to the dashboard trough 
```
https://localhost:80
```
![OpenStack_Dashboard](https://github.com/wverac/openstack_lab/blob/main/assets/openstack_demo.png)

w00t!
