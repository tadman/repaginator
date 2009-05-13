module Repaginator
  class Bucket
    # == Constants ============================================================
    
    DEFAULTS = {
      :per_page => 25
    }.freeze

    # == Class Methods ========================================================

    # == Instance Methods =====================================================
    
    def initialize(content = nil, options = { }, parent = nil)
      @content = (content or [ ])
      @options = DEFAULTS.merge(options)
      
      @conditions = @options[:conditions]
      
      if (@conditions)
        @content = @content.select(&@conditions)
      end
      
      @subsets = [ ]
    end

    def per_page=(value)
      @options[:per_page] = value.to_i
    end
    
    def per_page
      @options[:per_page]
    end
    
    def page(page_number)
      if (page_number < 0)
        page_number = 0
      end
      
      @content.slice((page_number - 1) * per_page, per_page)
    end
    
    def exclude(column, set)
      return self if (set.empty?)
      
      subset do |row|
        !set.include?(row[column])
      end
    end

    def union(column, set)
      return subset([ ]) if (set.empty?)
      
      subset do |row|
        set.include?(row[column])
      end
    end
    
    def size
      @content.size
    end
    alias_method :length, :size
    
    def empty?
      @content.empty?
    end
    
    def prepend(row)
      if (!@conditions || @conditions.call(row))
        @content.unshift(row)
      
        for_subsets do |subset|
          subset.prepend(row)
        end
      end
    end
    
    def append(row)
      if (!@conditions || @conditions.call(row))
        @content.push(row)
      
        for_subsets do |subset|
          subset.append(row)
        end
      end
    end
    
    def delete(key)
      @content.delete_if do |row|
        row[0] == key
      end
      
      for_subsets do |subset|
        subset.delete(key)
      end
    end

  protected
    def subset(content = nil, &block)
      subset = self.class.new(content || @content, @options.merge(:conditions => block), self)

      @subsets << subset
      
      subset
    end
    
    def for_subsets(&block)
      @subsets.each(&block)
    end
  end
end
