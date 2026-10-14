## Unreleased

BACKWARDS INCOMPATIBILITIES / NOTES:

* The `auto_minor_version_upgrade` variable has been renamed to 
  `enable_automatic_minor_version_upgrade`.
* The default value of `max_allocated_storage` has changed from `0` to `null`.
* The `private_subnet_ids` variable has been renamed to `subnet_ids` since it
  is now possible to deploy into public subnets and expose the database 
  publicly.
* The `private_network_cidr` variable has been renamed to `allowed_cidrs` to
  better reflect its purpose, and now accepts a list of CIDRs rather than a
  single CIDR.
* All variables previously using `"yes|no"` have been replaced with
  `true|false`.
* The default instance type has been changed from `db.t2.micro` to
  `db.t4g.micro`.
* The `database_master_user` variable has been renamed to
  `database_master_user_username` for parity with the equivalent password 
  variable.

ENHANCEMENTS:

* This module is now compatible with version 4 of the AWS provider.
* A `database_port` variable has been added allowing the listen port of the
  RDS database instance and the open port of the security group to be changed.
* A `storage_iops` variable has been added allowing the database storage IOPS
  to be configured.
* An `allow_public_access` variable has been added allowing the database
  instance to be exposed to the public Internet if required. Access is
  controlled via the `allowed_cidrs` variable and the security group so
  set this variable to `["0.0.0.0/0"]` if you want to allow full public access.
* Two new variables, `database_master_user_password_wo` and 
  `database_master_user_password_wo_version`, have been added to allow the use
  of ephemeral values for the master user password.
* This module now uses the nullable feature to simplify variable defaults.
* An `additional_security_group_ids` variable has been added, allowing callers
  to attach extra security groups to the RDS instance alongside the module's
  own SG. This is the recommended way to add ingress rules without mixing
  the module's inline `ingress` block with side-effect
  `aws_vpc_security_group_ingress_rule` resources on the same SG (which the
  AWS provider documentation warns against).
* A `deletion_protection` variable has been added, allowing the DB instance to
  be protected against accidental deletion. Defaults to `false` to preserve
  existing behaviour.
* `monitoring_interval` and `monitoring_role_arn` variables have been added,
  allowing Enhanced Monitoring to be configured on the DB instance. The
  monitoring IAM role is not created by the module; supply an ARN you manage.
  Defaults preserve existing behaviour (Enhanced Monitoring disabled).
* An `apply_immediately` variable has been added, controlling whether
  modifications are applied immediately or deferred to the next maintenance
  window. Defaults to `false` to preserve existing behaviour.
* An `enable_iam_database_authentication` variable has been added, allowing
  IAM database authentication to be enabled on the DB instance so database
  users granted `rds_iam` can sign in with IAM tokens. Defaults to `false` to
  preserve existing behaviour.

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
