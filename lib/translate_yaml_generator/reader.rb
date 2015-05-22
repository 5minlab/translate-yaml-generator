# encoding: utf-8

require "rubyXL"
require_relative "core"

module TranslateYamlGenerator
  module Reader
    class BaseReader
      def build_tree(records)
        root = TranslateYamlGenerator::Node.new
        records.each do |r|
        node = root.find_child! r.namespace
          node << r
        end
        root
      end

      def read(filename)
        check_filename(filename)
        records = read_records filename
        root = build_tree records
      end
    end


    class XlsxReader < BaseReader
      RE_XLSX = Regexp.new("\.xlsx$", Regexp::IGNORECASE)

      def check_filename(filename)
        raise ArgumentError, "not vaild xlsx file" unless filename =~ RE_XLSX
      end

      def read_records(filename)
        workbook = RubyXL::Parser.parse filename
        worksheet = workbook[0]

        records = []

        worksheet.each_with_index do |row, row_idx|
          if !row.respond_to?(:[])
            next
          end

          ns_cell = row[0]
          name_cell = row[1]

          # allow empty namespace
          ns = (defined? ns_cell.value) ? (ns_cell.value) : ""

          # empty name is not allowed
          next unless defined? name_cell.value

          rowdata = ns, name_cell.value
          (2...row.size).each do |col_idx|
            item_cell = row[col_idx]
            rowdata << item_cell.value
          end

          record = TranslateYamlGenerator::Record.new rowdata
          records << record
        end

        return records
      end
    end
  end
end
