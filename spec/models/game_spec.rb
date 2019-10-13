RSpec.describe Game, type: :model do
  it "only includes appropriate games in with_interest scope" do
    interesting, uninteresting = create_list(:game, 2)
    interesting.users << create(:user)

    expect(Game.with_interest.all.to_a.size).to eq(1)
  end

  it "allows us to join interests back to games" do
    interesting, uninteresting = create_list(:game, 2)
    interesting.users << create_list(:user, 3)

    expect(Game.with_interest.includes(:users).first.users.count).to eq(3)
  end
end
