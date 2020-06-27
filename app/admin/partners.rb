ActiveAdmin.register Partner do
  menu parent: 'People', label: 'Partner e Istituzioni', priority: 4

  permit_params :name,
                :position,
                :published

  include ActiveAdmin::SortableTable
  config.sort_order = 'position_asc'

  index do
    handle_column
    column "partner" do |partner|
      link_to "#{partner.name}", admin_partner_path(partner)
    end
    column :published
    actions
  end

  show do
    attributes_table do
      row :published,           label: 'Pubblicato'
      row :name,                label: 'Nome'
    end
  end

  member_action :delete_image, method: :delete do
   @pic = ActiveStorage::Attachment.find(params[:id])
   @pic.purge_later
   redirect_back(fallback_location: edit_admin_partner_path)
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Partner/Istituzione' do
      f.input :published,           label: 'Pubblicato'
      f.input :name,                label: 'Nome'
    end
    f.actions
  end
end
