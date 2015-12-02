class LyricsSetSerializer < ActiveModel::Serializer
  attributes :id, :cached_votes_score, :song_id, :number_of_lines,
   :lyrics_preview, :vote_status, :updated_at
  
  has_one :user, serializer: UserListSerializer

  def vote_status
    if options[:user] == nil
      return "no user applicable"
    else
      if options[:user].voted_up_on? object
        return "up"
      elsif options[:user].voted_down_on? object
        return "down"
      else
        return "yet"
      end
    end
  end

end
