# coding: utf-8

require 'faraday'
require 'json'

API_SERVER = 'http://api.search.nicovideo.jp'
API_URL = '/api/snapshot/'

conn = Faraday::Connection.new(url: API_SERVER) do |builder|
  #  builder.use Faraday::Request::UrlEncoded  # リクエストパラメータを URL エンコードする
  #  builder.use Faraday::Response::Logger     # リクエストを標準出力に出力する
  builder.use Faraday::Adapter::NetHttp        # Net/HTTP をアダプターに使う
end

field = ['cmsid', 'title', 'description', 'tags', 'start_time', 'thumbnail_url',
         'view_counter', 'comment_counter', 'mylist_counter', 'last_res_body',
         'length_seconds']
# 動画ID, 動画のタイトル, 動画の説明文, 動画のタグ, 動画の投稿日時, 動画のサムネイルURL,
# 再生数,コメント数,マイリスト数,直近のコメント
# 動画の再生時間(秒)

keyword = ['title', 'description', 'tags']
tag = ['tags_exact']

v = {
  query:  '艦これ',
  service:  ['video'],
  search:  tag,
  join:  field,
  issuer: 'ふぁらおてすと'
}

puts JSON.dump(v)

res = conn.post do |req|
  req.url API_URL
  req.body = JSON.dump(v)
end

puts res.body
