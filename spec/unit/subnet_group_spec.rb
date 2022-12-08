# frozen_string_literal: true

require 'spec_helper'

describe 'subnet group' do
  let(:component) do
    var(role: :root, name: 'component')
  end
  let(:deployment_identifier) do
    var(role: :root, name: 'deployment_identifier')
  end
  let(:subnet_ids) do
    output(role: :prerequisites, name: 'private_subnet_ids')
  end

  describe 'by default' do
    before(:context) do
      @plan = plan(role: :root)
    end

    it 'creates an RDS DB subnet group' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_subnet_group')
              .once)
    end

    it 'includes the component and deployment identifier in the name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_subnet_group')
              .with_attribute_value(
                :name,
                including(component)
                  .and(including(deployment_identifier))
              ))
    end

    it 'includes the component and deployment identifier in the description' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_subnet_group')
              .with_attribute_value(
                :description,
                including(component)
                  .and(including(deployment_identifier))
              ))
    end

    it 'uses the provided subnet IDs' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_subnet_group')
              .with_attribute_value(:subnet_ids, subnet_ids))
    end

    it 'includes component and deployment identifier tags' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_db_subnet_group')
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
        .to(include_resource_creation(type: 'aws_db_subnet_group')
              .with_attribute_value(
                :tags,
                a_hash_including(
                  Name: including(component)
                          .and(including(deployment_identifier))
                )
              ))
    end
  end
end
