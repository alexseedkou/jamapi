class TabsSet < ActiveRecord::Base

  belongs_to :song
  belongs_to :user

  acts_as_votable

  scope :sortedByVotes, lambda { order("cached_votes_score DESC") }
  scope :visible, -> { where(visible: true) }

  def total_score

  end

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

  def chords_preview
    #get first 8 chords of the song and concatenate to a string
    preview = ""
    unless chords.nil?
      for i in 0..chords.count-1
        if i >= 10
          break
        end
          preview += chords[i] + "  "
      end
    end
    return preview
  end
end
