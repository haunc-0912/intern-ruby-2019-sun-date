class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  layout "application_home"

  def login; end

  def home; end
end
