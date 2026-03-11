module ApplicationHelper

  # app/helpers/application_helper.rb

def render_form_fields(f, columns)
  fields = columns.map do |column|
    options = field_options_for(column)
    
    content_tag(:div, class: "field-group mb-4") do
      label_part = f.label(column, options[:label], class: "block text-sm font-medium text-gray-700")

      field_part = if options[:type] == :collection_check_boxes
          content_tag(:div, class: "flex flex-wrap gap-x-4 gap-y-2 mt-2") do
            # ブロックを使う場合、args の第5引数ではなく、ここ（b.check_box）にクラスを書く
            f.collection_check_boxes(column, options[:args][0], options[:args][1], options[:args][2], options[:args][3]) do |b|
              b.label(class: "inline-flex items-center cursor-pointer text-sm text-gray-700") { 
                b.check_box(class: "rounded border-gray-300 text-indigo-600 mr-2") + b.text 
              }
            end
          end
        elsif options[:args]
          f.send(options[:type], column, *options[:args])
        else
          f.send(options[:type], column, options[:html_options])
        end

      safe_join([label_part, field_part])
    end
  end
  safe_join(fields)
end

  def render_nested_post_fields(f)
    # Streamerの新規登録時のみ表示する条件チェック
    return unless f.object.is_a?(Streamer) && f.object.new_record?

    content_tag(:div, class: "bg-white p-6 rounded-lg border-2 border-indigo-100 mt-6") do
      safe_join([
        content_tag(:h3, "最初の投稿を作成", class: "text-lg font-bold mb-4 text-indigo-600"),
        
        # ネストしたフォームの生成
        f.fields_for(:posts) do |post_f|
          render_form_fields(post_f, [:content, :x_video_url, :genre_ids])
        end
      ])
    end
  end

  private

  def field_options_for(column)
    # 基本のスタイル
    base_class = "mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"

    # カラム名に応じた設定を定義
    case column.to_sym
    when :icon
    { 
      type: :file_field, 
      label: "配信者アイコン (画像)", 
      html_options: { 
        accept: 'image/*',
        class: "block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-md file:border-0 file:text-sm file:font-semibold file:bg-indigo-50 file:text-indigo-700 hover:file:bg-indigo-100"
      } 
    }
    when :genre_ids
        {
          type: :collection_check_boxes,
          label: "ジャンルを選択",
          # args: [collection, value_method, text_method, options = {}, html_options = {}]
          args: [
            Genre.all, :id, :name, {}, 
            { class: "rounded border-gray-300 text-indigo-600 focus:ring-indigo-500 mr-2" }
          ]
        }
    when :streamer_id
      {
        type: :collection_select,
        label: "配信者を選択",
        # collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
        # column(streamer_id) 以外の引数を配列で用意
        args: [Streamer.all, :id, :name, { prompt: "選択してください" }, { class: base_class }]
      }
    when :x_video_url
      { 
      type: :url_field, 
      label: "𝕏 ポストのURL", 
      html_options: { 
          class: base_class,
          placeholder: "https://x.com...",
          required: true # 必須にする場合
        } 
    }
    when :email
      { type: :email_field, label: "メールアドレス", html_options: { class: base_class } }
    when :password
      { type: :password_field, label: "パスワード", html_options: { class: base_class } }
    when :password_confirmation
      { type: :password_field, label: "パスワード(確認)", html_options: { class: base_class } }
    when :name
      { type: :text_field, label: "名前", html_options: { class: base_class } }
    when :x_url
      { type: :text_field, label: "𝕏 ID (@なし)", html_options: { class: base_class } }
    when :content
      { type: :text_area, label: "配信内容の紹介", html_options: { class: base_class } }
    else
      # デフォルト設定（未定義の場合）
      { type: :text_field, label: "未定義の項目", html_options: { class: base_class, placeholder: "編集不可" } }
    end
  end
end
