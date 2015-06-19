# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('circle').each ->
    id = undefined
    id = $(this).data('row').toString() + $(this).data('column').toString()
    $(this).attr 'id', id
  SEAT_SELECTOR = ((global, $) ->
    circle_mouseover_color = '#696969'
    circle_original_color = '#3b77bf'
    circle_filtered_color = '#551A8B'
    svg = $(".qe-seating-chart")
    box = $(".text-box-bubble")
    overlay = $(".seats-loading-overlay")
    event_name = $("#event-name").data("name")
    map_container = $(".seat-selection-page main")
    price_filter = $(".price-filter")[0]
    selected_seat_container = $(".selected-seat-box")[0]
    selected_seats = []
    namespace = '/onlineticketing/events/'
    appearance_css_obj = {'opacity':'1', 'z-index':'5'}
    disappearance_css_obj = {'opacity':'0', 'z-index':'-1'}
    map_select_timer = undefined
    seat_class_recontruction = (circle) ->
      basic_klass = "seat-circle"
      row_klass = "row-" + $(circle).data('row')
      column_klass = "column-" + $(circle).data('column')
      return basic_klass + " " + row_klass + " " + column_klass
    create_selected_seat_box = (object) ->
      seat_box = document.createElement('div')
      id = "selected-" + object.row + object.column
      seat_box.setAttribute('class', 'selected-seat-info')
      seat_box.innerHTML = "Row:" + object.row + ", Column " + object.column
      seat_box.setAttribute('id', id)
      return seat_box
    create_price_filter_option = (price) ->
      option = document.createElement('option')
      option.innerHTML = "$" + price
      option.setAttribute("value", price)
      return option
    get_default_color = (circle) ->
      klass = $(circle).attr("class")
      if klass.indexOf("filtered") is -1
        return circle_original_color
      else
        return circle_filtered_color
    return {
      events: {
        circle_mouseenter: (event) ->
          circle = this
          $(circle).attr('fill', circle_mouseover_color)
          SEAT_SELECTOR.timer = setTimeout (->
            position = $(circle).position()
            # scrollTop = $(map_container).scrollTop()
            cX = position.left
            cY = position.top
            x = cX - 22
            y = cY - 67
            $(box).css({top:y, left: x, opacity: 1, 'z-index': 5})
          ), 500
        circle_mouseleave: (event) ->
          circle = this
          klass = $(circle).attr('class')
          if klass.indexOf('selected-seat') is -1 and klass.indexOf('taken-seat') is -1
            $(circle).attr('fill', get_default_color(circle)) 
          window.clearTimeout(SEAT_SELECTOR.timer)
          $(box).css({"opacity":"0", 'z-index': '-1'})
        circle_click: (event) ->
          circle = this
          klass = $(circle).attr('class')
          if klass.indexOf('taken-seat') is -1
            if klass.indexOf('selected-seat') is -1
              $(circle).attr('class', klass + " selected-seat")
              selected_seats.push(circle)
              box_fields = {
                row: $(circle).data("row"),
                column: $(circle).data("column")
              }
              selected_seat_container.appendChild(
                create_selected_seat_box(box_fields)
              )
            else
              $(circle).attr('class', seat_class_recontruction(circle))
              $(circle).attr('fill', get_default_color(circle))
              index = selected_seats.indexOf(circle)
              id = "#selected-" + $(circle).data("row") + $(circle).data("column")
              selected_seats.splice(index,1)
              $(id).remove()
        submit_seats: (event) ->
          i = 0
          length = selected_seats.length
          params_obj = []
          while i < length
            seat = selected_seats[i]
            seat_name = $(seat).data("row").toString() + $(seat).data("column").toString()
            params_obj.push(seat_name)
            i++
          $.ajax
            url: namespace + event_name + "/seat_selection"
            method: "post"
            data: {
              seat_selection: params_obj
            }
            success: (response) ->
              console.log(response)
              if !response.rules_broken
                seat_array = response.seats_to_remove
                array_length = seat_array.length
                console.log("yup")
                if array_length != 0 
                  i = 0
                  while i < array_length
                    console.log(seat_array)
                    base_id = seat_array[i]
                    console.log(base_id)
                    circle = document.getElementById(base_id)
                    console.log(seat)
                    index = selected_seats.indexOf(seat)
                    console.log(index)
                    circle_klass = circle.getAttribute("class")
                    box_id = "#selected-" + base_id 
                    new_klass = circle_klass.replace("selected-seat", "taken-seat")
                    circle.setAttribute("class", new_klass)
                    selected_seats.splice(index, 1)
                    $(box_id).remove()
                    i++
              else 
                console.log("nope")
            error: () ->
              alert('Cannot send the seat selection')

        switch_map: (event) ->
          value = this.value
          upper_klass = $(".upper").attr("class")
          lower_klass = $(".lower").attr("class")
          window.clearTimeout(map_select_timer)
          if value is 'upper'
            if $('.upper').css("opacity") isnt "1"
              upper_klass = upper_klass.replace("spaceOutDown","")
              $(".upper").attr("class", upper_klass)
              upper_klass += " spaceInDown"
              $(".upper").css(appearance_css_obj)
              $(".upper").attr("class", upper_klass)
              map_select_timer = setTimeout (->
                $(".lower").css(disappearance_css_obj)
              ), 500
          else if value is 'base'
            if $(".upper").css("opacity") is "1" 
              upper_klass = upper_klass.replace("spaceInDown","")
              $(".upper").attr("class", upper_klass)
              upper_klass += " spaceOutDown"
              $(".upper").attr("class", upper_klass)
              map_select_timer = setTimeout (->
                $(".upper").css(disappearance_css_obj)
                $(".lower").css(appearance_css_obj)
              ), 250
        filter_price: (event) ->
          price = this.value
          circles = document.getElementsByClassName("seat-circle")
          i = 0
          length = circles.length
          while i < length
            circle = circles[i]
            seat_price = circle.getAttribute("data-price")
            klass = circle.getAttribute("class")
            if parseFloat(seat_price) is parseFloat(price) && klass.indexOf('taken-seat') is -1
              circle.setAttribute("class", klass+=' filtered') if klass.indexOf("filtered") is -1
              circle.setAttribute("fill", circle_filtered_color)
            else
              circle.setAttribute("class", klass.replace("filtered", "")) if klass.indexOf("filtered") isnt -1
              circle.setAttribute("fill", circle_original_color)
            i++

      },
      update_seating_chart: ->
        price_array = []
        $.ajax
          url: namespace + event_name + '/seat_update.json'
          method: 'get'
          success: (response) ->
            seats = response.seats
            length = seats.length
            i = 0
            while i < length
              seat = seats[i]
              price = seat.price
              circle = document.getElementById(seat.name)
              price_array.push(price) if price_array.indexOf(price) is -1
              circle.setAttribute("data-price", price)
              if seat.status isnt 'available'
                new_klass = seat_class_recontruction(circle) + " taken-seat"
                circle.setAttribute('class', new_klass)
                circle.setAttribute('fill', circle_mouseover_color)
              i++
            $(overlay).css(disappearance_css_obj)
            i = 0
            length = price_array.length
            while i < length
              price = price_array[i]
              option = create_price_filter_option(price)
              price_filter.appendChild(option)
              i++
          error: () ->
            alert("Cannot updated seats!")
    }
  )(window, jQuery)
  $('.seat-circle').on(
    'mouseenter.circle_selection', SEAT_SELECTOR.events.circle_mouseenter
  ).on(
    'mouseleave.circle_selection', SEAT_SELECTOR.events.circle_mouseleave
  )
  $('.seat-circle').on('click.select', SEAT_SELECTOR.events.circle_click)
  $('.submit-seats').on('click.submit_seats', SEAT_SELECTOR.events.submit_seats)
  $(".map-filter").on('change.change_map', SEAT_SELECTOR.events.switch_map)
  $(".price-filter").on("change.change_price", SEAT_SELECTOR.events.filter_price)
  SEAT_SELECTOR.update_seating_chart()


