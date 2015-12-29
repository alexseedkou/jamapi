class LyricsSet < ActiveRecord::Base
  belongs_to :song
  belongs_to :user

  acts_as_votable
  scope :sortedByVotes, lambda { order("cached_votes_score DESC") }
  scope :visible, -> { where(visible: true) }
  
  def number_of_lines
    unless lyrics.nil?
      return  lyrics.size
    end
    return 0
  end

  def lyrics_preview
    #get first 8 chords of the song and concatenate to a string
    preview = ""
    unless lyrics.nil?
      for i in 0..lyrics.count-1
        if i >= 2
          break
        end
          preview += lyrics[i] + "  "
      end
    end
    return preview
  end

end
