class Event::SeatPurchaser
  attr_reader :event_id
  attr_reader :customer_email
  attr_reader :customer_name
  attr_reader :seat_selection
  attr_reader :stripe_token
  attr_reader :is_successful
  attr_reader :error_message

  def initialize(options={})
    @event_id = options[:event_id]
    @customer_email = options[:customer_email]
    # @customer_name = options[:customer_name]
    @stripe_token = options[:stripe_token]
    @seat_selection = Seat.find_available_seats_by_name(
                        @event_id, options[:seat_selection])
  end

  def call()
    amount = 0  
    @is_successful = true
    is_valid = true
    
    @seat_selection.each do |s|
      amount += s.price_group.price
      is_valid = false if s.aasm_state != 'onhold'
    end

    if is_valid
      customer = Stripe::Customer.create(
        email: @customer_email,
        card: @stripe_token
      )

      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: (amount*100).to_i,
        description: 'Spring Show',
        currency: 'CAD'
      )
    else
      @is_successful = false
    end

  rescue Stripe::CardError => e 
    @is_successful = false
    @error_message = e.message
  end
end