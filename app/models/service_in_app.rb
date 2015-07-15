class ServiceInApp < ActiveRecord::Base
  has_many :reseau_services, foreign_key:"service_in_app_id"
  has_many :reseaus, through: :reseau_services

  has_many :vm_install_service_ins, foreign_key:"service_in_app_id"
  has_many :vms, through: :vm_install_service_ins

  has_many :service_out_apps

  belongs_to :services, foreign_key:"service_id"
  belongs_to :apps, foreign_key:"app_id"

  accepts_nested_attributes_for :reseau_services, :service_out_apps, :vm_install_service_ins
end
