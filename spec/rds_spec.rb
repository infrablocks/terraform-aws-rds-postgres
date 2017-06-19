require 'spec_helper'

describe 'RDS' do
  include_context :terraform

  let(:component) { RSpec.configuration.component }
  let(:deployment_identifier) { RSpec.configuration.deployment_identifier }

  let(:database_name) { RSpec.configuration.database_name }

  context 'rds' do
    subject {
      rds("db-instance-#{component}-#{deployment_identifier}")
    }

    it { should exist }

  end

end
