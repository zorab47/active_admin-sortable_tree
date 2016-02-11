# Change Log

All notable changes to this project will be documented in this file.

## [Unreleased]

## [0.2.1] - 2015-04-15

- Suppress list styles on sortable indexes when batch actions are disabled.
  ([#48](https://github.com/zorab47/activeadmin-sortable-tree/issues/48)).
- Do not render the extra cell for batch actions when they are disabled, which
  removes extra whitespace to the left of items.

## [0.2.0] - 2014-12-23

- Shrink gem file size by excluding spec files and dummy application.

## 0.1.0 - 2014-11-19

- Add option to disable sorting: `sortable: false`, which causes the index view
  to be a static tree view.
- Ensure the default actions honor authorization checks
  ([#43](https://github.com/nebirhos/activeadmin-sortable-tree/pull/43)).


[unreleased]: https://github.com/zorab47/active_admin-sortable_tree/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/zorab47/active_admin-sortable_tree/compare/v0.1.0...v0.2.0
[0.2.1]: https://github.com/zorab47/active_admin-sortable_tree/compare/v0.2.0...v0.2.1
