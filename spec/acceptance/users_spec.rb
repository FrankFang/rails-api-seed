require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Users 用户" do
  let(:email) { 'no-reply@your_domain.com' }
  let(:password) { '12345678' }
  let(:password_confirmation) { '12345678' }
  let(:user) { User.first }
  let(:id) { user.id }
  before :each do
    User.create!(email: email, password: password, name: '高圆圆')
  end
  get "/users/:id" do
    parameter :id, required: true
    response_field :resource, "User 对象"
    example "读取用户" do
      do_request
      expect(JSON.parse(response_body)['resource']['id']).to eq(id)
    end
  end
  post "/users" do
    parameter :email, '邮箱', required: true
    parameter :password, '密码', required: true
    parameter :password_confirmation, '确认密码'
    response_field :resource, "User 对象"
    example "创建用户" do
      expect { do_request }
        .to change { User.count }.by(+1)
              .and have_enqueued_job.on_queue('mailers')
      expect(status).to eq 200
    end
  end
  patch "/users/:id" do
    parameter :name, '姓名'
    response_field :resource, 'User 对象'
    response_field :errors, 'User 报错信息'
    example '更新用户' do
      expect {
        do_request name: 'Frank'
        user.reload
      }.to change(user, :name)
      expect(status).to eq 200
    end
  end

end
