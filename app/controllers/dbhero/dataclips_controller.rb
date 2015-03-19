require_dependency "dbhero/application_controller"

module Dbhero
  class DataclipsController < ApplicationController
    before_action :set_dataclip, only: [:show, :edit, :update, :destroy]
    respond_to :html

    # GET /dataclips
    def index
      @dataclips = Dataclip.all
    end

    # GET /dataclips/1
    def show
      Dataclip.transaction do
        @result = ActiveRecord::Base.connection.select_all("select sub.* from (#{@dataclip.raw_query}) sub limit 1000")
        raise ActiveRecord::Rollback
      end
    end

    # GET /dataclips/new
    def new
      @dataclip = Dataclip.new
    end

    # GET /dataclips/1/edit
    def edit
    end

    # POST /dataclips
    def create
      @dataclip = Dataclip.create(dataclip_params)
      respond_with @dataclip, notice: 'Dataclip was successfully created.'
    end

    # PATCH/PUT /dataclips/1
    def update
      @dataclip.update(dataclip_params)
      respond_with @dataclip, notice: 'Dataclip was successfully updated.'
    end

    # DELETE /dataclips/1
    def destroy
      @dataclip.destroy
      redirect_to dataclips_url, notice: 'Dataclip was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_dataclip
        @dataclip = Dataclip.find_by_token(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def dataclip_params
        params.require(:dataclip).permit(:description, :raw_query)
      end
  end
end