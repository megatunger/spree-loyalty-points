require "spec_helper"

describe SpreeLoyaltyPoints::Config do

  it "should set preference min_amount_required_to_get_loyalty_points"  do
    expect(SpreeLoyaltyPoints::Config.min_amount_required_to_get_loyalty_points).to eq(20.0)
  end

  it "should set preference loyalty_points_awarding_unit"  do
    expect(SpreeLoyaltyPoints::Config.loyalty_points_awarding_unit).to eq(0.0)
  end

  it "should set preference loyalty_points_redeeming_balance"  do
    expect(SpreeLoyaltyPoints::Config.loyalty_points_redeeming_balance).to eq(50)
  end

  it "should set preference loyalty_points_conversion_rate"  do
    expect(SpreeLoyaltyPoints::Config.loyalty_points_conversion_rate).to eq(5.0)
  end

  it "should set preference loyalty_points_award_period"  do
    expect(SpreeLoyaltyPoints::Config.loyalty_points_award_period).to eq(1)
  end

end
