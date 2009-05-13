require 'yaml'

module Repaginator
  class Configuration
    # == Constants ==========================================================
    
    DEFAULT_OPTIONS = {
      :config => %w[
        ./config/repaginator.yml
        ./config/repaginator.yaml
      ],
      :verbose => false
    }.freeze

    # == Class Methods ======================================================

    # == Instance Methods ===================================================
    
    def initialize(options = { })
      @options = DEFAULT_OPTIONS.merge(options)
    end
    
    def rails_env
      ENV['RAILS_ENV'] or 'development'
    end
  end
end
