require 'spec_helper'

describe 'RDS' do
  let(:component) {vars.component}
  let(:deployment_identifier) {vars.deployment_identifier}

  let(:database_name) {vars.database_name}

  let(:vpc_id) {output_for(:prerequisites, 'vpc_id')}
  let(:postgres_database_port) {output_for(:harness, 'postgres_database_port')}
  let(:postgres_database_host) {output_for(:harness, 'postgres_database_host')}

  context 'rds' do
    subject {
      rds("db-instance-#{component}-#{deployment_identifier}")
    }

    it {should exist}

    it {should have_security_group("database-security-group-#{component}-#{deployment_identifier}")}

    it {should have_tag('Name').value("db-instance-#{component}-#{deployment_identifier}")}
    it {should have_tag('Component').value(component)}
    it {should have_tag('DeploymentIdentifier').value(deployment_identifier)}

    it {should belong_to_vpc(vpc_id)}

    its('db_name') {should eq database_name}
    its('engine_version') {should eq "9.5.6"}

    its('endpoint.address') {should eq postgres_database_host}
    its('endpoint.port') {should eq postgres_database_port.to_i}

    its('backup_retention_period') {should eq 14}
    its('preferred_backup_window') {should eq '01:00-03:00'}
    its('preferred_maintenance_window') {should eq 'mon:03:01-mon:05:00'}
  end
end
