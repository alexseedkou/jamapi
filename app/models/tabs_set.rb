class TabsSet < ActiveRecord::Base
  belongs_to :song
  belongs_to :user

  def chords_preview
    #get first 8 chords of the song and concatenate to a string
    preview = ""
    unless chords.nil?
      for i in 0..chords.count-1
        if i >= 8
          break
        end
          preview += chords[i] + "  "
      end
    end
    return preview
  end

  def average_votes
    return upvotes - downvotes
  end

  scope :sortedByVotes, lambda { order("tabs_sets.upvotes - tabs_sets.downvotes DESC") }

end
