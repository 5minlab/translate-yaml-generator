# encoding: utf-8

require "translate_yaml_generator/writer"
require "translate_yaml_generator/core"


def get_data_file filename
  root_path = __FILE__
  4.times { root_path = File.dirname(root_path) }
  File.join(root_path, "data", filename)
end


describe TranslateYamlGenerator::Writer::HashWriter do
  let(:writer) { TranslateYamlGenerator::Writer::HashWriter.new }

  describe "#write" do
    it "use data" do
      filename = get_data_file "sample-1.xlsx"
      reader = TranslateYamlGenerator::Reader::XlsxReader.new
      root = reader.read filename
      actual = writer.write root
      expected = {
        "unknown" => "빈거",
        "admin" => {
          "item_1" => "한글",
          "item_2" => "테스트",
          "item_3" => "서비스",
          "debug" => {
            "sample_1" => "임시",
            "sample_2" => "점검"
          }
        },
        "foo" => {
          "bar" => {
            "spam" => {
              "dummy_1" => "메뉴",
              "dummy_2" => "항목"
            },
            "menu" => {
              "elem_1" => "일부",
              "elem_2" => "요소"
            }
          }
        },
        "test" => {
          "empty_key" => "",
          "list" => ["1","2","3"],
          "newline" => "한\n글",
        }
      }
      expect(actual).to eq(expected)
    end
  end
end


describe TranslateYamlGenerator::Writer::LineWriter do
  let(:writer) { TranslateYamlGenerator::Writer::LineWriter.new }

  describe "#locale_idx" do
    it "get/set" do
      expect(writer.locale_idx).to eq(0)
      writer.locale_idx = 1
      expect(writer.locale_idx).to eq(1)
    end
  end

  describe "#write" do
    it "use data" do
      filename = get_data_file "sample-1.xlsx"
      reader = TranslateYamlGenerator::Reader::XlsxReader.new
      root = reader.read filename

      actual = writer.write root
      expected = [
                  {:ns=>"", :name=>"unknown", :value=>"빈거"},
                  {:ns=>"admin", :name=>"item_1", :value=>"한글"},
                  {:ns=>"admin", :name=>"item_2", :value=>"테스트"},
                  {:ns=>"admin", :name=>"item_3", :value=>"서비스"},
                  {:ns=>"admin.debug", :name=>"sample_1", :value=>"임시"},
                  {:ns=>"admin.debug", :name=>"sample_2", :value=>"점검"},
                  {:ns=>"foo.bar.spam", :name=>"dummy_1", :value=>"메뉴"},
                  {:ns=>"foo.bar.spam", :name=>"dummy_2", :value=>"항목"},
                  {:ns=>"foo.bar.menu", :name=>"elem_1", :value=>"일부"},
                  {:ns=>"foo.bar.menu", :name=>"elem_2", :value=>"요소"},
                  {:ns=>"test", :name=>"empty_key", :value=>""},
                  {:ns=>"test", :name=>"list", :value=>["1", "2", "3"]},
                  {:ns=>"test", :name=>"newline", :value=>"한\n글"},
                 ]
      expect(actual).to eq(expected)
    end
  end
end


describe TranslateYamlGenerator::Writer::YamlWriter do
  let(:writer) { TranslateYamlGenerator::Writer::YamlWriter.new }

  describe "#write" do
    it "use data" do
      filename = get_data_file "sample-1.xlsx"
      reader = TranslateYamlGenerator::Reader::XlsxReader.new
      root = reader.read filename
      actual = writer.write root
      #puts actual
    end
  end
end
