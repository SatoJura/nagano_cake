class ApplicationController < ActionController::Base
  before_action :authenticate_customer!,except: [:top, :about], if: :use_before_action?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if current_admin
      flash[:notice] = "管理者ログインに成功しました"
      admin_path
    else
      flash[:notice] = "会員ログインに成功しました"
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :customer
      flash[:notice] = "会員ログアウトに成功しました"
      root_path
    else
      flash[:notice] = "管理者ログアウトに成功しました"
      new_admin_session_path
    end
  end

  protected
  def use_before_action?
    unless controller_name == 'items' && action_name == 'index'
      true
    end
  end

  def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number])
  end
end