# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  SEAT_SELECTOR = ((global, $) ->
    circle_mouseover_color = '#696969'
    circle_original_color = '#3b77bf'
    svg = $(".qe-seating-chart")
    box = $(".text-box-bubble")
    overlay = $(".seats-loading-overlay")
    event_name = $("#event-name").data("name")
    map_container = $(".seat-selection-page main")
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
          if $(circle).attr('class').indexOf('selected_seat') is -1
            $(circle).attr('fill', circle_original_color) 
          window.clearTimeout(SEAT_SELECTOR.timer)
          $(box).css({"opacity":"0", 'z-index': '-1'})
        circle_click: (event) ->
          circle = this
          klass = $(circle).attr('class')
          if klass.indexOf('taken_seat') is -1
            if klass.indexOf('selected_seat') is -1
              $(circle).attr('class', klass + " selected_seat")
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
              $(circle).attr('fill', circle_original_color)
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
              seat_selection: params_obj,
              event_name: event_name
            }
            success: (response) ->
              console.log(response)
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
      },
      update_seating_chart: ->
        $.ajax
          url: namespace + event_name + '/seat_update.json'
          method: 'get'
          # beforeSend: ->
          #   $(overlay).css(appearance_css_obj)
          success: (response) ->
            seats = response.seats
            length = seats.length
            i = 0
            while i < length
              seat = seats[i]
              if seat.status isnt 'available'
                circle = document.getElementById(seat.name)
                new_klass = seat_class_recontruction(circle) + " taken_seat"
                circle.setAttribute('class', new_klass)
                circle.setAttribute('fill', circle_mouseover_color)
              i++
            $(overlay).css(disappearance_css_obj)
          error: () ->
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
  # SEAT_SELECTOR.update_seating_chart()


