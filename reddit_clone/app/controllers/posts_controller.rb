class PostsController < ApplicationController
    # before_action :require_author, only: [:edit, :update]
    # before_action :require_signed_in! except: [:show]


    def show
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new
    end

    def create
        @post = current_user.posts.new(post_params)
        if @post.save
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update 
        @post = Post.find(params[:id])

        if @post.update(post_params)
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages
            render :edit 
        end
    end

    


    private

    def post_params
        params.require(:post).permit(:title, :content, :sub_id, :author_id)
    end

    def require_author 
        @post = Post.find_by(id: params[:id])
        redirect_to post_url(@post) unless current_user.id == @post.author_id
    end
end
