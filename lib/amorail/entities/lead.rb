module Amorail
  # AmoCRM lead entity
  class Lead < Amorail::Entity
    amo_names 'leads'

    amo_field :name, :price, :status_id, :tags, :pipeline_id, :responsible_user_id, :created_user_id, :date_create, :date_close, :main_contact_id

    validates :name, :status_id, presence: true

    amo_property :utm_source
    amo_property :utm_medium
    amo_property :utm_campaign
    amo_property :utm_content
    amo_property :utm_term
    amo_property :ga_client_id
    amo_property :client_id
    amo_property :form_name
    amo_property :product_link

    def reload
      @contacts = nil
      super
    end

    # Return list of associated contacts
    def contacts
      fail NotPersisted if id.nil?
      @contacts ||=
        begin
          links = Amorail::ContactLink.find_by_leads(id)
          links.empty? ? [] : Amorail::Contact.find_all(links.map(&:contact_id))
        end
    end
  end
end
