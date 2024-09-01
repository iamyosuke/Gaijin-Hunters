class MatchesController < ApplicationController
  def index
    @matches = current_user.matches.includes(matched_user: :profile)
  end
end
