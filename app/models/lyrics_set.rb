class LyricsSet < ActiveRecord::Base
  belongs_to :song
  belongs_to :user

  def numberOfLines
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

  def average_votes
    return upvotes - downvotes
  end

  scope :sortedByVotes, lambda { order("lyrics_sets.upvotes - lyrics_sets.downvotes DESC") }
end
