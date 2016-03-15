class TabsSet < ActiveRecord::Base

  belongs_to :song
  belongs_to :user

  acts_as_votable

  scope :sortedByVotes, lambda { order("cached_votes_score DESC") }
  scope :visible, -> { where(visible: true) }
  scope :qualifiedAndVisible, -> { where('qualified = true AND visible = true') }

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
