class GramsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create]
  #before_action :require_authorized_for_gram, only: [:show]
  
  def index
  end

  def new
    @gram = Gram.new
  end

  def show
    @gram = Gram.find_by_id(params[:id])
    if @gram.blank?
      render plain: 'Not Found :(', status: :not_found
    end
  end

  def create
    @gram = current_user.grams.create(gram_params)
    if @gram.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end



  private

  #def require_authorized_for_gram
   # if @gram.user_id != current_user
    #  render plain: "Unauthorized", status: :Unauthorized
    #end
  #end

  def gram_params
    params.require(:gram).permit(:message)
  end
end
