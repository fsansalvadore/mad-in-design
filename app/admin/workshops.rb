ActiveAdmin.register Workshop do
  menu parent: 'Workshop', label: 'Workshop', priority: 1
  permit_params :typology,
                :title,
                :subtitle,
                :body_copy,
                :start_date,
                :end_date,
                :cover,
                :priority,
                :published,
                :meta_title,
                :meta_description,
                :meta_keywords,
                workshop_carousel_images_attributes: [
                  :id,
                  :image,
                  :position,
                  :_destroy
                ],
                workshop_outcomes_attributes: [
                  :id,
                  :title,
                  :sottotitolo,
                  :project_leader,
                  :team,
                  :content,
                  :visible,
                  :position,
                  :image_1,
                  :image_2,
                  :image_3,
                  :image_4,
                  :image_5,
                  :outcome_images,
                  :_destroy
                ],
                workshop_outcome_images_attributes: [
                  :id,
                  :image
                ],
                workshop_teams_attributes: [
                  :id,
                  :title,
                  :project_leader,
                  :image,
                  :position,
                  :_destroy
                ],
                team_outcomes_attributes: [
                  :id,
                  :title,
                  :subtitle,
                  :cover,
                  :published,
                  :meta_title,
                  :meta_description,
                  :meta_keywords
                ]

  config.comments = false
  config.sort_order = 'created_at_asc'

  controller do
    defaults :finder => :find_by_slug
  end

  member_action :publish_workshop, method: :put do
    workshop = Workshop.friendly.find_by_slug(params[:id])
    workshop.update(published: true)
    redirect_to admin_workshop_path(workshop)
  end

  member_action :unpublish_workshop, method: :put do
    workshop = Workshop.friendly.find_by_slug(params[:id])
    workshop.update(published: false)
    redirect_to admin_workshop_path(workshop)
  end

  action_item :publish, only: :show do
    link_to "Pubblica", publish_admin_workshop_path(workshop), method: :put if !workshop.published
  end

  action_item :unpublish, only: :show do
    link_to "Metti offline", unpublish_admin_workshop_path(workshop), method: :put if workshop.published
  end

  member_action :publish, method: :put do
    workshop = Workshop.friendly.find_by_slug(params[:id])
    workshop.update(published: true)
    redirect_to admin_workshops_path
  end

  member_action :unpublish, method: :put do
    workshop = Workshop.friendly.find_by_slug(params[:id])
    workshop.update(published: false)
    redirect_to admin_workshops_path
  end

  index do
    selectable_column
    column "Titolo" do |workshop|
      link_to workshop.title, admin_workshop_path(workshop)
    end
    column :published
    column "Pubblica" do |workshop|
      if !workshop.published
        link_to "Pubblica", publish_admin_workshop_path(workshop), method: :put
      else
        link_to "Metti offline", unpublish_admin_workshop_path(workshop), method: :put
      end
    end
    actions
  end

  show title: :title do
    attributes_table do
      row :published
      row :slug
      row :title
      row :subtitle
      row :meta_title
      row :meta_description
      row :meta_keywords
      row :cover do |i|
        if workshop.cover.attached?
          image_tag(cl_image_path(workshop.cover.key), class: "image-preview")
        end
      end
    end
  end

  # filter :title
  # filter :published

  member_action :delete_image, method: :delete do
   @pic = ActiveStorage::Attachment.find(params[:id])
   @pic.purge_later
   redirect_back(fallback_location: edit_admin_workshop_path)
  end

  form do |f|
    f.actions
    f.semantic_errors *f.object.errors.keys
      tabs do
        tab :workshop do
          f.inputs 'Informazioni del Workshop' do
            f.input :typology,
                      label: 'Tipologia Workshop',
                      as: :select,
                      collection: [["Normale (Default)", 0], ["Con Squadre", 1]],
                      prompt: "Seleziona tipologia di workshop",
                      hint: "I workshop di tipo 'Normale' mostrano soltanto gli esiti. I workshop 'Squadre' contengono sia squadre sia gli esiti delle giornate.",
                      input_html: { 'onchange': 'workshopSelect(this)' },
                      wrapper_html: { class: 'selectInput' }

            f.input :published,   label: 'Pubblicato'
            f.input :cover, as: :file
            if f.object.cover.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.cover.key)
                unless f.object.id.nil?
                  div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.cover.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
                end
              end
            end
            f.input :title,       label: "Titolo", hint: 'Obbligatorio'
            f.input :subtitle,    label: "Sottotitolo"
            f.input :start_date,  label: "Data Inizio", as: :date_time_picker
            f.input :body_copy,   label: "Testo", as: :quill_editor
          end
        end
        tab :carosello do
          panel "Carosello" do
            f.has_many :workshop_carousel_images, heading: 'Immagini', allow_destroy: true, sortable: :position, sortable_start: 1 do |n_f|
              n_f.input :image,
                label: 'Immagine',
                as: :file,
                :hint => n_f.object.image.attached? \
                ? "<div class='nested-image-preview'>#{cl_image_tag(n_f.object.image.key)}<p>#{n_f.object.image.filename}</p></div>".html_safe
                : content_tag(:span, "Peso max: 500Kb. Altezza: min 200px / Max 2000px. Larghezza: min 200px / Max 3000px")
            end
          end
        end
        tab :meta do
          f.inputs 'Meta Data' do
            f.input :meta_title,        label: "Meta Title", placeholder: 'Meta Title', hint: "Aggiungi un meta title al workshop."
            f.input :meta_description,  label: "Meta Description", placeholder: 'Meta Description', hint: "Aggiungi una meta description al workshop."
            f.input :meta_keywords,     label: "Meta Keywords", placeholder: 'Inserisci parole chiave', hint: "Le keywords verranno usate nei meta-tag della pagina e devono essere separate da una virgola."
          end
        end
      # Esiti
      panel 'Squadre - Vengono visualizzate se la "Tipologia" del workshop è impostata su "Squadre"' do
        f.has_many :workshop_teams, heading: 'Aggiungi Squadre', allow_destroy: true, sortable: :position, sortable_start: 1 do |t_f|
          t_f.input :title,            label: "Nome Squadra", hint: 'Obbligatorio (Può essere "Team 1", "Team 2", ecc)'
          t_f.input :project_leader,  label: "Leader Squadra", hint: 'Obbligatorio (Può essere "Team 1", "Team 2", ecc)'
        end
      end
      panel 'Esiti - Vengono visualizzati se la "Tipologia" del workshop è impostata su normale' do
        f.has_many :workshop_outcomes, heading: 'Aggiungi Esiti', allow_destroy: true, sortable: :position, sortable_start: 1 do |n_f|
          n_f.input :visible,         label: "Visibile"
          n_f.input :title,           label: "Titolo", hint: 'Obbligatorio'
          n_f.input :sottotitolo,     label: "Sottotitolo"
          n_f.input :project_leader,  label: "Project Leader"
          n_f.input :team,            label: "Team"
          n_f.input :content,         label: "Testo", as: :quill_editor
          n_f.input :image_1,
                label: 'Immagine 1',
                as: :file,
                :hint => n_f.object.image_1.attached? \
                ? "<div class='nested-image-preview'>#{cl_image_tag(n_f.object.image_1.key)}<p>#{link_to "Rimuovi", delete_image_admin_workshop_path(n_f.object.image_1.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }} #{n_f.object.image_1.filename} </p></div>".html_safe
                : content_tag(:span, "Peso max: 500Kb. Altezza: min 200px / Max 2000px. Larghezza: min 200px / Max 3000px")
          n_f.input :image_2,
                label: 'Immagine 2',
                as: :file,
                :hint => n_f.object.image_2.attached? \
                ? "<div class='nested-image-preview'>#{cl_image_tag(n_f.object.image_2.key)}<p>#{link_to "Rimuovi", delete_image_admin_workshop_path(n_f.object.image_2.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }} #{n_f.object.image_2.filename} </p></div>".html_safe
                : content_tag(:span, "Peso max: 500Kb. Altezza: min 200px / Max 2000px. Larghezza: min 200px / Max 3000px")
          n_f.input :image_3,
                label: 'Immagine 3',
                as: :file,
                :hint => n_f.object.image_3.attached? \
                ? "<div class='nested-image-preview'>#{cl_image_tag(n_f.object.image_3.key)}<p>#{link_to "Rimuovi", delete_image_admin_workshop_path(n_f.object.image_3.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }} #{n_f.object.image_3.filename} </p></div>".html_safe
                : content_tag(:span, "Peso max: 500Kb. Altezza: min 200px / Max 2000px. Larghezza: min 200px / Max 3000px")
          n_f.input :image_4,
                label: 'Immagine 4',
                as: :file,
                :hint => n_f.object.image_4.attached? \
                ? "<div class='nested-image-preview'>#{cl_image_tag(n_f.object.image_4.key)}<p>#{link_to "Rimuovi", delete_image_admin_workshop_path(n_f.object.image_4.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }} #{n_f.object.image_4.filename} </p></div>".html_safe
                : content_tag(:span, "Peso max: 500Kb. Altezza: min 200px / Max 2000px. Larghezza: min 200px / Max 3000px")
          n_f.input :image_5,
                label: 'Immagine 5',
                as: :file,
                :hint => n_f.object.image_5.attached? \
                ? "<div class='nested-image-preview'>#{cl_image_tag(n_f.object.image_5.key)}<p>#{link_to "Rimuovi", delete_image_admin_workshop_path(n_f.object.image_5.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }} #{n_f.object.image_5.filename} </p></div>".html_safe
                : content_tag(:span, "Peso max: 500Kb. Altezza: min 200px / Max 2000px. Larghezza: min 200px / Max 3000px")
        end
      end
    end
    f.actions
  end
end
