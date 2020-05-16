class TagsController < ApplicationController
    before_action :authenticate_user

    def index
        @tags = Tag.search(params[:search])
    end

    def show
        @tag = Tag.find_by(name: params[:name])
        @posts = @tag.posts
    end
end