class AppsController < ApplicationController
  restfulie
  respond_to :html, :xml, :atom, :json

  # respond_to :html, :xml

  inherit_resources

  def index
    @apps = collection
    if stale? :etag => @apps.inject(0) { |etag, a| etag += a.updated_at.to_i }, :public => true
      respond_with @apps
    end
  end

  def show
    @app = resource
    if stale? :etag => @app.updated_at.to_i, :public => true
      respond_with @app
    end
  end
  
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

  # TODO: there is probably a cleaner way of overriding this method
  # with inherited resources
  def update
    @app = App.find(params[:id])
    if @state
      respond_to do |format|
        if @app.send(@state.to_sym)
          format.html { redirect_to(@app, :notice => 'App was successfully updated.') }
          format.xml { head :ok }
          format.atom { redirect_to @app }
          format.json { redirect_to @app }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
          format.atom { head :error }
          format.json { head :error }
        end
      end
    end
  end

  protected

  def collection
    state = params[:state] || "approved"
    Rails.logger.debug params.inspect
    @apps = end_of_association_chain.all(:conditions => { :state => state} )
  end
end
