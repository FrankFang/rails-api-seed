require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "PasswordResetRequests 密码重置请求" do
  let(:email) { 'xxxx@xxxxxx.com' }
  parameter :email, '邮箱', required: true
  post "/password_reset_requests" do
    response_field :resource, 'PasswordResetRequest 对象'
    example "请求重置密码" do
      User.create! email: email, password: '123456'
      expect { do_request }
        .to change { PasswordResetRequest.count }.by(+1)
              .and have_enqueued_job.on_queue('mailers')
      expect(status).to eq 200
    end
  end

end
