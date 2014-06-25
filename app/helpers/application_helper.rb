module ApplicationHelper
  def full_image_path_helper(img)
    root_url.chomp('/') + asset_path(img)
  end
end
