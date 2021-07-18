# frozen_string_literal: true

module EventSpecHelper
  def makes_user_event_id_hash(count)
    user_event = []
    count.times { |num|
      user_event << { user_id: create(:user).id }
    }
    user_event
  end
end
