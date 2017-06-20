Terraform AWS RDS
=========================

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
  source = "github.com/b-social/terraform-aws-rds.git//src"

  component = "${var.component}"
  deployment_identifier = "${var.deployment_identifier}"

  region = "${var.region}"
  vpc_id = "${coalesce(var.vpc_id,data.terraform_remote_state.network.vpc_id)}"

  private_subnet_ids = "${coalesce(var.private_subnet_ids, data.terraform_remote_state.network.private_subnet_ids)}"

  database_instance_class = "${var.database_instance_class}"

  database_name = "${var.database_name}"
  state_network_key = "${var.state_network_key}"
  database_master_user_password = "${var.database_master_user_password}"
  state_bucket = "${var.state_bucket}"
  database_master_user = "${var.database_master_user}"
}
```

By default, the module will use the provided region

As mentioned above, the RDS deploys into an existing base network
* [AWS Base Networking](https://github.com/tobyclemson/terraform-aws-base-networking)


### Inputs

| Name                                       | Description                                                         | Default            | Required |
|--------------------------------------------|---------------------------------------------------------------------|:------------------:|:--------:|
| region                                     | The region into which to deploy the service                         | -                  | yes      |
| vpc_id                                     | The ID of the VPC into which to deploy the service                  | -                  | yes      |
| component                                  | The component this service will contain                             | -                  | yes      |
| deployment_identifier                      | An identifier for this instantiation                                | -                  | yes      |
| private_subnet_ids                         | The IDs of the private subnets                               | -                  | yes      |
| database_instance_class                    | The instance type of the RDS instance.                      | -                  | yes
| database_name                              | The DB name to create. If omitted, no database is created initially.                       | -                  | yes      |
| database_master_user_password              | Password for the master DB user.                        | -                  | yes      |
| database_master_user |  Username for the master DB user. | see src/policies   | no       |


### Outputs

| Name                      | Description                                                          |
|---------------------------|----------------------------------------------------------------------|
| postgres_database_port    | The ARN of the created ECS task definition                           |
| postgres_database_host    | 


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

To provision the module test contents:

```bash
./go provision:aws[<deployment_identifier>]
```

To destroy the module test contents:

```bash
./go destroy:aws[<deployment_identifier>]
```

### Common Tasks

To generate an SSH key pair:

```
ssh-keygen -t rsa -b 4096 -C integration-test@example.com -N '' -f config/secrets/keys/bastion/ssh
```

To generate a self signed certificate:
```
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365
```

To decrypt the resulting key:

```
openssl rsa -in key.pem -out ssl.key
```

Contributing
------------

Bug reports and pull requests are welcome on GitHub at https://github.com/tobyclemson/terraform-aws-ecs-cluster. 
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to 
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


License
-------

The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
