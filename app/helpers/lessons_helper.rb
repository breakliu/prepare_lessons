# coding: utf-8
module LessonsHelper
  def index_lessons(lessons)
    ret = ''
    lessons.each do |lesson|
		  ret += '<tr>'
		  ret += '<td class="td1"><!--i class="icon-star-empty"></i-->' + link_to(lesson.title, show_lesson_path(lesson, course_type(lesson)))
		  #ret += ' <span class="label">新</span>' if lesson.created_at.strftime("%Y%m%d") == Time.now.strftime("%Y%m%d")
		  ret += '<img src="/assets/new.gif" />' if Time.now - lesson.created_at < 3.days
		  ret += '</td>'
		  ret += '<td class="td2">' + lesson.user.username + '</td>'
		  ret += '<td class="td3">' #+ lesson.created_at.strftime('%Y-%m-%d') 
      ret += '</td>'
		  ret += '</tr>'
    end
    ret.html_safe
  end
  
  def course_type(lesson)
    idx = Lesson::COURSES.index(lesson.course)
    if idx > 2 and params[:course_id].blank?
      -1
    else
      idx
    end
  end
end
