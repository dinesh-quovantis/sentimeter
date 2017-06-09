module TweetsHelper

	def close_button(selected_tweet, current_status)
		str = ''
		str << link_to('CLOSE', mark_closed_tweet_path(selected_tweet, :format => :js), :id => "mark_closed", :remote => true, :class => "btn primary-btn hollow-btn follow-btn") if current_status != CLOSED && current_user.present?
		str.html_safe
	end

	def comment_block(selected_tweet, current_status)
		str = ""
		if current_user.present? && current_status != CLOSED
			str << comment_form(selected_tweet)
		end	
		str.html_safe
	end	

	def close_status_block(selected_tweet, current_status)
		str = ""
		if current_status == CLOSED
			str << "<div class='timeline-status-comment'>"+formatted_date(selected_tweet.tweet_statuses.last.created_at) + "<div>" +I18n.t("timeline_status.closed") + "</div>" + "</div>" 
		end	
		str.html_safe
	end	

	def resolve_status_block(selected_tweet)
		str = "<div class='timeline-status-comment'>"+formatted_date(selected_tweet.tweet_statuses.first.created_at) + "<div>" +I18n.t("timeline_status.in_progress") + "</div>" + "</div>"
		str.html_safe
	end
	
	def show_work_log(work_logs)
		str = ""
		work_logs.each do |work_log|
			str <<  "<div class='timeline-status-comment'>"+ formatted_date(work_log.created_at) + "<div>" +  work_log.comment + "</div>" + "</div>"
		end	
		str.html_safe
	end

	def comment_form(selected_tweet)
		s = form_tag(comment_tweet_path(selected_tweet, :format => :js), method: "post", :remote => true, :class => "comment-form") do 
			p = '<div class="form-group">'
			p << text_area_tag("comment_text",nil ,:class => "form-control textarea-field", :cols => "30", :rows => "3", :placeholder=>"Your Comment")
			p << '</div>'
			p << '<div class="action-btn text-md-right">'
			p << "<span class='fa fa-twitter'></span>"
			p << submit_tag("Reply", :name => "reply_and_comment",:class => "comment-submit")
			p << submit_tag("Add Note", :name => "comment_only", :class => "comment-submit")
			p << '</div>'
			p.html_safe
		end
		s.html_safe
	end	

	def formatted_date(date)
		"<span class='timeline-date'>" + date.strftime("%d %b").to_s + "</span>"
	end	
end
