class Boke < ActiveRecord::Base
  # ヘルパーでやろうとしたが、hamlでエラーが出たのでここで回避
  def image_url(boke_id)
  	"http://ss.bokete.jp/#{boke_id}"
  end
  def raw_url(boke_id)
  	"http://ss.bokete.jp/#{boke_id}"
  end
  
end
