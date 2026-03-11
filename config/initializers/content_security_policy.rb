# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

# Rails.application.configure do
#   config.content_security_policy do |policy|
#     policy.default_src :self, :https
#     policy.font_src    :self, :https, :data
#     policy.img_src     :self, :https, :data
#     policy.object_src  :none
#     policy.script_src  :self, :https
#     policy.style_src   :self, :https
#     # Specify URI for violation reports
#     # policy.report_uri "/csp-violation-report-endpoint"
#   end
#
#   # Generate session nonces for permitted importmap, inline scripts, and inline styles.
#   config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
#   config.content_security_policy_nonce_directives = %w(script-src style-src)
#
#   # Automatically add `nonce` to `javascript_tag`, `javascript_include_tag`, and `stylesheet_link_tag`
#   # if the corresponding directives are specified in `content_security_policy_nonce_directives`.
#   # config.content_security_policy_nonce_auto = true
#
#   # Report violations without enforcing the policy.
#   # config.content_security_policy_report_only = true
# end

# config/initializers/content_security_policy.rb
# 一番下に追記
# config/initializers/content_security_policy.rb

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self, :https
    
    # :unsafe_inline を追加して、埋め込みタグ内のスクリプトを実行可能にする
    policy.script_src  :self, :https, "https://platform.twitter.com", :unsafe_inline
    
    # 動画プレイヤー表示のために必要
    policy.frame_src   :self, :https, "https://platform.twitter.com", "https://syndication.twitter.com"
    
    policy.style_src   :self, :https, :unsafe_inline
    policy.img_src     :self, :https, :data
    policy.font_src    :self, :https, :data
    policy.object_src  :none
  end
end
