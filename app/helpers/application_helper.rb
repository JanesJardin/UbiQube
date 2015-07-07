module ApplicationHelper

  #def admins_only(&block)
  #  block.call if current_user.role.nom == "Admin"
  #  nil
  #end
  def ldap
    require 'net/ldap'
    @ldap = Net::LDAP.new :host => "ldap.univ-tours.fr",
     :port => 389,
     :auth => {
           :method => :simple,
           :username => "cn=rails_conn,ou=applis,dc=univ-tours,dc=fr",
           :password => "s4cor;7Xvk2qSdrq"
    }


  end

  def ldap_filtre(titre, var)
    if ldap.bind
      #filter = Net::LDAP::Filter.eq( "uid", current_user[:uid] )
      #filter = Net::LDAP::Filter.eq( "UFRComposante", "DTIC" )
      filter = Net::LDAP::Filter.eq( titre, var )
      treebase = "ou=people,dc=univ-tours,dc=fr"
      @results = ldap.search( :base => treebase, :filter => filter )
      return @results
    else
        # authentication failed
         logger.debug("authentication failed")
    end
  end
  
end
