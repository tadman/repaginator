module Repaginator
  class Server < Repaginator::Memcache::Server
    # == Constants ==========================================================
    
    DEFAULT_PORT = 11310

    # == Class Methods ======================================================

    def self.port
      @port or DEFAULT_PORT
    end
    
    # == Instance Methods ===================================================
    
    def initialize(config)
      @config = config
      
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
      # Format: bucket=BUCKET_NAME/BUCKET_ID;page=PAGE_NUM/PAGE_SIZE
      # Options: union=SET_ID/COLUMN_ID
      #          exclude=SET_ID/COLUMN_ID
    end
    
    def append_command
      # Format: bucket=BUCKET_NAME/BUCKET_ID or set=SET_NAME/SET_ID
    end
    
    def delete_command
      # Format: bucket=BUCKET_NAME/BUCKET_ID or set=SET_NAME/SET_ID
      #         bucket=BUCKET_NAME or set=SET_NAME
    end
    
    def flush_all_command
    end
  end
end
