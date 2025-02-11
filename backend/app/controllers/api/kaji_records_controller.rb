module Api
    class KajiRecordsController < ApplicationController
      # GET /api/kaji_records
      def index
        records = KajiRecord.joins(:user, :kaji)
                             .select('kaji_records.*, users.name as user_name, kajis.title as kaji_title')
                             .order(performed_date: :desc)
        render json: records
      end
  
      # POST /api/kaji_records
      def create
        record = KajiRecord.new(record_params)
        if record.save
          render json: record, status: :created
        else
          render json: { errors: record.errors.full_messages }, status: :unprocessable_entity
        end
      end
  
      private
  
      def record_params
        params.permit(:user_id, :kaji_id, :performed_date)
      end
    end
  end