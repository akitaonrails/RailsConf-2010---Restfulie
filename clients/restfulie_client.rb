require 'rubygems'
require 'restfulie'

list = Restfulie.at("http://localhost:3000/apps/list_new").
  accepts("application/atom+xml").follow.get

app = list.entries.first
app = app.links.evaluate.follow.post!("")

if app.description =~ /Flash/
  app.links.decline.follow.post!("")
elsif app.description =~ /sex/
  app.links.decline.follow.post!("")
else
  app.links.approve.follow.post!("")
end
