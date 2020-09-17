module ExamsHelper
  def check_point(result, max_point)
    if result.nil? || (result.point < max_point)
      render 'exams/quiz_form'
    elsif result.point >= max_point
      render 'exams/result'
    end
  end
end
