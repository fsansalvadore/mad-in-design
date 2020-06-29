ActiveAdmin.register TecnicalSponsor do
  menu parent: 'People', label: 'Tecnical Sponsor', priority: 5

  permit_params :alt_text,
                :logo,
                :position,
                :published

  include ActiveAdmin::SortableTable
  config.sort_order = 'position_asc'

  member_action :publish_tecnical_sponsor, method: :put do
    tecnical_sponsor = TecnicalSponsor.find(params[:id])
    tecnical_sponsor.update(published: true)
    redirect_to admin_tecnical_sponsor_path(tecnical_sponsor)
  end

  member_action :unpublish_tecnical_sponsor, method: :put do
    tecnical_sponsor = TecnicalSponsor.find(params[:id])
    tecnical_sponsor.update(published: false)
    redirect_to admin_tecnical_sponsor_path(tecnical_sponsor)
  end

  # action_item :publish, only: :show do
  #   link_to "Anteprima live", tecnical_sponsor_path(tecnical_sponsor)
  # end

  action_item :publish, only: :show do
    link_to "Pubblica", publish_admin_tecnical_sponsor_path(tecnical_sponsor), method: :put if !tecnical_sponsor.published
  end

  action_item :unpublish, only: :show do
    link_to "Metti offline", unpublish_admin_tecnical_sponsor_path(tecnical_sponsor), method: :put if tecnical_sponsor.published
  end

  member_action :publish, method: :put do
    tecnical_sponsor = TecnicalSponsor.find(params[:id])
    tecnical_sponsor.update(published: true)
    redirect_to admin_tecnical_sponsors_path
  end

  member_action :unpublish, method: :put do
    tecnical_sponsor = TecnicalSponsor.find(params[:id])
    tecnical_sponsor.update(published: false)
    redirect_to admin_tecnical_sponsors_path
  end

  index do
    handle_column
    column "Logo" do |sponsor|
      if sponsor.logo.attached?
        image_tag(cl_image_path(sponsor.logo.key), class: "admin_table_thumb")
      end
    end
    column :alt_text
    column :published
    column "Pubblica" do |tecnical_sponsor|
      if !tecnical_sponsor.published
        link_to "Pubblica", publish_admin_tecnical_sponsor_path(tecnical_sponsor), method: :put
      else
        link_to "Metti offline", unpublish_admin_tecnical_sponsor_path(tecnical_sponsor), method: :put
      end
    end
    actions
  end

  show do
    attributes_table do
      row :published,           label: 'Pubblicato'
      row :logo do |i|
        if tecnical_sponsor.logo.attached?
          image_tag(cl_image_path(tecnical_sponsor.logo.key), class: "image-preview")
        end
      end
      row :alt_text,             label: 'Meta testo per il logo'
    end
  end

  member_action :delete_image, method: :delete do
   @pic = ActiveStorage::Attachment.find(params[:id])
   @pic.purge_later
   redirect_back(fallback_location: edit_admin_tecnical_sponsor_path)
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Sponsor Tecnico' do
      f.input :published,          label: 'Pubblicato'
      f.input :logo,               label: 'Logo', as: :file, hint: "Peso max: 200Kb. Altezza max 1000px. Larghezza max 1000px"
      if f.object.logo.attached?
        div class: "form-aligned" do
          div cl_image_tag(f.object.logo.key)
          unless f.object.id.nil?
            div link_to "Rimuovi immagine", delete_image_admin_staff_path(f.object.logo.id),method: :delete,class: "delete-btn", data: { confirm: "Confermi di voler cancellare l'immagine?" }
          end
        end
      end
      f.input :alt_text,           label: "Meta testo per l'immagine"
    end
    f.actions
  end
end
