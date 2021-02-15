class SubsController < ApplicationController

    def index
        @subs = Sub.all 
        render :index
    end

    def show
        @sub = Sub.find(params[:id])
        render :show
    end

    def new
        @sub = Sub.new
        render :new
    end

    def create
        @sub = Sub.new(sub_params)
        if @sub.save
            redirect_to subs_url
            
        end
    end
    
    private

    def sub_params
        params.require(:sub).permit(:title, :description, :modera)
    end

end
