require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Tagging 标记" do
  before :each do
    no_doc do
      user = User.create! email: 'xxxx@xxxxxx.com', password: '123456', name: '高圆圆'
      tag = Tag.create! name: '游戏皮肤', user: user
      record = Record.create! amount: 10000, category: 'outgoings', user: user
      Tagging.create! user: user, tag: tag, record: record
      sign_in user
    end
  end
  let(:tagging) { Tagging.first }
  let(:id) { tagging.id }
  let(:user) { User.first }
  let(:tag) { Tag.first }
  let(:record) { Record.first }
  get '/taggings' do
    parameter :page, '页码'
    parameter :order, '排序规则，如 "created_at asc, id desc"'
    response_field :resources, "Tagging 对象数组"
    response_field :pagination, '分页信息'
    example '获取所有标记' do
      do_request
      expect(status).to eq 200
      expect(JSON.parse(response_body)['resources']).to be
    end
  end
  get '/taggings/:id' do
    example '获取标记' do
      do_request
      expect(status).to eq 200
      expect(JSON.parse(response_body)['resource']).to be
    end
  end
  post '/taggings' do
    parameter :tag_id, 'User ID'
    parameter :record_id, 'Record ID'
    example '创建标记' do
      expect {
        do_request tag_id: tag.id, record_id: record.id
      }.to change { Tagging.count }.by(+1)
      expect(status).to eq 200
      expect(JSON.parse(response_body)['resource']).to be
    end
  end
  delete '/taggings/:id' do
    let(:id) { tagging.id }
    example '删除标记' do
      expect {
        do_request
      }.to change { Tagging.count }.by(-1)
      expect(status).to eq 200
    end
  end
end
