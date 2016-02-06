class TabsSet < ActiveRecord::Base

  belongs_to :song
  belongs_to :user

  acts_as_votable

  scope :sortedByVotes, lambda { order("cached_votes_score DESC") }
  scope :visible, -> { where(visible: true) }

  def qualified#we use 30 to determine if this is a good tabs
    unless times.nil?
      if times.size > 30
        return true
      else
        return false
      end
    end
    return false
  end

  #return unique chords for the song
  def chords_preview
    #get first 8 chords of the song and concatenate to a string
    preview = ""
    unless chords.nil?
      chords.to_set.each do |chord|
        preview += chord + "  "
      end
    end
    return preview
  end
end
