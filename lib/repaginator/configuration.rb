require 'yaml'

module Repaginator
  class Configuration
    # == Constants ==========================================================
    
    DEFAULT_OPTIONS = {
      :config => %w[
        ./config/repaginator.yml
        ./config/repaginator.yaml
      ].collect { |p| File.expand_path(p) },
      :verbose => false
    }.freeze

    # == Class Methods ======================================================

    # == Instance Methods ===================================================
    
    def initialize(options = { })
      @options = DEFAULT_OPTIONS.merge(options)
      
      load_config
    end
    
    def port
      @config[:port] and @config[:port].to_i or
        @options[:port] or
        Repaginator::Server.port
    end
    
    def buckets
      @config[:buckets] or { }
    end

    def sets
      @config[:sets] or { }
    end
    
    def config_file_path
      [ @options[:config] ].flatten.find do |path|
        File.exist?(path)
      end
    end
    
    def load_config
      config_file = config_file_path
      
      unless (config_file)
        raise RuntimeException, "Could not locate a valid configuration file at: #{[ @options[:config] ].flatten.join(', ')}"
      end
      
      @config = YAML.load(config_file)
      
      unless (@config)
        raise RuntimeException, "No data found in config file: #{config_file}"
      end
      
      @environment_config = @config[rails_env]
    end
    
    def rails_env
      ENV['RAILS_ENV'] or 'development'
    end
  end
end
