class OptionsController < ApplicationController
  def show
    respond_to do |format|
      format.html
      format.any { render :text => "Invalid format", :status => 406 }
    end
    # if request.format !=:html
    #   render nothing: true, status: :not_acceptable
    # end
  end
end
