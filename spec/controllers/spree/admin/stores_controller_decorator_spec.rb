require 'spec_helper'

describe Spree::Admin::StoresController, type: :controller do
  let(:user) { mock_model(Spree.user_class).as_null_object }
  let(:store) { create(:store) }

  before do
    allow(controller).to receive(:spree_current_user).and_return(user)
    allow(user).to receive(:generate_spree_api_key!).and_return(true)
    allow(controller).to receive(:authorize!).and_return(true)
    allow(controller).to receive(:authorize_admin).and_return(true)
  end

  describe "set_loyalty_points_settings callback" do
    it "is included in before action callbacks" do
      expect(Spree::Admin::StoresController._process_action_callbacks.select{ |callback| callback.kind == :before }.map(&:filter)).to include(:set_loyalty_points_settings)
    end
  end

  describe "GET 'edit'" do
    def send_request
      get :edit, params: { id: store.id }
    end

    before do
      send_request
    end

    it "assigns @preferences_loyalty_points" do
      expect(assigns[:preferences_loyalty_points]).to eq(
        {
          min_amount_required_to_get_loyalty_points: [""],
          loyalty_points_awarding_unit: ["For example: Set this as 10 if we wish to award 10 points for $1 spent on the site."],
          loyalty_points_redeeming_balance: [""],
          loyalty_points_conversion_rate: ["For example: Set this value to 5 if we wish 1 loyalty point is equivalent to $5"],
          loyalty_points_award_period: [""]
        }
      )
    end

    it "renders edit template" do
      expect(response).to render_template(:edit)
    end
  end
end
