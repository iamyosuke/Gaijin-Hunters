# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def index
    swiped_user_ids = current_user.swipes.pluck(:swiped_user_id)
    @users_to_swipe = User.joins(:profile)
                          .where.not(id: current_user.id)
                          .where.not(id: swiped_user_ids)
                          .order("RANDOM()")
                          .limit(10)
  end
end
