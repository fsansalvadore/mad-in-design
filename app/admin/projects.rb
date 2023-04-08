ActiveAdmin.register Project do
  menu priority: 4, label: "Progetti"
  permit_params :title,
                :intro,
                :role,
                :cover,
                :meta_title,
                :meta_description,
                :meta_keywords,
                :start_date,
                :description,
                :published,
                project_content_sections_attributes: [
                  :id,
                  :typology,
                  :rich_text,
                  :video_provider,
                  :video_url,
                  :position,
                  :published,
                  :image,
                  :image_width
                ]

  controller do
    defaults :finder => :find_by_slug
  end

  member_action :publish_project, method: :put do
    project = Project.friendly.find_by_slug(params[:id])
    project.update(published: true)
    redirect_to admin_project_path(project)
  end

  member_action :unpublish_project, method: :put do
    project = Project.friendly.find_by_slug(params[:id])
    project.update(published: false)
    redirect_to admin_project_path(project)
  end

  member_action :publish, method: :put do
    project = Project.friendly.find_by_slug(params[:id])
    project.update(published: true)
    redirect_to admin_projects_path
  end

  member_action :unpublish, method: :put do
    project = Project.friendly.find_by_slug(params[:id])
    project.update(published: false)
    redirect_to admin_projects_path
  end

  index do
    selectable_column
    column "Titolo" do |project|
      link_to project.title, admin_project_path(project)
    end
    column "copertina" do |project|
      if project.cover.present?
        image_tag(cl_image_path(project.cover.key), class: "admin_table_thumb")
      end
    end
    column :published
    column "Pubblica" do |project|
      if !project.published
        link_to "Pubblica", publish_admin_project_path(project), method: :put
      else
        link_to "Metti offline", unpublish_admin_project_path(project), method: :put
      end
    end
    actions
  end

  show title: :title do
    attributes_table do
      row :slug
      row :title
      row :meta_title
      row :meta_description
      row :meta_keywords
      row :cover do |i|
        if project.cover.attached?
          image_tag(cl_image_path(project.cover.key), class: "image-preview")
        end
      end
      row :published
    end
  end

  form do |f|
    f.actions
    f.semantic_errors *f.object.errors.keys
      tabs do
        tab :project do
          f.inputs 'Progetto' do
            # f.input :priority, label: "Priorità", as: :select, collection: [["1 — In Evidenza", 1], ["2 — Secondo", 2], ["3 — Terzo", 3], ["4 — Quarto", 4], ["5 — Non mostrare in Home Page", 5],["Non mostrare nel blog", 6]], prompt: "Seleziona l'ordine in Home Page", hint: "I post in Home Page vengono mostrati in ordine di Priorirà (da 1 a 4) o per data di creazione. I post con priorità 5 non compaiono in Home Page, quelli con 6 non compaiono nel blog."
            f.input :published, label: "Pubblicato"
            f.input :featured, label: "In evidenza", hint: "I progetti in evidenza vengono visualizzati in Home Page"
            f.input :title, label: "Titolo", placeholder: 'Titolo', hint: "Obbligatorio"
            f.input :intro, label: "Intro", placeholder: 'Introduzione', hint: "Compare nell'anteprima"
            f.input :start_date, as: :date_time_picker, label: "Data"
            f.inputs 'Cover' do
              f.input :cover,
              label: 'Immagine di in evidenza e di anteprima',
              as: :file,
              hint: "Peso max: 1MB. Altezza: min 200px / Max 2000px. Larghezza: min 200px / Max 3000px"
              if f.object.cover.attached?
                div class: "form-aligned" do
                  div cl_image_tag(f.object.cover.key)
                  unless f.object.id.nil? || f.object.cover.nil? || f.object.cover.id.nil?
                    div link_to "Rimuovi immagine", delete_image_admin_staff_path(f.object.cover.id),method: :delete,class: "delete-btn", data: { confirm: "Confermi di voler cancellare l'immagine?" }
                  end
                end
              end
            end

          end
        end
        tab :meta do
          f.inputs 'Meta Data' do
            f.input :meta_title, label: "Meta Title", placeholder: 'Meta Title', hint: "Aggiungi un meta title al post."
            f.input :meta_description, label: "Meta Description", placeholder: 'Meta Description', hint: "Aggiungi una meta description al post."
            f.input :meta_keywords, label: "Meta Keywords", placeholder: 'Inserisci parole chiave', hint: "Le keywords verranno usate nei meta-tag della pagina e devono essere separate da una virgola."
          end
        end
      f.inputs "Sezioni — Ogni sezione corrisponde a una tipologia di contenuto diverso: Testo / Video / Immagine (Inserisci solo una tipologia per sezione)" do
        f.has_many :project_content_sections, heading: 'Contenuto', allow_destroy: true, sortable: :position, sortable_start: 1 do |n_f|
          # n_f.input :published, label: "Visibilità Sezione", hint: "Togli la spunta 'visibile' se vuoi omettere momentaneamente questa sezione."
          n_f.input :typology,
            label: "Tipologia Contenuto",
            as: :select,
            collection: [["Testo", 0], ["Immagine", 1], ["Video", 2]],
            prompt: "Seleziona tipologia di media da inserire",
            hint: "Seleziona tipologia di media da inserire.",
            input_html: { 'onchange': 'selectChange(this)' },
            wrapper_html: { class: 'selectInput' }

          n_f.input :rich_text,
            label: "Blocco Testo",
            as: :quill_editor,
            hint: "Inserisci qui un normale blocco di testo.",
            wrapper_html: { class: 'hideInput typ1 showInput' }
          n_f.input :video_provider,
            label: "Sorgente Video",
            as: :select,
            collection: [["Nessuno", 0], ["Vimeo", 1], ["YouTube", 2], ["Facebook", 3]],
            prompt: "Seleziona sorgente video",
            hint: "Indica se il video proviene da YouTube o da Vimeo.",
            wrapper_html: { class: 'hideInput typ3' }
          n_f.input :video_url, label: "Codice video", hint: "Inserire soltanto il codice identificativo dell'url. Esempio: https://vimeo.com/123456789 -> 123456789 | https://www.youtube.com/watch?v=123456789 -> 123456789 | https://www.facebook.com/HearMeMinD/videos/2993502504031445/?v=2993502504031445 -> 2993502504031445/?v=2993502504031445",
            wrapper_html: { class: 'hideInput typ3' }
          n_f.input :image,
            label: 'Immagine',
            as: :file,
            :hint => n_f.object.image.attached? \
            ? cl_image_tag(n_f.object.image.key)
            : content_tag(:span, "Peso max: 500Kb. Altezza: min 200px / Max 2000px. Larghezza: min 200px / Max 3000px"),
            wrapper_html: { class: 'hideInput typ2' }
          n_f.input :image_width,
            label: "Larghezza Immagine",
            as: :select,
            collection: [["25% - 1/4", "one_fourth"], ["33% - 1/3", "one_third"],["50% - 1/2", "half"],["66% - 2/3", "two_thirds"], ["75% - 3/4", "three_fourths"], ["100%", "full"]],
            prompt: "Seleziona layout", hint: "Di default le immagini vengono visualizzate al 100% della larghezza.",
            wrapper_html: { class: 'hideInput typ2' }
        end
      end
    end
    f.actions
  end
end
