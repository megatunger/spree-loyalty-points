shared_examples_for "LoyaltyPoints" do
  describe 'loyalty_points_for' do
    context "when purpose is to award" do
      context "when eligible for being awarded" do
        let(:amount) { 50 }

        before do
          allow(resource_instance).to receive(:eligible_for_loyalty_points?).with(amount).and_return(true)
        end

        it "returns award amount" do
          expect(resource_instance.loyalty_points_for(amount, 'award')).to eq((amount * SpreeLoyaltyPoints::Config.loyalty_points_awarding_unit).floor)
        end
      end

      context "when ineligible for being awarded" do
        let(:amount) { 0 }

        before do
          allow(resource_instance).to receive(:eligible_for_loyalty_points?).with(amount).and_return(false)
        end

        it "returns 0" do
          expect(resource_instance.loyalty_points_for(amount, 'award')).to eq(0)
        end
      end
    end

    context "when purpose is to redeem" do
      it "returns redeem amount" do
        expect(resource_instance.loyalty_points_for(50, 'redeem')).to eq((50 / SpreeLoyaltyPoints::Config.loyalty_points_conversion_rate).ceil)
      end
    end

    context "when purpose is neither to redeem nor award" do
      it "returns 0" do
        expect(resource_instance.loyalty_points_for(50, 'other')).to eq(0)
      end
    end
  end

  describe 'eligible_for_loyalty_points?' do
    before do
      allow(SpreeLoyaltyPoints::Config).to receive(:min_amount_required_to_get_loyalty_points).and_return(30)
    end

    context "when amount greater than min amount" do
      it "returns true" do
        expect(resource_instance.send(:eligible_for_loyalty_points?, 40)).to be_truthy
      end
    end

    context "when amount less than redeeming balance" do
      it "returns false" do
        expect(resource_instance.send(:eligible_for_loyalty_points?, 20)).to be_falsey
      end
    end

    context "when amount equal to redeeming balance" do
      it "returns false" do
        expect(resource_instance.send(:eligible_for_loyalty_points?, 30)).to be_truthy
      end
    end
  end
end
