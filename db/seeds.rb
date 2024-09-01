# db/seeds.rb

# 既存のデータをクリア
User.destroy_all
Profile.destroy_all
Swipe.destroy_all
Match.destroy_all

# テストユーザーを作成
10.times do |i|
  user = User.create!(
    email: "user#{i+1}@example.com",
    password: 'password',
    password_confirmation: 'password'
  )

  Profile.create!(
    user: user,
    bio: "Hello, I'm user#{i+1}. Nice to meet you!",
    birth_date: Date.today - (20..40).to_a.sample.years,
    gender: ['male', 'female', 'other'].sample,
    location: ['Tokyo', 'Osaka', 'Nagoya', 'Fukuoka', 'Sapporo'].sample,
    interests: ['Travel', 'Cooking', 'Sports', 'Reading', 'Music'].sample(2).join(', '),
    language: ['Japanese', 'English', 'Chinese', 'Korean', 'French'].sample(2).join(', ')
  )
end

puts "テストユーザーが作成されました。"

# ランダムにスワイプを生成
users = User.all
users.each do |user|
  (users - [user]).sample(5).each do |swiped_user|
    Swipe.create!(
      user: user,
      swiped_user: swiped_user,
      direction: ['left', 'right'].sample
    )
  end
end

puts "ランダムなスワイプが生成されました。"

# マッチを生成
matches_created = Set.new  # 作成済みのマッチを追跡

Swipe.where(direction: 'right').each do |swipe|
  reverse_swipe = Swipe.find_by(user: swipe.swiped_user, swiped_user: swipe.user, direction: 'right')
  if reverse_swipe
    match_key = [swipe.user_id, swipe.swiped_user_id].sort
    unless matches_created.include?(match_key)
      Match.create!(user: swipe.user, matched_user: swipe.swiped_user)
      matches_created.add(match_key)
      puts "マッチが作成されました: #{swipe.user.email} と #{swipe.swiped_user.email}"
    end
  end
end

puts "シードデータの作成が完了しました。"

puts "シードデータの作成が完了しました。"
