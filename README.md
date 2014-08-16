manage-users Cookbook
=====================
This simple cookbook manage linux users, configures authorized_keys and grant sudo permission.

TODO:
  - Split default recipes.
  - Test more! 

Requirements
------------
TODO: 
   - To use this cookbook you must create a data bag 'managed_users', with data bag itens like the example below:
{
  "id": "rodrigo",
  "ssh_keys": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABA...",
  "shell": "\/bin\/bash",
  "comment": "Rodrigo",
  "home":"/home/rodrigo",
  "sudo":"enable",
  "status":"disable"
}   

e.g.

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

License and Authors
-------------------
Authors: Rodrigo