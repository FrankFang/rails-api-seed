require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  describe '重置密码' do
    before :each do
      @email = '1@example.com'
      @password = '123456'
      @user = User.create!(email: @email, password: @password)
      @password_reset_request = PasswordResetRequest.create!(email: @user.email)
    end
    it 'should 提示 code 不存在' do
      post :create, params: {code: 'hi', password: '123456', password_confirmation: '222222'}
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['errors']['code']).to be
    end
    it 'should 提示密码太短' do
      post :create, params: {code: @password_reset_request.code, password: '12', password_confirmation: '12'}
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['errors']['password']).to be
    end
    it 'should 提示密码不匹配' do
      post :create, params: {code: @password_reset_request.code, password: '123456', password_confirmation: '123457'}
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['errors']['password_confirmation']).to be
    end
  end
end
