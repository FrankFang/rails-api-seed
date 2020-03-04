# README


# 命令

* 生成 API 文档：`bin/rails docs:generate`; 打开 doc/api/index.html;
* 打开数据库：`docker run -v /path/to/morney-data:/var/lib/postgresql/data -p 5432:5432 -e POSTGRES_USER=dingdong -d postgres`
* 添加 discard migration：`bin/rails g migration add_discarded_at_to_???s discarded_at:datetime:index`

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
