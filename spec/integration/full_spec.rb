# frozen_string_literal: true

require 'spec_helper'

describe 'full' do
  let(:component) do
    var(role: :full, name: 'component')
  end
  let(:deployment_identifier) do
    var(role: :full, name: 'deployment_identifier')
  end

  let(:vpc_id) do
    output(role: :full, name: 'vpc_id')
  end

  let(:database_name) do
    var(role: :full, name: 'database_name')
  end

  let(:mysql_database_port) do
    output(role: :full, name: 'mysql_database_port')
  end
  let(:mysql_database_host) do
    output(role: :full, name: 'mysql_database_host')
  end

  before(:context) do
    apply(role: :full)
  end

  after(:context) do
    destroy(
      role: :full,
      only_if: -> { !ENV['FORCE_DESTROY'].nil? || ENV['SEED'].nil? }
    )
  end

  describe 'rds' do
    subject(:database) do
      rds("db-instance-#{component}-#{deployment_identifier}")
    end

    it { is_expected.to(exist) }

    it 'has a security group' do
      security_group_name =
        "database-security-group-#{component}-#{deployment_identifier}"
      expect(database)
        .to(have_security_group(security_group_name))
    end

    it 'has a name tag' do
      value = "db-instance-#{component}-#{deployment_identifier}"
      expect(database)
        .to(have_tag('Name').value(value))
    end

    it 'has a component tag' do
      expect(database)
        .to(have_tag('Component').value(component))
    end

    it 'has a deployment identifier tag' do
      expect(database)
        .to(have_tag('DeploymentIdentifier').value(deployment_identifier))
    end

    it { is_expected.to(belong_to_vpc(vpc_id)) }

    its('db_name') { is_expected.to(eq(database_name)) }
    its('engine_version') { is_expected.to(eq('14.3')) }

    its('endpoint.address') do
      is_expected.to(eq(mysql_database_host))
    end

    its('endpoint.port') do
      is_expected.to(eq(mysql_database_port.to_i))
    end

    its('backup_retention_period') { is_expected.to(eq(7)) }
    its('preferred_backup_window') { is_expected.to(eq('01:00-03:00')) }

    its('preferred_maintenance_window') do
      is_expected.to(eq('mon:03:01-mon:05:00'))
    end

    its('storage_type') { is_expected.to(eq('standard')) }
    its('performance_insights_enabled') { is_expected.to(be(true)) }

    its('max_allocated_storage') { is_expected.to(be_nil) }
  end

  describe 'security_group' do
    subject do
      security_group(
        "database-security-group-#{component}-#{deployment_identifier}"
      )
    end

    its(:inbound) do
      is_expected
        .to(be_opened(22)
              .protocol('tcp')
              .for(
                "database-security-group-#{component}-#{deployment_identifier}"
              ))
    end
  end
end
