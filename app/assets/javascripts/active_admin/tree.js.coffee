#= require jquery.mjs.nestedSortable

# add depth level to css class
depthFinder = (node) ->
  $('li.resource > ol, li.placeholder > ol', node).each ->
    depth = $(this).parents('li.resource, li.placeholder').length
    $(this).removeClass().addClass('level-' + depth)

$ ->
  console.log "asdasd"
  $(".index_as_tree [data-sortable=tree]").each ->
    $this = $(this)
    depthFinder($this)
    $this.nestedSortable
      forcePlaceholderSize: true,
      handle: '> .item'
      listType: 'ol'
      items: 'li'
      opacity: .6
      placeholder: 'placeholder'
      update: ->
        console.log $this.nestedSortable("serialize")
        # $this.nestedSortable("disable")
        depthFinder($this)
        # $.ajax
        #   url: $this.data("sort-path")
        #   type: "post"
        #   data: $this.sortable("serialize")
        # .always ->
        #   $this.nestedSortable("enable")
