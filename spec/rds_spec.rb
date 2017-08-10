require 'spec_helper'

describe 'RDS' do
  include_context :terraform

  let(:component) { RSpec.configuration.component }
  let(:deployment_identifier) { RSpec.configuration.deployment_identifier }

  let(:database_name) { RSpec.configuration.database_name }

  let(:vpc_id) { Terraform.output(name: 'vpc_id') }
  let(:postgres_database_port) { Terraform.output(name: 'postgres_database_port') }
  let(:postgres_database_host) { Terraform.output(name: 'postgres_database_host') }

  context 'rds' do
    subject {
      rds("db-instance-#{component}-#{deployment_identifier}")
    }

    it { should exist }

    it { should have_security_group("database-security-group-#{component}-#{deployment_identifier}") }

    it { should have_tag('Name').value("db-instance-#{component}-#{deployment_identifier}") }
    it { should have_tag('Component').value(component) }
    it { should have_tag('DeploymentIdentifier').value(deployment_identifier) }

    it { should belong_to_vpc(vpc_id) }

    its('db_name') { should eq database_name }


    its('endpoint.address') { should eq postgres_database_host }
    its('endpoint.port') { should eq postgres_database_port.to_i }

    its('backup_retention_period') { should eq 14 }

  end

end
