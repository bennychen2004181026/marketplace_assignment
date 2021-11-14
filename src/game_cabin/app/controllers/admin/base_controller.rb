# This controller is created only for admin dashboard
class Admin::BaseController < ActionController::Base
  before_action :authenticate_user!
  # Just for making sure you can realize mistake in case you forgot to authorize your controller action
  after_action :verify_authorized, except: [:show]
  #  Specifying Layouts for Admin BaseController
  layout 'admin/layouts/admin'


end
