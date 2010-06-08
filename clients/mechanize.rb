require 'rubygems'
require 'mechanize'

agent = Mechanize.new { |agent| agent.user_agent_alias = "Mac Safari" }

agent.get("http://localhost:3000/apps/list_new")

agent.click agent.page.link_with :href => /apps\/\d+/

evaluate = agent.page.link_with :text => /Evaluate/

agent.post evaluate.href, "" if evaluate

approve = agent.page.link_with :text => /Approve/ 
decline = agent.page.link_with :text => /Decline/

if approve && decline
  description = agent.page.search("pre").text
  if description =~ /Flash/
    agent.post decline.href, ""
  elsif description =~ /sex/
    agent.post decline.href, ""
  else
    agent.post approve.href, ""
  end
end
