User.seed do |f|
  f.id = 1
  f.first_name = "Linh"
  f.last_name = "Nguyen"
  f.email = "nguyenthienlinhptit@gmail.com"
  f.password =  "password",
  f.password_confirmation = "password"
  f.confirmed_at = Time.zone.now
end
