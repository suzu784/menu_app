crumb :root do
  link "Home", root_path
end

# 投稿のパンくずリスト
crumb :posts do
  link "投稿一覧", posts_path
  parent :root
end

crumb :post do |post|
  link post.cook_name, post_path(post)
  parent :posts
end

# 会員のパンくずリスト
crumb :customers do
  link "会員一覧", customers_path
  parent :root
end

crumb :customer do |customer|
  link customer.full_name, customer_path(customer)
  parent :customers
end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).