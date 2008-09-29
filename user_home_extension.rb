# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class UserHomeExtension < Radiant::Extension
  version "1.0"
  description "Allows users to set their home location for login."
  url "http://saturnflyer.com/"
  
  def activate
    User.class_eval do
      before_save :check_home_path
      validates_format_of :home_path, :with => %r{^([-_.A-Za-z0-9\/]*|/)$}, :message => 'invalid format'
      
      private
      def check_home_path
        if home_path.match(/^\/?admin\/?$/)
          self[:home_path] = nil
        end
      end
    end
    Admin::WelcomeController.class_eval do
      def index_with_preference
        if current_user.respond_to?(:home_path)
          unless current_user.home_path.blank?
            redirect_to current_user.home_path
          else
            index_without_preference
          end
        else
          index_without_preference
        end
      end
      alias_method_chain :index, :preference
    end
    
    admin.user.edit.add :form, 'home_path'
    if admin.respond_to?(:preferences)
      admin.preferences.form.add 'home_path'
    end
  end
  
  def deactivate
  end
  
end