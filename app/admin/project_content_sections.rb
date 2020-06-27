ActiveAdmin.register ProjectContentSection do
  menu false
  belongs_to :project
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :rich_text, :image, :video_provider, :video_url, :position, :project_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:rich_text, :image, :video_provider, :video_url, :position, :project_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
