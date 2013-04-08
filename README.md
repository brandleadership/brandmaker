# Brandmaker

BrandMaker Client written in ruby. Implements Access to the
following BrandMaker APIs:

* JobManager (DSE)

Access to the Media Pool API is planned.

## Installation

Add this line to your application's Gemfile:

    gem 'brandmaker',
      :git => "git@github.com:screenconcept/brandmaker.git",
      :tag => 'v0.x.y'

And then execute:

    $ bundle

## Usage

### Configuration

Enter the BrandMaker SOAP API information in a new initializer file

    # file: config/initializers/brandmaker.rb
    Brandmaker.configure do |conf|
      conf.user = 'username'
      conf.password = 'password'
      conf.dse_service = 'https://<url>/webservices/dse/?wsdl'
      conf.media_pool_service = 'https://<url>/webservices/MediaPool/?wsdl'

      config = Brandmaker::JobConfig.new('job_type_technical_name').tap do |c|
        c.add_variables(
          { :name => :JobName, :label => 'Job name' },
          # ...
        )
      end

      conf.job_configs = {
        :job_type_technical_name => job_type_technical_name
      }
    end

Make sure to add a valid JobConfiguration for the corresponding job type.
See [here](https://github.com/screenconcept/job_manager/blob/config/initializers/brandmaker.rb) for a sample initializer file.

#### Variable Configuration

Simple variable

    c.add_variables 'Variable A', 'Variable B'

Custom variable

    c.add_variables { :name => :JobName, :label => 'Job name' },

Available Variable configuration options

    {
      name: 'Variable Name',
      label: 'Human readable label',
      purpose: Brandmaker::VariablePurpose.EMAIL_RECIPIENT,
      content_type: :media | :grid
    }

### Job fetching

Fetch a specific Job calling the find method on the `Job` class

    job = Job.find 1000
    # Access the variables
    job.variables

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
