require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
  describe "GET /index" do
    let(:order_params) { { created_at: 'desc' } }
    let(:page_request) { { page: 1, page_size: 10 } }

    context "when there are no boards" do
      it 'should render the index template' do
        get :index
        expect(response.status).to eq(Http::STATUS_OK)
        expect(response).to render_template :index
        expect(assigns[:boards]).to eq([])
      end
    end

    context "when there are boards" do
      it 'should render the index template' do
        create_list(:board, 2)
        _, boards = BoardReadService.new.get_boards(order_params: order_params, page_request: page_request)
        get :index
        expect(response.status).to eq(Http::STATUS_OK)
        expect(response).to render_template :index

        expect(assigns[:boards]).to eq(boards)
        expect(assigns[:pagy].class).to eq(Pagy)
        expect(assigns[:sorting]).to be_truthy
      end
    end

    context "when the order params are invalid" do
      let(:sort) { { sort: "unknown" } }
      it 'should raise an constraint error and render index with flash' do
        get :index, params: sort

        expect(response.status).to eq(200)
        expect(response).to render_template :index
        # TODO: check flash
      end
    end
  end

  describe "GET /show" do
    context "when there is a board with that id" do
      let!(:id) { create(:board).id }

      it 'should render the show template' do
        get :show, params: { id: id }

        expect(response.status).to eq(Http::STATUS_OK)
        expect(response).to render_template :show
        expect(assigns[:board].id).to eq(id)
      end
    end
  end

  describe "GET /new" do
    context "when the new endpoint is called" do
      it 'should render the template' do
        get :new

        expect(response.status).to eq(Http::STATUS_OK)
        expect(response).to render_template :new
        expect(assigns[:board].new_record?).to be_truthy
      end
    end
  end

  describe "POST /create" do
    context "when params are valid" do
      let(:params) do
        {
            board: {
                name: 'name',
                email: 'email@example.com',
                width: 2,
                height: 2,
                bombs: 1
            }
        }
      end

      it 'should create a new board and redirect to index page' do
        post :create, params: params

        expect(response.status).to eq(302)
        expect(response).to redirect_to(boards_url)
        expect(Board.all.count).to eq(1)
      end
    end

    context "when params are invalid" do
      let(:params) do
        { board: { name: "name" } }
      end

      it 'should raise an constraint error and render new with invalid parameters' do
        post :create, params: params

        expect(response.status).to eq(Http::STATUS_UNPROCESSABLE_ENTITY)
        expect(response).to render_template :new
        expect(assigns[:board].new_record?).to be_truthy
        expect(assigns[:board].name).to eq(params[:board][:name])
      end
    end
  end

  describe "GET /home" do
    context "when there are no recent boards" do
      it 'should render template with no boards' do
        get :home

        expect(response.status).to eq(Http::STATUS_OK)
        expect(response).to render_template :home
        expect(assigns[:boards]).to eq([])
      end
    end

    context "when there are recent boards" do
      before do
        create_list(:board, 11)
      end

      it 'should render template with boards' do
        get :home
        result = BoardReadService.new.get_recent_boards
        expect(response.status).to eq(Http::STATUS_OK)
        expect(response).to render_template :home
        expect(assigns[:boards]).to eq(result)
        expect(assigns[:boards].size).to eq(10)
        expect(assigns[:sorting]).to be_falsey
      end
    end
  end
end
