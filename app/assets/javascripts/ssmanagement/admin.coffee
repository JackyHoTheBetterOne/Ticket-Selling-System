$ ->
  if window.location.href.indexOf('ssmanagement/events/') isnt -1
    ADMIN_CONTROL = ((global, $) ->
      ticket_div = document.getElementById("Ticket")
      return {
        events: {
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
    console.log("sup")
    $(".search-package-but").on "click.search_package", (event) ->
      event.preventDefault()
      ADMIN_CONTROL.events.package_search_event()
