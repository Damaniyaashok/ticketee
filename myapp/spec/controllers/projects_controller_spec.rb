require 'spec_helper'

describe ProjectsController do

  it "display an error for missing project" do
    get :show, id: "not-here"
    expect(response).to redirect_to(project_path)
    message = "The Project you are looking for not found"
    expect(flash[:alert]).to eql(message)
  end
end
