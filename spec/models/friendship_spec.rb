require 'rails_helper'

RSpec.describe Friendship, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { should belong_to :user }
  it { should belong_to :friend}

  it "should validate uniqueness of user with friend" do
    user = FactoryGirl.create(:user) # Creación de una usuario
    friend = FactoryGirl.create(:user) # creación de una amigo.

    FactoryGirl.create(:friendship, user: user, friend: friend) # amistad con primer usuario y primer amigo creado.
# usuario user le envío dos veces solicitud de amistad al usuario friend.
    amistad_duplicada = FactoryGirl.build(:friendship, user: user, friend: friend)
    # cambiamos create por build para que no intente guardarla.
    # build construye el objeto pero no lo guarda en la base de datos.
    expect(amistad_duplicada.valid?).to be_falsy
  end
end
