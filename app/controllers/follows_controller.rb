class FollowsController < ApplicationController
	def create




    Follow.create(follower_id: current_user.id, following_id: params[:user_id] )

    
    redirect_to user_path(current_user)

	end

	def following
	@following	=current_user.following 
		
	end
	def follower
	@followers	=current_user.followers 
		
	end
end
