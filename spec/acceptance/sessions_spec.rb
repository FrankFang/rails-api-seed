require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Session 会话" do
  post "/session" do
    response_field :resource, "User 对象"
    response_field :errors, "User 错误信息"
    parameter :email, '邮箱', required: true
    parameter :password, '密码', required: true
    let(:email) { 'gaoyuanyuan@163.com' }
    let(:password) { '123456' }
    let(:name) { '高圆圆' }
    example "登录" do
      user = User.create! email: email, name: name, password: password
      do_request
      expect(status).to eq 200
      expect(JSON.parse(response_body)['resource']['id']).to eq(user.id)
    end
  end

  delete '/session' do
    response_field :status, '200 表示成功，其他表示失败'
    example "注销" do
      do_request
      expect(status).to eq 200
      expect(JSON.parse(response_body)[:current_user_id]).to eq(nil)
    end
  end

end
