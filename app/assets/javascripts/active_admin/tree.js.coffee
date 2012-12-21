#= require jquery.mjs.nestedSortable

$ ->
  $(".index_as_tree [data-sortable-type=tree]").each ->
    $this = $(this)
    $this.nestedSortable
      forcePlaceholderSize: true,
      handle: '> .item'
      listType: 'ol'
      items: 'li'
      opacity: .6
      placeholder: 'placeholder'
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
