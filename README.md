Terraform AWS RDS Postgres
==========================

[![CircleCI](https://circleci.com/gh/infrablocks/terraform-aws-rds-postgres.svg?style=svg)](https://circleci.com/gh/infrablocks/terraform-aws-rds)

A Terraform module for deploying an RDS in AWS.

The AWS RDS requires:
* An existing VPC 
 
The RDS consists of:
* security groups
* subnet groups

Usage
-----

To use the module, include something like the following in your terraform
configuration:

```hcl-terraform
module "database" {
  source = "infrablocks/rds-postgres/aws"
  version = "0.1.8"

  region = "eu-west-2"
  vpc_id = "vpc-b197da6b"
  private_subnet_ids = "subnet-7cd8832a,subnet-0199db7c"
  private_network_cidr = "10.0.0.0/16"

  component = "identity-server"
  deployment_identifier = "2f3eddcb"

  database_instance_class = "db.t2.medium"
  database_version = "9.6.8"

  database_name = "identity"
  database_master_user = "admin"
  database_master_password = "1D$£#J!LKeE£(9d9"
}
```

As mentioned above, the database deploys into an existing base network:
* [AWS Base Networking](https://github.com/tobyclemson/terraform-aws-base-networking)


### Inputs

| Name                            | Description                                                                 | Default               | Required |
|---------------------------------|-----------------------------------------------------------------------------|:---------------------:|:--------:|
| region                          | The region into which to deploy the database                                | -                     | yes      |
| vpc_id                          | The ID of the VPC into which to deploy the database                         | -                     | yes      |
| component                       | The component this database will serve                                      | -                     | yes      |
| deployment_identifier           | An identifier for this instantiation                                        | -                     | yes      |
| private_network_cidr            | The CIDR of the private network allowed access to the ELB                   | -                     | yes      |
| private_subnet_ids              | The IDs of the private subnets to deploy the database into                  | -                     | yes      |
| database_instance_class         | The instance type of the RDS instance.                                      | -                     | yes      |
| database_version                | The database version. If omitted, it lets Amazon decide.                    | -                     | no       |
| database_name                   | The DB name to create. If omitted, no database is created initially.        | -                     | yes      |
| database_master_user_password   | The password for the master database user.                                  | -                     | yes      |
| database_master_user            | The username for the master database user.                                  | -                     | yes      |
| use_multiple_availability_zones | Whether to create a multi-availability zone database ("yes" or "no").       | "no"                  | yes      |
| use_encrypted_storage           | Whether or not to use encrypted storage for the database ("yes" or "no").   | "no"                  | yes      |
| snapshot_identifier             | The identifier of the snapshot to use to create the database.               | -                     | no       |
| backup_retention_period         | The number of days to retain database backups.                              | 7                     | yes      |
| backup_window                   | The time window in which backups should take place.                         | "01:00-03:00"         | yes      |
| maintenance_window              | The time window in which maintenance should take place.                     | "mon:03:01-mon:05:00" | yes      |
| include_self_ingress_rule       | Whether or not to add a self-referencing ingress rule on the security group | "no"                  | no       |
| allow_major_version_upgrade     | Whether or not to allow major version upgrades                              | "no"                  | no       |


### Outputs

| Name                    | Description                    |
|-------------------------|--------------------------------|
| postgres_database_port  | The database port              |
| postgres_database_host  | The database host              |
| postgres_database_name  | The database name              |
| postgres_database_sg_id | The database security group id |


Development
-----------

### Machine Requirements

In order for the build to run correctly, a few tools will need to be installed on your
development machine:

* Ruby (2.3.1)
* Bundler
* git
* git-crypt
* gnupg
* direnv

#### Mac OS X Setup

Installing the required tools is best managed by [homebrew](http://brew.sh).

To install homebrew:

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Then, to install the required tools:

```
# ruby
brew install rbenv
brew install ruby-build
echo 'eval "$(rbenv init - bash)"' >> ~/.bash_profile
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
eval "$(rbenv init -)"
rbenv install 2.3.1
rbenv rehash
rbenv local 2.3.1
gem install bundler

# git, git-crypt, gnupg
brew install git
brew install git-crypt
brew install gnupg

# direnv
brew install direnv
echo "$(direnv hook bash)" >> ~/.bash_profile
echo "$(direnv hook zsh)" >> ~/.zshrc
eval "$(direnv hook $SHELL)"

direnv allow <repository-directory>
```

### Running the build

To provision module infrastructure, run tests and then destroy that infrastructure,
execute:

```bash
./go
```

To provision the module prerequisites:

```bash
./go deployment:prerequisites:provision[<deployment_identifier>]
```

To provision the module contents:

```bash
./go deployment:harness:provision[<deployment_identifier>]
```

To destroy the module contents:

```bash
./go deployment:harness:destroy[<deployment_identifier>]
```

To destroy the module prerequisites:

```bash
./go deployment:prerequisites:destroy[<deployment_identifier>]
```


### Common Tasks

#### Generate an SSH key pair

To generate an SSH key pair:

```
ssh-keygen -t rsa -b 4096 -C integration-test@example.com -N '' -f config/secrets/keys/bastion/ssh
```

#### Generate a self signed certificate 

To generate a self signed certificate:
```
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365
```

To decrypt the resulting key:

```
openssl rsa -in key.pem -out ssl.key
```

#### Add a git-crypt user

To adding a user to git-crypt using their GPG key: 

```
gpg --import ~/path/xxxx.pub
git-crypt add-gpg-user --trusted GPG-USER-ID

```

#### Managing CircleCI keys

To encrypt a GPG key for use by CircleCI:

```bash
openssl aes-256-cbc \
  -e \
  -md sha1 \
  -in ./config/secrets/ci/gpg.private \
  -out ./.circleci/gpg.private.enc \
  -k "<passphrase>"
```

To check decryption is working correctly:

```bash
openssl aes-256-cbc \
  -d \
  -md sha1 \
  -in ./.circleci/gpg.private.enc \
  -k "<passphrase>"
```

Contributing
------------

Bug reports and pull requests are welcome on GitHub at 
https://github.com/infrablocks/terraform-aws-rds-postgres. 
This project is intended to be a safe, welcoming space for collaboration, and 
contributors are expected to adhere to 
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


License
-------

The library is available as open source under the terms of the 
[MIT License](http://opensource.org/licenses/MIT).
