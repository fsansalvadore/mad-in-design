#!/usr/bin/env ruby

# This is a standalone test script that loads our custom configuration
# without needing to load the entire Rails environment

require 'logger'
require 'ostruct'
require 'pathname'

# Create a minimal Rails application stub
module Rails
  class Application
    attr_accessor :config
    
    def initialize
      @config = OpenStruct.new
    end
  end
  
  def self.application
    @application ||= Application.new
  end
  
  def self.logger
    @logger ||= Logger.new(STDOUT)
  end
  
  def self.root
    @root ||= Pathname.new(File.expand_path('..', __FILE__))
  end
end

# Load our custom configuration
require_relative 'lib/custom_config'

# Print the result
puts "Custom config loaded successfully!"
puts "Rails.application.config.custom_setting = #{Rails.application.config.custom_setting.inspect}"
puts "Rails.application.config.app_name = #{Rails.application.config.app_name.inspect}" 