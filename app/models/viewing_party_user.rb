class ViewingPartyUser < ApplicationRecord
    validates :host, inclusion: { in: [true, false] }
    belongs_to :user
    belongs_to :viewing_party
end