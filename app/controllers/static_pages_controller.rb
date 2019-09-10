class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def login; end

  def home; end
end
