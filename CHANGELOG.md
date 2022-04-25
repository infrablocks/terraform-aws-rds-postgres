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
