# frozen_string_literal: true

module Api
  module V1
    # transfer list and trading controller
    class TransferListController < ApplicationController
      def index
        records = Player.on_transfer_list
        render json: records
      end
    end
  end
end
