class PeopleController < ApplicationController
  def index
    @staff_members = Staff.where(published: true).order(:position)
    @committee = Committee.where(published: true).order(:position)
    @leaders = ProjectLeader.where(published: true).order(:position)
    @partners = Partner.where(published: true).order(:position)
    @sponsors = TecnicalSponsor.where(published: true).order(:position)
    @collaborators = Collaborator.where(published: true).order(:position)
  end
end
