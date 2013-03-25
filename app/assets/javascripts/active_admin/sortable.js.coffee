#= require jquery.mjs.nestedSortable

$ ->
  $(".index_as_sortable [data-sortable-type]").each ->
    $this = $(@)
    if $this.data('sortable-type') == "tree"
      max_levels = if $this.data('max-levels') then $this.data('max-levels') else 0
      tab_hack = 20 # nestedSortable default
    else
      max_levels = 1
      tab_hack = 99999
    protect_root = if $this.data('protect-root') then true else false

    $this.nestedSortable
      forcePlaceholderSize: true
      forceHelperSizeType: true
      errorClass: 'cantdoit'
      disableNesting: 'cantdoit'
      handle: '> .item'
      listType: 'ol'
      items: 'li'
      opacity: .6
      placeholder: 'placeholder'
      revert: 250
      maxLevels: max_levels,
      tabSize: tab_hack
      protectRoot: protect_root
      # prevent drag flickers
      tolerance: 'pointer'
      toleranceElement: '> div'
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
