class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    @clubs = Beerclub.all.reject { |club| current_user.in? club.members } #kaikki klubit, joihin ei vielä kuulu
    # @clubs = Beerclub.all.select { |club| current_user.in? club.members } #kaikki, joihin kuuluu
    # @clubs = Beerclub.all
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    # @membership = Membership.new params.require(:membership).permit(:beerclub_id, :user_id) #(membership_params)
    @membership = Membership.new(membership_params)
    club = Beerclub.find membership_params[:beerclub_id]

    if not current_user.in? club.members and @membership.save
      current_user.memberships << @membership
      @membership.save
      # if new_membership_path
      #   redirect_to @membership.user, notice: "You've joined to #{@membership.beerclub.name}"
      redirect_to beerclub_path(club), notice: "#Welcome to #{@membership.beerclub.name}"
      # else
      #   redirect_to @beerclub, notice: "#{current_user.username}, welcome to the club"
      # end
    else
      @clubs = Beerclub.all
      render :new
    end

    # respond_to do |format|
    #   if current_user.clubs.select{|m| m.id == params[:membership][:beerclub_id].to_i}.empty? #@membership.beerclub_id
    #     if @membership.save
    #       format.html { redirect_to memberships_path, notice: 'Membership was successfully created.' }
    #       format.json { render :show, status: :created, location: @membership }
    #     else
    #       @clubs = Beerclub.all
    #       @users = User.all
    #       # Membership.last.delete
    #       format.html { redirect_to new_membership_path, notice: 'You are already in this beerclub! Choose another one.' } # render :new
    #       format.json { render json: @membership.errors, status: :unprocessable_entity }
    #     end
    #   else
    #     @clubs = Beerclub.all
    #     @users = User.all
    #     # Membership.last.delete
    #     format.html { redirect_to new_membership_path, notice: 'You are already in this beerclub! Choose another one.' } # render :new
    #     format.json { render json: @membership.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to user_path(@membership.user), notice: "Membership was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @membership = Membership.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def membership_params
    params.require(:membership).permit(:beerclub_id)
  end
end
