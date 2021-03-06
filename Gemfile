source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails',      '6.0.3'
gem 'aws-sdk-s3',              '1.46.0', require: false # 本番環境での画像アップロード用
gem 'image_processing',           '1.9.3' # 画像処理用のgemを追加
gem 'mini_magick',                '4.9.5' # 画像処理用のgemを追加
gem 'active_storage_validations', '0.8.2' # 画像アップロードに対するバリデーションをかけるため
gem 'bcrypt',     '3.1.13' # ハッシュ化されたパスワードを使うため
gem 'faker',      '2.1.2' # サンプルで使用するユーザーを増やすため
gem 'will_paginate','3.1.8' # ページネーション機能のため
gem 'bootstrap-will_paginate','1.0.0' # ページネーション機能のため
gem 'bootstrap-sass', '3.4.1'
gem 'puma',       '4.3.6'
gem 'sass-rails', '5.1.0'
gem 'webpacker',  '4.0.7'
gem 'turbolinks', '5.2.0'
gem 'jbuilder',   '2.9.1'
gem 'bootsnap',   '1.4.5', require: false

group :development, :test do
  gem 'sqlite3', '1.4.1'
  gem 'byebug',  '11.0.1', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console',           '4.0.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.1.0'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'capybara',                 '3.28.0'
  gem 'selenium-webdriver',       '3.142.4'
  gem 'webdrivers',               '4.1.2'
  gem 'rails-controller-testing', '1.0.4'
  # ↓↓↓ クラウドIDEを含む多くのシステムで red や green の表示が見やすくなる 
  gem 'minitest',                 '5.11.3'
  gem 'minitest-reporters',       '1.3.8'
  # ↓↓↓ ファイルなどを変更すると自動的にテストを実行してくれるツール
  gem 'guard',                    '2.16.2'
  gem 'guard-minitest',           '2.4.6'
end

group :production do
  gem 'pg', '1.1.4'
end

# Windows ではタイムゾーン情報用の tzinfo-data gem を含める必要があります
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]