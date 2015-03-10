module Starburst
	class AnnouncementsController < ApplicationController
		def mark_as_read
			announcement = Announcement.find(params[:id])
			if respond_to?(Starburst.current_user_method) && send(Starburst.current_user_method) && announcement
				if AnnouncementView.where(user_id: send(Starburst.current_user_method), announcement_id: announcement).first_or_create do |anon|
					user_id = send(Starburst.current_user_method)
					announcement_id = announcement
				end
				render :json => :ok
			else
				render json: nil, :status => :unprocessable_entity
			end
		else
			render json: nil, :status => :unprocessable_entity
		end
	end
end