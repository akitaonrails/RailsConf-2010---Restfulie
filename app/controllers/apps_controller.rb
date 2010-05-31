class AppsController < ApplicationController
  inherit_resources
  respond_to :html, :xml

  def list_new
    redirect_to apps_url(:state => "new")
  end

  def list_approved
    redirect_to apps_url(:state => "approved")
  end

  def list_declined
    redirect_to apps_url(:state => "declined")
  end

  def evaluate
    @state = "evaluate"
    update
  end

  def approve
    @state = "approve"
    update
  end

  def decline
    @state = "decline"
    update
  end

  def update
    @app = App.find(params[:id])
    @app.send(@state.to_sym) if @state
    Rails.logger.debug("Hello #{@state}")
    update!
  end

  protected

  def collection
    state = params[:state] || "approved"
    @apps = end_of_association_chain.all(:conditions => { :state => state} )
  end
end
