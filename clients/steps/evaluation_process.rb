def is_valid?(app)
  @black_list.inject(false) do |result, word|
    result = result || !(app.description =~ /#{word}/).nil?
  end
end

When "there is a new app" do |resource|
  if @app || resource.entries.empty?
    false
  else
    @entries = resource.entries
    @app = resource.entries.last
  end
end

Then "move forward to evaluate it" do |resource|
  @app = @app.links.evaluate.follow.post!("")
  resource
end

When "there is an app being evaluated" do |resource|
  @app.state == "evaluating"
end

When "the app passes the criteria" do |resource|
  is_valid?(@app)
end

Then "approve the app" do |resource|
  @app.links.approve.follow.post!("")
  @app = nil
  resource.entries.pop
  resource
end

When "the app doesnt pass the criteria" do |resource|
  !is_valid?(@app)
end

Then "decline the app" do |resource, regex, mikyung|
  @app.links.decline.follow.post!("")
  @app = nil
  resource.entries.pop
  resource
end

