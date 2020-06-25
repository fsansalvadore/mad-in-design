ActiveAdmin.register WorkshopTeam do
  belongs_to :workshop

  controller do
    defaults :finder => :find_by_slug
  end
end
