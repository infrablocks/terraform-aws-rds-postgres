# frozen_string_literal: true

require 'spec_helper'

describe 'RDS' do
  let(:component) do
    var(role: :root, name: 'component')
  end
  let(:deployment_identifier) do
    var(role: :root, name: 'deployment_identifier')
  end

  let(:database_name) do
    var(role: :root, name: 'database_name')
  end
  let(:database_master_user) do
    var(role: :root, name: 'database_master_user')
  end
  let(:database_master_user_password) do
    var(role: :root, name: 'database_master_user_password')
  end

  describe 'by default' do
    before(:context) do
      @plan = plan(role: :root)
    end

    it 'creates an RDS DB instance' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .once)
    end

    it 'includes the component and deployment identifier in the identifier' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(
                :identifier,
                including(component)
                  .and(including(deployment_identifier))
              ))
    end

    it 'uses an engine of "postgres"' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:engine, 'postgres'))
    end

    it 'uses the default engine version' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:engine_version, a_nil_value))
    end

    it 'uses an instance class of "db.t4g.micro"' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:instance_class, 'db.t4g.micro'))
    end

    it 'is not publicly accessible' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:publicly_accessible, false))
    end

    it 'is not multi-AZ' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:multi_az, false))
    end

    it 'uses "standard" storage type' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:storage_type, 'standard'))
    end

    it 'does not set IOPS' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:iops, a_nil_value))
    end

    it 'does not use encrypted storage' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:storage_encrypted, false))
    end

    it 'allocates 10GB of storage' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:allocated_storage, 10))
    end

    it 'does not set max storage allocation' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:max_allocated_storage, a_nil_value))
    end

    it 'uses the provided database name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:db_name, database_name))
    end

    it 'uses the provided database username' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:username, database_master_user))
    end

    it 'uses the provided database password' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(
                :password,
                matching(/^#{database_master_user_password}$/)
              ))
    end

    it 'skips the final snapshot' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:skip_final_snapshot, true))
    end

    it 'does not specify a snapshot identifier' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:snapshot_identifier, a_nil_value))
    end

    it 'uses a backup retention period of 7 days' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:backup_retention_period, 7))
    end

    it 'uses a backup window of "01:00-03:00"' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:backup_window, '01:00-03:00'))
    end

    it 'uses a maintenance window of "mon:03:01-mon:05:00"' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:maintenance_window, 'mon:03:01-mon:05:00'))
    end

    it 'does not set parameter_group_name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:parameter_group_name, a_nil_value))
    end

    it 'allows automatic minor version upgrades' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:auto_minor_version_upgrade, true))
    end

    it 'does not allow major version upgrades' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:allow_major_version_upgrade, false))
    end

    it 'does not enable performance insights' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:performance_insights_enabled, false))
    end

    it 'includes component and deployment identifier tags' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(
                :tags,
                a_hash_including(
                  Component: component,
                  DeploymentIdentifier: deployment_identifier
                )
              ))
    end

    it 'includes a name tag including component and deployment identifier' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(
                :tags,
                a_hash_including(
                  Name: including(component)
                          .and(including(deployment_identifier))
                )
              ))
    end

    it 'outputs the database host' do
      expect(@plan)
        .to(include_output_creation(name: 'module_outputs')
              .with_value(including(:postgres_database_host)))
    end

    it 'outputs the database name' do
      expect(@plan)
        .to(include_output_creation(name: 'module_outputs')
              .with_value(including(:postgres_database_name)))
    end

    it 'outputs the database port' do
      expect(@plan)
        .to(include_output_creation(name: 'module_outputs')
              .with_value(including(:postgres_database_port)))
    end

    it 'outputs the security group id' do
      expect(@plan)
        .to(include_output_creation(name: 'module_outputs')
              .with_value(including(:postgres_database_sg_id)))
    end

    it 'outputs the security group name' do
      expect(@plan)
        .to(include_output_creation(name: 'module_outputs')
              .with_value(including(:postgres_database_sg_name)))
    end
  end

  describe 'when database_version provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.database_version = '5.7.38'
      end
    end

    it 'uses the provided engine version' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:engine_version, '5.7.38'))
    end
  end

  describe 'when database_instance_class provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.database_instance_class = 'db.t4g.small'
      end
    end

    it 'uses the provided instance class' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:instance_class, 'db.t4g.small'))
    end
  end

  describe 'when database_port provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.database_port = '5433'
      end
    end

    it 'listens on the provided port' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:port, 5433))
    end
  end

  describe 'when storage_type provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.storage_type = 'gp2'
      end
    end

    it 'uses the provided storage type' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:storage_type, 'gp2'))
    end
  end

  describe 'when storage_iops provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.storage_iops = 1000
      end
    end

    it 'uses the provided storage type' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:iops, 1000))
    end
  end

  describe 'when allocated_storage provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.allocated_storage = 25
      end
    end

    it 'uses the provided value for allocated storage' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:allocated_storage, 25))
    end
  end

  describe 'when max_allocated_storage provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.max_allocated_storage = 100
      end
    end

    it 'uses the provided value for max allocated storage' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:max_allocated_storage, 100))
    end
  end

  describe 'when snapshot_identifier provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.snapshot_identifier = 'snapshot-123'
      end
    end

    it 'uses the provided value for allocated storage' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:snapshot_identifier, 'snapshot-123'))
    end
  end

  describe 'when backup_retention_period provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.backup_retention_period = 14
      end
    end

    it 'uses the provided value for backup retention period' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:backup_retention_period, 14))
    end
  end

  describe 'when backup_window provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.backup_window = '02:00-04:00'
      end
    end

    it 'uses the provided value for the backup window' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:backup_window, '02:00-04:00'))
    end
  end

  describe 'when maintenance_window provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.maintenance_window = 'tue:02:01-tue:04:00'
      end
    end

    it 'uses the provided value for the maintenance window' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:maintenance_window, 'tue:02:01-tue:04:00'))
    end
  end

  describe 'when parameter_group_name provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.parameter_group_name = 'test-parameter-group'
      end
    end

    it 'uses the provided value for the assigned parameter group' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:parameter_group_name,
                                    'test-parameter-group'))
    end
  end

  describe 'when skip_final_snapshot provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.skip_final_snapshot = false
      end
    end

    it 'uses the provided skip_final_snapshot' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:skip_final_snapshot, false))
    end

    it 'includes identifiers in the final snapshot identifier' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:final_snapshot_identifier,
                                    including(component)
                                      .and(including(deployment_identifier))))
    end
  end

  describe 'when use_multiple_availability_zones is true' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.use_multiple_availability_zones = true
      end
    end

    it 'enables multi-AZ' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:multi_az, true))
    end
  end

  describe 'when use_multiple_availability_zones is false' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.use_multiple_availability_zones = false
      end
    end

    it 'does not enable multi-AZ' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:multi_az, false))
    end
  end

  describe 'when use_encrypted_storage is true' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.use_encrypted_storage = true
      end
    end

    it 'uses encrypted storage' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:storage_encrypted, true))
    end
  end

  describe 'when use_encrypted_storage is false' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.use_encrypted_storage = false
      end
    end

    it 'does not use encrypted storage' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:storage_encrypted, false))
    end
  end

  describe 'when allow_public_access is true' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.allow_public_access = true
      end
    end

    it 'is publicly accessible' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:publicly_accessible, true))
    end
  end

  describe 'when allow_public_access is false' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.allow_public_access = false
      end
    end

    it 'is not publicly accessible' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:publicly_accessible, false))
    end
  end

  describe 'when enable_automatic_minor_version_upgrade is true' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.enable_automatic_minor_version_upgrade = true
      end
    end

    it 'enables automatic minor version upgrades' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:auto_minor_version_upgrade, true))
    end
  end

  describe 'when enable_automatic_minor_version_upgrade is false' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.enable_automatic_minor_version_upgrade = false
      end
    end

    it 'does not enable automatic minor version upgrades' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:auto_minor_version_upgrade, false))
    end
  end

  describe 'when allow_major_version_upgrade is true' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.allow_major_version_upgrade = true
      end
    end

    it 'allows automatic minor version upgrades' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:allow_major_version_upgrade, true))
    end
  end

  describe 'when allow_major_version_upgrade is false' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.allow_major_version_upgrade = false
      end
    end

    it 'does not allow major version upgrades' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:allow_major_version_upgrade, false))
    end
  end

  describe 'when enable_performance_insights is true' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.enable_performance_insights = true
      end
    end

    it 'enables performance insights' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:performance_insights_enabled, true))
    end
  end

  describe 'when enable_performance_insights is false' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.enable_performance_insights = false
      end
    end

    it 'does not enable performance insights' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_instance')
              .with_attribute_value(:performance_insights_enabled, false))
    end
  end
end
