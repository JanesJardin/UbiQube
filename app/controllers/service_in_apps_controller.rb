class ServiceInAppsController < ApplicationController

  def index
    @app=App.find(params[:app_id])
    @service_in_apps = @app.service_in_apps

  end

  def show
    @service_in_app = ServiceInApp.find(params[:id])
    respond_to do |format|
      format.html
      format.js{ render :layout => false }
    end
  end

  def edit
    @service_in_app=ServiceInApp.find(params[:id])
    respond_to do |format|
      format.html
      format.js{ render :layout => false }
    end
  end

  # GET /ServiceInApps/new
  # GET /ServiceInApps/new.xml
  def new
    @app=App.find(params[:app_id])
    @service_in_app= @app.service_in_apps.build
  end

  # POST /ServiceInApps
  # POST /ServiceInApps.xml
  def create
    #app_params.permit!
    @app=App.find(params[:app_id])
    @service_in_app = @app.service_in_apps.build(serIN_params)

    respond_to do |format|
      if @service_in_app.save
        format.html { redirect_to app_url(@service_in_app.app_id), :notice => 'App Service was successfully created.' }
        format.js { render :action => 'mesapps', :status => :created, :location => @user }
      else
        format.html { render :action => 'new' }
        format.js { render :action => @service_in_app.errors, :status => :unprocessable_entity }
      end
    end

  end

  # PUT /ServiceInApps/1
  # PUT /ServiceInApps/1.xml
  def update
    @service_in_app = ServiceInApp.find(params[:id])

      if @service_in_app.update_attributes(params[:app])
        format.html {redirect_to mesapps_url(current_user), :notice => 'App was successfully updated.' }

      else
        render :action => "edit"
      end

  end

  # DELETE /ServiceInApps/1
  # DELETE /ServiceInApps/1.xml
  def destroy
    @service_in_app = ServiceInApp.find(params[:id])
    if @service_in_app.destroy then
      respond_to do |format|
        format.html {redirect_to mesapps_url(current_user), :notice => 'App was successfully deleted'}
        format.js { render :layout=>false,template:'service_in_apps/destroy.js.erb'}
      end
    end



  end

  def edit_tech
    @app=App.find(params[:app_id])
    #@service_in_app= ServiceInApp.find(params[:id])
    #@vm_install_service_in= @service_in_app.vm_install_service_ins.build
    @service_ins=@service_in_apps.services.build
    @vm_installs=@service_in_apps.vms.build

    respond_to do |format|
      format.html
      format.js{ render :layout => false }
    end
  end

private
  def serIN_params
    params.require(:service_in_app).permit(:port, apps_attributes[:id])
  end
end