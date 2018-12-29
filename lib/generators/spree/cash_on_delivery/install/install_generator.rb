module Spree::CashOnDelivery
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_javascripts
        append_file "vendor/assets/javascripts/spree/frontend/all.js", "//= require store/cash_on_delivery\n"
        append_file "vendor/assets/javascripts/spree/backend/all.js", "//= require admin/cash_on_delivery\n"
      end

      def add_stylesheets
        inject_into_file "vendor/assets/stylesheets/spree/frontend/all_mobile.css", " *= require store/cash_on_delivery\n", :before => /\*\//, :verbose => true
        inject_into_file "vendor/assets/stylesheets/spree/frontend/all_normal.css", " *= require store/cash_on_delivery\n", :before => /\*\//, :verbose => true
        inject_into_file "vendor/assets/stylesheets/spree/backend/all.css", " *= require admin/cash_on_delivery\n", :before => /\*\//, :verbose => true
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_cash_on_delivery'
      end

      def run_migrations
         res = ask "Would you like to run the migrations now? [Y/n]"
         if res == "" || res.downcase == "y"
           run 'bundle exec rake db:migrate'
         else
           puts "Skiping rake db:migrate, don't forget to run it!"
         end
      end
    end
  end
end
