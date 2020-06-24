# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  username               :string           default(""), not null
#  name                   :string
#  last_name              :string
#  bio                    :text
#  uid                    :string
#  provider               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :username}
  it { should validate_uniqueness_of :username}
  it { should validate_length_of(:username).is_at_least(3).is_at_most(12)}

  describe "#validate_username_regex" do
    let(:user){FactoryGirl.build(:user)}

    it "should not allow username with the numbers at the beginning" do
      # 1 valid? => false
      # método invaild? del modelo retorne => true
      # arreglo de errors => no esté vacío
      # errors.full_messages => El username debe iniciar con una letra.
      # podemos esperar cualquiera de éstos mensajes de error que indicamos al método correspondiente.
      # podemos evaluar sobre las espectativas
      # falsy es un contexto en Ruby que quiere decir false o nil. Ruby los evalúa como false a false y nil.
      user.username = "9asdas"
      expect(user.valid?).to be_falsy
    end

    it "should not contain special characters" do
      user.username = "asdas*"
      expect(user.valid?).to be_falsy
    end

  end

end
