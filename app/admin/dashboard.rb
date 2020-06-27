ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column span: 2 do
        panel "Progetti Pubblicati: #{Project.where(published: true) ? Project.where(published: true).count : 'Nessuno'}" do
          if Project.where("published = true").length > 0
            table_for Project.where("published = true") do |event|
              column "Titolo" do |project|
                link_to project.title, admin_project_path(project)
              end
              column "copertina" do |project|
                if project.cover.attached?
                  image_tag(cl_image_path(project.cover.key), class: "admin_table_thumb")
                end
              end
            end
          else
            h4 "Non ci sono progetti pubblicati."
          end
        end
      end
      column span: 1 do
        panel "Staff Members: #{Staff.where(published: true) ? Staff.where(published: true).count : '0'}" do
          if Staff.where(published: true).length > 0
            table_for Staff.where(published: true).order(:order) do |member|
              column "Nome" do |staff|
                link_to("#{staff.nome} #{staff.cognome}", admin_staff_path(staff))
              end
              column "Ruolo", :role
            end
          else
            h4 "Non ci sono membri del team pubblicati."
          end
        end
      end
    end
  end # content
end
