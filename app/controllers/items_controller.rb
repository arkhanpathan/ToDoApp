# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy toggle_status assign assign_item]

  # GET /items
  def index
    @items = ItemsSearch.call(current_user, params)
  end

  # GET /items/1
  def show; end

  # GET /items/new
  def new
    @item = Item.new
    render turbo_stream: turbo_stream.replace('all_items', partial: 'items/form', locals: { item: @item })
  rescue StandardError => e
    flash[:alert] = "Error: #{e.message}"
    redirect_to items_url
  end

  # GET /items/1/edit
  def edit
    render turbo_stream: turbo_stream.replace('all_items', partial: 'items/form', locals: { item: @item })
  rescue StandardError => e
    flash[:alert] = "Error: #{e.message}"
    redirect_to items_url
  end

  # POST /items or /items.json
  def create
    @item = BuildItem.call(current_user,item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to items_url, notice: 'Item created successfully' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    flash[:alert] = "Error: #{e.message}"
    redirect_to items_url
  end

  # GET /items
  def show
    render turbo_stream: turbo_stream.replace('all_items', partial: 'items/show', locals: { item: @item })
  end

  # PATCH/PUT /items/1
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to items_url, notice: 'Item updated successfully' }
      else
        flash[:error] = 'unable to update item'
        redirect_to items_url, error: 'Item failed to update.'
      end
    end
  rescue StandardError => e
    flash[:alert] = "Error: #{e.message}"
    redirect_to items_url
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    if @item.destroy
      render turbo_stream: turbo_stream.remove("item_#{@item.id}")
    else
      flash[:error] = 'unable to update status'
      redirect_to items_url, error: 'Item failed to update.'
    end
  end

  def toggle_status
    if @item.toggle_status
      render turbo_stream: turbo_stream.replace("item_#{@item.id}", partial: 'items/item', locals: { item: @item })
    else
      flash[:error] = 'unable to update status'
      redirect_to items_url, error: 'Item failed to update.'
    end
  end

  # GET /items/1/assign
  def assign
    render turbo_stream: turbo_stream.replace('all_items', partial: 'items/assign', locals: { item: @item, users: User.not_admin })
  rescue StandardError => e
    flash[:alert] = "Error: #{e.message}"
    redirect_to items_url
  end
  
  # PATCH/PUT /items/1/assign_item
  def assign_item
    @item.assigned_items.destroy_all
    if @item.assigned_items.create(user_id: params[:user_id])
      redirect_to items_url, notice: 'Item successfully assigned'
    else
      flash[:error] = 'unable to assign item'
      redirect_to items_url, error: 'Item failed to assign.'
    end
  rescue StandardError => e
    flash[:alert] = "Error: #{e.message}"
    redirect_to items_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:title, :description, :start_date_time, :end_date_time, :status)
  end
end
