require 'spec_helper'

describe ProjectsController do
  let!(:user) { FactoryGirl.create(:user)}


  context "Standerd user" do
      {
        new: :get,
        create: :post,
        edit: :get,
        update: :put,
        destroy: :delete
      }.each do |action, method|
          it "can not access #{action} action" do
            sign_in(user)
            send(method, action, :id => FactoryGirl.create(:project))
            expect(response).to redirect_to(root_path)
            expect(flash[:alert]).to eql("You must be an admin to do that.")
          end
      end
    end


  # it "display an error for missing project" do
  #   get :show, id: "not-here"
  #   expect(response).to redirect_to(project_path)
  #   message = "The Project you are looking for not found"
  #   expect(flash[:alert]).to eql(message)
  # end
end
