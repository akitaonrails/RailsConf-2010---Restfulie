require 'rubygems'
require 'active_resource'

class App < ActiveResource::Base
  self.site = "http://localhost:3000/"
end

#apps = App.get(:list_new)
apps = App.find(:all, :params => { :state => "new" })

first_app = apps.first
if first_app.state == "new"
  first_app.put(:evaluate)
end

if apps.first.description =~ /Flash/
  first_app.put(:decline)
elsif apps.first.description =~ /sex/
  first_app.put(:decline)
else
  first_app.put(:approve)
end
