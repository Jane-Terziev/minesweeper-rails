class BoardsController < ApplicationController
  def initialize(board_service: BoardService.new, board_read_service: BoardReadService.new)
    super()
    @board_service = board_service
    @board_read_service = board_read_service
  end

  def home
    @boards = @board_read_service.get_recent_boards
    @table_headers = [
        { label: 'Name' },
        { label: 'Email' },
        { label: 'Generated At' }
    ]
  end

  def index
    @pagy, @boards = @board_read_service.get_boards(order_params: order_params, page_request: page_request)
    @table_headers = [
        { label: 'Name', sort_column: 'name' },
        { label: 'Email', sort_column: 'email' },
        { label: 'Width', sort_column: 'width' },
        { label: 'Height', sort_column: 'height' },
        { label: 'Bombs', sort_column: 'bombs' }
    ]
  end

  def new
    @board = Board.new
  end

  def create
    whitelisted_params = @contract_validator.validate(board_params.to_h, CreateBoardContract.new)
    board = @board_service.create_board(whitelisted_params)

    flash[:success_notice] =  "Board created successfully."
    redirect_to board_path(board)
  rescue ConstraintError => e
    @board = Board.new(board_params.to_h)
    flash[:form_error_notice] = e.messages
    render :new, status: Http::STATUS_UNPROCESSABLE_ENTITY
  end

  def show
    @board = @board_read_service.get_board_by_id(id: params[:id])
  end

  private

  def board_params
    params.require(:board).permit!
  end

  def order_params
    valid_sort_params = @contract_validator.validate(sort_params.to_h, GetBoardsQueryContract.new)
    valid_sort_params[:sort] = 'created_at' unless valid_sort_params[:sort]
    valid_sort_params[:direction] = 'desc' unless valid_sort_params[:direction]
    { valid_sort_params[:sort] => valid_sort_params[:direction] }

  rescue ConstraintError => e
    params.delete(:sort)
    params.delete(:direction)
    flash[:error_notice] = e.messages
    index
    render :index, error_notice: e.messages and return
  end
end
