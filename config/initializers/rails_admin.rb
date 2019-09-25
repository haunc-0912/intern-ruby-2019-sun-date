RailsAdmin.config do |config|
  config.parent_controller = "ApplicationController"
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.authorize_with :cancancan

  config.actions do
    dashboard
    index
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end

  config.model "User" do
    show do
      field :name
      field :email
      field :gender
      field :birthday
      field :role
    end

    create do
      field :name
      field :email
      field :password
      field :gender
      field :birthday
      field :role
    end

    list do
      field :name
      field :email
      field :gender
      field :birthday
      field :role
    end
  end
end
