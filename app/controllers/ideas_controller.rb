class IdeasController < ApplicationController
  def create
    idea = Idea.create(idea_params)
  end

  private
  def idea_params
    params.require(idea).permit(:title, :body)
  end
end
