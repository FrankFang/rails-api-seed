require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Tags 标签" do
  let(:user) { User.first }
  let(:tag) { Tag.first }
  let(:name) { '测试' }
  let(:id) { tag.id }
  before :each do
    no_doc do
      user = User.create!(email: 'xxxx@xxxxxx.com', password: '123456', name: '高圆圆')
      Tag.create! name: '游戏皮肤', user: user
      sign_in user
    end
  end
  get "/tags" do
    parameter :page, '页码'
    parameter :order, '排序规则，如 "created_at asc, id desc"'
    response_field :resources, "Tag 对象数组"
    response_field :pagination, '分页信息'
    example "获取所有标签" do
      Tag.destroy_all
      Tag.create! name: '游戏皮肤', user: user
      Tag.create! name: '吃饭', user: user
      do_request
      expect(status).to eq 200
      expect(JSON.parse(response_body)['resources'].size).to eq 2
    end
  end
  get "/tags/:id" do
    response_field :resource, "Tag 对象"
    example "读取标签" do
      tag = Tag.create! name: '游戏皮肤', user: user
      do_request id: tag.id
      expect(status).to eq 200
      expect(JSON.parse(response_body)['resource']['id']).to eq tag.id
    end
  end
  delete "/tags/:id" do
    example "删除标签" do
      tag = Tag.create! name: '游戏皮肤', user: user
      expect {
        do_request id: tag.id
      }.to change { Tag.count }.by(-1)
      expect(status).to eq 200
    end
  end
  patch "/tags/:id" do
    parameter :name, '标签名', required: true
    response_field :resource, "Tag 对象"
    response_field :errors, "Tag 出错信息"
    example "更新标签" do
      expect {
        do_request
        tag.reload
      }.to change(tag, :name)
      expect(status).to eq 200
    end
  end
  post "/tags" do
    response_field :resource, "Tag 对象"
    response_field :errors, "Tag 错误信息"
    parameter :name, '标签名', required: true
    example "创建标签" do
      expect {
        do_request name: '新的标签名'
      }.to change { Tag.count }.by(+1)
      expect(status).to eq 200
    end
  end
end
