module Api::V1
  class IdeasController < ApplicationController
    def index
      @ideas = Idea.all.order(created_at: :desc);
      render json: @ideas
    end

    def create
      idea = Idea.create(idea_params)
      render json: idea
    end

    def update
      idea = Idea.find_by(id: params[:id])
      idea.update(idea_params)
      render json: idea
    end

    private
    def idea_params
      params.require(:idea).permit(:title, :body)
    end
  end
end
