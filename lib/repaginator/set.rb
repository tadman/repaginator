module Repaginator
  class Set
    # == Constants ============================================================

    # == Class Methods ========================================================

    # == Instance Methods =====================================================
    
    def initialize(list = nil)
      replace(list)
    end
    
    def items
      @set.keys
    end
    
    def empty?
      @set.empty?
    end

    def size
      @set.size
    end
    alias_method :length, :size
    
    def include?(value)
      @set.include?(value)
    end

    def replace(list)
      @set =
        case (list)
        when Repaginator::Set
          expand_from_list(list.items)
        when Array
          expand_from_list(list)
        when Hash
          expand_from_list(list.keys)
        else
          { }
        end
    end
    
    def to_h
      @set
    end
  
  protected
    def expand_from_list(list)
      list.inject({ }) do |h, v|
        h[v] = true
        h
      end
    end
  end
end
