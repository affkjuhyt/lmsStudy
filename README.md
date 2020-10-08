# README

Trang web dạy học trực tuyến demo Athena.

Things you may want to cover:

* Ruby version: 2.7.0

* System dependencies: redis, sidekiq

* Configuration

* Database creation: mysql

* How to run the test suite: rspec

* Services (job queues, cache servers, search engines elasticsearch, etc.)

* Deployment instructions: docker

---
Hướng dẫn sử dụng:
- Sử dụng `docker-compose build` để build images, sau đó dùng `docker-compose up` để chạy chương trình
---
Cơ chế hoạt động của trang web:
- Trang web bao gồm hai phần là admin và user:
  - Admin sẽ thực hiện những chức năng như:
    - Thêm sửa xóa khóa học.
    - Thêm sửa user.
    - Thống kê được tiến trình của từng user.
    - Thống kê được mức độ được sử dụng của từng khóa học.
    - Thống kê những khóa học được nhiều người tham gia theo chart.
    - Tạo được hệ thống câu hỏi, video, thay đổi thứ tự xuất hiện của các lesson.
    - Chat với user.
  - User sẽ thực hiện những chức năng như:
    - Search khóa học
    - Đăng kí khóa học
    - Đăng kí tài khoản bằng gmail or via Facebook.
    - Rate khóa học
    - Trả lời câu hỏi trong khóa học.
    - Đánh giá comment từng khóa học.
    - Chat với admin.
  - Hệ thống:
    - Sẽ gửi mail cho user mỗi khi tạo khóa học mới.
    - Sẽ gửi thông báo cho những user đăng kí những khóa học thuộc thể loại course được tạo.
---
Cách tạo dữ liệu test:
 - Chạy câu lệnh `docker-compose run lmsstudy rails db:seed_fu`
 - File seed dữ liệu được viết trong thư mục `db/fixtures`
 - Code trong file seed-data:
 ```user_attrs = proc do
  10.times.map do |idx|
    {
      id: idx + 1,
      first_name: Faker::Name.first_name,
      avatar: Faker::LoremFlickr.image(size: '200x200'),
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email(domain: 'example'),
      password: 'password',
      password_confirmation: 'password',
      confirmed_at: Time.zone.now
    }
  end
end

User.seed_once(:id, *user_attrs.call)

category_name = ["Web Design", "Web Development", "Marketing", "Product Management"]

category_attrs = proc do
  4.times.map do |idx|
    {
      id: idx + 1,
      name: category_name.sample,
      image: Faker::LoremFlickr.image(size: '150x150')
    }
  end
end

Category.seed_once(:id, *category_attrs.call)

video_urls = ["https://player.vimeo.com/video/180293809", "https://player.vimeo.com/video/119105386",
  "https://player.vimeo.com/video/69225705", "https://player.vimeo.com/video/61789173",
  "https://player.vimeo.com/video/393999309", "https://player.vimeo.com/video/377600390",
  "https://player.vimeo.com/video/375432709", "https://player.vimeo.com/video/373997050",
  "https://player.vimeo.com/video/372988843", "https://player.vimeo.com/video/368134723",
  "https://player.vimeo.com/video/363921958", "https://player.vimeo.com/video/360832524",
  "https://player.vimeo.com/video/355204808", "https://player.vimeo.com/video/355114615",
  "https://player.vimeo.com/video/348671806", "https://player.vimeo.com/video/45230972",
  "https://player.vimeo.com/video/25641459", "https://player.vimeo.com/video/1904672",
  "https://player.vimeo.com/video/17752439", "https://player.vimeo.com/video/369095"]

course_attrs = proc do
  10.times.map do |idx|
    {
      id: idx + 1,
      user_id: 1,
      image: Faker::LoremFlickr.image(size: '200x200'),
      title: Faker::Job.title,
      overview: Faker::Lorem.sentence(word_count: 15),
      description: Faker::Lorem.sentence,
    }
  end
end

lesson_attrs = proc do
  10.times.map do |idx|
    {
      course_id: idx + 1,
      name: Faker::Educator.course_name,
      lesson_type: rand(1..2),
      check_point: 1,
      sequence: idx + 1,
      video_url: video_urls.sample
    }
  end
end

question_attrs = proc do
  10.times.map do |idx|
    {
      lesson_id: idx + 1,
      title: Faker::Lorem.sentence(word_count: 3)

    }
  end
end

Course.seed_once(:id, *course_attrs.call)
Lesson.seed_once(:id, *lesson_attrs.call)
Question.seed_once(:id, *question_attrs.call)

Question.all.each do |choice|
  answer = [true, false, false, false].sample(4)
  for i in 0..3 do
    QuestionChoice.create(
      question: choice,
      answer: Faker::Lorem.sentence,
      right_answer: answer[i]
    )
  end
end

course_category_attrs = proc do
  4.times.map do |idx|
    {
      id: idx + 1,
      course_id: idx + 1,
      category_id: idx + 1
    }
  end
end

CourseCategory.seed_once(:id, *course_category_attrs.call)```
