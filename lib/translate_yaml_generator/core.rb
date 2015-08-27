# encoding: utf-8

module TranslateYamlGenerator
  class Record
    INDEX_NAMESPACE = 0
    INDEX_NAME = 1
    METADATA_FIELD_COUNT = 2

    def initialize(row)
      raise ArgumentError.new("No language data inside row") if row.length < METADATA_FIELD_COUNT
      @row = row
    end

    def namespace
      @row[INDEX_NAMESPACE]
    end

    def name
      @row[INDEX_NAME]
    end

    def item(idx)
      raise ArgumentError.new("Invalid index") if idx < 0
      raise ArgumentError.new("few elements exist") if @row.length < METADATA_FIELD_COUNT

      val =
        if idx < 0 or idx >= self.count
          ""
        else
          @row[idx + METADATA_FIELD_COUNT]
        end

      # is convertable
      re_array = /^\[(.+)\]$/
      m = re_array.match val
      if m
        val = $1.split(",").map {|x| x.gsub('"', '').strip }
      end

      val
    end

    def count
      @row.length - METADATA_FIELD_COUNT
    end
  end


  class Node
    attr_reader :name, :children, :records
    attr_accessor :parent
    protected :parent=

    def initialize(name="")
      @name = name
      @parent = nil
      @children = []
      @records = []
    end

    def fullname
      token_list = [@name]
      parent = @parent
      while parent != nil
        token_list << parent.name
        parent = parent.parent
      end
      token_list.reject! { |c| c.empty? }
      token_list.reverse.join(".")
    end

    def add_child(child)
      @children << child
      child.parent = self
    end

    def add_record(record)
      @records << record
    end

    def find_child!(ns)
      return self if @name == ns
      find_child_r!(ns)
    end

    def find_child_r!(ns)
      return self if ns == ""
      token_list = ns.split(".")
      child_name = token_list[0]
      next_ns = token_list[1, token_list.length].join(".")

      @children.each do |child|
        return child.find_child_r! next_ns if child.name == child_name
      end

      if token_list.length == 1
        node = TranslateYamlGenerator::Node.new child_name
        self << node
        return node
      else
        node = TranslateYamlGenerator::Node.new child_name
        self << node
        node.find_child! next_ns
      end
    end

    def <<(item)
      if item.is_a? TranslateYamlGenerator::Record
        add_record item
      elsif item.is_a? TranslateYamlGenerator::Node
        add_child item
      else
        raise ArgumentError, "not valid type"
      end
    end
  end
end
