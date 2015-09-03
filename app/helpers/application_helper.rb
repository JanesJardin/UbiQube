require 'net/ldap'

module ApplicationHelper

  def flash_class(flash_type)
    {
      :notice => "alert alert-info",
      :success => "alert alert-success",
      :error => "alert alert-error",
      :alert => "alert alert-block",
      :warning=>"alert alert-warning"
     }[flash_type.to_sym] || flash_type.to_s

  end
  # Limit le lecture d'info d'user
  def ldap_filtre(titre, var)
    if ldap.bind
      #filter = Net::LDAP::Filter.eq( "uid", current_user[:uid] )
      #filter = Net::LDAP::Filter.eq( "ufrcomposante", "DTIC" )
      filter = Net::LDAP::Filter.eq( titre, var )
      treebase = "ou=people,dc=univ-tours,dc=fr"
      @results = ldap.search( :base => treebase, :filter => filter )
      return @results
    else
        # authentication failed
         logger.debug("ldap authentication filter failed")
    end
  end

  def ldap_query
    result={}
    emails=aliasname=[]
    if ldap.bind
      filter = Net::LDAP::Filter.eq( "uid", current_user[:uid])
      #filter = Net::LDAP::Filter.eq( "ufrcomposante", "DTIC" )
      treebase = "ou=people,dc=univ-tours,dc=fr"
      ldap.search( :base => treebase, :filter => filter,:return_result => false ) do |item|
        emails << (item.mail.is_a?(Array) ? item.mail.first.to_s.strip : item.mail.to_s.strip)
        aliasname << (item.alias.is_a?(Array) ? item.alias.first.to_s.strip : item.alias.to_s.strip)
      end
      result["emails"]=emails
      result["name"]=aliasname
    else
        # authentication failed
         logger.debug("ldap authentication failed")
    end

    result
  end


end
