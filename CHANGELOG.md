## Unreleased

BACKWARDS INCOMPATIBILITIES / NOTES:

* The `auto_minor_version_upgrade` variable has been renamed to 
  `enable_automatic_minor_version_upgrade`.
* The default value of `max_allocated_storage` has changed from `0` to `null`.  

ENHANCEMENTS:

* This module is now compatible with version 4 of the AWS provider.
* A `database_port` variable has been added allowing the listen port of the
  RDS database instance and the open port of the security group to be changed.
* A `storage_iops` variable has been added allowing the database storage IOPS
  to be configured.
* An `allow_public_access` variable has been added allowing the database
  instance to be exposed to the public Internet if required. Access is still
  controlled via the `private_network_cidr` variable and the security group so
  set this variable to `"0.0.0.0/0"` if you want to allow full public access.

## 2.3.0 (August 22nd, 2023)
* The creation of the database final snapshot can be enabled via the `skip_final_snapshot` var.
  The final snapshot will have the same name of the RDS database instance.
* The parameter group for the database can now be specified via the `parameter_group_name` var.

## 2.2.0 (April 25th, 2022)
* Performance insights can be enabled by setting `performance_insights_enabled` to `"yes"`.

## 2.1.0 (June 6th, 2021)

IMPROVEMENTS:

* The storage type for the database can now be specified via the `storage_type`
  var as one of `"standard"` or `"gp2"`.
* Automatic minor version upgrades can now be disabled by passing `"no"` for
  the `auto_minor_version_upgrade` var.

## 2.0.0 (May 28th, 2021)

BACKWARDS INCOMPATIBILITIES / NOTES:

* This module is now compatible with Terraform 0.14 and higher.
