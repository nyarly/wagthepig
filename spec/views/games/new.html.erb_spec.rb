RSpec.describe "games/new", type: :view do
  before(:each) do
    assign(:game, create(:game))
  end

  it "renders successfully" do
    expect{render}.not_to raise_error
  end
end
