class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    orders = current_user.is_admin ? Order.joins(order_items: :product).order(id: :desc).distinct : Order.none
    if params[:filter_name].present?
      orders = orders.joins(:user).where("users.name LIKE '%#{params[:filter_name]}%'")
    end
    if params[:filter_status]
      orders = orders.where(status: params[:filter_status])
    end
    
    @pagy, @orders = pagy(orders, items: 10)
  end

  def edit
    @order = Order.find_by(id: params[:id])
  end

  def update
    @order = Order.find_by(id: params[:id])
    if @order.update(order_params)
      redirect_to orders_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:id, :status)
  end
end
