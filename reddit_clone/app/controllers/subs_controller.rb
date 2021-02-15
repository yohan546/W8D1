class SubsController < ApplicationController
    before_action :require_signed_in!, except: [:show, :index]
    before_action :require_moderator, only: [:edit, :update]

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
    end

    def create
        @sub = Sub.new(sub_params)

        if @sub.save
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages 
            render :new 
        end
    end

    def edit 
        @sub = Sub.find(params[:id])
    end

    def update
        @sub = Sub.find(params[:id])
        if @sub.update(sub_params)
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :edit
        end
    end
    
    private

    def sub_params
        params.require(:sub).permit(:title, :description)
    end

    def require_moderator 
        @sub = Sub.find_by(id: params[:id])
        redirect_to sub_url(@sub) unless current_user.id == @sub.moderator
    end
end
