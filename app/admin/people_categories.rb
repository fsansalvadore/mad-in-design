ActiveAdmin.register PeopleCategory do
  menu parent: 'People', label: 'Categorie'
  include ActiveAdmin::SortableTable # creates the controller action which handles the sorting
  config.sort_order = 'position_asc'

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :published
  #
  # or
  index do
    handle_column
    column "Titolo" do |cat|
      link_to cat.title, admin_people_category_path(cat)
    end
    column :published
    actions
  end

  show title: :title do
    attributes_table do
      row :title,     label: 'Titolo'
      row :published, label: 'Pubblicato'
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Categoria' do
      f.input :title,     label: 'Titolo'
      f.input :published, label: 'Pubblica'
    end
    f.actions
  end
end
