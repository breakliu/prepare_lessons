# coding: utf-8
module LessonsHelper
  def index_lessons(lessons)
    ret = ''
    lessons.each do |lesson|
		  ret += '<tr>'
		  ret += '<td class="td1"><!--i class="icon-star-empty"></i-->' + link_to(lesson.title, show_lesson_path(lesson))
		  #ret += ' <span class="label">新</span>' if lesson.created_at.strftime("%Y%m%d") == Time.now.strftime("%Y%m%d")
		  ret += '<img src="/assets/new.gif" />' if Time.now - lesson.created_at < 3.days
		  ret += '</td>'
		  ret += '<td class="td2">' + lesson.user.username + '</td>'
		  ret += '<td class="td3">' + lesson.created_at.strftime('%Y-%m-%d') + '</td>'
		  ret += '</tr>'
    end
    ret.html_safe
  end
end
