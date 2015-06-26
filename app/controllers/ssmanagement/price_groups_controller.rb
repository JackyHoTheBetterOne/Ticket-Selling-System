class Ssmanagement::PriceGroupsController < ApplicationController
  def create
    @group = PriceGroup.create(price: params[:price].to_f)
    render json: @group
  end
end
