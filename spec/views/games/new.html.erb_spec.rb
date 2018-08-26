require 'rails_helper'

RSpec.describe "games/new", type: :view do
  before(:each) do
    assign(:game, Game.new(
      :name => "MyText",
      :min_players => 1,
      :max_players => 1,
      :bgg_link => "MyText",
      :duration_secs => ""
    ))
  end

  it "renders new game form" do
    render

    assert_select "form[action=?][method=?]", games_path, "post" do

      assert_select "textarea[name=?]", "game[name]"

      assert_select "input[name=?]", "game[min_players]"

      assert_select "input[name=?]", "game[max_players]"

      assert_select "textarea[name=?]", "game[bgg_link]"

      assert_select "input[name=?]", "game[duration_secs]"
    end
  end
end
