class Content < ActiveRecord::Base
  attr_accessible :body
  belongs_to :contented , :polymorphic => true

  # validator
  validates_presence_of :body
  validates_length_of :body, :maximum => ApplicationController::MAX_POST_CONTENT_LENGTH

  def to_s
    "id =>#{id} body => #{body}"
  end
end
