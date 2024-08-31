namespace :users do
  desc "Ensure all users have a profile"
  task ensure_profiles: :environment do
    User.find_each do |user|
      user.create_profile if user.profile.nil?
    end
  end
end
