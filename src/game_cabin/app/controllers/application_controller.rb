class ApplicationController < ActionController::Base
    include Pundit
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    # If the current user is not authorized, then invoke the method defined in private method  and display alert message.
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    # Because the categories controller and home controller are inherited from there
    # and I need to get the whole categories data in categories controller and home controller,
    # so it's a convenient way to define a method here to reduce the repeat work.
    # Protected is a method tha let the inherited controllers to invoke the methods inside.
    protected

    def get_categories
      @categories = Category.grouped_data
    end

    # Private methods can only be used within the class definition.The only way to have external access to a private 
    # method is to call it within a public method. 
    private
  
    def user_not_authorized
      flash[:alert] = "Sorry, Access denied."
      redirect_to (request.referrer || root_path)
    end
end
