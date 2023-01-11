# README
**User テーブル**
| column | data |
| ---- | ---- |
| name | string |

**Task テーブル**
| column | data |
| ---- | ---- |
| user_id | bigint |
| title | string |
| to_do | text |
| dead_line | datetime |
| priority | integer |
| status | string |

**Label テーブル**
| column | data |
| ---- | ---- |
| user_id | bignit |
| task_id | bignit |

**Herokuにデプロイする方法**
1. Herokuに新しいアプリ作成 $heroku create
2. Gemfile追加('net-smtp', 'net-imap', 'net-pop') $bundle install
3. Herokuアプリへコミット $git add . → $git commit -m 'init'
4. Rubyのbuildpack追加 $heroku buildpacks:set heroku/ruby
5. Node.jsのbuildpack追加 $heroku buildpacks:add --index 1 heroku/nodejs
6. Herokuへデプロイ $git push heroku main
7. DBの移行 $heroku run rails db:migrate
8. アプリケーションにアクセス $heroku open