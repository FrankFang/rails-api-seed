require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Records 记录" do
  before :each do
    no_doc do
      user = User.create!(email: 'xxxx@xxxxxx.com', password: '123456', name: '高圆圆')
      Tag.create! name: 'test', user: user
      Record.create! amount: 10000, category: 'outgoings', user: user
      Record.create! amount: 20000, category: 'outgoings', user: user
      sign_in user
    end
  end
  let(:record) { Record.first }
  let(:id) { record.id }
  let(:amount) { 10000 }
  let(:category) { 'outgoings' }
  let(:tag) { Tag.first }
  let(:tag_ids) { [tag.id] }
  get "/records" do
    parameter :page, '页码'
    parameter :order, '排序规则，如 "created_at asc, id desc"'
    response_field :resources, "Record 对象数组"
    response_field :pagination, '分页信息'
    let(:page) { 1 }
    example "获取所有记录" do
      do_request
      p response_body
      expect(status).to eq 200
    end
  end
  get "/records/:id" do
    response_field :resource, "Record 对象"

    example "获取记录" do
      do_request
      expect(status).to eq 200
      expect(JSON.parse(response_body)['resource']['id']).to eq id
    end
  end
  post "/records/" do
    response_field :resource, "Record 对象"
    response_field :errors, "Record 错误信息"
    parameter :amount, '金额', required: true
    parameter :category, '类型', required: true
    parameter :notes, '备注'
    parameter :tag_ids, '标签 ID 列表'
    example "创建记录" do
      do_request
      expect(status).to eq 200
      expect(JSON.parse(response_body)['resource']).to be
    end
  end
  delete "/records/:id" do
    example "删除记录" do
      do_request
      expect(status).to be 200
    end
  end

  patch "/records/:id" do
    response_field :resource, "Record 对象"
    response_field :errors, "Record 错误信息"
    parameter :amount, '金额', required: true
    parameter :category, '类型', required: true
    parameter :notes, '备注'
    parameter :tag_ids, '标签 ID 列表'
    example "更新记录" do
      expect {
        do_request amount: 9999
        record.reload
      }.to change(record, :amount)
      expect(status).to eq 200
    end
  end
end
