class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if current_customer
      flash[:notice] = "会員ログインに成功しました"
      root_path
    elsif @admin
      flash[:notice] = "管理者ログインに成功しました"
      admin_path
    else
      flash[:notice] = "会員新規登録が完了しました"
      customers_my_page_pathh
    end
  end

  protected

  def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number])
  end
end