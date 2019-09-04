class ImagesController < ApplicationController
  before_action :load_user, only: %i(index create)

  def index
    @image = @user.images.all
  end

  def create
    if @user.update user_image_params
      params[:user][:images]["link"].each do |link|
        @image = @user.images.create link: link
      end
      flash[:success] = t "image.message.upload_success"
    else
      flash[:success] = t "image.message.error"
    end
    redirect_to images_path
  end

  def destroy
    @image = Image.find_by id: params[:id]

    if @image
      @image.destroy
      flash[:success] = t "image.message.delete_success"
    else
      flash[:success] = t "image.message.no_image"
    end
    redirect_to images_path
  end

  private

  def load_user
    @user = current_user
  end

  private

  def user_image_params
    params.require(:user).permit User::USER_IMAGE_PARAMS
  end
end
