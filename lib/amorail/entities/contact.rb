require 'amorail/entities/leadable'

module Amorail
  # AmoCRM contact entity
  class Contact < Amorail::Entity
    include Leadable
    amo_names 'contacts'

    amo_field :name, :company_name, :linked_company_id, :created_user_id

    amo_property :email, enum: 'WORK'
    amo_property :phone_mobile, enum: 'MOB'
    amo_property :phone_work, enum: 'WORK'
    amo_property :position
    amo_property :site
    amo_property :profile_link

    validates :name, presence: true

    # Clear company cache
    def reload
      @company = nil
      super
    end

    def company
      return if linked_company_id.nil?
      @company ||= Amorail::Company.find(linked_company_id)
    end
  end
end
