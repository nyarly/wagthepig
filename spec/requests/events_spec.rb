RSpec.describe "Events", type: :request do
  describe "GET /events" do
    it "simple success" do
      get events_path
      expect(response).to have_http_status(200)
    end
  end
end
