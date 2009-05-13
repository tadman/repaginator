module Repaginator
  autoload(:Bucket, 'repaginator/bucket')
  autoload(:Configuration, 'repaginator/configuration')
  autoload(:Memcache, 'repaginator/memcache')
  autoload(:Server, 'repaginator/server')
  autoload(:Set, 'repaginator/set')
  
  VERSION = '0.0.1'
  
  class RuntimeException < Exception
  end
end
