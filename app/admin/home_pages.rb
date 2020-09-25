ActiveAdmin.register HomePage do
  menu parent: 'Pagine Sito', label: 'Home Page', priority: 1
  permit_params :meta_title,
                :meta_description,
                :meta_keywords,
                :banner_visibility,
                :banner_image,
                :main_title_one,
                :main_title_two,
                :subtitle,
                :banner_cta_visibility,
                :banner_cta_link,
                :banner_cta_text,
                :graphics_visibility,
                :sticky_box_visibility,
                :sticky_box_text,
                :sticky_box_link_url,
                :sticky_box_cta_text,
                :box_1_label,
                :box_1_text,
                :box_1_url,
                :box_1_cta,
                :box_1_image,
                :box_2_label,
                :box_2_text,
                :box_2_url,
                :box_2_cta,
                :box_3_label,
                :box_3_text,
                :box_3_url,
                :box_3_cta

  controller do
    def index
      redirect_to admin_home_page_path(HomePage.all.first)
    end
  end

  config.comments = false
  actions :all, :except => [:destroy]


  show title: "Home Page" do
    attributes_table :title => "Meta Data" do
      row :meta_title
      row :meta_description
      row :meta_keywords
    end
    attributes_table :title => "Header" do
      row :main_title_one
      row :main_title_two
      row :subtitle
      row :banner_cta_visibility
      row :banner_cta_link
      row :banner_cta_text
      row :banner_image do |i|
        if home_page.banner_image.attached?
          image_tag(cl_image_path(home_page.banner_image.key), class: "image-preview")
        end
      end
    end
    attributes_table :title => "Sticky Box" do
      row :sticky_box_visibility, label: 'Visibilità'
      row :sticky_box_text, label: 'Testo'
      row :sticky_box_link_url,   label: 'Url di atterraggio'
    end
    attributes_table :title => "Box 1" do
      row :box_1_label, label: 'Titolo'
      row (:box_1_text) {|hp| raw(hp.box_1_text)}
      row :box_1_url,   label: 'Url di atterraggio'
      row :box_1_image do |i|
        if home_page.box_1_image.attached?
          image_tag(cl_image_path(home_page.box_1_image.key), class: "image-preview")
        end
      end
    end
    attributes_table :title => "Box 2" do
      row :box_2_label, label: 'Titolo'
      row (:box_2_text) {|hp| raw(hp.box_2_text)}
      row :box_2_url,   label: 'Url di atterraggio'
    end
    attributes_table :title => "Box 3" do
      row :box_3_label, label: 'Titolo'
      row (:box_3_text) {|hp| raw(hp.box_3_text)}
      row :box_3_url,   label: 'Url di atterraggio'
    end
  end
  
  form do |f|
    f.actions
    f.semantic_errors *f.object.errors.keys
      f.inputs 'Meta Data' do
        f.input :meta_title, label: "Meta Title", placeholder: 'Meta Title', hint: "Aggiungi un meta title al post."
        f.input :meta_description, label: "Meta Description", placeholder: 'Meta Description', hint: "Aggiungi una meta description al post."
        f.input :meta_keywords, label: "Meta Keywords", placeholder: 'Inserisci parole chiave', hint: "Le keywords verranno usate nei meta-tag della pagina e devono essere separate da una virgola."
      end

      f.inputs 'Header' do
        f.input :main_title_one, label: "Titolo 1", placeholder: 'Titolo 1'
        f.input :main_title_two, label: "Titolo 2", placeholder: 'Titolo 2'
        f.input :subtitle, label: "Sottotitolo", placeholder: 'Sottotitolo'
        f.input :banner_cta_visibility, label: "Visibilità del Tasto"
        f.input :banner_cta_text, label: "Testo del tasto", placeholder: 'Testo Call to Action'
        f.input :banner_cta_link, label: "Link", placeholder: 'Inserisci un link di atterraggio (compreso di http:// o https://)', hint: "Il link deve essere completo di http:// o https://"
        f.input :graphics_visibility, label: "Presenza cerchi animati"
        f.inputs 'Cover' do
          f.input :banner_image,
          label: 'Immagine di copertina',
          as: :file,
          hint: "Peso max: 1MB - Altezza max: 4000px - Larghezza max: 3000px"
          if f.object.banner_image.attached?
            div class: "form-aligned" do
              div cl_image_tag(f.object.banner_image.key)
              unless f.object.id.nil?
                div link_to "Rimuovi immagine", delete_image_admin_staff_path(f.object.banner_image.id),method: :delete,class: "delete-btn", data: { confirm: "Confermi di voler cancellare l'immagine?" }
              end
            end
          end
        end
      end
      f.inputs 'Sticky Box' do
        f.input :sticky_box_visibility, label: "Visibilità Box"
        f.input :sticky_box_text, label: "Testo", placeholder: 'Testo', as: :quill_editor
        f.input :sticky_box_cta_text, label: "Testo del tasto", placeholder: 'Testo Call to Action'
        f.input :sticky_box_link_url, label: "Link", placeholder: 'Link url'
      end
      f.inputs 'Box 1' do
        f.input :box_1_label, label: "Titolo", placeholder: 'Titolo'
        f.input :box_1_text, label: "Contenuto", placeholder: 'Contenuto', as: :quill_editor
        f.input :box_1_cta, label: "Testo link", placeholder: 'Testo link'
        f.input :box_1_url, label: "Link url", placeholder: 'Link url'
        f.inputs 'Immagine' do
          f.input :box_1_image,
          label: 'Immagine di copertina',
          as: :file,
          hint: "Peso max: 1MB - Altezza max: 4000px - Larghezza max: 3000px"
          if f.object.box_1_image.attached?
            div class: "form-aligned" do
              div cl_image_tag(f.object.box_1_image.key)
              unless f.object.id.nil?
                div link_to "Rimuovi immagine", delete_image_admin_staff_path(f.object.box_1_image.id),method: :delete,class: "delete-btn", data: { confirm: "Confermi di voler cancellare l'immagine?" }
              end
            end
          end
        end
      end
      f.inputs 'Box 2' do
        f.input :box_2_label, label: "Titolo", placeholder: 'Titolo'
        f.input :box_2_text, label: "Contenuto", placeholder: 'Contenuto', as: :quill_editor
        f.input :box_2_cta, label: "Testo link", placeholder: 'Testo link'
        f.input :box_2_url, label: "Link url", placeholder: 'Link url'
      end
      f.inputs 'Box 3' do
        f.input :box_3_label, label: "Titolo", placeholder: 'Titolo'
        f.input :box_3_text, label: "Contenuto", placeholder: 'Contenuto', as: :quill_editor
        f.input :box_3_cta, label: "Testo link", placeholder: 'Testo link'
        f.input :box_3_url, label: "Link url", placeholder: 'Link url'
      end
    f.actions
  end
  
end
