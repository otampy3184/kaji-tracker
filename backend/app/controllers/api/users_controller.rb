module Api
    class UsersController < ApplicationController
      # GET /api/users
      def index
        users = User.order(created_at: :desc)
        render json: users
      end
  
      # POST /api/users
      def create
        user = User.find_or_initialize_by(uid: params[:uid])
        user.assign_attributes(user_params)
        if user.save
          render json: user, status: user.persisted? ? :ok : :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end
  
      private
  
      def user_params
        params.permit(:uid, :name, :email, :photo_url)
      end
    end
  end