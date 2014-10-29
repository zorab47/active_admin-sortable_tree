require 'rails_helper'

RSpec.describe "ActiveAdmin::SortableTree", type: :feature do
  context "configured as sortable" do
    it "sorts by dragging vertically", js: true do
      bottom = Category.create! name: "bottom", position: 0
      top    = Category.create! name: "top",    position: 1
      middle = Category.create! name: "middle", position: 2

      visit admin_categories_path

      expect(all(".ui-sortable li h3").map(&:text)).to eq(["bottom", "top", "middle"])

      wait_for_ajax { drag_element("#category_#{middle.id} h3", dy: -100) }
      wait_for_ajax { drag_element("#category_#{top.id} h3", dy: -100) }

      expect(all(".ui-sortable li h3").map(&:text)).to eq(["top", "middle", "bottom"])
      expect(Category.order(:position).map(&:name)).to eq(["top", "middle", "bottom"])
    end

    context "with option `sortable: false`" do
      before do
        sortable_options_for("Category")[:sortable] = false
      end

      it "disables sorting by excluding sortable data attributes" do
        bottom = Category.create! name: "bottom", position: 0
        top    = Category.create! name: "top",    position: 1
        middle = Category.create! name: "middle", position: 2

        visit admin_categories_path

        expect(page).to have_css(".index_as_sortable")
        expect(page).not_to have_css("[data-sortable-type]")
        expect(page).not_to have_css("[data-sortable-url]")
      end
    end
  end

  context "configured as sortable tree" do
    it "sorts by dragging vertically", js: true do
      bottom = Category.create! name: "bottom", position: 0
      top    = Category.create! name: "top",    position: 1
      middle = Category.create! name: "middle", position: 2

      visit admin_category_trees_path

      expect(all(".ui-sortable li h3").map(&:text)).to eq(["bottom", "top", "middle"])

      wait_for_ajax { drag_element("#category_tree_#{middle.id} h3", dy: -100) }
      wait_for_ajax { drag_element("#category_tree_#{top.id} h3", dy: -100) }

      expect(all(".ui-sortable li h3").map(&:text)).to eq(["top", "middle", "bottom"])
      expect(Category.order(:position).map(&:name)).to eq(["top", "middle", "bottom"])
    end

    it "assigns hierarchy by dragging horizontally", js: true do
      top    = Category.create! name: "top",    position: 0
      middle = Category.create! name: "middle", position: 1
      bottom = Category.create! name: "bottom", position: 2
      expect(top.children).not_to include(middle)

      visit admin_category_trees_path

      wait_for_ajax { drag_element("#category_tree_#{middle.id} h3", dx: 40) }
      wait_for_ajax { drag_element("#category_tree_#{bottom.id} h3", dx: 40) }

      expect(top.children).to include(middle, bottom)
    end

    context "with option `sortable: false`" do
      before do
        sortable_options_for("CategoryTree")[:sortable] = false
      end

      it "disables sorting by excluding sortable data attributes" do
        bottom = Category.create! name: "bottom", position: 0
        top    = Category.create! name: "top",    position: 1
        middle = Category.create! name: "middle", position: 2

        visit admin_category_trees_path

        expect(page).to have_css(".index_as_sortable")
        expect(page).not_to have_css("[data-sortable-type]")
        expect(page).not_to have_css("[data-sortable-url]")
      end
    end
  end

  def drag_element(selector, options)
    options.reverse_merge! moves: 20
    page.execute_script(%Q($("#{selector}").simulate("drag", #{options.to_json} )))
  end

  def sortable_options_for(resource)
    resource_config = ActiveAdmin.application.namespace(:admin).resource_for(resource)
    resource_config.dsl.sortable_options
  end
end
