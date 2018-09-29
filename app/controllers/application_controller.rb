class ApplicationController < ActionController::Base
  # filter method
  before_action :authenticate_user!

  # it will envoke on every request and set layout on that base.
  layout :layout_by_resource

  private

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end
