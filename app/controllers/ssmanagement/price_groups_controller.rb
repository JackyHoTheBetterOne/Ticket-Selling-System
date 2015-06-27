class Ssmanagement::PriceGroupsController < ApplicationController
  def create
    @group = PriceGroup.create(price: params[:price].to_f,
                                event_id: params[:event_id].to_i)
    render json: @group
  end

  def destroy
    @group = PriceGroup.find(params[:id])
    @group.destroy
    render text: "success"
  end

end
