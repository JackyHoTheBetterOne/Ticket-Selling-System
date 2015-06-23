$ ->
  STRIPE_PAYMENT = ((global, $, stripe_system) ->
    stripe_key = 'pk_test_X0QOzTREgDolYkv9Nxysjlre'
    disappearance_css_obj = {'opacity':'0', 'z-index':'-1'}
    mutate_url = (name) ->
      url = window.location.href
      url = url.replace("seat_view", name)
      return url
    purchase_seats = (data) ->
      url = window.location.href
      url = url.replace("seat_view", "seat_purchase")
      $.ajax
        url: url
        method: "POST"
        data: data
        success: (response) ->
          console.log(response)
        error: ->
          console.log("Cannot complete the payment")
    unhold_seats = () ->
      url = window.location.href
      url = url.replace("seat_view", "seat_unhold")
      $.ajax
        url: url
        method: "POST"
        data: {
          seat_selection: assembleSelectedSeats()
        }
        success: (response) ->
          console.log("Seats unheld")
        error: ->
          console.log("Cannot unhold the seats")
      $(".payment-overlay").css(disappearance_css_obj)
    assembleSelectedSeats = () ->
      selected_seats = []
      $(".selected-seat").each ->
        seat = this
        selected_seats.push(this.getAttribute("id"))
      return selected_seats
    stripeResponseHandler = (status, response) ->
      $form = $('#payment-form')
      if response.error
        $form.find('.payment-errors').text(response.error.message)
      else
        params_obj = {
          token: response.id,
          customer_name: $(".customer-name").val(),
          customer_email: $(".customer-email").val(),
          seat_selection: assembleSelectedSeats()
        }
        purchase_seats(params_obj)
      return
    stripeCreateToken = (handler) ->
      stripe_system.card.createToken({
        number: $('.card-number').val(),
        cvc: $('.card-cvc').val(),
        exp_month: $('.card-expiry-month').val(),
        exp_year: $('.card-expiry-year').val()
      }, handler)

    stripe_system.setPublishableKey(stripe_key)

    return {
      payment_event: () ->
        stripeCreateToken(stripeResponseHandler)
        return
      unhold_event: () ->
        unhold_seats()
        return
    }
  )(window, jQuery, Stripe)

  $("#submit-seat-payment").on "click", (event) ->
    event.preventDefault()
    STRIPE_PAYMENT.payment_event()
  $(".close-form").on "click", (event) ->
    event.preventDefault()
    STRIPE_PAYMENT.unhold_event()
    



