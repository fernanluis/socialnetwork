class Friendship < ApplicationRecord
  include AASM
  
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, uniqueness:{ scope: :friend_id, message: "Amistad duplicada" } # no puedo enviarle amistad dos veces a la persona.

# states machines
  aasm column: "status" do
    state :pending, initial: true # estado por default
    state :active
    state :denied

# definimos los eventos dentro de la definición de la máquina de estados.
# sirven para transicionar un estado.
    event :accepted do
      transitions from: [:pending], to: [:acitve] # si alguien ya te rechazó, no te puede activar.
    end

    event :rejected do
      transitions from: [:pending, :active], to: [:denied]
    end

  end

end
