ActiveAdmin.register Staff do
  menu parent: 'People', label: 'Staff', priority: 1

  permit_params :name,
                :role,
                :photo,
                :description,
                :position,
                :published

  include ActiveAdmin::SortableTable
  config.sort_order = 'position_asc'

  member_action :publish_staff, method: :put do
    staff = Staff.find(params[:id])
    staff.update(published: true)
    redirect_to admin_staff_path(staff)
  end

  member_action :unpublish_staff, method: :put do
    staff = Staff.find(params[:id])
    staff.update(published: false)
    redirect_to admin_staff_path(staff)
  end

  action_item :publish, only: :show do
    link_to "Pubblica", publish_admin_staff_path(staff), method: :put if !staff.published
  end

  action_item :unpublish, only: :show do
    link_to "Metti offline", unpublish_admin_staff_path(staff), method: :put if staff.published
  end

  member_action :publish, method: :put do
    staff = Staff.find(params[:id])
    staff.update(published: true)
    redirect_to admin_staffs_path
  end

  member_action :unpublish, method: :put do
    staff = Staff.find(params[:id])
    staff.update(published: false)
    redirect_to admin_staffs_path
  end

  index do
    handle_column
    column "Staff" do |staff|
      link_to "#{staff.name}", admin_staff_path(staff)
    end
    column "Foto" do |staff|
      if staff.photo.attached?
        image_tag(cl_image_path(staff.photo.key), class: "admin_table_thumb")
      end
    end
    column :role
    column :published
    column "Pubblica" do |staff|
      if !staff.published
        link_to "Pubblica", publish_admin_staff_path(staff), method: :put
      else
        link_to "Metti offline", unpublish_admin_staff_path(staff), method: :put
      end
    end
    actions
  end

  show do
    attributes_table do
      row :published,           label: 'Pubblicato'
      row :photo do |i|
        if staff.photo.attached?
          image_tag(cl_image_path(staff.photo.key), class: "image-preview")
        end
      end
      row :name,                label: 'Nome'
      row :role,                label: 'Ruolo'
      row (:description) {|staff| raw(staff.description)}
    end
  end

  member_action :delete_image, method: :delete do
   @pic = ActiveStorage::Attachment.find(params[:id])
   @pic.purge_later
   redirect_back(fallback_location: edit_admin_staff_path)
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Membro/a dello Staff' do
      f.input :published,           label: 'Pubblicato'
      f.input :name,                label: 'Nome'
      f.input :role,                label: 'Ruolo'
      f.input :photo,               label: 'Foto', as: :file, hint: "Peso max: 500Kb. Altezza: min 200px / Max 2000px. Larghezza: min 200px / Max 3000px"
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
