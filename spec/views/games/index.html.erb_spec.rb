RSpec.describe "games/index", type: :view do
  before(:each) do
    assign(:games, [
      Game.create!(
        :name => "MyText",
        :min_players => 2,
        :max_players => 3,
        :bgg_link => "MyText",
        :duration_secs => ""
      ),
      Game.create!(
        :name => "MyText",
        :min_players => 2,
        :max_players => 3,
        :bgg_link => "MyText",
        :duration_secs => ""
      )
    ])
  end

  it "renders a list of games" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
