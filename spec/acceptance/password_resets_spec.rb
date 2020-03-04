require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "PasswordResets 密码重置" do
  parameter :password, '密码'
  parameter :password_confirmation, '确认密码'
  parameter :code, '重置码'
  response_field :resource, 'PasswordReset 对象'
  let(:email) { '1@example.com' }
  let(:password) { '123456' }
  let(:password_confirmation) { '123456' }
  let(:user) { User.create!(email: email, password: password) }
  let(:password_reset_request) { PasswordResetRequest.create!(email: user.email) }
  let(:code) { password_reset_request.code }
  post "/password_resets" do
    example "重置密码" do
      expect {
        do_request
        user.reload
      }.to change(user, :password_digest)
      expect(status).to eq 200
    end
  end
end
