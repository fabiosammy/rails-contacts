json.extract! contact, :id, :name, :birthday, :employed, :salary, :gender, :created_at, :updated_at
json.url contact_url(contact, format: :json)
