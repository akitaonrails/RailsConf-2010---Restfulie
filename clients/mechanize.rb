require 'rubygems'
require 'mechanize'

agent = Mechanize.new { |agent| agent.user_agent_alias = "Mac Safari" }

agent.get("http://localhost:3000/apps/list_new")

apps = agent.page.links.select { |link| link.href =~ /apps\/\d+/ }

agent.click apps.first

evaluate = agent.page.links.select { |link| link.text =~ /Evaluate/ }
evaluate = evaluate.first if evaluate && !evaluate.empty?

agent.post evaluate.href, "" if evaluate

approve = agent.page.links.select { |link| link.text =~ /Approve/ }
approve = approve.first if approve && !approve.empty?
decline = agent.page.links.select { |link| link.text =~ /Decline/ }
decline = decline.first if decline && !decline.empty?

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
