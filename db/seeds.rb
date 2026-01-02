# ===== 都道府県マスタ =====
areas = %w[
  北海道 青森県 岩手県 宮城県 秋田県 山形県 福島県
  茨城県 栃木県 群馬県 埼玉県 千葉県 東京都 神奈川県
  新潟県 富山県 石川県 福井県 山梨県 長野県
  岐阜県 静岡県 愛知県 三重県
  滋賀県 京都府 大阪府 兵庫県 奈良県 和歌山県
  鳥取県 島根県 岡山県 広島県 山口県
  徳島県 香川県 愛媛県 高知県
  福岡県 佐賀県 長崎県 熊本県 大分県 宮崎県 鹿児島県 沖縄県
]

areas.each do |name|
  Area.find_or_create_by!(name: name)
end

# ===== ポートフォリオ閲覧用デモユーザー =====
user = User.find_or_create_by!(email: "portfolio@soine.com") do |u|
  u.name = "Soine デモユーザー"
  u.password = "password"
end

# エリア（必ず存在させる）
area = Area.find_or_create_by!(name: "東京都")

# ===== ポートフォリオ用投稿 =====
posts = [
  {
    title: "夜泣きが続く時期の乗り切り方",
    body: "生後3ヶ月頃から夜泣きが増えました。抱っこ・室温調整・お風呂の時間を見直したら少し落ち着きました。",
    area: area
  },
  {
    title: "離乳食を始めて困ったこと",
    body: "初期は量よりも『慣れること』を意識しました。食べない日があっても焦らないのが大事でした。",
    area: area
  },
  {
    title: "パパの育児参加で意識したこと",
    body: "完璧を目指さず、できることを継続することを大切にしています。",
    area: area
  }
]

posts.each do |post|
  user.posts.find_or_create_by!(title: post[:title]) do |p|
    p.body = post[:body]
    p.area = post[:area]
  end
end
