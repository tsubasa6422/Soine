class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    
def after_sign_in_path_for(resource)
  if resource.is_a?(Admin)
    admin_root_path
  else
    mypage_path
  end
end

def after_sign_out_path_for(resource_or_scope)
  if resource_or_scope == :admin
    new_admin_session_path
  else
    root_path
  end
end




  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :area_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :area_id, :introduction, :profile_image])
  end
end
