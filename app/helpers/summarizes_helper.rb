module SummarizesHelper
	def index_summarizes(summarizes)
	    ret = ''
	    summarizes.each do |summarize|
			  ret += '<tr>'
			  ret += '<td class="td1"><!--i class="icon-star-empty"></i-->' + link_to(summarize.title, summarize_path(summarize))
			  #ret += ' <span class="label">新</span>' if lesson.created_at.strftime("%Y%m%d") == Time.now.strftime("%Y%m%d")
			  ret += '<img src="/assets/new.gif" />' if Time.now - summarize.created_at < 3.days
			  ret += '</td>'
			  ret += '<td class="td2">' + summarize.user.username + '</td>'
			  ret += '<td class="td3">' + summarize.created_at.strftime('%Y-%m-%d') + '</td>'
			  ret += '</tr>'
	    end
    	ret.html_safe
  	end
end
