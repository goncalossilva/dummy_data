require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

$:.unshift File.expand_path('../../lib',  __FILE__)
require 'rubygems'
require_relative '../lib/dummy_data'
require 'test/unit'
require 'fileutils'
require 'rails/all'
require 'rails/generators'
require 'rails/generators/test_case'
require 'rails/generators/rails/app/app_generator'

APP_NAME = 'dummy_rails_app'

module Rails
  def self.root
    @root ||= File.expand_path(File.join(File.dirname(__FILE__), "../tmp/#{APP_NAME}"))
  end
end

def create_test_application
  unless Object.const_defined?(APP_NAME.gsub(/\W/, '_').squeeze('_').camelize)
    prepare_destination
    Rails::Generators::AppGenerator.start(["#{Rails.root}"])

    templates_dir = File.expand_path('generators/templates', File.dirname(__FILE__))
    %w(child parent grand_parent).each do |model|
      copy_file "#{templates_dir}/#{model}.rb", "#{Rails.root}/app/models/#{model}.rb"
    end
  end
end

def clean_dummy
  FileUtils.rm_rf Dir["#{Rails.root}/test/dummy*"] + ["#{Rails.root}/lib/tasks/dummy_data.rake"]
end

def clean_tmp
  FileUtils.rm_rf File.join(File.dirname(__FILE__), '../tmp')
end
