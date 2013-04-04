require 'spec_helper'

describe Brandmaker::Job do

  let :job do
    Brandmaker::Job.new main_job_data
  end

  let :job_config do
    nil
  end

  describe '#id' do
    it 'returns the id' do
      job.id.should == '8193'
    end
  end

  describe '#technical_name' do
    it 'returns the technical_name' do
      job.technical_name.should == 'screenconcept__hauptjob'
    end
  end

  around :each do |example|
    Brandmaker.configure do |config|
      config.job_configs[:screenconcept__hauptjob] = job_config
    end

    example.run

    Brandmaker.configure do |config|
      config.job_configs.delete :screenconcept__hauptjob
    end
  end

  describe '#config' do
    context 'when a job config exists' do
      let :job_config do
        Brandmaker::JobConfig.new(job.technical_name)
      end

      it 'returns the job config' do
        job.config.should == job_config
      end
    end

    context 'when no job config exists' do
      it 'raises an exception' do
        expect { job.config }.to raise_error "Job #{job.id} is not configured, no config for #{job.technical_name}"
      end
    end
  end

  describe '#variables' do
    let :job_config do
      Brandmaker::JobConfig.new job.technical_name, [
        Brandmaker::VariableConfig.new(:name => 'default_media'),
        Brandmaker::VariableConfig.new(:name => 'some_email_recipient', :purpose => Brandmaker::VariablePurpose::EMAIL_RECIPIENT)
      ]
    end

    before :each do
      Brandmaker.configure do |config|
        config.job_configs[:screenconcept__hauptjob] = job_config
      end
    end

    it 'returns all variables which are configured in the job config' do
      job.variables.count.should be(1)
    end

    it 'returns a list of Variables' do
      job.variables.should be_all { |v| v.should be_a(Brandmaker::Variable) }
    end
  end

  describe '#recipients' do
    let :job_config do
      Brandmaker::JobConfig.new job.technical_name, [
        Brandmaker::VariableConfig.new(:name => 'email_field1', :purpose => Brandmaker::VariablePurpose::EMAIL_RECIPIENT)
      ]
    end

    it 'returns an array' do
      job.recipients.should == %w(test@test.com)
    end
  end
end
