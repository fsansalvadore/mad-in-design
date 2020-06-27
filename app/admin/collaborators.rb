ActiveAdmin.register Collaborator do
  menu parent: 'People', label: 'Hanno lavorato con noi', priority: 6

  permit_params :name,
                :link,
                :link_alt_text,
                :photo,
                :description,
                :position,
                :published

  include ActiveAdmin::SortableTable
  config.sort_order = 'position_asc'

  index do
    handle_column
    column "Collaboratore" do |collaborator|
      link_to "#{collaborator.name}", admin_collaborator_path(collaborator)
    end
    column "Foto" do |collaborator|
      if collaborator.photo.attached?
        image_tag(cl_image_path(collaborator.photo.key), class: "admin_table_thumb")
      end
    end
    column :published
    actions
  end

  show do
    attributes_table do
      row :published,           label: 'Pubblicato'
      row :photo do |i|
        if collaborator.photo.attached?
          image_tag(cl_image_path(collaborator.photo.key), class: "image-preview")
        end
      end
      row :name,                label: 'Nome'
      row :link,                label: 'Link'
      row (:description) {|collaborator| raw(collaborator.description)}
    end
  end

  member_action :delete_image, method: :delete do
   @pic = ActiveStorage::Attachment.find(params[:id])
   @pic.purge_later
   redirect_back(fallback_location: edit_admin_collaborator_path)
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Collaboratore' do
      f.input :published,           label: 'Pubblicato'
      f.input :name,                label: 'Nome', hint: 'Obbligatorio'
      f.input :link,                label: 'Link', hint: 'Opzionale'
      # f.input :link_alt_text,       label: 'Ruolo'
      f.input :photo,               label: 'Foto', as: :file
      if f.object.photo.attached?
        div class: "form-aligned" do
          div cl_image_tag(f.object.photo.key)
          div link_to "Rimuovi immagine", delete_image_admin_staff_path(f.object.photo.id),method: :delete,class: "delete-btn", data: { confirm: "Confermi di voler cancellare l'immagine?" }
        end
      end
      f.input :description,         label: 'Descrizione', as: :quill_editor
    end
    f.actions
  end
end
