crumb :root do
  link "Home", root_path
end

crumb :category do
  link "カテゴリー検索", category_items_path
  parent :root
end
crumb :item_search do
  link "検索結果", item_search_items_path
  parent :category
end

crumb :brand do
  link "ブランド検索", brand_items_path
  parent :root
end

crumb :tag_search do
  link "検索結果", brand_items_path
  parent :brand
end







# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).