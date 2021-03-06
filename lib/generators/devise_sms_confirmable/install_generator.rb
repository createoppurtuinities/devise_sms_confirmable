module DeviseSmsConfirmable
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      desc "Add DeviseSmsConfirmable config variables to the Devise initializer and copy DeviseSmsConfirmable locale files to your application."
            
      def add_config_options_to_initializer
        devise_initializer_path = "config/initializers/devise.rb"
        if File.exist?(devise_initializer_path)
          old_content = File.read(devise_initializer_path)
          
          if old_content.match(Regexp.new(/^\s# ==> Configuration for :sms_confirmable\n/))
            false
          else
            inject_into_file(devise_initializer_path, :before => "  # ==> Configuration for :confirmable\n") do
<<-CONTENT
  # ==> Configuration for :sms_confirmable
  # sms_confirmation_field: model field which store phone for sms confirmation
  #config.sms_confirmation_field = :phone_for_sms
  # sms_confirmation_method: method of ApplicationController which return true if sms confirmation requred.
  #config.sms_confirmation_method = :sms_confirmation?
  # sms_secret_method: method of ApplicationController which return secret for sending
  #config.sms_secret_method = :sms_secret
  #sms_provider: special object which uses for sending SMS. It must have at least one method send_sms(phone, message) which return true or false
  #config.sms_provider = DeviseSmsConfirmable::Provider
  #default_provider_silent: if true default provider does't send sms
  #config.default_provider_silent = true
  #default_provider_login
  #config.default_provider_login = "tstest1001"
  #default_provider_password
  #config.default_provider_password = "tstest1001"

CONTENT
            end
          end
        end
      end
      
      def copy_locale
        copy_file "../../../../config/locales/devise_sms_confirmable.en.yml", "config/locales/devise_sms_confirmable.en.yml"
      end

      def show_readme
        readme "README"
      end
      
    end
  end
end
