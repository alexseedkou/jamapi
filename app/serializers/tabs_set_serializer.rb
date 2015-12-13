class TabsSetSerializer < ActiveModel::Serializer
  attributes :id, :tuning, :capo, :cached_votes_score, :chords_preview, :vote_status, :updated_at

  has_one :song, serializer: SongInformationSerializer
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
