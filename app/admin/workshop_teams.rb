ActiveAdmin.register WorkshopTeam do
  menu parent: 'Workshop', label: 'Squadre', priority: 2
  # belongs_to :workshop
  permit_params :title,
                :project_leader,
                :image,
                :position,
                team_outcomes_attributes: [
                  :id,
                  :title,
                  :subtitle,
                  :cover,
                  :priority,
                  :published,
                  :meta_title,
                  :meta_description,
                  :meta_keywords,
                  :position
                ]

  actions :all, :except => [:new]
  # controller do
  #   defaults :finder => :find_by_slug
  # end

  index do
    selectable_column
    column "Titolo" do |workshop_team|
      link_to workshop_team.title, admin_workshop_team_path(workshop_team)
    end
    column :project_leader
    column :workshop
    column :published

    actions
  end

  form do |f|
    f.actions
    f.semantic_errors *f.object.errors.keys
      f.inputs 'Squadra' do
        f.input :workshop_id,    label: 'Workshop'
        # f.input :published,   label: 'Pubblicato'
        # f.input :title,       label: "Titolo", hint: 'Obbligatorio'
        # f.input :image, as: :file
        # if f.object.image.attached?
        #   div class: "form-aligned" do
        #     div cl_image_tag(f.object.image.key)
        #     unless f.object.id.nil?
        #       div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.image.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
        #     end
        #   end
        # end
        f.has_many :team_outcomes, heading: 'Giornate / Esiti', allow_destroy: true, sortable: :position, sortable_start: 1 do |n_f|
          n_f.input :published,         label: "Visibile"
          n_f.input :title,             label: "Titolo", hint: 'Obbligatorio'
        end
      # end
    end
    f.actions
  end
end
