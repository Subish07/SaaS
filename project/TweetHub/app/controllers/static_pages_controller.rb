class StaticPagesController < ApplicationController
  def index
	Repository.delete_all
	Tweet.delete_all
  end
end
