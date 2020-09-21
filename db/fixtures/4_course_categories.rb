course_category_attrs = proc do
  4.times.map do |idx|
    {
      id: idx + 1,
      course_id: idx + 1,
      category_id: idx + 1
    }
  end
end

CourseCategory.seed_once(:id, *course_category_attrs.call)
