ActiveAdmin.register Partner do
  menu parent: 'People', label: 'Partner e Istituzioni', priority: 4

  permit_params :name,
                :logo,
                :position,
                :published

  include ActiveAdmin::SortableTable
  config.sort_order = 'position_asc'

  member_action :publish_partner, method: :put do
    partner = Partner.find(params[:id])
    partner.update(published: true)
    redirect_to admin_partner_path(partner)
  end

  member_action :unpublish_partner, method: :put do
    partner = Partner.find(params[:id])
    partner.update(published: false)
    redirect_to admin_partner_path(partner)
  end

  action_item :publish, only: :show do
    link_to "Pubblica", publish_admin_partner_path(partner), method: :put if !partner.published
  end

  action_item :unpublish, only: :show do
    link_to "Metti offline", unpublish_admin_partner_path(partner), method: :put if partner.published
  end

  member_action :publish, method: :put do
    partner = Partner.find(params[:id])
    partner.update(published: true)
    redirect_to admin_partners_path
  end

  member_action :unpublish, method: :put do
    partner = Partner.find(params[:id])
    partner.update(published: false)
    redirect_to admin_partners_path
  end

  index do
    handle_column
    column "Partner / Alt text" do |partner|
      link_to "#{partner.name}", admin_partner_path(partner)
    end
    column "Logo" do |partner|
      if partner.logo.attached?
        image_tag(cl_image_path(partner.logo.key), class: "admin_table_thumb")
      end
    end
    column :published
    column "Pubblica" do |partner|
      if !partner.published
        link_to "Pubblica", publish_admin_partner_path(partner), method: :put
      else
        link_to "Metti offline", unpublish_admin_partner_path(partner), method: :put
      end
    end
    actions
  end

  show do
    attributes_table do
      row :published,           label: 'Pubblicato'
      row :logo do |i|
        if partner.logo.attached?
          image_tag(cl_image_path(partner.logo.key), class: "image-preview")
        end
      end
      row :name,                label: 'Partner / Alt Text'
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
      f.input :logo,               label: 'Logo', as: :file, hint: "Peso max: 200Kb. Altezza max 1000px. Larghezza max 1000px"
      if f.object.logo.attached?
        div class: "form-aligned" do
          div cl_image_tag(f.object.logo.key)
          unless f.object.id.nil?
            div link_to "Rimuovi immagine", delete_image_admin_staff_path(f.object.logo.id),method: :delete,class: "delete-btn", data: { confirm: "Confermi di voler cancellare l'immagine?" }
          end
        end
      end
      f.input :name,                label: 'Partner / Alt Text'
    end
    f.actions
  end
end
