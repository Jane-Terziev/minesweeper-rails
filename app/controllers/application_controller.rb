require 'util/contract_validator'

class ApplicationController < ActionController::Base
  def initialize(contract_validator: ContractValidator.new)
    super()
    @contract_validator = contract_validator
  end

  def page_params
    params.permit(:page, :page_size)
  end

  def sort_params
    params.permit(:sort, :direction)
  end

  def page_request
    page_params_hash = page_params
    page_params_hash[:page] = page_params_hash[:page].try(&:to_i)
    page_params_hash[:page_size] = page_params_hash[:page_size].try(&:to_i)
    page_params_hash[:page] = 1 unless page_params_hash[:page]
    page_params_hash[:page_size] = 10 unless page_params_hash[:page]

    page_params_hash
  end
end
