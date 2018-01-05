module Api::V1
  class IdeasController < ApplicationController
    def index
      @ideas = Idea.all.order(created_at: :desc).page(params[:page].to_i).per(6);
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

    def destroy
      idea = Idea.find(params[:id])
      if idea.destroy
        head :no_content, status: :ok
      else
        render json: @idea.errors, status: :unprocessable_entity
      end
    end

    def search
      @ideas = Idea.where('title LIKE ?', "%#{params[:keyword]}%")
      render json: @ideas
    end

    private
    def idea_params
      params.require(:idea).permit(:title, :body)
    end
  end
end
