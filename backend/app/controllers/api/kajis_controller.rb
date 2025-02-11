module Api
    class KajisController < ApplicationController
      # GET /api/kajis
      def index
        kajis = Kaji.order(created_at: :desc)
        render json: kajis
      end
  
      # POST /api/kajis
      def create
        kaji = Kaji.new(kaji_params)
        if kaji.save
          render json: kaji, status: :created
        else
          render json: { errors: kaji.errors.full_messages }, status: :unprocessable_entity
        end
      end
  
      private
  
      def kaji_params
        params.permit(:title, :content, :points)
      end
    end
  end