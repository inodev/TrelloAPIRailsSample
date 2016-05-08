module TrelloApi
  require 'net/http'

  ### define ###
  # 参考 http://qiita.com/isseium/items/8eebac5b79ff6ed1a180 
  TRELLO_URL        = "trello.com".freeze
  TRELLO_APP_KEY    = "XXXXXXXXXX8d89db84ab5bc0376XXXXX".freeze
  TRELLO_TOKEN      = "XXXXXXXXXXaa1221bd921a546e37f18ac062a9f00b1df31143906b6ae99XXXXX".freeze
  TRELLO_LIST_ID    = "XXXXXXXXXXd5b83614cXXXXX".freeze
 

  ### カード発行メソッド ###
  def create_card(title = "No Title", content = "No Content", reference_url = nil)
    # クエリ設定
    h = {
      key: TRELLO_APP_KEY,
      name: title,
      desc: "【投稿内容】" + content,
      token: TRELLO_TOKEN,
      idList: TRELLO_LIST_ID,
      urlSource: reference_url,
      pos: "top",
      due: (Time.now.tomorrow.to_f*1000).to_i  # 期日（UNIX TIME*1000）
    }

    # クエリストリング組み立て
    queries = h.map{|k,v| URI.encode(k.to_s) + "=" + URI.encode(v.to_s)}.join("&")

    # POSTメソッドでHTTPリクエスト
    response = Net::HTTP.start(TRELLO_URL, 443, use_ssl: true) do |http|
      # 接続startの前後に例外処理対応を入れたほうが良い
      resp = http.post('/1/cards', queries)
    end
  end
end
