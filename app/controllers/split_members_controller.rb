class SplitMembersController < ApplicationController
  def create
    raise
    # check if member_id is present in params
      # if no, means contact not selected.
        # check if phone_number belongs to existing member
          # if yes, find that member
        # else
          # create new member
  end
end
