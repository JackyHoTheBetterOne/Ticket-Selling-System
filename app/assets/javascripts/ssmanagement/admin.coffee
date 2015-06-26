$ ->
  if window.location.href.indexOf('ssmanagement/events/') isnt -1
    ADMIN_CONTROL = ((global, $) ->
      ticket_div = document.getElementById("Ticket")
      price_group_div = document.getElementsByClassName("price-group-list")[0]
      create_price_group_html = (obj) ->
        group = document.createElement('div')
        price = document.createElement('strong')
        button = document.createElement('button')
        price.setAttribute('style', 'font-size: 125%;')
        price.innerHTML = obj.price
        button.setAttribute('class', 'btn btn-default')
        button.setAttribute('id', obj.id)
        button.innerHTML = 'Assign Price'
        group.appendChild(price)
        group.appendChild(button)
        return group
      return {
        events: {
          create_price_group: ->
            $.ajax
              url: window.location.origin + "/ssmanagement/price_groups"
              method: "post"
              data: {
                price: $(".price-group-price").val()
              }
              success: (response) ->
                element = create_price_group_html(response)
                br = document.createElement("br")
                price_group_div.appendChild(br)
                price_group_div.appendChild(element)
              error: ->
                console.log("Cannot create the group")
          package_search_event: ->
            $.ajax
              url: window.location.href
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
        }
      }
    )(window, jQuery)
    $(".search-package-but").on "click.search_package", (event) ->
      event.preventDefault()
      ADMIN_CONTROL.events.package_search_event()
    $(".create-price-but").on "click.create_price", (event) ->
      event.preventDefault()
      ADMIN_CONTROL.events.create_price_group()
