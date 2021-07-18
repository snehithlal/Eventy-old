# frozen_string_literal: true

module Api
  module V1
    class FriendListsController < ApiController
      # GET - returns all connected friends
      def index
        friends = @current_user.friends_list
        render json: UserSerializer.render_as_json(friends, root: :user, view: :profile_details),
               status: 200
      end

      # POST - new friend request
      def create
      end

      # DELETE - reject friend request / Unfriend
      def destroy
      end

      # GET - accept friend request
      def accept
      end

      # GET - search in friends list
      def search
      end

      private

      def friend_list_params
        params.require(:friend_list).permit(:acceptor_id, :status)
      end
    end
  end
end
