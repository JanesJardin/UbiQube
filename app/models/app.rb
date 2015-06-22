class App < ActiveRecord::Base
  #les attributs modifable
 # attr_accessible :nom, :niveau, :etat_id, :etape_id, :groupe_app_id
  #validation d'existance
  #validates :nom, presence: true
  #validates :niveau, presence: true

  #relation d'APP

  #si une App est supprimée, on va supprimer tous les records dans user_app_roles
  has_many :user_app_roles, foreign_key: "app_id", dependent: :destroy
  #APP a plusieurs users et roles(many to many)
  has_many :users, through: :user_app_roles
  has_many :roles, through: :user_app_roles

  belongs_to :etape_app,:class_name => "EtapeApp"
  has_many :etat_app, :as => :etat_collection, :class_name => "EtatApp"
  belongs_to :groupe_app,:class_name => "GroupeApp"

end
