module PlansHelper
	def index_plans(plans)
	    ret = ''
	    plans.each do |plan|
			  ret += '<tr>'
			  ret += '<td class="td1"><!--i class="icon-star-empty"></i-->' + link_to(plan.title, plan_path(plan))
			  #ret += ' <span class="label">新</span>' if lesson.created_at.strftime("%Y%m%d") == Time.now.strftime("%Y%m%d")
			  ret += '<img src="/assets/new.gif" />' if Time.now - plan.created_at < 3.days
			  ret += '</td>'
			  ret += '<td class="td2">' + plan.user.username + '</td>'
			  ret += '<td class="td3">' + plan.created_at.strftime('%Y-%m-%d') + '</td>'
			  ret += '</tr>'
	    end
    	ret.html_safe
  	end
end
