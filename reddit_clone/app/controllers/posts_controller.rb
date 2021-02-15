class PostsController < ApplicationController

    def show
        @posts = Post.all
        render :show
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    


    private

    def post_params
        params.require(:post).permit(:title, :content, :sub_id, :author_id)
    end
end
