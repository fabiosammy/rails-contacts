json.extract! contact_phone, :id, :name, :phone, :created_at, :updated_at
json.url contact_phone_url(contact_phone.contact, contact_phone, format: :json)
