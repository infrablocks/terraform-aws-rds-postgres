require 'bundler/setup'

require 'awspec'
require 'securerandom'

require 'support/shared_contexts/terraform'

require_relative '../lib/terraform'
require_relative '../lib/public_ip'

RSpec.configure do |config|
  deployment_identifier = ENV['DEPLOYMENT_IDENTIFIER']

  config.example_status_persistence_file_path = '.rspec_status'
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.add_setting :vpc_cidr, default: "10.1.0.0/16"
  config.add_setting :region, default: 'eu-west-2'
  config.add_setting :availability_zones, default: 'eu-west-2a,eu-west-2b'
  config.add_setting :private_network_cidr, default: '10.0.0.0/8'

  config.add_setting :component, default: 'test'
  config.add_setting :deployment_identifier,
      default: deployment_identifier || SecureRandom.hex[0, 8]

  config.add_setting :bastion_ami, default: 'ami-bb373ddf'
  config.add_setting :bastion_ssh_public_key_path, default: 'config/secrets/keys/bastion/ssh.public'
  config.add_setting :bastion_ssh_allow_cidrs, default: PublicIP.as_cidr

  config.add_setting :domain_name, default: 'greasedscone.uk'
  config.add_setting :public_zone_id, default: 'Z4Q2X3ESOZT4N'
  config.add_setting :private_zone_id, default: 'Z2CDAFD23Q10HO'

  config.add_setting :database_instance_class, default: 'db.t2.micro'

  config.add_setting :database_name, default: 'testservicedb'
  config.add_setting :database_master_user, default: 'testservice'
  config.add_setting :database_master_user_password, default: 'testpassword'

  config.add_setting :infrastructure_events_bucket, default: 'tobyclemson-open-source'

  config.before(:suite) do
    variables = RSpec.configuration
    configuration_directory = Paths.from_project_root_directory('spec/infra')

    puts
    puts "Provisioning with deployment identifier: #{variables.deployment_identifier}"
    puts

    Terraform.clean
    Terraform.get(directory: configuration_directory)
    Terraform.apply(
        directory: configuration_directory,
        vars: {
            vpc_cidr: variables.vpc_cidr,
            region: variables.region,
            availability_zones: variables.availability_zones,
            private_network_cidr: variables.private_network_cidr,

            component: variables.component,
            deployment_identifier: variables.deployment_identifier,

            bastion_ami: variables.bastion_ami,
            bastion_ssh_public_key_path: variables.bastion_ssh_public_key_path,
            bastion_ssh_allow_cidrs: variables.bastion_ssh_allow_cidrs,

            domain_name: variables.domain_name,
            public_zone_id: variables.public_zone_id,
            private_zone_id: variables.private_zone_id,

            database_instance_class: variables.database_instance_class,
            database_name: variables.database_name,
            database_master_user: variables.database_master_user,
            database_master_user_password: variables.database_master_user_password,

            infrastructure_events_bucket: variables.infrastructure_events_bucket
        })
  end

  config.after(:suite) do
    unless deployment_identifier
      variables = RSpec.configuration
      configuration_directory = Paths.from_project_root_directory('spec/infra')

      puts
      puts "Destroying with deployment identifier: #{variables.deployment_identifier}"
      puts

      Terraform.clean
      Terraform.get(directory: configuration_directory)
      Terraform.destroy(
          directory: configuration_directory,
          force: true,
          vars: {
              vpc_cidr: variables.vpc_cidr,
              region: variables.region,
              availability_zones: variables.availability_zones,
              private_network_cidr: variables.private_network_cidr,

              component: variables.component,
              deployment_identifier: variables.deployment_identifier,

              bastion_ami: variables.bastion_ami,
              bastion_ssh_public_key_path: variables.bastion_ssh_public_key_path,
              bastion_ssh_allow_cidrs: variables.bastion_ssh_allow_cidrs,

              domain_name: variables.domain_name,
              public_zone_id: variables.public_zone_id,
              private_zone_id: variables.private_zone_id,

              database_instance_class: variables.database_instance_class,
              database_name: variables.database_name,
              database_master_user: variables.database_master_user,
              database_master_user_password: variables.database_master_user_password,

              infrastructure_events_bucket: variables.infrastructure_events_bucket,
          })

      puts
    end
  end
end
