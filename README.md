manage-users Cookbook
=====================
This simple cookbook manage linux users, configures authorized_keys and grant sudo permission.

Requirements
------------

   - To use this cookbook you must create a data bag 'managed_users', with data bag itens like the example below:

```json 
{
  "id": "rodrigo",
  "ssh_keys": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABA...",
  "shell": "\/bin\/bash",
  "comment": "Rodrigo",
  "home":"/home/rodrigo",
  "sudo":"enable",
  "status":"disable"
}   
```

Usage
-----
#### manage-users::default

e.g.
Just include `manage-users` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[manage-users]"
  ]
}
```

TODO
-----
  - Test more! 

License and Authors
-------------------
Authors: Rodrigo
