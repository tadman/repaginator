module Repaginator
  class Server < Repaginator::Memcache::Server
    # == Constants ==========================================================
    
    DEFAULT_PORT = 11310

    # == Class Methods ======================================================

    def self.port
      @port or DEFAULT_PORT
    end
    
    # == Instance Methods ===================================================
    
    def initialize(options)
      @options = options
      
      @buckets = { }
      @sets = { }
    end

    def post_init
      # ...
    end

    # -- Data Retrieval Methods ---------------------------------------------
    
    def fetch_bucket(id)
      # Implementation left up to subclass
      [ ]
    end
    
    def fetch_set(id)
      # Implementation left up to subclass
      [ ]
    end
    
    # -- Command Implementation ---------------------------------------------
    
    def get_command
      # Format: bucket=BUCKET_ID;page=PAGE_SPEC
      # Options: union=COLUMN_ID/SET_ID
      #          exclude=COLUMN_ID/SET_ID
    end
    
    def append_command
      # Format: bucket=BUCKET_ID
    end
    
    def delete_command
      # Format: bucket=BUCKET_ID
    end
    
    def flush_all_command
    end
  end
end
