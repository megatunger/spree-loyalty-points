# frozen_string_literal: true

require 'spec_helper'

describe Spree::Admin::LoyaltyPointsTransactionsController, type: :controller do
  let(:user) { mock_model(Spree.user_class).as_null_object }
  let(:loyalty_points_transaction) { mock_model(Spree::LoyaltyPointsCreditTransaction).as_null_object }
  let(:order) { mock_model(Spree::Order).as_null_object }

  before do
    @routes = Spree::Core::Engine.routes
    allow(controller).to receive(:spree_current_user).and_return(user)
    allow(user).to receive(:generate_spree_api_key!).and_return(true)
    allow(controller).to receive(:authorize!).and_return(true)
    allow(controller).to receive(:authorize_admin).and_return(true)
    allow(user.loyalty_points_transactions).to receive(:create).and_return(loyalty_points_transaction)
    allow(controller).to receive(:parent_data).and_return({ model_name: 'spree/order', model_class: Spree::Order, find_by: 'id' })
  end

  def default_host
    { host: "http://test.host" }
  end

  describe "set_user callback" do
    it "is included in before action callbacks" do
      expect(Spree::Admin::LoyaltyPointsTransactionsController._process_action_callbacks.select{ |callback| callback.kind == :before }.map(&:filter).include?(:set_user)).to be_truthy
    end
  end

  describe "set_ordered_transactions callback" do
    it "is included in before action callbacks" do
      expect(Spree::Admin::LoyaltyPointsTransactionsController._process_action_callbacks.select{ |callback| callback.kind == :before }.map(&:filter).include?(:set_ordered_transactions)).to be_truthy
    end
  end

  context "when user found" do
    before do
      allow(controller).to receive(:parent).and_return(user)
      allow(Spree.user_class).to receive(:find_by).and_return(user)
    end

    describe "GET 'index'" do
      def send_request(params = {})
        get :index, params: params.merge!(user_id: "1")
      end

      context 'with successful response' do
        before { send_request }

        it "assigns loyalty_points_transactions" do
          expect(assigns[:loyalty_points_transactions]).not_to be_nil
        end

        it "renders index template" do
          expect(response).to render_template(:index)
        end
      end

      context 'with correct method flow' do
        after { send_request }

        it "user should receive loyalty_points_transactions" do
          expect(user).to receive(:loyalty_points_transactions)
        end
      end
    end

    describe "POST 'create'" do
      def send_request(params = {})
        post :create, params: params.merge!(loyalty_points_transaction: attributes_for(:loyalty_points_transaction), order_id: order.id, user_id: "1")
      end

      before do
        allow(controller).to receive(:load_resource_instance).and_return(loyalty_points_transaction)
      end

      it "assigns @loyalty_points_transaction" do
        send_request
        expect(assigns[:loyalty_points_transaction]).not_to be_nil
      end

      it "@loyalty_points_transaction should receive save" do
        expect(loyalty_points_transaction).to receive(:save)
        send_request
      end

      context "when transaction created " do
        before do
          allow(controller).to receive(:parent).and_return(user)
          controller.instance_variable_set(:@parent, user)
          send_request
        end

        it "redirects to admin users loyalty points page" do
          expect(response).to redirect_to(admin_user_loyalty_points_url(user, default_host))
        end
      end

      context "when transaction failed " do
        before do
          allow(controller).to receive(:load_resource_instance).and_return(loyalty_points_transaction)
          allow(loyalty_points_transaction).to receive(:save).and_return(false)
        end

        it "renders new template" do
          send_request(loyalty_points_transaction: attributes_for(:loyalty_points_credit_transaction), user_id: "1")
          expect(response).to render_template(:new)
        end
      end
    end
  end

  context "when user not found" do
    before do
      allow(Spree.user_class).to receive(:find_by).and_return(nil)
      allow(controller).to receive(:parent).and_raise(ActiveRecord::RecordNotFound)
    end

    it "redirects to user's loyalty points page" do
      get :index, params: { user_id: "1" }
      expect(response).to redirect_to(admin_users_path)
    end
  end

  describe "collection_url" do
    context "when parent_data is present" do
      before do
        allow(controller).to receive(:parent_data).and_return({ model_name: 'spree/order', model_class: Spree::Order, find_by: 'id' })
      end

      context "when parent is nil" do
        before do
          controller.instance_variable_set(:@parent, nil)
        end

        it "returns admin_users_url" do
          expect(controller.send(:collection_url)).to eq(admin_users_url(default_host))
        end
      end

      context "when parent is not nil" do
        before do
          controller.instance_variable_set(:@parent, user)
        end

        it "returns admin_users_url" do
          expect(controller.send(:collection_url)).to eq(admin_user_loyalty_points_url(user, default_host))
        end
      end
    end

    context "when parent_data is absent" do
      before do
        allow(controller).to receive(:parent_data).and_return({})
      end

      it "returns admin_users_url" do
        expect(controller.send(:collection_url)).to eq(admin_users_url(default_host))
      end
    end
  end

  describe "association_name" do
    let(:class_name) { Spree::LoyaltyPointsDebitTransaction }

    it "receives gsub on klass" do
      expect(class_name).to receive(:gsub).with('Spree::', '').and_return('LoyaltyPointsDebitTransaction')
      controller.send(:association_name, class_name)
    end
  end

  describe "build_resource" do
    context "when params[:loyalty_points_transaction][:type] is present" do
      before do
        allow(controller).to receive(:params).and_return({ loyalty_points_transaction: { type: 'Spree::LoyaltyPointsCreditTransaction' } })
        allow(controller).to receive(:parent).and_return(user)
        allow(controller).to receive(:association_name).and_return("loyalty_points_credit_transactions")
      end

      it "receives send on parent" do
        expect(user).to receive(:send).with("loyalty_points_credit_transactions")
        controller.send(:build_resource)
      end
    end

    context "when params[:loyalty_points_transaction][:type] is absent" do
      before do
        allow(controller).to receive(:params).and_return({})
        allow(controller).to receive(:parent).and_return(user)
        allow(controller).to receive(:controller_name).and_return("loyalty_points_transactions")
      end

      it "receives send on parent" do
        expect(user).to receive(:send).with("loyalty_points_transactions")
        controller.send(:build_resource)
      end
    end
  end

  describe "GET 'order_transactions'" do
    render_views
    def send_request(params = {})
      get :order_transactions, params: params.merge!(loyalty_points_transaction: attributes_for(:loyalty_points_transaction), order_id: order.id, user_id: "1")
    end

    before do
      allow(Spree::Order).to receive(:find_by).and_return(order)
      @user = double(Spree.user_class)
      allow(Spree.user_class).to receive(:find_by).and_return(@user)
      @loyalty_points_transactions = double(Spree::LoyaltyPointsCreditTransaction)
      allow(Spree.user_class).to receive(:find_by).and_return(@user)
      allow(@user).to receive_message_chain(:loyalty_points_transactions, :for_order, :includes, :order).and_return([@loyalty_points_transactions])
    end

    context "when user is found" do
      before do
        allow(controller).to receive(:parent).and_return(user)
        send_request
      end

      it "redirect_toes admin_users_path" do
        expect(response).not_to redirect_to(admin_users_path)
      end

      it "assigns @loyalty_points_transactions" do
        expect(assigns[:loyalty_points_transactions]).not_to be_nil
      end

      it "is http success" do
        expect(response).to be_success
      end
    end

    context "when user is not found" do
      before do
        allow(Spree.user_class).to receive(:find_by).and_return(nil)
        send_request
      end

      it "redirect_toes admin_users_path" do
        expect(response).to redirect_to(admin_users_path)
      end
    end
  end
end
