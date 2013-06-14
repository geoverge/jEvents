class HallsController < ApplicationController

  before_filter :get_venue

  def get_venue
    @venue = Venue.find(params[:venue_id])
  end

  def index
    @halls = @venue.halls.all
    @hall = Hall.new  # ???
    
    respond_to do |format|
      format.js
    end
  end

  def show
    @hall = Hall.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: [@venue, @hall] }
    end
  end

  def new
    @hall = Hall.new
    
    respond_to do |format|
      format.js
    end
  end

  def edit
    @hall = Hall.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def create
    @hall = Hall.new(params[:hall])
    @hall.venue_id = @venue.id

    respond_to do |format|
      if @hall.save
        format.html { redirect_to edit_venue_path(@venue) }
        format.json { render json: [@venue, @hall], status: :created, location: @hall } #To BE UPDATED
      else
        format.html { render action: "new" }
        format.json { render json: @hall.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @hall = Hall.find(params[:id])

    respond_to do |format|
      if @hall.update_attributes(params[:hall])
        format.html { redirect_to edit_venue_path(@venue) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hall.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @hall = Hall.find(params[:id])
    @hall.destroy

    respond_to do |format|
      format.html { redirect_to halls_url }
      format.json { head :no_content }
    end
  end
end
