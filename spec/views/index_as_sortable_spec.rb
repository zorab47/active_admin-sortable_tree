require "test_helper"
require "active_admin/component"
require "active_admin/views/index_as_sortable"

describe ActiveAdmin::Views::IndexAsSortable do
  let(:described_class) { ActiveAdmin::Views::IndexAsSortable }
  let(:view) { described_class.new }

  subject { view }

  before do
    described_class.send(:include, ActiveAdminHelpers)
    subject.active_admin_config = active_admin_config
  end

  let(:active_admin_config) do
    config = MiniTest::Mock.new
    config.expect(:resource_class, TreeNode)
    config
  end

  let(:options) { { roots_method: :roots } }

  it { must_respond_to(:active_admin_config) }

  describe ".index_name" do
    it "returns sortable" do
      described_class.index_name.must_equal "sortable"
    end
  end

  describe "#tree?" do
    it "returns true when configured for a tree" do
      subject.stub :options, { tree: true } do
        subject.tree?.must_equal true
      end
    end

    it "returns false by default" do
      subject.stub :options, { } do
        subject.tree?.must_equal false
      end
    end
  end

  describe "#roots_collection" do
    it "returns nil without the :roots_collection option" do
      subject.stub :options, {} do
        subject.roots_collection.must_be_nil
      end
    end

    it "returns nodes via defined proc when :roots_collection is set" do
      subject.stub :options, { roots_collection: proc { current_user_roots } } do
        subject.roots_collection.must_equal [:current_user_tree_node]
      end
    end
  end

  describe "#default_roots_collection" do
    it "retrieves nodes via roots_method on the resource_class" do
      subject.stub :options, { roots_method: :roots } do
        subject.default_roots_collection.must_equal [:tree_node]
      end
    end
  end

  describe "#roots" do
    it "retrieves default roots without a roots_collection" do
      subject.stub :options, { roots_method: :roots } do
        subject.roots.must_equal [:tree_node]
      end
    end

    describe "with roots_collection defined" do
      it "retrieves roots via roots_collection when defined" do
        subject.stub :options, { roots_method: :roots, roots_collection: proc { current_user_roots } } do
          subject.roots.must_equal [:current_user_tree_node]
        end
      end
    end
  end
end

module ActiveAdminHelpers
  attr_accessor :active_admin_config

  def controller
    FakeController.new
  end

  def resource_class
    TreeNode
  end
end

class TreeNode
  def self.roots
    [:tree_node]
  end
end

class FakeController
  def current_user_roots
    [:current_user_tree_node]
  end
end
