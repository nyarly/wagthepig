require 'rails_helper'

RSpec.describe "games/edit", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      :name => "MyText",
      :min_players => 1,
      :max_players => 1,
      :bgg_link => "MyText",
      :duration_secs => ""
    ))
  end

  it "renders the edit game form" do
    render

    assert_select "form[action=?][method=?]", game_path(@game), "post" do

      assert_select "textarea[name=?]", "game[name]"

      assert_select "input[name=?]", "game[min_players]"

      assert_select "input[name=?]", "game[max_players]"

      assert_select "textarea[name=?]", "game[bgg_link]"

      assert_select "input[name=?]", "game[duration_secs]"
    end
  end
end
