#= require jquery.mjs.nestedSortable

$ ->
  $(".index_as_sortable [data-sortable-type]").each ->
    $this = $(this)
    if $this.data('sortable-type') == "tree"
      max_levels = 0
      tab_hack = 20 # nestedSortable default
    else
      max_levels = 1
      tab_hack = 99999

    $this.nestedSortable
      forcePlaceholderSize: true,
      handle: '> .item'
      listType: 'ol'
      items: 'li'
      opacity: .6
      placeholder: 'placeholder',
      maxLevels: max_levels,
      tabSize: tab_hack
      update: ->
        $this.nestedSortable("disable")
        $.ajax
          url: $this.data("sortable-url")
          type: "post"
          data: $this.nestedSortable("serialize")
        .always ->
          $this.find('.item').each (index) ->
            if index % 2
              $(this).removeClass('odd').addClass('even')
            else
              $(this).removeClass('even').addClass('odd')
          $this.nestedSortable("enable")
