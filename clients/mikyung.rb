require 'rubygems'
require 'restfulie'

class EvaluationProcess < Restfulie::Client::Mikyung::RestProcessModel
  at "http://localhost:3000/apps/list_new"
  current_dir File.dirname(__FILE__)
  follow true

  def initialize(*black_list)
    @black_list = black_list
  end

  def completed?(resource)
    resource.entries.size == 0 
  end

  def self.run
    goal = EvaluationProcess.new("Flash", "sex")
    result = Restfulie::Mikyung.new.achieve(goal).run
    puts result.response.body 
  end
end

EvaluationProcess.run
