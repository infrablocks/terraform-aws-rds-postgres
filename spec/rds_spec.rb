require 'spec_helper'

describe 'RDS' do
  let(:component) { vars.component }
  let(:deployment_identifier) { vars.deployment_identifier }

  let(:database_name) { vars.database_name }

  let(:vpc_id) { output_for(:prerequisites, 'vpc_id') }
  let(:postgres_database_port) do
    output_for(:harness, 'postgres_database_port')
  end
  let(:postgres_database_host) do
    output_for(:harness, 'postgres_database_host')
  end

  context 'rds' do
    subject {
      rds("db-instance-#{component}-#{deployment_identifier}")
    }

    it { should(exist) }

    it do
      should(have_security_group(
          "database-security-group-#{component}-#{deployment_identifier}"))
    end

    it do
      should(have_tag('Name')
          .value("db-instance-#{component}-#{deployment_identifier}"))
    end
    it { should(have_tag('Component').value(component)) }
    it { should(have_tag('DeploymentIdentifier').value(deployment_identifier)) }

    it { should(belong_to_vpc(vpc_id)) }

    its('db_name') { should(eq(database_name)) }
    its('engine_version') { should(eq("9.5.6")) }

    its('endpoint.address') { should(eq(postgres_database_host)) }
    its('endpoint.port') { should(eq(postgres_database_port.to_i)) }

    its('backup_retention_period') { should(eq(14)) }
    its('preferred_backup_window') { should(eq('01:00-03:00')) }
    its('preferred_maintenance_window') do
      should(eq('mon:03:01-mon:05:00'))
    end
  end

  context 'security_group' do
    subject {
      security_group(
          "database-security-group-#{component}-#{deployment_identifier}")
    }

    its(:inbound) do
      should(be_opened(22)
          .protocol('tcp')
          .for("database-security-group-#{component}-#{deployment_identifier}"))
    end
  end
end
