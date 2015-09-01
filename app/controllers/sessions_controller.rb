class SessionsController < ApplicationController

  def new
    redirect_to '/auth/cas'
  end

  def create
      auth = request.env["omniauth.auth"]

      if ldap_auth(auth['uid'])
        user = User.where(:provider => auth['provider'],
                          :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
        user.email=auth.info.mail
        user.name=auth['info']['displayname']
        reset_session
        session[:user_id] = user.id
        #redirect_to root_url, :notice => 'Signed in!'
        #redirect à la page de mes Apps
        redirect_to mesapps_url(user.id), :alert => 'Signed in!'
      else
         flash.keep
         flash[:notice] ="Authentication error: que les personnelles du DTIC authorisées"
         redirect_to signout_url
      end

  end

  def destroy
    reset_session
    redirect_to 'https://cas.univ-tours.fr/cas/logout?service=http://ubiqube.univ-tours.fr'
    #redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :error => "Authentication error: #{params[:message].humanize}"
  end

end
