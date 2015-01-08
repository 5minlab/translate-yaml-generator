# encoding: utf-8

require "i18n_yaml_generator/core"

describe I18nYamlGenerator::Record do
  describe "#item" do
    let(:row) { ["ns", "name", "english", "한국어"] }
    let(:record) { I18nYamlGenerator::Record.new row }

    it "valid index" do
      expect(record.item 0).to eq("english")
      expect(record.item 1).to eq("한국어")
    end

    it "invalid index" do
      expect { record.item -1 }.to raise_error(ArgumentError)
      expect { record.item 2 }.to raise_error(ArgumentError)
    end
  end

  describe "#item" do
    let(:row) { ["", "name"] }

    it "empty language data" do
      expect { I18nYamlGenerator::Record.new row }.to raise_error(ArgumentError)
    end
  end
end


describe I18nYamlGenerator::Node do
  let(:root) { I18nYamlGenerator::Node.new "" }
  let(:child) { I18nYamlGenerator::Node.new "child" }
  let(:record) { I18nYamlGenerator::Record.new ["ns", "name", "english", "한국어"] }

  describe "#add_child" do
    it "add child node" do
      expect(root.children.length).to eq(0)

      root.add_child child
      expect(root.children.length).to eq(1)
      expect(child.parent).to eq(root)
    end
  end

  describe "#add_record" do
    it "add record" do
      expect(root.records.length).to eq(0)

      root.add_record record
      expect(root.records.length).to eq(1)
    end
  end

  describe "#fullname" do
    it "get fulllname" do
      node = I18nYamlGenerator::Node.new "node"
      child << node

      expect(root.fullname).to eq("")
      expect(child.fullname).to eq("child")
      expect(node.fullname).to eq("child.node")
    end
  end

  describe "#<< " do
    it "child" do
      root << child
      expect(root.children.length).to eq(1)
      expect(root.records.length).to eq(0)
    end
    it "record" do
      root << record
      expect(root.children.length).to eq(0)
      expect(root.records.length).to eq(1)
    end
    it "not valid" do
      expect { root << "not-valid" }.to raise_error(ArgumentError)
    end
  end

  describe "#find_child!" do
    before(:each) do
      root << child
    end

    it "ns equal current node" do
      expect(root.find_child! "").to eq(root)
      expect(child.find_child! "child").to eq(child)
    end

    it "child exist" do
      expect(root.find_child! "child").to eq(child)
    end

    it "create child if parent exist" do
      name_list = "new_child", "child.new_child"
      name_list.each do |name|
        node = root.find_child! name
        expect(node.fullname).to eq(name)
      end
    end
    it "create child if parent not exist" do
      name_list = "foo.bar.spam", "child.foo.bar.spam"
      name_list.each do |name|
        node = root.find_child! name
        expect(node.fullname).to eq(name)
      end
    end
  end
end
