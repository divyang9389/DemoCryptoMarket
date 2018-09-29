class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :authenticate_user!

  %w(google).each do |provider|
    define_method provider do
      auth = request.env['omniauth.auth']
      unless identity = Identity.find_from_omniauth(auth)
        user = User.from_omniauth(auth)
        identity = Identity.create_from_omniauth(auth, user)
      end

      if identity.user.persisted?
        flash[:success] = 'Signed in successfully.'
        sign_in_and_redirect identity.user
      else
        redirect_to new_user_registration_url
      end
    end
  end

  def failure
    redirect_to root_path
  end
end