module CurrentNavHelper
  def current_nav(path)
    "inline-flex p-4 blue-600 rounded-t-lg border-b-2 border-blue-800 active dark:text-blue-500 dark:border-blue-800 group" if request.path == path
  end
end
