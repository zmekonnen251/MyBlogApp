require 'rails_helper'

RSpec.describe User, type: :model do
  it 'it should create a user' do
    user = User.create(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    expect(user).to be_valid
  end

  it 'The user name should be present' do
    user = User.create(bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    expect(user).to be_invalid
  end

  it 'The user name length should be below 50 characters' do
    user = User.create(name: 'test name', bio: 'test bio', photo: 'www.photourl.com/test.jpg')
    expect(user).to be_valid
  end
end
