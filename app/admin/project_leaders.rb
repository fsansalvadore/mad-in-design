ActiveAdmin.register ProjectLeader do
  menu parent: 'People', label: 'Project Leader', priority: 3

  permit_params :name,
                :photo,
                :description,
                :year,
                :position,
                :published

  include ActiveAdmin::SortableTable
  config.sort_order = 'position_asc'

  index do
    handle_column
    column "Project Leader" do |project_leader|
      link_to "#{project_leader.name}", admin_project_leader_path(project_leader)
    end
    column "Foto" do |project_leader|
      if project_leader.photo.attached?
        image_tag(cl_image_path(project_leader.photo.key), class: "admin_table_thumb")
      end
    end
    column :year
    column :published
    actions
  end

  show do
    attributes_table do
      row :published,           label: 'Pubblicato'
      row :photo do |i|
        if project_leader.photo.attached?
          image_tag(cl_image_path(project_leader.photo.key), class: "image-preview")
        end
      end
      row :name,                label: 'Nome'
      row :year,                label: 'Anno'
      row (:description) {|project_leader| raw(project_leader.description)}
    end
  end

  member_action :delete_image, method: :delete do
   @pic = ActiveStorage::Attachment.find(params[:id])
   @pic.purge_later
   redirect_back(fallback_location: edit_admin_project_leader_path)
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Project Leader' do
      f.input :published,           label: 'Pubblicato'
      f.input :name,                label: 'Nome'
      f.input :year,                label: 'Anno'
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
