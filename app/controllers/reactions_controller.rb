# frozen_string_literal: true

class ReactionsController < ApplicationController
  layout 'internal'
  
  before_action :authenticate_user!
  before_action :block_crossprofile_access
  before_action :recover_profile

  def index
    @reactions = @profile.reactions
  end

  def new; end

  def edit
    @reaction = Reaction.find(params[:id])
  end

  def create
    @reaction = Reaction.new(reaction_params)

    @reaction.profile = @profile

    if @reaction.save
      flash[:success] = 'Adverse Reaction registered sucessfully'
      redirect_to profile_reactions_path(profile_email: @profile.email)
    else
      render 'new'
    end
    end

  def update
    @reaction = Reaction.find(params[:id])

    if @reaction.update(reaction_params)
      flash[:success] = 'Adverse Reaction updated sucessfully'
      redirect_to profile_reactions_path(profile_email: @reaction.profile.email)
    else
      render 'edit'
    end
  end

  def destroy
    @reaction = Reaction.find(params[:id])

    profile_email = @reaction.profile.email

    @reaction.destroy

    redirect_to profile_reactions_path(profile_email: profile_email)
  end

  private

  def reaction_params
    params.require(:reaction).permit(:name, :cause, :description, :start, :finish)
  end
end
