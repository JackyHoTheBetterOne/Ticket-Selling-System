$ ->
  if window.location.href.indexOf('ssmanagement/events/') isnt -1
    ADMIN_CONTROL = ((global, $) ->
      ticket_div = document.getElementById("Ticket")
      price_group_div = document.getElementsByClassName("price-group-list")[0]
      event_id = $(".event-name").attr("id")
      box = $('.text-box-bubble')[0]
      create_price_group_html = (obj) ->
        group = document.createElement('div')
        price = document.createElement('strong')
        button = document.createElement('button')
        price.setAttribute('style', 'font-size: 125%;')
        price.innerHTML = obj.price
        button.setAttribute('class', 'btn btn-default')
        button.setAttribute('id', obj.id)
        button.innerHTML = 'Delete'
        group.appendChild(price)
        group.appendChild(button)
        return group
      return {
        events: {
          create_price_group: (event) ->
            $.ajax
              url: global.location.origin + "/ssmanagement/price_groups"
              method: "post"
              data: {
                price: $(".price-group-price").val(),
                event_id: event_id
              }
              success: (response) ->
                element = create_price_group_html(response)
                br = document.createElement("br")
                price_group_div.appendChild(br)
                price_group_div.appendChild(element)
              error: ->
                console.log("Cannot create the group")
          delete_price_group: (but) ->
            id = $(but).attr("id")
            $.ajax
              url: global.location.origin + "/ssmanagement/price_groups/" + id
              method: "delete"
              success: (response) ->
                if response is "success"
                  $("#price-group-" + id).fadeOut(500).remove()
              error: ->
                console.log("Cannot delete the group")
          package_search_event: ->
            $.ajax
              url: global.location.href
              method: 'get'
              data: {
                keyword: $(".package-search-field").val()
              }
              success: (response) ->
                frag = document.createElement('div')
                frag.innerHTML = response
                div = frag.getElementsByClassName("package-list")[0]
                $(".package-list").fadeOut(300).remove()
                div.style["display"] = 'none'
                ticket_div.appendChild(div)
                $(".package-list").fadeIn(300)
              error: ->
                console.log("Cannot search packages")
          mouseenter_circle: (event) ->
            circle = this
            global.CHART_INTERACTOR.circle_position_translation_to_box(circle, box, -208.5, 61)
          mouseleave_circle: (event) ->
            global.CHART_INTERACTOR.box_hide(box)
        }
      }
    )(window, jQuery)
    $('circle').each ->
      id = undefined
      id = $(this).data('row').toString() + "-" + $(this).data('column').toString()
      $(this).attr 'id', id
    $(".search-package-but").on "click.search_package", (event) ->
      event.preventDefault()
      ADMIN_CONTROL.events.package_search_event()
    $(".create-price-but").on "click.create_price", (event) ->
      event.preventDefault()
      ADMIN_CONTROL.events.create_price_group()
    $(".container").on "click.delete_group", ".delete-group-but", (event) ->
      event.preventDefault()
      ADMIN_CONTROL.events.delete_price_group(this)
    $('.seat-circle').on(
      'mouseenter.circle_selection', ADMIN_CONTROL.events.mouseenter_circle
    ).on(
      'mouseleave.circle_selection', ADMIN_CONTROL.events.mouseleave_circle
    )
