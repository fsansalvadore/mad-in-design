ActiveAdmin.register Workshop do
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
                :outcome_1_title,
                :outcome_1_subtitle,
                :outcome_1_content,
                :outcome_1_display,
                :outcome_1_img_1,
                :outcome_1_img_2,
                :outcome_1_img_3,
                :outcome_1_img_4,
                :outcome_1_img_5,
                :outcome_2_title,
                :outcome_2_subtitle,
                :outcome_2_content,
                :outcome_2_display,
                :outcome_2_img_1,
                :outcome_2_img_2,
                :outcome_2_img_3,
                :outcome_2_img_4,
                :outcome_2_img_5,
                :outcome_3_title,
                :outcome_3_subtitle,
                :outcome_3_content,
                :outcome_3_display,
                :outcome_3_img_1,
                :outcome_3_img_2,
                :outcome_3_img_3,
                :outcome_3_img_4,
                :outcome_3_img_5,
                :outcome_4_title,
                :outcome_4_subtitle,
                :outcome_4_content,
                :outcome_4_display,
                :outcome_4_img_1,
                :outcome_4_img_2,
                :outcome_4_img_3,
                :outcome_4_img_4,
                :outcome_4_img_5,
                :outcome_5_title,
                :outcome_5_subtitle,
                :outcome_5_content,
                :outcome_5_display,
                :outcome_5_img_1,
                :outcome_5_img_2,
                :outcome_5_img_3,
                :outcome_5_img_4,
                :outcome_5_img_5,
                :outcome_6_title,
                :outcome_6_subtitle,
                :outcome_6_content,
                :outcome_6_display,
                :outcome_6_img_1,
                :outcome_6_img_2,
                :outcome_6_img_3,
                :outcome_6_img_4,
                :outcome_6_img_5,
                workshop_carousel_images_attributes: [
                  :id,
                  :image
                ],
                workshop_outcomes_attributes: [
                  :id,
                  :title,
                  :sottotitolo,
                  :content,
                  :visible,
                  :position,
                  :image_1,
                  :image_2,
                  :image_3,
                  :image_4,
                  :image_5,
                  :outcome_images
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
                  :position
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

  # action_item :publish, only: :show do
  #   link_to "Anteprima live", workshop_path(workshop)
  # end

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
    # actions defaults: true do |workshop|
    #   link_to 'Duplica', clone_admin_workshop_path(workshop)
    # end
  end

  show title: :title do
    attributes_table do
      row :published
      row :slug
      row :rubrica
      row :title
      row :subtitle
      row :meta_title
      row :meta_description
      row :meta_keywords
      row :cover do |i|
        if workshop.cover
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
            f.input :typology,    label: 'Tipologia Workshop', as: :select, collection: [["Normale (Default)", 0], ["Squadre", 1]], prompt: "Seleziona tipologia di workshop", hint: "I workshop di tipo 'Normale' mostrano soltanto gli esiti. I workshop 'Squadre' contengono sia squadre sia gli esiti delle giornate."
            f.input :published,   label: 'Pubblicato'
            f.input :cover, as: :file
            if f.object.cover.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.cover.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.cover.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :title,       label: "Titolo", hint: 'Obbligatorio'
            f.input :subtitle,    label: "Sottotitolo"
            f.input :start_date,  label: "Data Inizio", as: :datepicker
            f.input :body_copy,   label: "Testo", as: :quill_editor
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
      tabs do
        tab :esito_1 do
          f.inputs 'Esito 1' do
            f.input :outcome_1_display,     label: "Mostra"
            f.input :outcome_1_title,       label: "Titolo"
            f.input :outcome_1_subtitle,    label: "Sottotitolo"
            f.input :outcome_1_content,     label: "Testo", as: :quill_editor
            f.input :outcome_1_img_1, as: :file, label: "Immagine 1"
            if f.object.outcome_1_img_1.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_1_img_1.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_1_img_1.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_1_img_2, as: :file, label: "Immagine 2"
            if f.object.outcome_1_img_2.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_1_img_2.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_1_img_2.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_1_img_3, as: :file, label: "Immagine 3"
            if f.object.outcome_1_img_3.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_1_img_3.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_1_img_3.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_1_img_4, as: :file, label: "Immagine 4"
            if f.object.outcome_1_img_4.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_1_img_4.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_1_img_4.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_1_img_5, as: :file, label: "Immagine 5"
            if f.object.outcome_1_img_5.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_1_img_5.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_1_img_5.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
          end
        end
        tab :esito_2 do
          f.inputs 'Esito 2' do
            f.input :outcome_2_display,     label: "Mostra"
            f.input :outcome_2_title,       label: "Titolo"
            f.input :outcome_2_subtitle,    label: "Sottotitolo"
            f.input :outcome_2_content,     label: "Testo", as: :quill_editor
            f.input :outcome_2_img_1, as: :file, label: "Immagine 1"
            if f.object.outcome_2_img_1.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_2_img_1.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_2_img_1.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_2_img_2, as: :file, label: "Immagine 2"
            if f.object.outcome_2_img_2.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_2_img_2.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_2_img_2.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_2_img_3, as: :file, label: "Immagine 3"
            if f.object.outcome_2_img_3.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_2_img_3.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_2_img_3.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_2_img_4, as: :file, label: "Immagine 4"
            if f.object.outcome_2_img_4.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_2_img_4.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_2_img_4.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_2_img_5, as: :file, label: "Immagine 5"
            if f.object.outcome_2_img_5.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_2_img_5.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_2_img_5.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
          end
        end
        tab :esito_3 do
          f.inputs 'Esito 3' do
            f.input :outcome_3_display,     label: "Mostra"
            f.input :outcome_3_title,       label: "Titolo"
            f.input :outcome_3_subtitle,    label: "Sottotitolo"
            f.input :outcome_3_content,     label: "Testo", as: :quill_editor
            f.input :outcome_3_img_1, as: :file, label: "Immagine 1"
            if f.object.outcome_3_img_1.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_3_img_1.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_3_img_1.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_3_img_2, as: :file, label: "Immagine 2"
            if f.object.outcome_3_img_2.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_3_img_2.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_3_img_2.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_3_img_3, as: :file, label: "Immagine 3"
            if f.object.outcome_3_img_3.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_3_img_3.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_3_img_3.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_3_img_4, as: :file, label: "Immagine 4"
            if f.object.outcome_3_img_4.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_3_img_4.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_3_img_4.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_3_img_5, as: :file, label: "Immagine 5"
            if f.object.outcome_3_img_5.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_3_img_5.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_3_img_5.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
          end
        end
        tab :esito_4 do
          f.inputs 'Esito 4' do
            f.input :outcome_4_display,     label: "Mostra"
            f.input :outcome_4_title,       label: "Titolo"
            f.input :outcome_4_subtitle,    label: "Sottotitolo"
            f.input :outcome_4_content,     label: "Testo", as: :quill_editor
            f.input :outcome_4_img_1, as: :file, label: "Immagine 1"
            if f.object.outcome_4_img_1.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_4_img_1.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_4_img_1.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_4_img_2, as: :file, label: "Immagine 2"
            if f.object.outcome_4_img_2.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_4_img_2.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_4_img_2.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_4_img_3, as: :file, label: "Immagine 3"
            if f.object.outcome_4_img_3.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_4_img_3.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_4_img_3.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_4_img_4, as: :file, label: "Immagine 4"
            if f.object.outcome_4_img_4.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_4_img_4.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_4_img_4.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_4_img_5, as: :file, label: "Immagine 5"
            if f.object.outcome_4_img_5.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_4_img_5.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_4_img_5.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
          end
        end
        tab :esito_5 do
          f.inputs 'Esito 5' do
            f.input :outcome_5_display,     label: "Mostra"
            f.input :outcome_5_title,       label: "Titolo"
            f.input :outcome_5_subtitle,    label: "Sottotitolo"
            f.input :outcome_5_content,     label: "Testo", as: :quill_editor
            f.input :outcome_5_img_1, as: :file, label: "Immagine 1"
            if f.object.outcome_5_img_1.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_5_img_1.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_5_img_1.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_5_img_2, as: :file, label: "Immagine 2"
            if f.object.outcome_5_img_2.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_5_img_2.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_5_img_2.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_5_img_3, as: :file, label: "Immagine 3"
            if f.object.outcome_5_img_3.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_5_img_3.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_5_img_3.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_5_img_4, as: :file, label: "Immagine 4"
            if f.object.outcome_5_img_4.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_5_img_4.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_5_img_4.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_5_img_5, as: :file, label: "Immagine 5"
            if f.object.outcome_5_img_5.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_5_img_5.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_5_img_5.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
          end
        end
        tab :esito_6 do
          f.inputs 'Esito 6' do
            f.input :outcome_6_display,     label: "Mostra"
            f.input :outcome_6_title,       label: "Titolo"
            f.input :outcome_6_subtitle,    label: "Sottotitolo"
            f.input :outcome_6_content,     label: "Testo", as: :quill_editor
            f.input :outcome_6_img_1, as: :file
            if f.object.outcome_6_img_1.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_6_img_1.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_6_img_1.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_6_img_2, as: :file
            if f.object.outcome_6_img_2.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_6_img_2.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_6_img_2.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_6_img_3, as: :file
            if f.object.outcome_6_img_3.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_6_img_3.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_6_img_3.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_6_img_4, as: :file
            if f.object.outcome_6_img_4.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_6_img_4.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_6_img_4.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
            f.input :outcome_6_img_5, as: :file
            if f.object.outcome_6_img_5.attached?
              div class: "form-aligned" do
                div cl_image_tag(f.object.outcome_6_img_5.key)
                div link_to "Rimuovi immagine", delete_image_admin_workshop_path(f.object.outcome_6_img_5.id),method: :delete,class: "delete-btn", data: { confirm: 'Are you sure?' }
              end
            end
          end
        end

      end
        #fine esiti
      # f.inputs do
      #   f.has_many :workshop_outcomes, heading: 'Esiti del workshop', allow_destroy: true, sortable: :position, sortable_start: 1 do |n_f|
      #     n_f.input :visible,     label: "Visibilità Esito", hint: "Togli la spunta 'visibile' se vuoi omettere momentaneamente questo esito."
      #     n_f.input :title,       label: "Titolo"
      #     n_f.input :sottotitolo, label: "Sottotitolo"
      #     n_f.input :content,     label: "Testo"

      #     # n_f.input :outcome_images, as: :file, input_html: { multiple: true }
      #     # if n_f.object.outcome_images.attached?
      #     #   n_f.object.outcome_images.each do |img|
      #     #      div class: "form-aligned" do
      #     #         span cl_image_tag(img)
      #     #         span link_to "Rimuovi",delete_image_admin_workshop_path(img.id),method: :delete,class: "delete-btn",data: { confirm: 'Are you sure?' }
      #     #       end
      #     #    end
      #     # end
      #     n_f.input :image_1, as: :file
      #       if n_f.object.image_1.attached?
      #         div class: "form-aligned" do
      #           div cl_image_tag(n_f.object.image_1.key)
      #           div link_to "Rimuovi immagine", delete_image_admin_workshop_path(n_f.object.image_1.id),method: :delete,class: "delete-btn", data: { confirm: 'Confermi di voler cancellare?' }
      #         end
      #       end
      #     n_f.input :image_2, as: :file
      #       if n_f.object.image_2.attached?
      #         div class: "form-aligned" do
      #           div cl_image_tag(n_f.object.image_2.key)
      #           div link_to "Rimuovi immagine", delete_image_admin_workshop_path(n_f.object.image_2.id),method: :delete,class: "delete-btn", data: { confirm: 'Confermi di voler cancellare?' }
      #         end
      #       end
      #     n_f.input :image_3, as: :file
      #       if n_f.object.image_3.attached?
      #         div class: "form-aligned" do
      #           div cl_image_tag(n_f.object.image_3.key)
      #           div link_to "Rimuovi immagine", delete_image_admin_workshop_path(n_f.object.image_3.id),method: :delete,class: "delete-btn", data: { confirm: 'Confermi di voler cancellare?' }
      #         end
      #       end
      #     div do
      #       n_f.input :image_4, as: :file
      #       if n_f.object.image_4.attached?
      #         div class: "form-aligned" do
      #           div cl_image_tag(n_f.object.image_4.key)
      #           div link_to "Rimuovi immagine", delete_image_admin_workshop_path(n_f.object.image_4.id),method: :delete,class: "delete-btn", data: { confirm: 'Confermi di voler cancellare?' }
      #         end
      #       end
      #     end
      #     n_f.input :image_5, as: :file
      #       if n_f.object.image_5.attached?
      #         div class: "form-aligned" do
      #           div cl_image_tag(n_f.object.image_5.key)
      #           div link_to "Rimuovi immagine", delete_image_admin_workshop_path(n_f.object.image_5.id),method: :delete,class: "delete-btn", data: { confirm: 'Confermi di voler cancellare?' }
      #         end
      #       end
      #   end
      # end
      # f.inputs "Workshop con squadre" do
      #   f.has_many :workshop_teams, heading: 'Squadre', allow_destroy: true, sortable: :position, sortable_start: 1 do |wt_f|
      #     wt_f.input :title,          label: "Titolo"
      #     wt_f.input :project_leader, label: "Project Leader"
      #     wt_f.input :image,          label: "Immagine", as: :file, :image_preview => true

      #   end

      # end
    end
    f.actions
  end
end
