class SwipesController < ApplicationController
  def create
    @swipe = current_user.swipes.build(swipe_params)

    if @swipe.save
      match = check_for_match if @swipe.direction == 'right'
      render json: { status: 'success', match: match }, status: :created
    else
      render json: { status: 'error', errors: @swipe.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def swipe_params
    params.require(:swipe).permit(:swiped_user_id, :direction)
  end

  def check_for_match
    swiped_user = User.find(swipe_params[:swiped_user_id])
    if swiped_user.swipes.exists?(swiped_user: current_user, direction: 'right')
      Match.create(user: current_user, matched_user: swiped_user)
      Match.create(user: swiped_user, matched_user: current_user)
      return true
    end
    false
  end
end
