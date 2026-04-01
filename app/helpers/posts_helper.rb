module PostsHelper
    def post_card_link_path(post)
    # affiliate_urlがあればそれを、なければ詳細パスを返す
    post.affiliate_url.presence || post_path(post)
  end

  def post_card_link_options(post)
    # affiliate_urlがある場合のみ、別タブ(target)とnofollow(rel)を付与する
    if post.affiliate_url.present?
      { target: "_blank", rel: "nofollow", class: "absolute inset-0 z-10" }
    else
      { class: "absolute inset-0 z-10" }
    end
  end

  def post_card_button_text(post)
    post.affiliate_url.present? ? "サンプルを見る" : "詳細を見る"
  end

  def post_external_link?(post)
    post.affiliate_url.present?
  end
end
