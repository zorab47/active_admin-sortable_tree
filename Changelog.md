# Change Log

All notable changes to this project will be documented in this file.

## [2.0.0] - 2018-01-22

### Changed

- Depend on same version of `jquery-ui-rails` as ActiveAdmin
- Update dependencies to only support ActiveAdmin `< 1.1.0` because `v1.1.0`
  [dropped its dependency on `jquery-ui-rails`](https://github.com/activeadmin/activeadmin/blob/master/CHANGELOG.md).
- Remove usage of bourbon mixin; instead rely on ActiveAdmin's utilities mixin
  (fixes #73)

### Removed

- Remove support for Rails 3.2
- Remove support for ActiveAdmin 0.6.6

### Upgrading from 1.0.0

It is suggested (but not required) to manually include the JavaScript and
stylesheet to your manifest files in preparation for ActiveAdmin v2.0. See the
Installation section of the [README.md](README.md#installation) for instructions.

## [1.0.0] - 2017-06-01

### Added

- Support for Rails 5.0 and 5.1 by conditionally invoking `parameterize` with its
  expected parameters.

### Changed

- Relax dependency on `jquery-ui-rails` to be `>= 5.0` (previously `~> 5.0`).

### Removed

- Ruby 1.9.3, 2.1, and 2.2 are no longer explicitly supported.

## [0.3.0] - 2016-09-08

- Rename sortable.css.sass to sortable.sass to fix deprecation warnings
- Update usage of box-sizing to fix Bourbon deprecation warning

## [0.2.1] - 2015-04-15

- Suppress list styles on sortable indexes when batch actions are disabled.
  ([#48](https://github.com/zorab47/activeadmin-sortable-tree/issues/48)).
- Do not render the extra cell for batch actions when they are disabled, which
  removes extra whitespace to the left of items.

## [0.2.0] - 2014-12-23

- Shrink gem file size by excluding spec files and dummy application.

## [0.1.0] - 2014-11-19

- Add option to disable sorting: `sortable: false`, which causes the index view
  to be a static tree view.
- Ensure the default actions honor authorization checks
  ([#43](https://github.com/nebirhos/activeadmin-sortable-tree/pull/43)).

## 0.0.1 - 2014-08-07

- Published to Rubygems.


[unreleased]: https://github.com/zorab47/active_admin-sortable_tree/compare/v1.0.0...HEAD
[0.1.0]: https://github.com/zorab47/active_admin-sortable_tree/compare/v0.0.1...v0.1.0
[0.2.0]: https://github.com/zorab47/active_admin-sortable_tree/compare/v0.1.0...v0.2.0
[0.2.1]: https://github.com/zorab47/active_admin-sortable_tree/compare/v0.2.0...v0.2.1
[0.3.0]: https://github.com/zorab47/active_admin-sortable_tree/compare/v0.2.1...v0.3.0
[1.0.0]: https://github.com/zorab47/active_admin-sortable_tree/compare/v0.3.0...v1.0.0
[1.1.0]: https://github.com/zorab47/active_admin-sortable_tree/compare/v1.0.0...v1.1.0
