class TradesController < ApplicationController
  def index
    TradeSearch::Operation::Search.run(params[:filter] || {}) do |op|
      @form = op.contract
      @filter = op.model
      @trades = @filter.run.page(params[:page]).per(1000) and return
    end

    render inline: 'Data is not valid. Please try again.'
  end
end
