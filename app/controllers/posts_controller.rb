class PostsController < ApplicationController

    def index
        @posts = Post.all.order(created_at: :desc)
        @post = Post.new(flash[:post])
    end

    def new
        @post = Post.new(flash[:post])
    end
    
    def create
        post = Post.new(post_params)
        post.user_id = @current_user.id
        binding.pry
        if post.save
            flash[:notice] = "投稿が完了しました"
            redirect_to posts_path
        else
            redirect_to new_post_path, flash: {
                post: post,
                error_messages: post.errors.full_messages
            }
        end
    end

    def show
        set_target_post
        @repries = Repry.where(post_id: @post.id)
        @repry = Repry.new(post_id: @post.id)
        @like = Like.new
    end

    def destroy
        set_target_post
        @post.destroy
        redirect_to posts_path, flash: { notice: "投稿が削除されました" }
    end 
    
    def update
        set_target_post
        if @post.update(post_params)
            redirect_to @post
        else
            render 'posts/edit'
        end
    end

    private

    def post_params
        params.require(:post).permit(:content)
    end

    def set_target_post
        @post = Post.find(params[:id])
    end

end 