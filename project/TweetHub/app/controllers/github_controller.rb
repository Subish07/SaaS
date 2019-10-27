class GithubController < ApplicationController
  def index
	if !Repository.first.nil?
		@reposits=Repository.all 
	else
		myrepo
		redirect_to action: "index"
	end
  end
  private
   def myrepo
	require 'github_api'

	github = Github.new

	repos_from_github = github.repos.list(user: 'Subish07')

	repos_from_github.each do |repo|
	  @dept=Repository.new(name: repo.name,url: repo.svn_url,stars: repo.stargazers_count)
	  @dept.save!
	end
   end
  
end
