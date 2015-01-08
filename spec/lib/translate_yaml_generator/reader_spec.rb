# encoding: utf-8

require "translate_yaml_generator/reader"

def get_data_file filename
  root_path = __FILE__
  4.times { root_path = File.dirname(root_path) }
  File.join(root_path, "data", filename)
end

describe TranslateYamlGenerator::Reader::XlsxReader do
  let(:reader) { TranslateYamlGenerator::Reader::XlsxReader.new }

  describe "#read" do
    it "not valid xlsx extension" do
      expect { reader.read "foo.csv" }.to raise_error(ArgumentError)
    end

    it "read record" do
      filename = get_data_file "sample-1.xlsx"
      root = reader.read filename

      expect(root.children.length).to eq(2)
      expect(root.records.length).to eq(1)

      node = root.find_child! "admin.debug"
      expect(node.children.length).to eq(0)
      expect(node.records.length).to eq(2)
    end
  end
end
