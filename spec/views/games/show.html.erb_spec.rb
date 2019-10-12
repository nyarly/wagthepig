RSpec.describe "games/show", type: :view do
  before(:each) do
    @game = assign(:game, create(:game))
  end

  it "renders successfully" do
    expect{render}.not_to raise_error
  end
end
