class TicketPackageDecorator
  attr_reader :package

  def initialize(package)
    @package = package
  end

  def self.collection(packages)
    package_collection = []
    packages.each do |p|
      package_collection << self.new(p)
    end

    return package_collection
  end

  def ticekt_count
    self.tickets.count
  end

  def seat_array
    arr = []
    self.seats.each do |s|
      arr << s.name
    end
    return arr
  end



  def method_missing(method_name, *args, &block)
    package.send(method_name, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    package.respond_to?(method_name, include_private) || super
  end


end
