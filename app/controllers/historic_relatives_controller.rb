class HistoricRelativesController < ApplicationController
    layout 'internal'
    before_action :authenticate_user!
  before_action :block_crossprofile_access
  before_action :recover_profile
    def index
    end
    def create
    end
    def new
    end
    def edit
        
    end

end
