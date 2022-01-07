class Api::V1::UsersController < ApplicationController
  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      render json: @user.slice(:email), status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # TODO: Add destroy so a user can restart the game if they want

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
