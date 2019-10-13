module ControllerMacros
  def login_user
    let :logged_in_user do
      FactoryBot.create(:user)
    end

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      #user.confirm! # or set a confirmed_at inside the factory. Only necessary
      #if you are using the "confirmable" module
      sign_in logged_in_user
    end
  end
end
