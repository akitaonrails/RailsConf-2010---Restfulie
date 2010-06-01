def is_valid?(app)
  @black_list.inject(false) do |result, word|
    result = result || !(app.description =~ /#{word}/).nil?
  end
end

When "there is a new app" do |resource|
  if resource.entries.empty?
    false
  else
    @app = resource.entries.first
  end
end

Then "move forward to evaluate it" do |resource|
  @app = @app.links.evaluate.follow.put!("")
  resource
end

When "there is an app being evaluated" do |resource|
  @app.state == "evaluating"
end

When "the app passes the criteria" do |resource|
  is_valid?(@app)
end

Then "approve the app" do |resource, regex, mikyung|
  @app = @app.links.approve.follow.put!("")
  resource.entries.delete_if { |a| a.id == @app.id }
  resource
end

When "the app doesnt pass the criteria" do |resource|
  !is_valid?(@app)
end

Then "decline the app" do |resource, regex, mikyung|
  @app = @app.links.decline.follow.put!("")
  resource.entries.delete_if { |a| a.id == @app.id }
  resource
end

When "there is still a new app" do |resource|
  resource.entries.size > 0
end

Then "restart the process" do |resource, regex, mikyung|
  mikyung.start
end

