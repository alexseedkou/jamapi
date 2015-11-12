class TabsSet < ActiveRecord::Base
  belongs_to :song
  belongs_to :user

  def average_votes
    return upvotes - downvotes
  end

  scope :sortedByVotes, lambda { order("tabs_sets.upvotes - tabs_sets.downvotes DESC") }

end
