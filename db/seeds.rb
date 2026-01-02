# ================================
# 都道府県マスタ（バリデーション無視で確実に作成）
# ================================
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
  area = Area.find_or_initialize_by(name: name)
  area.save!(validate: false)   # ← Areaの厳しいバリデーションを無視
end

# ================================
# ポートフォリオ用デモユーザー
# ================================
user = User.find_or_initialize_by(email: "portfolio@soine.com")
user.name = "Soine デモユーザー"
user.password = "password"
user.password_confirmation = "password"
user.save!

# ================================
# 投稿で使うエリア（必ず存在）
# ================================
tokyo = Area.find_or_initialize_by(name: "東京都")
tokyo.save!(validate: false)

# ================================
# ポートフォリオ用投稿
# ================================
posts = [
  {
    title: "夜泣きが続く時期の乗り切り方",
    body: "生後3ヶ月頃から夜泣きが増えました。抱っこ・室温調整・お風呂の時間を見直したら少し落ち着きました。"
  },
  {
    title: "離乳食を始めて困ったこと",
    body: "初期は量よりも『慣れること』を意識しました。食べない日があっても焦らないのが大事でした。"
  },
  {
    title: "パパの育児参加で意識したこと",
    body: "完璧を目指さず、できることを継続することを大切にしています。"
  }
]

posts.each do |data|
  post = Post.find_or_initialize_by(
    user: user,
    title: data[:title]
  )

  post.body = data[:body]
  post.area = tokyo
  post.save!
end

puts "✅ seed 完了（デモユーザー・投稿・エリア作成済み）"
