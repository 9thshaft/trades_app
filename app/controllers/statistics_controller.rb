class StatisticsController < ApplicationController
  def show
    operation = Statistics::Operation::Collect.run(params[:filter] || {}) do |op|
      @form = op.contract
      @filter = op.model
      @stats = @filter.run and return
    end

    render text: operation.errors.full_messages.join(' ')
  end
end
