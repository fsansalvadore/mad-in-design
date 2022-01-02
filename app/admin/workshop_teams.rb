ActiveAdmin.register WorkshopTeam do
  menu parent: 'Workshop', label: 'Squadre', priority: 2

  permit_params :title,
                :project_leader,
                :image,
                :position,
                :description,
                :workshop_id,
                team_outcomes_attributes: [
                  :id,
                  :title,
                  :subtitle,
                  :cover,
                  :content,
                  :image_1,
                  :image_2,
                  :image_3,
                  :image_4,
                  :image_5,
                  :priority,
                  :published,
                  :meta_title,
                  :meta_description,
                  :meta_keywords,
                  :position,
                  :_destroy
                ],
                attachments_attributes: [
                  :id,
                  :image,
                  :position,
                  :_destroy
                ]

  controller do
    defaults :finder => :find_by_slug
  end

  actions :all, :except => [:new]

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
    tabs do
      tab :squadra do
        f.inputs 'Squadra' do
          f.input :workshop,    label: 'Workshop'
          f.input :title,       label: "Titolo", hint: 'Obbligatorio'
          f.input :description, label: "Descrizione", as: :quill_editor
        end
      end
      tab :carosello_immagini do
        panel "Carosello iniziale" do
          f.has_many :attachments, heading: 'Immagini', allow_destroy: true, sortable: :position, sortable_start: 1 do |n_f|
            n_f.input :image,
              label: 'Immagine',
              as: :file,
              :hint => n_f.object.image.attached? \
              ? "<div class='nested-image-preview'>#{cl_image_tag(n_f.object.image.key)}<p>#{n_f.object.image.filename}</p></div>".html_safe
              : content_tag(:span, "Peso max: 500Kb. Altezza: min 200px / Max 2000px. Larghezza: min 200px / Max 3000px")
          end
        end
      end
      tab :immagine_di_copertina do
        f.inputs 'Immagine di copertina' do
          f.input :image, as: :file
          if f.object.image.attached?
            div class: "form-aligned" do
              div cl_image_tag(f.object.image.key)
              unless f.object.id.nil?
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.image.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
          end
        end
      end
    end
    panel 'Squadre - Vengono visualizzate se la "Tipologia" del workshop è impostata su "Squadre"' do
      f.has_many :team_outcomes, heading: 'Giornate / Esiti', allow_destroy: true, sortable: :position, sortable_start: 1 do |n_f|
        n_f.input :published,         label: "Visibile"
        n_f.input :title,             label: "Titolo", hint: 'Obbligatorio'
        n_f.input :content,         label: "Testo", as: :quill_editor
        n_f.input :image_1,
              label: 'Immagine 1',
              as: :file,
              :hint => n_f.object.image_1.attached? \
              ? "<div class='nested-image-preview'>#{cl_image_tag(n_f.object.image_1.key)}<p>#{link_to "Rimuovi", delete_image_admin_workshop_path(n_f.object.image_1.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }} #{n_f.object.image_1.filename} </p></div>".html_safe
              : content_tag(:span, "Peso max: 600Kb. Altezza: min 200px / Max 2000px. Larghezza: min 200px / Max 3000px")
        n_f.input :image_2,
              label: 'Immagine 2',
              as: :file,
              :hint => n_f.object.image_2.attached? \
              ? "<div class='nested-image-preview'>#{cl_image_tag(n_f.object.image_2.key)}<p>#{link_to "Rimuovi", delete_image_admin_workshop_path(n_f.object.image_2.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }} #{n_f.object.image_2.filename} </p></div>".html_safe
              : content_tag(:span, "Peso max: 600Kb. Altezza: min 200px / Max 2000px. Larghezza: min 200px / Max 3000px")
        n_f.input :image_3,
              label: 'Immagine 3',
              as: :file,
              :hint => n_f.object.image_3.attached? \
              ? "<div class='nested-image-preview'>#{cl_image_tag(n_f.object.image_3.key)}<p>#{link_to "Rimuovi", delete_image_admin_workshop_path(n_f.object.image_3.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }} #{n_f.object.image_3.filename} </p></div>".html_safe
              : content_tag(:span, "Peso max: 600Kb. Altezza: min 200px / Max 2000px. Larghezza: min 200px / Max 3000px")
        n_f.input :image_4,
              label: 'Immagine 4',
              as: :file,
              :hint => n_f.object.image_4.attached? \
              ? "<div class='nested-image-preview'>#{cl_image_tag(n_f.object.image_4.key)}<p>#{link_to "Rimuovi", delete_image_admin_workshop_path(n_f.object.image_4.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }} #{n_f.object.image_4.filename} </p></div>".html_safe
              : content_tag(:span, "Peso max: 600Kb. Altezza: min 200px / Max 2000px. Larghezza: min 200px / Max 3000px")
        n_f.input :image_5,
              label: 'Immagine 5',
              as: :file,
              :hint => n_f.object.image_5.attached? \
              ? "<div class='nested-image-preview'>#{cl_image_tag(n_f.object.image_5.key)}<p>#{link_to "Rimuovi", delete_image_admin_workshop_path(n_f.object.image_5.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }} #{n_f.object.image_5.filename} </p></div>".html_safe
              : content_tag(:span, "Peso max: 600Kb. Altezza: min 200px / Max 2000px. Larghezza: min 200px / Max 3000px")
      end
    end
    f.actions
  end
end
