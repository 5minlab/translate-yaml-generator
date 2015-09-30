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

    context "test content" do
      let(:filename) { get_data_file "sample-1.xlsx" }
      let(:root) { reader.read filename }

      # sample tree
      # - admin
      #   - debug
      # - foo
      #   - bar
      #     - spam
      #     - menu
      # - test

      it "check root node" do
        expect(root.children.length).to eq(3)
        expect(Set.new(root.children.map {|x| x.name})).to eq(Set.new(["admin", "foo", "test"]))

        expect(root.records.length).to eq(1)
        expect(root.records.map {|x| x.name}).to eq(["unknown"])
      end


      it "admin.debug" do
        node = root.find_child! "admin.debug"
        expect(node.children.length).to eq(0)
        expect(node.records.length).to eq(2)
        expect(node.records.map {|x| x.name}).to eq(["sample_1", "sample_2"])
      end

      it "test" do
        node = root.find_child! "test"
        expect(node.records.length).to eq(3)

        # empty element
        empty_record = node.records.select {|r| r.name == "empty_key"}[0]
        expect(empty_record.item 0).to eq("")
        expect(empty_record.item 1).to eq("")
        expect(empty_record.item 2).to eq("")

        # list element
        list_record = node.records.select {|r| r.name == "list"}[0]
        expect(list_record.item 0).to eq(["1", "2", "3"])
        expect(list_record.item 1).to eq(["a", "b", "c"])

        # newline
        list_record = node.records.select {|r| r.name == "newline"}[0]
        expect(list_record.item 0).to eq("한\n글")
        expect(list_record.item 1).to eq("abc\ndef")
      end
    end
  end
end
