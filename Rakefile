require 'rspec/core/rake_task'
require 'securerandom'
require 'git'
require 'semantic'

require_relative 'lib/public_ip'
require_relative 'lib/terraform'

DEPLOYMENT_IDENTIFIER = SecureRandom.hex[0, 8]

Terraform::Tasks.install('0.8.6')

task :default => 'test:integration'

namespace :test do
  RSpec::Core::RakeTask.new(:integration => ['terraform:ensure']) do
    ENV['AWS_REGION'] = 'eu-west-2'
  end
end

namespace :provision do
  desc 'Provisions module in AWS'
  task :aws, [:deployment_identifier] => ['terraform:ensure'] do |_, args|
    deployment_identifier = args.deployment_identifier || DEPLOYMENT_IDENTIFIER
    configuration_directory = Paths.from_project_root_directory('spec', 'infra')

    puts "Provisioning with deployment identifier: #{deployment_identifier}"

    Terraform.clean
    Terraform.get(directory: configuration_directory)
    Terraform.apply(
        directory: configuration_directory,
        vars: terraform_vars_for(
            deployment_identifier: deployment_identifier))
  end
end

namespace :destroy do
  desc 'Destroys module in AWS'
  task :aws, [:deployment_identifier] => ['terraform:ensure'] do |_, args|
    deployment_identifier = args.deployment_identifier || DEPLOYMENT_IDENTIFIER
    configuration_directory = Paths.from_project_root_directory('spec', 'infra')

    puts "Destroying with deployment identifier: #{deployment_identifier}"

    Terraform.clean
    Terraform.get(directory: configuration_directory)
    Terraform.destroy(
        directory: configuration_directory,
        force: true,
        vars: terraform_vars_for(
            deployment_identifier: deployment_identifier))
  end
end

namespace :release do
  desc 'Increment and push tag'
  task :tag do
    repo = Git.open('.')
    tags = repo.tags
    latest_tag = tags.map { |tag| Semantic::Version.new(tag.name) }.max
    next_tag = latest_tag.increment!(:patch)
    repo.add_tag(next_tag.to_s)
    repo.push('origin', 'master', tags: true)
  end
end

def terraform_vars_for(opts)
  {
      vpc_cidr: '10.1.0.0/16',
      region: 'eu-west-2',
      availability_zones: 'eu-west-2a,eu-west-2b',
      private_network_cidr: '10.0.0.0/8',

      component: 'test',
      deployment_identifier: opts[:deployment_identifier],

      bastion_ami: 'ami-bb373ddf',
      bastion_ssh_public_key_path: 'config/secrets/keys/bastion/ssh.public',
      bastion_ssh_allow_cidrs: PublicIP.as_cidr,

      domain_name: 'greasedscone.uk',
      public_zone_id: 'Z2WA5EVJBZSQ3V',
      private_zone_id: 'Z2BVA9QD5NHSW6',

      database_instance_class: 'db.t.micro',

      database_name: 'testservicedb',
      database_master_user: 'testservice',
      database_master_user_password: 'testpassword',
      state_network_key: 'Z2CDAFD23Q10HO',
      state_bucket: 'testbucket',

      infrastructure_events_bucket: 'tobyclemson-open-source',
      snapshot_identifier: 'test-snapshot-identifier'
  }
end