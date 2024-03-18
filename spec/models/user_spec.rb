require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:questions).with_foreign_key('author_id').dependent(:destroy) }
  it { should have_many(:answers).with_foreign_key('author_id').dependent(:destroy) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  context 'define author of entity' do
    let(:user1){create(:user)}
    let(:user2){create(:user)}
    let!(:question){create(:question, author: user1)}
    let!(:answer){create(:answer, author: user2)}

    it 'show correct author of entity' do
      expect(user1.author_of?(question)).to be_truthy
      expect(user2.author_of?(answer)).to be_truthy
      expect(user1.author_of?(answer)).to be_falsey
      expect(user2.author_of?(question)).to be_falsey
    end
  end

end
