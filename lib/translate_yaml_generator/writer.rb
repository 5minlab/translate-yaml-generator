# encoding: utf-8

require 'yaml'

module TranslateYamlGenerator
  module Writer
    class BaseWriter
      attr_accessor :locale_idx, :locale

      def initialize
        @locale_idx = 0
        @locale = "en"
      end

      def write(node)
        reset
        visit_r node, ""
        result
      end

      def reset
      end

      def result
      end

      def visit_r(node, parent_ns)
        ns = [parent_ns, node.name].reject(&:empty?).join(".")
        node.records.each do |r|
          handle_record ns, r
        end
        node.children.each { |c| visit_r c, ns}
      end
    end

    class LineWriter < BaseWriter
      def reset; @item_list = []; end
      def result; @item_list; end

      def handle_record(ns, record)
        data = {
          :ns => ns,
          :name => record.name,
          :value => (record.item @locale_idx)
        }
        @item_list << data
      end
    end

    class HashWriter < BaseWriter
      def reset; @root = {}; end
      def result; @root; end

      def handle_record(ns, record)
        token_list = ns.split(".")
        curr_hash = @root
        token_list.each do |token|
          if curr_hash.has_key? token
            curr_hash = curr_hash[token]
          else
            curr_hash[token] = {}
            curr_hash = curr_hash[token]
          end
        end

        curr_hash[record.name] = record.item @locale_idx
      end
    end

    class YamlWriter < HashWriter
      def result
        root = {
          @locale => @root
        }
        result = YAML.dump(root)
        result.gsub "---\n", ""
      end
    end
  end
end
