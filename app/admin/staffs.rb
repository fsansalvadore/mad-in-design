ActiveAdmin.register Staff do
  menu parent: 'People', label: 'Staff'

  permit_params :name,
                :role,
                :photo,
                :description,
                :position,
                :published

  index do
    column "Perona" do |pers|
      link_to "#{pers.first_name} #{pers.last_name}", admin_person_path(pers)
    end
    column :role
    column :published
    actions
  end

  show do
    attributes_table do
      row (:people_category_id) { |cat| cat.people_category.title }
      row :image do |i|
        if person.image.attached?
          image_tag(cl_image_path(person.image.key), class: "image-preview")
        end
      end
      row :first_name,          label: 'Nome'
      row :last_name,           label: 'Cognome'
      row :role,                label: 'Ruolo'
      row (:description) {|person| raw(person.description)}
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Categoria' do
      f.input :people_category_id,  label: 'Categoria', as: :select, as: :select, collection: PeopleCategory.all.map {|cat| [cat.title, cat.id]}, prompt: 'Seleziona una categoria'
      f.input :image,               label: 'Foto', as: :file
      f.input :first_name,          label: 'Nome'
      f.input :last_name,           label: 'Cognome'
      f.input :role,                label: 'Ruolo'
      f.input :description,         label: 'Descrizione', as: :quill_editor
    end
    f.actions
  end

end
