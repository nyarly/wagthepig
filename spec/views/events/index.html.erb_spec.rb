require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        :name => "MyText",
        :where => "MyText"
      ),
      Event.create!(
        :name => "MyText",
        :where => "MyText"
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
