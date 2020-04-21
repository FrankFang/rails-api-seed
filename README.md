# README

请全局搜索 your_domain.com，将其替换为你的域名
请全局搜索 your_project_name，将其替换为你的项目名
做完之后，删除这三行文字

## 数据库

* 打开数据库：`docker run -v /path/to/your_project_name-data:/var/lib/postgresql/data -p 5432:5432 -e POSTGRES_USER=your_project_name -d postgres:12.2`
* 运行 `bin/rails db:create db:migrate` 获得 db/schema.rb

## 测试

* 运行 `rails db:migrate RAILS_ENV=test`
* 运行普通测试用例 `bundle exec rspec`

* 生成 API 文档：`bin/rails docs:generate`; 打开 doc/api/index.html;

## 其他命令

* 添加 discard migration：`bin/rails g migration add_discarded_at_to_???s discarded_at:datetime:index`

