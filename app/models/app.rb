class App < ActiveRecord::Base
  attr_accessible :name, :author, :image_uri, :price, :state, :description
  validates_presence_of :name, :author, :image_uri, :price, :state, :description

  state_machine :initial => :new do 
    event :evaluate do
      transition :new => :evaluating
    end

    event :approve do
      transition [:declined, :evaluating] => :approved
    end

    event :decline do
      transition [:approved, :evaluating] => :declined
    end
  end
end
