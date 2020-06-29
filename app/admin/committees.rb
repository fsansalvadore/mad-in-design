ActiveAdmin.register Committee do
  menu parent: 'People', label: 'Comitato Tecnico Scientifico', priority: 2

  permit_params :name,
                :role,
                :photo,
                :description,
                :position,
                :published

  include ActiveAdmin::SortableTable
  config.sort_order = 'position_asc'

  index do
    handle_column
    column "Persona" do |committee|
      link_to "#{committee.name}", admin_committee_path(committee)
    end
    column "Foto" do |committee|
      if committee.photo.attached?
        image_tag(cl_image_path(committee.photo.key), class: "admin_table_thumb")
      end
    end
    column :role
    column :published
    actions
  end

  show do
    attributes_table do
      row :published,           label: 'Pubblicato'
      row :photo do |i|
        if committee.photo.attached?
          image_tag(cl_image_path(committee.photo.key), class: "image-preview")
        end
      end
      row :name,                label: 'Nome'
      row :role,                label: 'Ruolo'
      row (:description) {|committee| raw(committee.description)}
    end
  end

  member_action :delete_image, method: :delete do
   @pic = ActiveStorage::Attachment.find(params[:id])
   @pic.purge_later
   redirect_back(fallback_location: edit_admin_staff_path)
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Membro/a del Comitato Tecnico Scientifico' do
      f.input :published,           label: 'Pubblicato'
      f.input :name,                label: 'Nome'
      f.input :role,                label: 'Ruolo'
      f.input :photo,               label: 'Foto', as: :file, hint: "Peso max: 500Kb. Altezza max 2000px. Larghezza max 3000px"
      if f.object.photo.attached?
        div class: "form-aligned" do
          div cl_image_tag(f.object.photo.key)
          if f.object.id.nil?
            div link_to "Rimuovi immagine", delete_image_admin_staff_path(f.object.photo.id),method: :delete,class: "delete-btn", data: { confirm: "Confermi di voler cancellare l'immagine?" }
          end
        end
      end
      f.input :description,         label: 'Descrizione', as: :quill_editor
    end
    f.actions
  end
end
