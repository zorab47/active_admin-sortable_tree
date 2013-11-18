# ActiveAdmin Sortable Tree

This gem adds a tree and a list view to your ActiveAdmin resource index, both sortable via drag'n'drop.


## Installation

```ruby
# Gemfile
gem "activeadmin-sortable-tree", :github => "nebirhos/activeadmin-sortable-tree", :branch => "master"
```


*WARNING!* Not compatible with neo/activeadmin-sortable[https://github.com/neo/activeadmin-sortable]


## Usage (Tree)

**Admin**:

```ruby
# app/admin/page.rb
ActiveAdmin.register Page do
  sortable tree: true

  index :as => :sortable do
    label :title # item content
        actions
  end
end
```

**Model**: activeadmin-sortable-tree is agnostic to the tree implementation. All you have to do is expose a sorting attribute and a few tree methods (:parent, :children and :roots).
Let's say you use [Ancestry](https://github.com/stefankroes/ancestry):

```ruby
class Page < ActiveRecord::Base
  attr_accessible :title, :body, :position
  has_ancestry :orphan_strategy => :rootify
end
```

You can configure these methods if you need:

```ruby
ActiveAdmin.register Page do
  sortable tree: true,
           sorting_attribute: :position,
           parent_method: :parent,
           children_method: :children,
           roots_method: :roots,
           roots_collection: proc { current_user.pages.roots }
  # ...
end
```

The option `roots_collection` provides full control on how to find the root
nodes of your sortable tree and is evaluated within the context of the
controller. Please note that `roots_collection` will override what is specified
in `roots_method`.

## Usage (List)

**Admin**:
```ruby
# app/admin/page.rb
ActiveAdmin.register Page do
  sortable

  index :as => :sortable do
    label :title # item content
    actions
  end
end
```

**Model**: Sortable list assumes you have a `:position` field in your resource. Of course it's configurable:

```ruby
ActiveAdmin.register Page do
  sortable tree: false, # default
           sorting_attribute: :my_position_field
  ...
end
```


## Usage (generic ActiveAdmin index)

Currently supports only IndexAsBlock, more to come!

**Admin**:
```ruby
# app/admin/page.rb

ActiveAdmin.register Page do
  sortable

  index :as => :block do |page|
    # item content
  end
end
```

**Model**: Same as list view (see above)


## Customization

### Full options list with defaults

```ruby
ActiveAdmin.register Page do
  sortable tree: true,
           max_levels: 0,               # infinite indent levels
           protect_root: false,         # allow root items to be dragged
           sorting_attribute: :position,
           parent_method: :parent,
           children_method: :children,
           roots_method: :roots,
           roots_collection: nil,       # proc to specifiy retrieval of roots
           collapsible: false,          # show +/- buttons to collapse children
           start_collapsed: false,      # when collapsible, start with all roots collapsed
end
```


### Actions

In `IndexAsSortable` you can add custom actions (with or without the defaults):

```ruby
index :as => :sortable do
  actions defaults: false do |page|
    link_to "Custom action", my_custon_path(page)
  end
end
```


### Ajax Callback Config

It exposes three Ajax Events: ajaxDone, ajaxFail and ajaxAlways, which correspond to jQuery ajax callbacks: done, fail and always.

To subscribe Ajax callback:

```javascript
ActiveAdminSortableEvent.add('ajaxDone', function (){
  // do what you want
})
```

## Copyright

Copyright © 2013 Francesco Disperati, Cantiere Creativo. See the file MIT-LICENSE for details.
See the full list list of [contributors](https://github.com/nebirhos/activeadmin-sortable-tree/graphs/contributors).
