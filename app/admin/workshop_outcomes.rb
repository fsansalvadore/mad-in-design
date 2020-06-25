ActiveAdmin.register Workshop
ActiveAdmin.register WorkshopOutcome do
  menu false
  belongs_to :workshop

  permit_params :title,
                :sottotitolo,
                :content,
                :visible
end
