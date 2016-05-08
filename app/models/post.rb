class Post < ActiveRecord::Base
  require "trello_api"
  include TrelloApi

  after_create do 
    create_card(self.title, self.content, self.url)
  end
end
