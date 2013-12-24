require 'rails_admin/main_controller'
module RailsAdmin
  class MainController < RailsAdmin::ApplicationController
    def charts
      get_model
      #get_object
      action = RailsAdmin::Config::Actions.find(:charts)
      #@authorization_adapter.try(:authorize, action.authorization_key, @abstract_model, @object)
      @action = action.with({controller: self, abstract_model: @abstract_model})
      @page_name = wording_for(:title)
      #
      #if request.get?
      #elsif request.post?
      #end
      #redirect_to back_or_index
    end
  end

end