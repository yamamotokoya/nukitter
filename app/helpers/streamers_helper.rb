module StreamersHelper
    def streamer_avatar_class(name)
    # Tailwindのカラーバリエーション（背景色と文字色のセット）
    colors = [
      "bg-red-100 text-red-700",
      "bg-blue-100 text-blue-700",
      "bg-green-100 text-green-700",
      "bg-yellow-100 text-yellow-700",
      "bg-indigo-100 text-indigo-700",
      "bg-purple-100 text-purple-700",
      "bg-pink-100 text-pink-700",
      "bg-emerald-100 text-emerald-700"
    ]

    # 名前の文字列を数値に変換（sumメソッドで各文字のコードを足す）
    # 色の数（size）で割った余りを使うことで、同じ名前なら必ず同じ色になる
    index = name.to_s.sum % colors.size
    colors[index]
  end
end
