
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

  it "renders successfully" do
    expect{render}.not_to raise_error
  end
end
